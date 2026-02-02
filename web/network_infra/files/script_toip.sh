#!/bin/bash

# ==============================================================================
# SCRIPT FINAL ULTIME - IPBX SAÉ3 (Auto-Détection Interface)
# ==============================================================================

# 1. RÉPARATION DE L'ENVIRONNEMENT
export PATH=$PATH:/usr/sbin:/sbin:/usr/bin:/bin

echo "=================================================="
echo "   INSTALLATION IPBX - SAÉ33"
echo "=================================================="

# On cherche l'interface qui a une route vers internet (celle utilisée pour wget)
DETECTED_IF=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \K\S+')

# Si la détection échoue, on propose enp0s3 par défaut
if [ -z "$DETECTED_IF" ]; then
    DETECTED_IF="enp0s3"
fi

echo "Interface détectée : [$DETECTED_IF]"
read -p "Appuyez sur ENTRÉE pour valider, ou écrivez le nom (ex: eth0) : " USER_IF

# Si l'utilisateur a juste fait Entrée, on garde la détectée. Sinon on prend la sienne.
INTERFACE="${USER_IF:-$DETECTED_IF}"

# Petite vérification de sécurité
if [ ! -d "/sys/class/net/$INTERFACE" ]; then
    echo "ERREUR : L'interface '$INTERFACE' n'existe pas sur cette machine !"
    echo "Voici vos interfaces disponibles :"
    ls /sys/class/net
    exit 1
fi
# -------------------------------------------------------

read -p "Entrez votre numéro de département (ex: 3) : " DEPT_ID

# Validation Dept
if [[ ! "$DEPT_ID" =~ ^[0-9]+$ ]]; then
    echo "Erreur : Numéro de département invalide."
    exit 1
fi

# 2. VARIABLES
# ------------------------------------------------------------------------------
IP_IPBX="192.168.8${DEPT_ID}.2"
NETMASK="24"
GATEWAY="192.168.8${DEPT_ID}.1"

URL_BASE="http://centre.gtr.tp/TextesTP/Asterisk-base-SAE33-p8-Deb12-20241119"

echo "--------------------------------------------------"
echo "RÉSUMÉ CONFIGURATION :"
echo " - Dept       : $DEPT_ID"
echo " - Interface  : $INTERFACE (Validée)"
echo " - IP Future  : $IP_IPBX"
echo "--------------------------------------------------"
echo "Appuyez sur Entrée pour lancer l'installation (INTERNET REQUIS)..."
read

# 3. INSTALLATION
# ------------------------------------------------------------------------------
echo "[1/4] Installation des paquets..."
apt-get update
apt-get install -y asterisk asterisk-core-sounds-fr wget curl ifupdown tftpd-hpa

# 4. TÉLÉCHARGEMENT & CONFIGURATION ASTERISK
# ------------------------------------------------------------------------------
echo "[2/4] Configuration Asterisk (PJSIP)..."
cd /etc/asterisk
mkdir -p backup_vieux
mv extensions.conf modules.conf pjsip.conf voicemail.conf backup_vieux/ 2>/dev/null

# Téléchargement
wget -q "${URL_BASE}/extensions.conf"
wget -q "${URL_BASE}/modules.conf"
wget -q "${URL_BASE}/pjsip.conf"
wget -q "${URL_BASE}/voicemail.conf"

if [ ! -f pjsip.conf ]; then
    echo "ERREUR : Téléchargement échoué. Vérifiez l'URL ou internet."
    exit 1
fi

# Remplacement des variables
sed -i "s/NUMPAIL=[0-9]*/NUMPAIL=${DEPT_ID}/g" extensions.conf
sed -i "s/pail[0-9]*@/pail${DEPT_ID}@/g" voicemail.conf

# Adaptation PJSIP
sed -i "s/_p8/_p${DEPT_ID}/g" pjsip.conf
sed -i "s/-p8/-p${DEPT_ID}/g" pjsip.conf
sed -i "s/:p8@/:p${DEPT_ID}@/g" pjsip.conf

cat >> /etc/asterisk/pjsip.conf <<EOF

; --- TRUNK VERS LE CENTREX (10.4.110.250) ---
[reg_centrex]
type=registration
outbound_auth=auth_centrex
server_uri=sip:10.4.110.250
client_uri=sip:siteC@10.4.110.250
retry_interval=60

[auth_centrex]
type=auth
auth_type=userpass
password=azerty
username=siteC

[aor_centrex]
type=aor
contact=sip:10.4.110.250

[endpoint_centrex]
type=endpoint
context=from-centrex
disallow=all
allow=alaw
allow=ulaw
outbound_auth=auth_centrex
aors=aor_centrex
direct_media=no

tos_audio=ef
cos_audio=5
tos_sip=cs3
cos_sip=3
EOF

# 2. Configuration EXTENSIONS (Le routage sortant)
# Attention : Le \ devant $EXTEN est obligatoire dans un script bash !
cat >> /etc/asterisk/extensions.conf <<EOF

[sortant]
; Routage vers les autres sites via le Trunk Prof
exten => _[124569]XXXX,1,Dial(PJSIP/\${EXTEN}@endpoint_centrex)
EOF

# Permissions et redémarrage
chown asterisk:asterisk *.conf
chmod 640 *.conf
systemctl restart asterisk

# CONFIGURATION TFTP (Pour les téléphones)
# ------------------------------------------------------------------------------
echo "[INFO] Configuration du serveur TFTP..."
cat > /etc/default/tftpd-hpa <<EOF
TFTP_USERNAME="tftp"
TFTP_DIRECTORY="/srv/tftp"
TFTP_ADDRESS="0.0.0.0:69"
TFTP_OPTIONS="--secure"
EOF

# On crée le dossier et on donne les droits
mkdir -p /srv/tftp
chown -R tftp:tftp /srv/tftp
chmod -R 777 /srv/tftp
systemctl restart tftpd-hpa

# 5. CONFIGURATION RÉSEAU PERSISTANTE
# ------------------------------------------------------------------------------
echo "[3/4] Écriture de /etc/network/interfaces..."
cat > /etc/network/interfaces <<EOF
# Config Dept $DEPT_ID
auto lo
iface lo inet loopback

auto $INTERFACE
iface $INTERFACE inet static
    address $IP_IPBX
    netmask 255.255.255.0
    gateway $GATEWAY
    dns-nameservers 10.4.110.251
    dns-search gtr.tp
EOF

# 6. APPLICATION IMMÉDIATE DE L'IP
# ------------------------------------------------------------------------------
echo "[4/4] Bascule sur l'IP du TP ($IP_IPBX)..."
echo "ATTENTION : Coupure Internet imminente."

# On utilise la variable $INTERFACE partout pour ne pas se tromper
ip addr flush dev $INTERFACE
ip addr add $IP_IPBX/$NETMASK dev $INTERFACE
ip link set $INTERFACE up
ip route add default via $GATEWAY dev $INTERFACE 2>/dev/null

echo "=================================================="
echo " TERMINÉ ! "
echo "=================================================="
echo "Vérification :"
echo "1. IP : ip a show $INTERFACE"
echo "2. Asterisk : /usr/sbin/asterisk -rvvv"
echo "3. Voir les téléphones connectés : pjsip show endpoints"
echo "4. Voir la connexion au "Monde" : pjsip show registrations"
