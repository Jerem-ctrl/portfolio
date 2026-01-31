import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portofolio/main.dart' show Lang;

// --- FENÊTRE DE CONTACT ---
class ContactWindow extends StatefulWidget {
  const ContactWindow({super.key});

  @override
  State<ContactWindow> createState() => _ContactWindowState();
}

class _ContactWindowState extends State<ContactWindow> {
  bool _isMaximized = false;
  bool _isMinimized = false; // Pour l'effet "masquer" (réduire à la barre)

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
    final size = MediaQuery.of(context).size;
    
    // Si minimisé (bouton jaune) : on garde juste la barre (44px)
    final double currentHeight = _isMinimized 
        ? 44 
        : (_isMaximized ? 600 : 560);
        
    final double currentWidth = _isMaximized 
        ? size.width 
        : (size.width < 400 ? size.width * 0.9 : 380);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: currentWidth,
          height: currentHeight,
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
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Barre de titre
              GestureDetector(
                 onDoubleTap: () => setState(() => _isMinimized = !_isMinimized),
                 child: Container(
                  height: 44, 
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      _macosControl(const Color(0xFFFF605C), () => Navigator.of(context).pop()),
                      const SizedBox(width: 8),
                      // Bouton Jaune : Réduit (Window Shade)
                      _macosControl(const Color(0xFFFFBD2E), () => setState(() => _isMinimized = !_isMinimized)),
                      const SizedBox(width: 8),
                      _macosControl(const Color(0xFF28C940), () => setState(() {
                          _isMinimized = false; 
                          _isMaximized = !_isMaximized;
                      })),
                      const Spacer(),
                      const Text("Contact", style: TextStyle(color: Colors.white70)),
                      const Spacer(),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
              ),
              
              // Contenu
              if (!_isMinimized)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/images/moi1.jpeg'),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Jérémy Girard',
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Étudiant R&T - Cybersécurité',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _contactIcon(Icons.call, 'Appel', () => _launchUrl('tel:+33783645695')),
                            _contactIcon(Icons.mail, 'Mail', () => _launchUrl('https://outlook.office.com/mail/deeplink/compose?to=jeremy.girard@etu.unice.fr&subject=Contact%20depuis%20le%20portfolio&body=Bonjour%20Jérémy')),
                            _contactIcon(Icons.language, 'Web', () => _launchUrl('https://jerem-ctrl.github.io/portfolio/')),
                            _contactIcon(Icons.share, 'Partager', _handleShare),
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
                          child: Text('site web\n  https://jerem-ctrl.github.io/portfolio/', style: TextStyle(color: Colors.white)),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => const AboutMeWindow(lang: Lang.fr),
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
            ],
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

// --- FENÊTRE À PROPOS (AboutMeWindow) ---
class AboutMeWindow extends StatefulWidget {
  final Lang lang;
  const AboutMeWindow({super.key, this.lang = Lang.fr});

  @override
  State<AboutMeWindow> createState() => _AboutMeWindowState();
}

class _AboutMeWindowState extends State<AboutMeWindow> {
  bool _isMaximized = false;
  bool _isMinimized = false; // État pour "masquer" (fenêtre vide)

  @override
  Widget build(BuildContext context) {
    final bool isFr = widget.lang == Lang.fr;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 600;

    // --- DIMENSIONS ---
    // Largeur : 650px sur PC, 95% sur mobile
    final double targetWidth = isMobile || _isMaximized ? size.width * 0.95 : 650;
    
    // Hauteur : On augmente un peu la hauteur par défaut pour que le stage rentre bien (700px)
    final double targetHeight = _isMinimized 
        ? 44 
        : (_isMaximized ? size.height * 0.8 : 700);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: targetWidth,
          height: targetHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withOpacity(0.98),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 24,
                spreadRadius: 8,
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          ),
          child: Column(
            children: [
              // --- BARRE DE TITRE ---
              GestureDetector(
                onDoubleTap: () => setState(() {
                   _isMinimized = false;
                   _isMaximized = !_isMaximized;
                }),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Row(
                    children: [
                      // ROUGE : Fermer
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: _macButton(const Color(0xFFFF605C)),
                      ),
                      const SizedBox(width: 8),
                      
                      // JAUNE : Masquer (Réduire à la barre de titre)
                      GestureDetector(
                        onTap: () => setState(() => _isMinimized = !_isMinimized),
                        child: _macButton(const Color(0xFFFFBD2E)),
                      ),
                      const SizedBox(width: 8),
                      
                      // VERT : Agrandir
                      GestureDetector(
                        onTap: () => setState(() {
                          _isMinimized = false;
                          _isMaximized = !_isMaximized;
                        }),
                        child: _macButton(const Color(0xFF28C940)),
                      ),

                      // TITRE
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            isFr ? "À propos de moi" : "About Me",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- CONTENU (Cache si minimisé) ---
              if (!_isMinimized)
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Photo et Nom
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white12, width: 2),
                                  boxShadow: [
                                    BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5)),
                                  ],
                                ),
                                child: const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/images/moi1.jpeg'),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded( // Pour éviter l'overflow sur mobile
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jérémy Girard',
                                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
                                      ),
                                      child: Text(
                                        isFr ? 'Étudiant R&T - Option Cybersécurité' : 'R&T Student - Cybersecurity Option',
                                        style: const TextStyle(color: Colors.blueAccent, fontSize: 11, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Divider(color: Colors.white10),
                          const SizedBox(height: 20),

                          // Textes structurés
                          _buildTextBlock(
                            isFr ? '🎓 Formation' : '🎓 Education', 
                            isFr 
                              ? 'Étudiant en 2ᵉ année de BUT Réseaux & Télécommunications à l’IUT Nice Côte d’Azur.\nSpécialisation Cybersécurité.'
                              : 'Bachelor’s student in Network Engineering | Specialization in Cybersecurity.'
                          ),
                          const SizedBox(height: 20),
                          
                          // SECTION STAGE
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white10),
                            ),
                            child: _buildTextBlock(
                              isFr ? '🚀 Stage à venir' : '🚀 Upcoming Internship',
                              isFr
                                ? 'Stage chez Thales Alenia Space (Cannes).\n📅 7 Avril - 19 Juin 2026.\nSujet : Intégration de solutions numériques et accompagnement des équipes.'
                                : 'Internship at Thales Alenia Space (Cannes).\n📅 April 7 - June 19, 2026.\nTopic: Integration of digital solutions and team support.'
                            ),
                          ),
                          const SizedBox(height: 20),
                          
                          _buildTextBlock(
                            isFr ? '💻 Compétences' : '💻 Expertise',
                            isFr
                              ? 'Administration système (Linux, Windows), Réseaux (Cisco, TCP/IP), Scripting & Développement sécurisé.'
                              : 'System administration (Linux, Windows), Networking (Cisco, TCP/IP), Scripting & Secure Development.'
                          ),
                           const SizedBox(height: 20),

                          _buildTextBlock(
                            isFr ? '✨ Soft Skills' : '✨ Soft Skills',
                            isFr 
                              ? 'Curieux, autonome et rigoureux.'
                              : 'Curious, autonomous, and rigorous.'
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper pour les blocs de texte
  Widget _buildTextBlock(String title, String content) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
        const SizedBox(height: 6),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
        ),
      ],
    );
  }

  Widget _macButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 0.5),
      ),
    );
  }
}