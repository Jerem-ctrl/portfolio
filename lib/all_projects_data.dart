// all_projects_data.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
import 'package:portofolio/main.dart' show Lang;

List<Widget> getAllProjects(Lang lang) {
  bool isFr = lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  return [
    // === INITIATIVE PROGRAMMATION ===

    FeaturedProjectCard(
      title: tr("🛡️ Audit & Pentest Infrastructure Docker", 
                "🛡️ Docker Infrastructure Audit & Pentest"),
      category: tr("Cybersécurité & Sécurité Offensive", 
                   "Cybersecurity & Offensive Security"),
      shortDescription: tr(
        "Test d'intrusion (Pentest) en boîte noire : exploitation de failles critiques (RCE), pivot réseau et exfiltration de données.",
        "Black-box penetration test: exploitation of critical vulnerabilities (RCE), network pivoting, and data exfiltration.",
      ),
      fullDescription: tr(
        "Dans le cadre d'une mission de sécurité offensive, j'ai réalisé un audit complet d'une infrastructure conteneurisée (Docker). L'objectif était d'éprouver la résistance du système face à une attaque externe sans information préalable (Boîte Noire).\n\n"
        "Le scénario d'attaque s'est déroulé en plusieurs phases techniques :\n"
        "• Reconnaissance : Identification des services via Nmap, révélant un serveur de fichiers vulnérable.\n"
        "• Exploitation : Utilisation de la vulnérabilité 'SambaCry' (CVE-2017-7494) via Metasploit pour obtenir un accès Root à distance.\n"
        "• Mouvement Latéral (Pivot) : Mise en place d'un tunnel SSH pour contourner la segmentation réseau et atteindre la zone interne protégée.\n"
        "• Compromission Finale : Attaque de l'application web interne et exfiltration de la base de données clients.\n\n"
        "Ce projet a abouti à la rédaction d'un rapport d'audit professionnel incluant l'analyse des risques et des recommandations de durcissement (Hardening).",
        
        "As part of an offensive security mission, I conducted a comprehensive audit of a containerized infrastructure (Docker). The goal was to test system resilience against an external attack with zero prior knowledge (Black Box).\n\n"
        "The attack scenario involved several technical phases:\n"
        "• Reconnaissance: Service identification via Nmap, revealing a vulnerable file server.\n"
        "• Exploitation: Leveraging the 'SambaCry' vulnerability (CVE-2017-7494) via Metasploit to gain remote Root access.\n"
        "• Lateral Movement (Pivoting): Establishing an SSH tunnel to bypass network segmentation and reach the protected internal zone.\n"
        "• Final Compromise: Attacking the internal web application and exfiltrating the client database.\n\n"
        "This project concluded with a professional audit report including risk analysis and hardening recommendations."
      ),
      image: "assets/images/pentest_docker_cover.webp", // Mets l'image du schéma d'architecture ici
      gallery: [
        "assets/images/Sae34Presentation.png",
        "assets/images/Sae34Sommaire.png",
        "assets/images/Sae34Perimetre01.png",
        "assets/images/Sae34Perimetre02.png",
        "assets/images/Sae34CompromissionInitial01.png",
        "assets/images/Sae34CompromissionInitial02.png",
        "assets/images/Sae34Pivotage01.png",
        "assets/images/Sae34Pivotage02.png",
        "assets/images/Sae34CompromissionAppWeb01.png",
        "assets/images/Sae34CompromissionAppWeb02.png",
        "assets/images/Sae34CompromissionAppWeb03.png",
        "assets/images/Sae34CompromissionAppWeb04.png",
        "assets/images/Sae34Recommandation01.png",
        "assets/images/Sae34Recommandation02.png",
        "assets/images/Sae34Conclusion.png",
      ],
      competencies: [
        tr("Test d'intrusion & Audit (Black Box)", 
           "Penetration Testing & Auditing (Black Box)"),
        tr("Exploitation de vulnérabilités (SambaCry, RCE)", 
           "Vulnerability Exploitation (SambaCry, RCE)"),
        tr("Mouvement latéral & Pivot réseau (SSH Tunneling)", 
           "Lateral Movement & Network Pivoting (SSH Tunneling)"),
        tr("Rédaction de rapports d'audit & Recommandations", 
           "Audit Reporting & Remediation Recommendations"),
        tr("Outils : Metasploit, Nmap, Wireshark, Docker", 
           "Tools: Metasploit, Nmap, Wireshark, Docker"),
      ],
      // J'ai mis un lien générique, pense à créer le repo sur ton GitHub si tu veux partager le rapport
      githubUrl: "https://jerem-ctrl.github.io/portfolio/pentest_docker/index.html",
    ),
    const SizedBox(height: 24),

    StandardProjectCard(
      title: tr("Systèmes de Transmission & Traitement Multimédia",
                "Transmission Systems & Multimedia Processing"),
      category: tr("Télécommunications & Dev Python",
                   "Telecommunications & Python Dev"),
      shortDescription: tr(
        "Analyse des normes de diffusion TV (DVB-T/Satellite) et développement d'un studio logiciel de traitement de signal.",
        "Analysis of TV broadcasting standards (DVB-T/Satellite) and development of a signal processing software studio.",
      ),
      fullDescription: tr(
        "Ce projet double volet explore la chaîne complète de transmission de l'information.\n\n"
        "1. Ingénierie des Transmissions : Étude approfondie des infrastructures de diffusion numérique (DVB-T, Satellite), incluant le codage de canal, la modulation (QAM, QPSK) et le multiplexage OFDM pour assurer l'intégrité du signal.\n"
        "2. Développement Outil 'CodecPlayer' : Conception d'une application Python interactive (basée sur GStreamer et IPyWidgets) permettant de manipuler des flux audio/vidéo, de visualiser leur spectre fréquentiel et de comparer l'impact de la quantification et des codecs en temps réel.",
        
        "This dual-faceted project explores the complete information transmission chain.\n\n"
        "1. Transmission Engineering: In-depth study of digital broadcasting infrastructures (DVB-T, Satellite), including channel coding, modulation (QAM, QPSK), and OFDM multiplexing to ensure signal integrity.\n"
        "2. 'CodecPlayer' Tool Development: Design of an interactive Python application (based on GStreamer and IPyWidgets) to manipulate audio/video streams, visualize their frequency spectrum, and compare the impact of quantization and codecs in real-time.",
      ),
      image: "assets/images/transmission_studio_main.gif",
      gallery: [
        "assets/images/Sae31Interface.png",
        "assets/images/Sae31Stereo.png",
        "assets/images/Sae31Spectre.png",
        "assets/images/Sae31Analyse.png",
        "assets/images/Sae31Quantification2bits.png",
        "assets/images/Sae31Quantification4bits.png",
        "assets/images/Sae31Quantification8bits.png",
        "assets/images/Sae31Quantification12bits.png",
        "assets/images/Sae31Gstreamer.jpeg",
        "assets/images/Sae31Jupyter.png",
        "assets/images/Sae31Cr (1).jpg",
        "assets/images/Sae31Cr (2).jpg",
        "assets/images/Sae31Cr (3).jpg",
        "assets/images/Sae31Cr (4).jpg",
        "assets/images/Sae31Cr (5).jpg",
        "assets/images/Sae31Cr (6).jpg",
        "assets/images/Sae31Cr (7).jpg",
        "assets/images/Sae31Cr (8).jpg",
        "assets/images/Sae31Cr (9).jpg",
        "assets/images/Sae31Cr (10).jpg",
        "assets/images/Sae31Cr (11).jpg",
        "assets/images/Sae31Cr (12).jpg",
        "assets/images/Sae31Cr (13).jpg",
        "assets/images/Sae31Cr (14).jpg",
        "assets/images/Sae31Cr (15).jpg",
        "assets/images/Sae31Cr (16).jpg",
        "assets/images/Sae31Cr (17).jpg",
        "assets/images/Sae31Cr (18).jpg",
        "assets/images/Sae31Cr (19).jpg",
        "assets/images/Sae31Cr (20).jpg",
        "assets/images/Sae31Cr (21).jpg",
        "assets/images/Sae31Cr (22).jpg",
        "assets/images/Sae31Cr (23).jpg",
        "assets/images/Sae31Cr (24).jpg",
        "assets/images/Sae31Cr (25).jpg",
        "assets/images/Sae31Cr (26).jpg",
        "assets/images/Sae31Cr (27).jpg",
        "assets/images/Sae31Cr (28).jpg",
        "assets/images/Sae31Cr (29).jpg",
        "assets/images/Sae31Cr (30).jpg",
        "assets/images/Sae31Cr (31).jpg",
        "assets/images/Sae31Cr (32).jpg",
        "assets/images/Sae31Cr (33).jpg",
        "assets/images/Sae31Cr (34).jpg",
        "assets/images/Sae31Cr (35).jpg",
        "assets/images/Sae31Cr (36).jpg",
        "assets/images/Sae31Cr (37).jpg",
      ],
      competencies: [
        tr("Traitement du signal : Modulation, Multiplexage (OFDM), Correction d'erreurs",
           "Signal Processing: Modulation, Multiplexing (OFDM), Error Correction"),
        tr("Développement Python avancé (GStreamer, Matplotlib, IPyWidgets)",
           "Advanced Python Development (GStreamer, Matplotlib, IPyWidgets)"),
        tr("Analyse spectrale et temporelle de signaux multimédias",
           "Spectral and temporal analysis of multimedia signals"),
        tr("Compréhension des infrastructures de télécommunication (DVB-T)",
           "Understanding of telecommunication infrastructures (DVB-T)"),
      ],

      githubUrl: "https://jerem-ctrl.github.io/portfolio/transmission_ascii/index.html", 
    ),

    StandardProjectCard(
      title: tr("Application Android de Surveillance Réseau",
                "Android Network Monitoring App"),
      category: tr("Développement Mobile & Cybersécurité",
                   "Mobile Development & Cybersecurity"),
      shortDescription: tr(
        "Application mobile connectée pour l'audit de sécurité réseau et la visualisation de vulnérabilités en temps réel.",
        "Connected mobile app for network security auditing and real-time vulnerability visualization.",
      ),
      fullDescription: tr(
        "Ce projet vise à simplifier l'audit de sécurité via une application Android communicante. L'architecture repose sur trois piliers : un serveur Java effectuant des scans réseaux (Nmap) et détectant les vulnérabilités (CVE), une API Web (PHP) faisant l'interface, et l'application mobile affichant les résultats. L'utilisateur peut ainsi surveiller les équipements connectés, voir les ports ouverts et recevoir des alertes de sécurité directement sur son smartphone.",
        "This project aims to simplify security auditing via a communicating Android app. The architecture rests on three pillars: a Java server performing network scans (Nmap) and detecting vulnerabilities (CVE), a Web API (PHP) acting as an interface, and the mobile app displaying results. Users can monitor connected devices, view open ports, and receive security alerts directly on their smartphone.",
      ),
      image: "assets/images/sae302_dashboard.gif",
      gallery: [
        "assets/images/Sae32Presentation.png",
        "assets/images/Sae32Sommaire.png",
        "assets/images/Sae32Introduction.png",
        "assets/images/Sae32Gestion.png",
        "assets/images/Sae32Raci.png",
        "assets/images/Sae32Architecture.png",
        "assets/images/Sae32Schema.png",
        "assets/images/Sae32BaseDeDonnees.png",
        "assets/images/Sae32Dashboard.png",
        "assets/images/Sae32Developpement.png",
        "assets/images/Sae32Liaison.png",
        "assets/images/Sae32DeveloppementApplication.png",
        "assets/images/Sae32Problemes.png",
        "assets/images/Sae32Conclusion.png",
      ],
      competencies: [
        tr("Développement Mobile Android (Java/Android Studio)",
           "Android Mobile Development (Java/Android Studio)"),
        tr("Conception et consommation d'API REST (PHP/JSON)",
           "REST API Design & Consumption (PHP/JSON)"),
        tr("Automatisation de scans réseaux (Nmap, Serveur Java)",
           "Network Scan Automation (Nmap, Java Server)"),
        tr("Gestion de base de données et authentification sécurisée",
           "Database Management & Secure Authentication"),
      ],
      githubUrl: "https://jerem-ctrl.github.io/portfolio/android_app/index.html",
    ),

    StandardProjectCard(
      title: tr("HighDef — Analyse Audio Haute Définition", "HighDef — HD Audio Analysis"),
      category: tr("Traitement du signal", "Signal processing"),
      shortDescription: tr("Mesure rapide d’un signal audio.",
                          "Fast measurement of an audio signal."),
      fullDescription: tr(
        "Le projet HighDef est une étude en trois phases portant sur la comparaison entre la qualité audio Haute Définition (HD) et Simple Définition (SD). Il vise à déterminer si l’amélioration de la qualité perçue est significative, justifiant l’usage de formats audio HD.",
        "HighDef is a three-phase study comparing High Definition (HD) and Standard Definition (SD) audio quality to assess whether the perceived improvement is significant enough to justify HD formats.",
      ),
      image: "assets/images/tss.jpg",
      gallery: [
        "assets/images/sae22frt.png",
        "assets/images/sae22ism.png",
        "assets/images/sae22plt.png",
        "assets/images/sae22rad1.png",
        "assets/images/sae22spectre.png",
        "assets/images/sae22trs1.png",
      ],
      competencies: [
        tr("Extraction et analyse de caractéristiques audio (RMS, spectre, dynamique)",
           "Feature extraction & analysis (RMS, spectrum, dynamics)"),
        tr("Utilisation de bibliothèques Python (NumPy, SciPy, Matplotlib)",
           "Python libs (NumPy, SciPy, Matplotlib)"),
        tr("Visualisation de signaux dans le domaine temporel et fréquentiel",
           "Time/frequency-domain visualization"),
        tr("Interprétation de résultats expérimentaux et rédaction scientifique",
           "Experimental result analysis & technical writing"),
      ],
      githubUrl: "https://github.com/Jerem-ctrl/HighDef",
    ),

    StandardProjectCard(
      title: tr('Interface Web embarquée pour Thales',
                'Embedded Web Interface for Thales'),
      category: tr('Projet Web & Système embarqué',
                   'Web Project & Embedded System'),
      shortDescription: tr(
        "Conception d'une interface web sécurisée pour banc avionique dans le cadre d’un projet Thales.",
        "Design of a secure web interface for an avionics test bench as part of a Thales project.",
      ),
      fullDescription: tr(
        "Ce projet a consisté à développer une interface web intuitive permettant de prendre, visualiser et gérer des photos dans le cadre de la SAE 23. L’objectif principal était de concevoir une plateforme accessible à distance, avec authentification sécurisée et journalisation des actions utilisateur, le tout dans un environnement embarqué.",
        "Built an intuitive web interface to take, view, and manage photos (SAE 23). Focus on remote access, secure authentication, and user action logging in an embedded environment.",
      ),
      image: 'assets/images/sae23php1.jpg',
      gallery: [
        'assets/images/sae23php2.png',
        'assets/images/sae23php3.png',
        'assets/images/sae23php4.png',
        'assets/images/sae23php5.png',
        'assets/images/sae23php6.png',
        'assets/images/sae23php7.png',
        'assets/images/sae23php8.png',
        'assets/images/sae23php9.png',
        'assets/images/sae23php10.png',
        'assets/images/sae23php11.png',
        'assets/images/sae23php12.png',
        'assets/images/sae23php13.png',
      ],
      competencies: [
        tr('Développement front-end en HTML, CSS et JavaScript pour une interface responsive',
           'Responsive front-end in HTML, CSS, JavaScript'),
        tr('Intégration d’un serveur web léger avec routage et gestion des sessions',
           'Lightweight web server with routing & sessions'),
        tr('Implémentation de fonctionnalités de sécurité (authentification, logging)',
           'Security features (auth, logging)'),
        tr('Gestion des formulaires et traitement des données utilisateur côté serveur',
           'Form handling and server-side processing'),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Secure_Embedded_Web_Interface_for_Thales',
    ),

    StandardProjectCard(
      title: tr('Système de traçabilité Photo embarqué pour Banc Avionique',
                'Embedded Photo-Logging System for Avionics'),
      category: tr('Systèmes embarqués & Programmation Python',
                   'Embedded Systems & Python'),
      shortDescription: tr(
        "Développement d’un système embarqué permettant la capture et la gestion sécurisée de photos sur un banc de test avionique, avec interface web, authentification et traçabilité des actions.",
        "Embedded system to capture and securely manage photos on an avionics bench with web UI, authentication, and action logging.",
      ),
      fullDescription: tr(
        "Dans le cadre de la SAE 24, ce projet visait à développer un système de capture photo embarqué sur Raspberry Pi, destiné à documenter les modifications sur un banc de test avionique. En combinant Python, un microcontrôleur Pico WH, une caméra USB, et des composants GPIO (LED, boutons, etc.), le système permet la prise de photos automatique ou manuelle avec gestion de l’éclairage. L'ensemble s’intègre à une interface web sécurisée développée lors de la SAE 23, pour assurer la traçabilité et l’accessibilité des images à distance.",
        "As part of SAE 24, built a Raspberry Pi-based photo capture system to document changes on a test bench. Python + Pico WH + USB camera + GPIO (LEDs, buttons). Automatic/manual shots with light control and a secure web interface (from SAE 23) for remote traceability.",
      ),
      image: 'assets/images/sae24py1.webp',
      gallery: [
        'assets/images/sae24py2.png',
        'assets/images/sae24py3.png',
        'assets/images/sae24py4.png',
        'assets/images/sae24py5.png',
        'assets/images/sae24py6.png',
        'assets/images/sae24py7.png',
        'assets/images/sae24py8.png',
      ],
      competencies: [
        tr('Programmation Python embarquée','Embedded Python programming'),
        tr('Utilisation de Raspberry Pi et microcontrôleur','Raspberry Pi & microcontroller use'),
        tr('Communication série (UART)','Serial communication (UART)'),
        tr('Intégration de périphériques (caméra, GPIO)','Peripheral integration (camera, GPIO)'),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Embedded_Photo-Logging_System_for_Avionics',
    ),

    // === INITIATIVE RÉSEAUX ===

    FeaturedProjectCard(
      title: tr("🌐 Architecture Réseau Multi-Site : VPN & Haute Disponibilité",
                "🌐 Secure Multi-Site Architecture: VPN & High Availability"),
      category: tr("Ingénierie Réseau & Infrastructure",
                   "Network Engineering & Infrastructure"),
      shortDescription: tr(
        "Infrastructure multi-sites : VPN (IPSec/SSL), Haute Disponibilité (HSRP) et Sécurité.",
        "Design of a corporate infrastructure connecting three critical sites: VPN Tunnels (IPSec/SSL), High Availability (HSRP), and Advanced Security.",
      ),
      fullDescription: tr(
        "Ce projet d'ingénierie simule la refonte complète d'une infrastructure réseau répartie sur trois sites géographiques. L'enjeu majeur était de garantir une continuité de service totale et une confidentialité des échanges inter-sites.\n\n"
        "J'ai déployé une architecture hiérarchique Cisco intégrant :\n"
        "• Interconnexion Cryptée : Mise en place de tunnels VPN IPSec (Site-à-Site) pour relier les agences et de VPN SSL pour les accès distants sécurisés.\n"
        "• Haute Disponibilité : Implémentation du protocole HSRP pour la redondance des passerelles et RSTP pour la résilience de niveau 2.\n"
        "• Routage & Sécurité Renforcée : Configuration d'OSPF multi-aires, filtrage périmétrique via pare-feu ASA et verrouillage des accès locaux (DHCP Snooping, DAI, Port-Security).",
        
        "This engineering project simulates the complete overhaul of a network infrastructure distributed across three geographic sites. The main goal was to ensure total service continuity and confidentiality of inter-site exchanges.\n\n"
        "I deployed a hierarchical Cisco architecture integrating:\n"
        "• Encrypted Interconnection: Implementation of IPSec VPN tunnels (Site-to-Site) to connect branches and SSL VPN for secure remote access.\n"
        "• High Availability: Implementation of HSRP protocol for gateway redundancy and RSTP for Layer 2 resilience.\n"
        "• Routing & Hardened Security: Multi-area OSPF configuration, perimeter filtering via ASA firewalls, and local access locking (DHCP Snooping, DAI, Port-Security).",
      ),
      image: "assets/images/Sae33.webp",
      gallery: [
        "assets/images/Sae33Padedegarde.png",
        "assets/images/Sae33Sommaire.png",
        "assets/images/Sae33VisionStratégique.png",
        "assets/images/Sae33Contexte.png",
        "assets/images/Sae33Perimetre.png",
        "assets/images/Sae33Architecture.png",
        "assets/images/Sae33Conception01.png",
        "assets/images/Sae33Conception02.png",
        "assets/images/Sae33Peripherie.png",
        "assets/images/Sae33Strategie.png",
        "assets/images/Sae33Decoupage.png",
        "assets/images/Sae33Gestion.png",
        "assets/images/Sae33Haute.png",
        "assets/images/Sae33Redondance.png",
        "assets/images/Sae33RedondanceDeNiveau2.png",
        "assets/images/Sae33ProtocoleDeRoutage.png",
        "assets/images/Sae33Routage.png",
        "assets/images/Sae33RoutageStatique.png",
        "assets/images/Sae33ArchitectureDeSecurite.png",
        "assets/images/Sae33Securite.png",
        "assets/images/Sae33Reseaux.png",
        "assets/images/Sae33SecuriteDeLaCouche.png",
        "assets/images/Sae33Infrastructure.png",
        "assets/images/Sae33GestionDeProjet.png",
        "assets/images/Sae33Diffusion.png",
        "assets/images/Sae33Test.png",
        "assets/images/Sae33Conclusion.png",
      ],
      competencies: [
        tr("Déploiement de tunnels VPN IPSec et SSL (Site-to-Site / Remote Access)",
           "Deployment of IPSec & SSL VPN tunnels (Site-to-Site / Remote Access)"),
        tr("Conception d'architecture Haute Disponibilité (HSRP, RSTP)",
           "High Availability Architecture Design (HSRP, RSTP)"),
        tr("Routage dynamique avancé (OSPF Multi-Area)",
           "Advanced Dynamic Routing (OSPF Multi-Area)"),
        tr("Sécurisation des couches accès et distribution (ACL, DAI, Port-Sec)",
           "Access & Distribution Layer Security (ACL, DAI, Port-Sec)"),
      ],
      githubUrl: 'https://jerem-ctrl.github.io/portfolio/network_infra/index.html',
    ),
    const SizedBox(height: 24),

    StandardProjectCard(
      title: tr("Infrastructure Fibre Optique & Réflectométrie",
                "Fiber Optic Infrastructure & Reflectometry"),
      category: tr("Télécommunications & Infrastructure Réseau",
                   "Telecommunications & Network Infrastructure"),
      shortDescription: tr(
        "Déploiement et certification de liaisons optiques : Soudure par fusion, Photométrie et Diagnostic OTDR.",
        "Deployment and certification of optical links: Fusion splicing, Photometry, and OTDR diagnostics.",
      ),
      fullDescription: tr(
        "Ce projet couvre l'intégralité du cycle de vie physique d'une liaison fibre optique, de l'installation à la maintenance experte.\n\n"
        "1. Ingénierie de Déploiement : Préparation des câbles (dénudage, clivage de précision) et raccordement par soudure à l'arc (fusionneuse) avec protection thermorétractable (SMOUV).\n"
        "2. Certification & Métrologie : Validation des pertes d'insertion par photométrie (Source Laser calibrée/Radiomètre) et qualification des connecteurs.\n"
        "3. Diagnostic Avancé (OTDR) : Analyse par réflectométrie temporelle pour cartographier la liaison. Interprétation des courbes pour localiser précisément les défauts (épissures, contraintes, connecteurs), mesurer l'atténuation linéique (dB/km) et la réflectance.",
        
        "This project covers the entire physical lifecycle of a fiber optic link, from installation to expert maintenance.\n\n"
        "1. Deployment Engineering: Cable preparation (stripping, precision cleaving) and connection via arc fusion splicing with heat-shrink protection.\n"
        "2. Certification & Metrology: Validation of insertion losses via photometry (Calibrated Laser Source/Radiometer) and connector qualification.\n"
        "3. Advanced Diagnostics (OTDR): Time-domain reflectometry analysis to map the link. Interpretation of traces to precisely locate faults (splices, stress, connectors), measure linear attenuation (dB/km), and reflectance.",
      ),
      image: "assets/images/fibre_otdr_trace.gif",
      gallery: [
        "assets/images/fibre_soudure.jpeg",
        "assets/images/fibre_architecture.png",
        "assets/images/fibre_photometrie.png",
      ],
      competencies: [
        tr("Soudure optique par fusion (Arc Fusion Splicing)",
           "Optical Fusion Splicing (Arc Fusion Splicing)"),
        tr("Réflectométrie (OTDR) : Analyse de courbes et localisation de défauts",
           "Reflectometry (OTDR): Trace analysis and fault localization"),
        tr("Photométrie : Bilan de puissance et mesure d'atténuation (dB)",
           "Photometry: Power budget and attenuation measurement (dB)"),
        tr("Connaissance des composants passifs (Coupleurs, Connecteurs SC/APC)",
           "Passive components knowledge (Splitters, SC/APC Connectors)"),
      ],
      githubUrl: "https://jerem-ctrl.github.io/portfolio/fiber_optics/index.html", 
    ),

    StandardProjectCard(
      title: tr("Pentesting Avancé & Analyse Malware",
                "Advanced Pentesting & Malware Analysis"),
      category: tr("Cybersécurité Offensive (Red Team) & Blue Team",
                   "Offensive Cybersecurity (Red Team) & Blue Team"),
      shortDescription: tr(
        "Série d'audits de sécurité complets (Web, Linux, Windows) et analyse forensique de malwares (Crypto-miner).",
        "Series of comprehensive security audits (Web, Linux, Windows) and forensic malware analysis (Crypto-miner).",
      ),
      fullDescription: tr(
        "Ce projet regroupe plusieurs missions d'intrusion éthique et d'analyse de menaces :\n\n"
        "1. Pentest Web & Linux : Exploitation de vulnérabilités critiques (ProFTPD CVE-2015-3306, Injection SQL), élévation de privilèges (SUID, Path Hijacking) et exfiltration de données sur environnements Debian.\n"
        "2. Pentest Windows & AD : Compromission d'un serveur Windows via l'exploit SMB 'EternalBlue' (MS17-010), post-exploitation avec Meterpreter et récupération de flags Administrateur.\n"
        "3. Analyse Malware (Blue Team) : Dissection comportementale d'un binaire malveillant (Crypto-mineur) sur Ubuntu via Sandbox (Any.Run). Identification des IOCs (Indicateurs de Compromission), analyse des connexions C2 et recommandations de remédiation.",
        
        "This project aggregates several ethical hacking and threat analysis missions:\n\n"
        "1. Web & Linux Pentest: Exploitation of critical vulnerabilities (ProFTPD CVE-2015-3306, SQL Injection), privilege escalation (SUID, Path Hijacking), and data exfiltration on Debian environments.\n"
        "2. Windows & AD Pentest: Compromise of a Windows Server via the SMB 'EternalBlue' exploit (MS17-010), post-exploitation using Meterpreter, and retrieval of Administrator flags.\n"
        "3. Malware Analysis (Blue Team): Behavioral dissection of a malicious binary (Crypto-miner) on Ubuntu via Sandbox (Any.Run). Identification of IOCs (Indicators of Compromise), C2 connection analysis, and remediation recommendations.",
      ),
      image: "assets/images/pentest_cover.gif",
      gallery: [
        "assets/images/PentestR (1).jpg",
        "assets/images/PentestR (2).jpg",
        "assets/images/PentestR (3).jpg",
        "assets/images/PentestR (4).jpg",
        "assets/images/PentestR (5).jpg",
        "assets/images/PentestR (6).jpg",
        "assets/images/PentestR (7).jpg",
        "assets/images/PentestR (8).jpg",
        "assets/images/PentestR (9).jpg",
        "assets/images/PentestR (10).jpg",
        "assets/images/PentestR (11).jpg",
        "assets/images/PentestR (12).jpg",
        "assets/images/PentestR (13).jpg",
        "assets/images/PentestR (14).jpg",
        "assets/images/PentestR (15).jpg",
        "assets/images/PentestR (16).jpg",
        "assets/images/PentestR (17).jpg",
        "assets/images/PentestR (18).jpg",
        "assets/images/PentestR (19).jpg",
        "assets/images/PentestR (20).jpg",
        "assets/images/PentestR (21).jpg",
        "assets/images/PentestR (22).jpg",
        "assets/images/PentestR (23).jpg",
        "assets/images/PentestR (24).jpg",
        "assets/images/PentestR (25).jpg",
        "assets/images/PentestR (26).jpg",
        "assets/images/PentestR (27).jpg",
        "assets/images/PentestR (28).jpg",
      ],
      competencies: [
        tr("Tests d'intrusion (Pentesting) : Méthodologie OWASP, Nmap, Burp Suite, Sqlmap",
           "Penetration Testing: OWASP Methodology, Nmap, Burp Suite, Sqlmap"),
        tr("Exploitation de vulnérabilités : CVE-2015-3306, MS17-010 (EternalBlue), SUID",
           "Vulnerability Exploitation: CVE-2015-3306, MS17-010 (EternalBlue), SUID"),
        tr("Post-Exploitation & Escalade de privilèges (Linux/Windows)",
           "Post-Exploitation & Privilege Escalation (Linux/Windows)"),
        tr("Analyse Forensique & Malware : Sandbox Any.Run, Détection d'IOCs",
           "Forensics & Malware Analysis: Any.Run Sandbox, IOC Detection"),
      ],
      githubUrl: "https://jerem-ctrl.github.io/portfolio/pentest/index.html", 
    ),

    StandardProjectCard(
      title: tr("Infrastructure réseau sécurisée pour PME",
                "Secure Network Infrastructure for SMB"),
      category: tr("Réseaux & Sécurité", "Networking & Security"),
      shortDescription: tr(
        "Ce projet simule une architecture réseau complète pour PME avec VLANs, DNS/DHCP, DMZ, pare-feu ASA, routage et sécurité.",
        "Simulates a full SMB network architecture: VLANs, DNS/DHCP, DMZ, ASA firewall, routing, and security.",
      ),
      fullDescription: tr(
        "Dans le cadre de la SAÉ 21, nous avons conçu l’architecture réseau d’une PME à l’aide de Cisco Packet Tracer. Le projet comprend la configuration de VLANs, de serveurs DHCP/DNS, d’une DMZ avec pare-feu ASA, de routage statique, ainsi que la mise en place de la sécurité via des ACL et du NAT. L’objectif était d’assurer la segmentation, la sécurité et la connectivité complète du réseau d’entreprise.",
        "As part of SAE 21, designed an SMB network with Cisco Packet Tracer: VLANs, DHCP/DNS servers, DMZ with ASA firewall, static routing, ACLs and NAT for secure segmentation and full connectivity.",
      ),
      image: "assets/images/sae21ci1.jpg",
      gallery: [
        "assets/images/sae21ci2.png",
        "assets/images/sae21c3.png",
        "assets/images/sae21c4.png",
        "assets/images/sae21c5.png",
      ],
      competencies: [
        tr("Configuration de VLANs et routage inter-VLAN",
           "VLAN configuration & inter-VLAN routing"),
        tr("Mise en place d’un pare-feu ASA (DMZ, NAT, ACL)",
           "ASA firewall setup (DMZ, NAT, ACL)"),
        tr("Plan d’adressage et configuration DNS/DHCP",
           "Addressing plan + DNS/DHCP configuration"),
        tr("Simulation réseau complète sous Cisco Packet Tracer",
           "End-to-end network simulation in Packet Tracer"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Secure-Network-Infrastructure-for-Small-Businesses',
    ),

    StandardProjectCard(
      title: tr('Analyse de cyberattaques & bonnes pratiques',
                'Analysis of Cyberattacks & Best Practices'),
      category: tr('Cybersécurité & Sensibilisation',
                   'Cybersecurity & Awareness'),
      shortDescription: tr(
        'Étude de cyberattaques réelles et sensibilisation aux menaces numériques.',
        'Study of real-world cyberattacks and awareness of digital threats.',
      ),
      fullDescription: tr(
        'Dans le cadre de la SAÉ 11, nous avons analysé plusieurs cyberattaques connues afin d’en comprendre les mécanismes, les conséquences et les moyens de prévention. Ce travail s’est appuyé sur des recherches approfondies concernant les bonnes pratiques d’hygiène informatique. L’objectif principal était de développer une culture de la cybersécurité et de renforcer les réflexes face aux menaces numériques.',
        'As part of SAE 11, analyzed known cyberattacks to understand mechanisms, impact, and defenses. Emphasis on security hygiene and building a strong cybersecurity culture.',
      ),
      image: 'assets/images/sae11c3.jpg',
      gallery: [
        'assets/images/sae11c4.webp',
        'assets/images/sae11c5.png',
        'assets/images/sae11c6.png',
      ],
      competencies: [
        tr("Comprendre les principes de base de la cybersécurité",
           "Understand cybersecurity fundamentals"),
        tr("Analyser une cyberattaque et ses vecteurs",
           "Analyze attacks and vectors"),
        tr("Identifier les bonnes pratiques d’hygiène informatique",
           "Identify security hygiene best practices"),
        tr("Communiquer efficacement à travers un support pédagogique",
           "Communicate via clear educational material"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
    ),

    StandardProjectCard(
      title: tr('Exploration des réseaux domestiques & impacts énergétiques',
                'Home Networks Exploration & Energy Impact'),
      category: tr('Réseaux & Écoresponsabilité',
                   'Networking & Eco-responsibility'),
      shortDescription: tr(
        'Mise en pratique des connaissances réseaux via l’analyse d’un environnement domestique réel, combinée à une étude de la consommation énergétique des équipements.',
        'Hands-on networking through analysis of a real home environment, plus a study of device energy consumption.',
      ),
      fullDescription: tr(
        'Dans le cadre de la SAÉ 12, nous avons étudié le fonctionnement d’un réseau local domestique à travers l’analyse d’un équipement connecté (ordinateur, smartphone…). Cette démarche comprenait l’identification des composants réseau, l’observation du trafic (IP, DNS, ports) et la représentation schématique de l’infrastructure. En parallèle, une réflexion a été menée sur la consommation énergétique des équipements numériques et leur impact environnemental.',
        'As part of SAE 12, analyzed a home LAN via a connected device (PC, smartphone). Identified network components, observed traffic (IP, DNS, ports), and diagrammed the infrastructure. Also assessed energy consumption and environmental impact.',
      ),
      image: 'assets/images/sae12r3.jpeg',
      gallery: [
        'assets/images/sae12r4.png',
        'assets/images/sae12r5.png',
        'assets/images/sae12r6.png',
        'assets/images/sae12r7.png',
      ],
      competencies: [
        tr("Comprendre et analyser un réseau local (IP, MAC, DHCP, DNS…)",
           "Understand & analyze a LAN (IP, MAC, DHCP, DNS…)"),
        tr("Utiliser des outils de diagnostic réseau (Traceroute, Wireshark)",
           "Use network diagnostics (Traceroute, Wireshark)"),
        tr("Interpréter des données techniques (consommation, émissions CO₂)",
           "Interpret technical data (consumption, CO₂)"),
        tr("Schématiser et documenter une infrastructure réseau personnelle",
           "Diagram & document a personal network"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
    ),
  ];
}