// competence_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;
import 'package:portofolio/main.dart' show Lang; // on réutilise l'enum

class CompetenceWindow extends StatelessWidget {
  final Lang lang;
  const CompetenceWindow({super.key, required this.lang});

  bool get isFr => lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  @override
  Widget build(BuildContext context) {
    return MacOSProjectWindow(
      title: tr('Compétences', 'Skills'),
      content: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            tr('Compétences techniques', 'Technical skills'),
            style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),

        // Cartes compétences techniques
        Wrap(
          spacing: 16, runSpacing: 16,
          children: [
            _skillCard(
              tr('Wireshark','Wireshark'),
              tr('Étude des couches protocolaires','Study of protocol layers'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/wi.png',
            ),
            _skillCard(
              tr('Packet Tracer','Packet Tracer'),
              tr('Conception d’une topologie réseau','Network topology design'),
              tr('Avancé','Advanced'),
              'assets/images/cis.png',
            ),
            _skillCard(
              tr('Cisco','Cisco'),
              tr('Création et administration d’un réseau local','LAN setup and administration'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/cisc.jpg',
            ),
            _skillCard(
              'C#',
              tr('Maîtrise du langage C#','C# language proficiency'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/c#.png',
            ),
            _skillCard(
              'Linux',
              tr('Administration sous Linux, création de scripts','Linux administration, scripting'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/linu.png',
            ),
            _skillCard(
              'HTML5|CSS3|JS|PHP',
              tr('Création de site-web responsive','Responsive website creation'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/ph.png',
            ),
            _skillCard(
              'Python',
              tr('Codage de l’information','Programming (data processing)'),
              tr('Intermédiaire','Intermediate'),
              'assets/images/py.png',
            ),
            _skillCard(
              tr('Raspberry','Raspberry'),
              tr('Initiation au codage de l’information','Intro to embedded coding'),
              tr('Débutant','Beginner'),
              'assets/images/ra.png',
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Soft Skills',
            style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),

        // Soft skills
        Wrap(
          spacing: 16, runSpacing: 16,
          children: [
            _softSkillCard(tr('🤷‍♀️ Autonome','🤷‍♀️ Autonomous')),
            _softSkillCard(tr('💪 Motivé','💪 Motivated')),
            _softSkillCard(tr('🗣️ Sens du contact','🗣️ People skills')),
            _softSkillCard(tr('🫱 Travail en équipe','🫱 Teamwork')),
          ],
        ),
      ],
    );
  }

  static Widget _skillCard(String title, String desc, String level, String iconPath) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 48, height: 48),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(
            (level.isNotEmpty)
              ? (title == 'HTML5|CSS3|JS|PHP' ? '${_prefixLevel(level)}$level' : '${_prefixLevel(level)}$level')
              : '',
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  static String _prefixLevel(String level) {
    // petite aide pour “Niveau: ” / “Level: ”
    // on détecte FR via mots-clés connus
    final frLevels = {'Débutant','Intermédiaire','Avancé'};
    final isFr = frLevels.contains(level);
    return isFr ? 'Niveau: ' : 'Level: ';
  }

  static Widget _softSkillCard(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF394865),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }
}
