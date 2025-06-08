import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWindow extends StatefulWidget {
  const ContactWindow({super.key});

  @override
  State<ContactWindow> createState() => _ContactWindowState();
}

class _ContactWindowState extends State<ContactWindow> {
  bool _isMaximized = false;

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _handleShare() {
    final url = Uri.base.toString();
    final text = Uri.encodeComponent("Découvrez ce superbe portfolio ! $url");
    final shareUrl = 'https://wa.me/?text=$text';
    _launchUrl(shareUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isMaximized ? 440 : 380,
          height: _isMaximized ? 600 : 560,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withOpacity(0.98),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 24,
                spreadRadius: 4,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    _macosControl(const Color(0xFFFF605C), () => Navigator.of(context).pop()),
                    const SizedBox(width: 8),
                    _macosControl(const Color(0xFFFFBD2E), () => setState(() => _isMaximized = false)),
                    const SizedBox(width: 8),
                    _macosControl(const Color(0xFF28C940), () => setState(() => _isMaximized = !_isMaximized)),
                    const Spacer(),
                    const Text("Contact", style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Jérémy Girard',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Etudiant',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _contactIcon(Icons.call, 'appel', () => _launchUrl('tel:+33783645695')),
                    _contactIcon(Icons.mail, 'mail', () => _launchUrl('https://mail.google.com/mail/?view=cm&to=jeremy@example.com&su=Contact%20depuis%20le%20portfolio&body=Bonjour%20Jérémy')),
                    _contactIcon(Icons.language, 'web', () => _launchUrl('https://jeremy.dev')),
                    _contactIcon(Icons.share, 'partager', _handleShare),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white24),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('téléphone   +33 7 83 64 56 95', style: TextStyle(color: Colors.white)),
                ),
                const Divider(color: Colors.white24),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('email   jeremy.girard@etu.unice.fr', style: TextStyle(color: Colors.white)),
                ),
                const Divider(color: Colors.white24),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text('site web  https://jeremy.dev', style: TextStyle(color: Colors.white)),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => const AboutMeWindow(),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    backgroundColor: Colors.grey[700],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('À propos de moi', style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactIcon(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue,
            child: Icon(icon, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white))
      ],
    );
  }

  Widget _macosControl(Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 2,
                offset: const Offset(0.5, 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboutMeWindow extends StatelessWidget {
  const AboutMeWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('À propos de moi', style: TextStyle(color: Colors.white)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/images/avatar.png')),
            SizedBox(height: 12),
            Text('Jérémy Girard', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Etudiant', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '🎓 Étudiant en Réseaux et Télécommunications à l’Université Côte d’Azur, je développe mes compétences en programmation, cybersécurité et gestion des réseaux. Passionné par les nouvelles technologies, je suis en quête constante d’apprentissage pour approfondir mes connaissances dans ces différents domaines.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '💡 Curieux, autonome et rigoureux, je cherche à évoluer dans les domaines des réseaux et de la cybersécurité en mettant à profit mes compétences techniques et ma curiosité.',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fermer', style: TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}