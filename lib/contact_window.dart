import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
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
  bool _isMinimized = false;
  bool _isPrivacyMode = false;

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
    final bool isMobile = size.width < 600; // Détection mobile
    
    // HAUTEUR : 
    // Sur mobile : on prend 85% de la hauteur de l'écran max (pour éviter que ça dépasse)
    // Sur PC : on garde 560px fixe (ou 600 si agrandi)
    final double defaultHeight = 560;
    final double targetHeight = _isMinimized 
        ? 44 
        : (_isMaximized 
            ? size.height 
            : (size.height < defaultHeight + 50 ? size.height * 0.85 : defaultHeight));

    // LARGEUR :
    // Sur mobile : 90% de la largeur de l'écran
    // Sur PC : 380px fixe
    final double targetWidth = _isMaximized 
        ? size.width 
        : (isMobile ? size.width * 0.90 : 380);

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // Action : Fermer la fenêtre
      behavior: HitTestBehavior.opaque, // Important : Capture le clic partout
      child: Center(
        // 2. On ajoute un second GestureDetector sur la fenêtre elle-même
        // pour EMPÊCHER qu'elle se ferme si on clique DEDANS.
        child: GestureDetector(
          onTap: () {}, // Ne rien faire (absorbe le clic)
          child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: targetWidth,
            height: targetHeight,
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
                        // 1. Bouton ROUGE (Fermer) - Maintenant animé avec la croix
                        MacControlButton(
                          color: const Color(0xFFFF5F57),
                          icon: Icons.close,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        
                        // 2. Bouton JAUNE (Mode Privé/Blur) - Animé avec l'œil/cadenas
                        MacControlButton(
                          color: const Color(0xFFFFBD2E),
                          // Si mode privé actif (flou) = Cadenas, Sinon (visible) = Œil barré (pour masquer)
                          icon: _isPrivacyMode ? Icons.lock : Icons.visibility_off,
                          onTap: () => setState(() => _isPrivacyMode = !_isPrivacyMode),
                        ),
                        
                        // 3. Bouton VERT (Agrandir/Réduire) - Maintenant animé avec les flèches
                        MacControlButton(
                          color: const Color(0xFF28C840),
                          icon: _isMaximized ? Icons.close_fullscreen : Icons.open_in_full,
                          onTap: () => setState(() {
                              _isMinimized = false; 
                              _isMaximized = !_isMaximized;
                          }),
                        ),
                        
                        const Spacer(),
                        const Text("Contact", style: TextStyle(color: Colors.white70)),
                        const Spacer(),
                        const SizedBox(width: 50), // Pour équilibrer le titre
                      ],
                    ),
                  ),
                ),
                
                // Contenu
                if (!_isMinimized)
                Expanded(
                  child: Stack(
                    children: [
                      // Le contenu flouté
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: _isPrivacyMode ? 10.0 : 0.0,
                          sigmaY: _isPrivacyMode ? 10.0 : 0.0,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(30),
                          child: SingleChildScrollView(
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
                              const SizedBox(height: 20), // Un espace fixe au lieu du Spacer

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
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ], // Fin de children (Stack)
                  ),   // Fin de Stack
                ),     // Fin de Expanded
              ],       // Fin de children (Column principale)
            ),         // Fin de Column
            ),           // Fin de AnimatedContainer
          ),             // Fin de Material
        ),               // Fin de GestureDetector (celui du "bouclier")
      ),                 // Fin de Center
    );                   // Fin de GestureDetector (celui qui ferme la fenêtre) et du return
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
  bool _isMinimized = false;

  @override
  Widget build(BuildContext context) {
    final bool isFr = widget.lang == Lang.fr;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 700;

    // --- DIMENSIONS ---
    final double targetWidth = isMobile || _isMaximized ? size.width * 0.95 : 850;
    final double targetHeight = _isMinimized 
        ? 44 
        : (_isMaximized ? size.height * 0.85 : 650);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: targetWidth,
          height: targetHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF151515).withOpacity(0.95), // Fond très sombre MacOS
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 30,
                spreadRadius: 8,
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.5),
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      MacControlButton(
                        color: const Color(0xFFFF5F57),
                        icon: Icons.close,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                      MacControlButton(
                        color: const Color(0xFFFFBD2E),
                        icon: _isMinimized ? Icons.visibility : Icons.visibility_off,
                        onTap: () => setState(() => _isMinimized = !_isMinimized),
                      ),
                      MacControlButton(
                        color: const Color(0xFF28C840),
                        icon: _isMaximized ? Icons.close_fullscreen : Icons.open_in_full,
                        onTap: () => setState(() => _isMaximized = !_isMaximized),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: Text(
                            isFr ? "À propos de moi" : "About Me",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // --- CONTENU BENTO GRID ---
              if (!_isMinimized)
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: isMobile ? _buildMobileLayout(isFr) : _buildDesktopLayout(isFr),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // --- LAYOUTS ---
  
  Widget _buildDesktopLayout(bool isFr) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colonne Gauche (Profil)
            Expanded(
              flex: 4,
              child: _buildBentoCard(
                padding: const EdgeInsets.all(32),
                gradientColors: [const Color(0xFF1E3C72), const Color(0xFF2A5298)],
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.4), width: 3),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/images/moi1.jpeg'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Jérémy Girard',
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 1),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Text(
                        isFr ? 'Réseaux & Cyberdéfense' : 'Networks & Cyberdefense',
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isFr 
                        ? "Étudiant en BUT R&T passionné par l'IT. En route pour le Canada (UQAC) en Septembre 2026 pour un double diplôme en cyberdéfense !"
                        : "Network Engineering student with a passion for IT. Heading to Canada (UQAC) in September 2026 for a dual IT & Cyber degree!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            // Colonne Droite (Formation, Stage, Objectif)
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _buildBentoCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('🎓', isFr ? 'Parcours' : 'Education', Colors.blueAccent),
                                const SizedBox(height: 12),
                                const Text('BUT R&T Campus Sophia', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(height: 4),
                                Text(isFr ? 'Futur : UQAC Chicoutimi (Canada)\nSéjour prévu en Sept. 2026' : 'Next: UQAC Chicoutimi (Canada)\nStarting Sept. 2026', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: _buildBentoCard(
                            gradientColors: [const Color(0xFFe53935).withOpacity(0.8), const Color(0xFFe35d5b).withOpacity(0.8)],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('🚀', isFr ? 'Prochain Stage' : 'Next Internship', Colors.white),
                                const SizedBox(height: 12),
                                const Text('Thales Alenia Space', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(height: 4),
                                Text(isFr ? 'Avril - Juin 2026 (Cannes)\nIntégration Cybersécurité' : 'April - June 2026 (Cannes)\nCybersecurity Integration', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildBentoCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle('🎯', isFr ? 'Plan de Carrière / Ambition' : 'Dream Job / Ambition', Colors.purpleAccent),
                        const SizedBox(height: 12),
                        Text(
                          isFr
                            ? "Après mon diplôme à l'UQAC, j'ambitionne de viser un Master d'excellence en Suisse 🇨🇭 (type EPFL ou HES-SO), suivi potentiellement d'un PhD au Royaume-Uni 🇬🇧 en sécurité de l'IA. Mon but : devenir Expert en Cyberdéfense (AI Safety) dans des écosystèmes internationaux de pointe."
                            : "After my UQAC degree, I aim for a top-tier Master's in Switzerland 🇨🇭 (e.g. EPFL or HES-SO), followed perhaps by a PhD in the UK 🇬🇧 focusing on AI Safety. Ultimate goal: becoming a Cyberdefense Expert in cutting-edge global ecosystems.",
                          style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Ligne du bas (Passions & Compétences)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _buildBentoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('🌍', isFr ? 'Univers Personnel' : 'Personal World', Colors.pinkAccent),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPassionIcon('✈️', isFr ? "Voyages\n(Norvège, Maroc)" : "Travel\n(Norway)", Colors.cyan),
                        _buildPassionIcon('⛷️', isFr ? "Ski Alpin\n(Dépassement)" : "Skiing\n(Challenge)", Colors.orangeAccent),
                        _buildPassionIcon('🎹', isFr ? "Piano\n(Créativité)" : "Piano\n(Creativity)", Colors.deepPurpleAccent),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isFr 
                        ? "Curieux et explorateur dans l'âme, je puise mon inspiration dans les voyages, l'exigence du ski alpin et l'expression créative du piano. Cet équilibre me permet d'aborder la tech avec un regard ouvert et rigoureux."
                        : "Curious and exploratory by nature, I draw my inspiration from travels, the rigor of alpine skiing, and the creative expression of playing piano. This balance helps me approach tech with an open mind.",
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, height: 1.5, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 4,
              child: _buildBentoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('🛡️', isFr ? 'Expertise Cyber & Réseau' : 'Cyber & Network', Colors.greenAccent),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChip('Cisco CCNA 1 & 2', Colors.blue),
                        _buildChip('Routage OSPF & BGP', Colors.indigoAccent),
                        _buildChip('Vulnérabilités AD', Colors.purple),
                        _buildChip('Séc. Offensive', Colors.redAccent),
                        _buildChip('Exploitation Linux', Colors.orange),
                        _buildChip('Défense IA', Colors.cyan),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle('🧠', isFr ? 'Mon état d\'esprit' : 'Soft Skills', Colors.amberAccent),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChip(isFr ? 'Curiosité' : 'Curiosity', Colors.purpleAccent),
                        _buildChip(isFr ? 'Autonomie' : 'Autonomy', Colors.tealAccent),
                        _buildChip(isFr ? 'Rigueur' : 'Rigor', Colors.indigoAccent),
                        _buildChip(isFr ? 'Travail d\'équipe' : 'Teamwork', Colors.pinkAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout(bool isFr) {
    // Version empilée pour mobile
    return Column(
      children: [
        _buildBentoCard(
          padding: const EdgeInsets.all(24),
          gradientColors: [const Color(0xFF1E3C72), const Color(0xFF2A5298)],
          child: Column(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/images/moi1.jpeg'),
              ),
              const SizedBox(height: 16),
              const Text('Jérémy Girard', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: Text(isFr ? 'Réseaux & Cyberdéfense' : 'Cyberdefense', style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(height: 16),
              Text(
                isFr ? "En route pour l'UQAC (Canada) en Sept. 2026 pour un double diplôme en cyberdéfense !" : "Heading to UQAC (Canada) in Sept. 2026 for a dual cyber degree!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildBentoCard(
          gradientColors: [const Color(0xFFe53935).withOpacity(0.8), const Color(0xFFe35d5b).withOpacity(0.8)],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('🚀', isFr ? 'Stage à venir' : 'Upcoming Internship', Colors.white),
              const SizedBox(height: 8),
              const Text('Thales Alenia Space (Cannes)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(isFr ? 'Avril - Juin 2026' : 'April - June 2026', style: TextStyle(color: Colors.white.withOpacity(0.9))),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildBentoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('🌍', isFr ? 'Passions' : 'Passions', Colors.pinkAccent),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPassionIcon('✈️', isFr ? "Voyages" : "Travel", Colors.cyan),
                  _buildPassionIcon('⛷️', isFr ? "Ski" : "Skiing", Colors.orangeAccent),
                  _buildPassionIcon('🎹', "Piano", Colors.deepPurpleAccent),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildBentoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('🛡️', 'Expertise', Colors.greenAccent),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 8, children: [
                 _buildChip('CCNA', Colors.blue), _buildChip('OSPF/BGP', Colors.indigoAccent), _buildChip('Active Directory', Colors.purple), _buildChip('Séc. Offensive', Colors.redAccent),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildBentoCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('🎯', isFr ? 'Objectif' : 'Objective', Colors.purpleAccent),
              const SizedBox(height: 8),
              Text(
                isFr ? "Master en Suisse 🇨🇭 puis Expert Cyberdéfense / IA." : "Swiss Master 🇨🇭 then Cyberdefense/AI Expert.",
                style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- COMPOSANTS REUTILISABLES ---

  Widget _buildBentoCard({
    required Widget child,
    double? width,
    double? height,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24),
    List<Color>? gradientColors,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: gradientColors != null
            ? LinearGradient(colors: gradientColors, begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
        color: gradientColors == null ? const Color(0xFF2A2A2A).withOpacity(0.6) : null,
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        boxShadow: gradientColors != null ? [
          BoxShadow(color: gradientColors[0].withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))
        ] : null,
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String emoji, String title, Color color) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 16, fontFamilyFallback: ['Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'])),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title, 
            style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPassionIcon(String emoji, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Text(emoji, style: const TextStyle(fontSize: 28, fontFamilyFallback: ['Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'])),
        ),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
} // Fin de File