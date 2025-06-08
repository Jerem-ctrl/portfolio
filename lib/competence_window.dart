// Nouveau fichier : competence_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;


class CompetenceWindow extends StatelessWidget {
  const CompetenceWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MacOSProjectWindow(
      title: 'Compétences',
      content: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Compétences techniques',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _skillCard('Wireshark', 'Etude des couches protocolaires', 'Intermédiaire', 'assets/images/wi.png'),
            _skillCard('Packet Tracer', 'Conception d\'une topologie réseau', 'Avancé', 'assets/images/cis.png'),
            _skillCard('Cisco', 'Création et administration d\'un réseau local', 'Intermédiaire', 'assets/images/cisc.jpg'),
            _skillCard('C#', 'Maitrise du langage C#', 'Intermédiaire', 'assets/images/c#.png'),
            _skillCard('Linux', 'Administration sous Linux, création de scripts', 'Intermédiaire', 'assets/images/linu.png'),
            _skillCard('HTML5|CSS3|JS|PHP', 'Création de site-web responsive', 'Intermédiaire', 'assets/images/ph.png'),
            _skillCard('Python', 'Codage de l\'informations', 'Intermédiaire', 'assets/images/py.png'),
            _skillCard('Rasbperry', 'Initiation au codage de l\'informations', 'Débutant', 'assets/images/ra.png'),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'Soft Skills',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _softSkillCard('🤷‍♀️ Autonome'),
            _softSkillCard('💪 Motivé'),
            _softSkillCard('🗣️ Sens du contact'),
            _softSkillCard('🫱 Travail en équipe'),
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
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 48, height: 48),
          const SizedBox(height: 12),
          Text(title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text('Niveau: $level',
              style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
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

