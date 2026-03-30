// competence_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;
import 'package:portofolio/main.dart' show Lang;

class CompetenceWindow extends StatelessWidget {
  final Lang lang;
  const CompetenceWindow({super.key, required this.lang});

  bool get isFr => lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    return MacOSProjectWindow(
      title: tr('Compétences', 'Skills'),
      content: [

        // --- MESSAGE INTRODUCTIF ---
        Padding(
          padding: EdgeInsets.fromLTRB(isMobile ? 16 : 40, 0, isMobile ? 16 : 40, 24),
          child: Text(
            tr(
              "Étudiant en BUT R&T (spécialisation Cybersécurité), j'ai développé mes compétences à travers des projets concrets en réseaux, développement et sécurité offensive.\nParcourez les sections ci-dessous pour découvrir mes outils et niveaux de maîtrise.",
              "As a BUT R&T student (Cybersecurity specialization), I have built my skills through hands-on projects in networking, development, and offensive security.\nBrowse the sections below to explore my tools and proficiency levels.",
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 13,
              height: 1.5,
              fontFamily: '.SF UI Text',
            ),
          ),
        ),

        // --- TITRE SECTION + LÉGENDE DES NIVEAUX ---
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('Compétences techniques', 'Technical Skills'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _legendItem(const Color(0xFF28C840), tr('Avancé', 'Advanced')),
                  const SizedBox(width: 16),
                  _legendItem(const Color(0xFF007AFF), tr('Intermédiaire', 'Intermediate')),
                  const SizedBox(width: 16),
                  _legendItem(const Color(0xFFFF9500), tr('Débutant', 'Beginner')),
                ],
              ),
            ],
          ),
        ),

        // --- GRILLE DE COMPÉTENCES TECHNIQUES ---
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _skillCard(
              tr('Packet Tracer', 'Packet Tracer'),
              tr('Conception de topologies réseau', 'Network topology design'),
              tr('Avancé', 'Advanced'),
              'assets/images/cis.png',
              ['SAE 21', 'SAE 33'],
            ),
            _skillCard(
              tr('Cisco IOS', 'Cisco IOS'),
              tr('Administration & configuration', 'Admin & configuration'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/cisc.jpg',
              ['SAE 21', 'SAE 33'],
            ),
            _skillCard(
              tr('VLAN / VPN', 'VLAN / VPN'),
              tr('Segmentation & tunnels sécurisés', 'Segmentation & secure tunnels'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/reseau.png',
              ['SAE 21', 'SAE 33'],
            ),
            _skillCard(
              tr('OSPF / Routage', 'OSPF / Routing'),
              tr('Routage dynamique multi-aire', 'Multi-area dynamic routing'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/cisco_logo.png',
              ['SAE 33'],
            ),
            _skillCard(
              tr('Linux / Bash', 'Linux / Bash'),
              tr('Administration & scripting', 'Admin & scripting'),
              tr('Avancé', 'Advanced'),
              'assets/images/logo-bash.png',
              ['Pentest Docker', 'Pentest'],
            ),
            _skillCard(
              'Python',
              tr('Traitement de signal & automatisation', 'Signal processing & automation'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/py1.png',
              ['SAE 31', 'SAE 24', 'HighDef'],
            ),
            _skillCard(
              'HTML / CSS / PHP',
              tr('Développement web embarqué', 'Embedded web development'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/php2.png',
              ['SAE 23'],
            ),
            _skillCard(
              'Docker',
              tr('Conteneurisation & sécurité', 'Containerization & security'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/docker_logo.webp',
              ['Pentest Docker'],
            ),
            _skillCard(
              tr('Analyse Réseau', 'Network Analysis'),
              tr('Nmap, Wireshark, TCP/IP', 'Nmap, Wireshark, TCP/IP'),
              tr('Avancé', 'Advanced'),
              'assets/images/wi.png',
              ['SAE 12', 'SAE 34'],
            ),
            _skillCard(
              tr('Pentest Web', 'Web Pentesting'),
              tr('Burp Suite, OWASP, SQLmap', 'Burp Suite, OWASP, SQLmap'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/burp_logo.webp',
              ['SAE 34', 'Pentest'],
            ),
            _skillCard(
              tr('Analyse Malware', 'Malware Analysis'),
              tr("Sandbox, détection d'IOC", 'Sandbox, IOC detection'),
              tr('Débutant', 'Beginner'),
              'assets/images/malware_icon.png',
              ['Pentest'],
            ),
            _skillCard(
              'Raspberry Pi',
              tr('Système embarqué & GPIO', 'Embedded system & GPIO'),
              tr('Débutant', 'Beginner'),
              'assets/images/ra.webp',
              ['SAE 24'],
            ),
            _skillCard(
              'Git',
              tr('Versioning & collaboration', 'Versioning & collaboration'),
              tr('Intermédiaire', 'Intermediate'),
              'assets/images/github.png',
              [],
            ),
          ],
        ),

        const SizedBox(height: 40),

        // --- SOFT SKILLS ---
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Soft Skills',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _softSkillBadge(tr('Curiosité', 'Curiosity'), '🧐'),
            _softSkillBadge(tr('Autonomie', 'Autonomy'), '🚀'),
            _softSkillBadge(tr('Rigueur', 'Rigor'), '🎯'),
            _softSkillBadge(tr('Résolution de problèmes', 'Problem Solving'), '🧩'),
            _softSkillBadge(tr("Travail d'équipe", 'Teamwork'), '🤝'),
          ],
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  // --- LÉGENDE ---
  Widget _legendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // --- CARTE COMPÉTENCE ---
  Widget _skillCard(
    String title,
    String desc,
    String level,
    String iconPath,
    List<String> projects,
  ) {
    final Color levelColor = (level == 'Avancé' || level == 'Advanced')
        ? const Color(0xFF28C840)
        : (level == 'Intermédiaire' || level == 'Intermediate')
            ? const Color(0xFF007AFF)
            : const Color(0xFFFF9500);

    return Container(
      width: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 36,
            height: 36,
            errorBuilder: (c, o, s) =>
                const Icon(Icons.code, color: Colors.white54, size: 36),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white60, fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          // Badge niveau coloré
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: levelColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              level.toUpperCase(),
              style: TextStyle(
                color: levelColor,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Tags projets associés
          if (projects.isNotEmpty) ...[
            const SizedBox(height: 6),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: projects
                  .map(
                    (p) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: Text(
                        p,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  // --- BADGE SOFT SKILL ---
  Widget _softSkillBadge(String text, String emoji) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
