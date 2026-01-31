// [file name]: main.dart
// [file content begin]

import 'package:universal_html/html.dart' as html; // Le remplaçant sécurisé de dart:html
import 'package:flutter/foundation.dart'; // Pour kIsWeb
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portofolio/project_windows.dart';
import 'package:portofolio/contact_window.dart';
import 'package:portofolio/experience_window.dart';
import 'package:portofolio/competence_window.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;
import 'package:portofolio/project_windows.dart' show FeaturedProjectCard;
import 'package:portofolio/all_projects_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  await initializeDateFormatting('en_US', null);
  runApp(const MonPortfolio());
}

class MonPortfolio extends StatelessWidget {
  const MonPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Portfolio',
      debugShowCheckedModeBanner: false,
      home: const MacOSStyleHome(),
    );
  }
}

class MacOSStyleHome extends StatefulWidget {
  const MacOSStyleHome({super.key});

  @override
  State<MacOSStyleHome> createState() => _MacOSStyleHomeState();
}

enum Lang { fr, en }

const _menuLabels = {
  Lang.fr: {
    'about': 'À propos',
    'contact': 'Contact',
    'projects': 'Projets',
    'skills': 'Compétences',
    'experience': 'Expérience',
  },
  Lang.en: {
    'about': 'About',
    'contact': 'Contact',
    'projects': 'Projects',
    'skills': 'Skills',
    'experience': 'Experience',
  }
};

class _MacOSStyleHomeState extends State<MacOSStyleHome>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  late DateTime _currentTime;
  bool _isLoading = true;
  Lang _lang = Lang.fr;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    Future.delayed(const Duration(seconds: 5), () {
      _controller.forward().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _langChip(String label, Lang value) {
  final bool active = _lang == value;
  return InkWell(
    onTap: () => setState(() => _lang = value),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.black : Colors.white.withOpacity(0.75),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
  }

  PageRouteBuilder _buildProjectWindow(
    BuildContext context,
    String title,
    List<Widget> content,
  ) {
    return PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) =>
          MacOSProjectWindow(title: title, content: content),
      transitionsBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animation),
            child: Image.asset(
              'assets/images/apple_splash.png',
              width: 75,
              height: 75,
            ),
          ),
        ),
      );
    }

    final bool isFr = _lang == Lang.fr;
    final locale = isFr ? 'fr_FR' : 'en_US';
    final pattern = isFr ? 'EEE d MMM HH:mm' : 'EEE. MMM. d h:mm a';
    final dateFormatter = DateFormat(pattern, locale);
    final formattedDate = dateFormatter.format(_currentTime);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // BARRE DE MENU macOS - UN SEUL POSITIONED !
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 28,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(0.2), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    // PARTIE GAUCHE
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Image(
                              image: AssetImage('assets/images/apple_logo.png'),
                              height: 25,
                              width: 25,
                            ),
                            const Text(
                              '  Finder',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 12),
                            _macMenuItem(context, _menuLabels[_lang]!['about']!, () {
                              showDialog(
                                context: context,
                                // AJOUT DE "lang: _lang" ICI :
                                builder: (_) => AboutMeWindow(lang: _lang),
                              );
                            }),
                            _macMenuItem(context, _menuLabels[_lang]!['contact']!, () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  transitionDuration: const Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) => const ContactWindow(),
                                  transitionsBuilder: (_, anim, __, child) => ScaleTransition(
                                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                                      CurvedAnimation(parent: anim, curve: Curves.easeOut),
                                    ),
                                    child: FadeTransition(opacity: anim, child: child),
                                  ),
                                ),
                              );
                            }),
                            _macMenuItem(context, _menuLabels[_lang]!['projects']!, () {
                              Navigator.of(context).push(
                                _buildProjectWindow(
                                  context,
                                  _lang == Lang.fr ? 'Tous les projets' : 'All Projects',
                                  getAllProjects(_lang),
                                ),
                              );
                            }),
                            _macMenuItem(context, _menuLabels[_lang]!['skills']!, () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  transitionDuration: const Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) => CompetenceWindow(lang: _lang),
                                  transitionsBuilder: (_, anim, __, child) => ScaleTransition(
                                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                                      CurvedAnimation(parent: anim, curve: Curves.easeOut),
                                    ),
                                    child: FadeTransition(opacity: anim, child: child),
                                  ),
                                ),
                              );
                            }),
                            _macMenuItem(context, _menuLabels[_lang]!['experience']!, () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false,
                                  transitionDuration: const Duration(milliseconds: 400),
                                  pageBuilder: (_, __, ___) => ExperienceWindow(lang: _lang),
                                  transitionsBuilder: (_, anim, __, child) => ScaleTransition(
                                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                                      CurvedAnimation(parent: anim, curve: Curves.easeOut),
                                    ),
                                    child: FadeTransition(opacity: anim, child: child),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    
                    // PARTIE DROITE
                    Row(
                      children: [
                        _langChip('FR', Lang.fr),
                        _langChip('EN', Lang.en),
                        const SizedBox(width: 12),
                        Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // ICÔNES DU BUREAU
            Positioned(
              top: 60,
              left: 30,
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'Projets' : 'Projects',
                        imagePath: 'assets/images/projetcts.png',
                        badgeText: '8+',
                        lang: _lang,
                      ),
                      const SizedBox(width: 40),
                      CustomDesktopIcon(
                        label: 'LinkedIn',
                        imagePath: 'assets/images/linkedin_icon.png',
                        badgeText: '4K+',
                        lang: _lang,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomDesktopIcon(
                        label: 'Replit', 
                        imagePath: 'assets/images/replit.png',
                        badgeText: '3',
                        lang: _lang,
                      ),
                      const SizedBox(width: 40),
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'Plein écran' : 'Fullscreen',
                        imagePath: 'assets/images/full_screen.png',
                        lang: _lang,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'CV' : 'Resume',
                        imagePath: 'assets/images/pdf.png',
                        lang: _lang,
                      ),
                      const SizedBox(width: 40),
                      CustomDesktopIcon(
                        label: 'GitHub',
                        imagePath: 'assets/images/github.png',
                        badgeText: '10+',
                        lang: _lang,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // MÉTÉO (SEULEMENT SUR GRAND ÉCRAN)
            if (MediaQuery.of(context).size.width > 600)
              Positioned(
                top: 50,
                right: 20,
                child: WeatherWidget(),
              ),
            
            // DOCK EN BAS
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 12)],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DockIconImage(
                        imagePath: 'assets/images/home.png',
                        label: _lang == Lang.fr ? 'Accueil' : 'Home',
                        onRefresh: () => setState(() => _currentTime = DateTime.now()),
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/mail.png',
                        label: _lang == Lang.fr ? 'Menvoyez un e-mail' : 'Email me',
                        url: 'https://outlook.office.com/mail/deeplink/compose?to=jeremy.girard@etu.unice.fr&subject=Contact%20depuis%20le%20portfolio&body=Bonjour%20Jérémy',
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/flutter.png',
                        label: _lang == Lang.fr
                            ? 'Consultez mes projets de programmation'
                            : 'See my programming projects',
                        badgeText: '8+',
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/pct.png',
                        label: _lang == Lang.fr
                            ? 'Explorez mes projets de réseaux'
                            : 'Browse my networking projects',
                      ),
                      const SizedBox(width: 15),
                      CalendarDockIcon(
                        url: 'https://calendly.com/jeremy_girard',
                        tooltip: _lang == Lang.fr ? 'Planifiez' : 'Schedule',
                        lang: _lang,
                      ),
                      const SizedBox(width: 15),
                      ProfileDockIcon(
                        imagePath: 'assets/images/moi1.jpeg',
                        label: _lang == Lang.fr ? 'Me contactez' : 'Contact me',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _macMenuItem(BuildContext context, String label, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}

class DockIconImage extends StatelessWidget {
  final String imagePath;
  final String? badgeText;
  final String? label;
  final String? url;
  final VoidCallback? onRefresh;

  const DockIconImage({
    super.key,
    required this.imagePath,
    this.badgeText,
    this.label,
    this.url,
    this.onRefresh,
  });

  void _handleTap(BuildContext context) async {
    if (label == 'Consultez mes projets de programmation' || label == 'See my programming projects') {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: 'Initiative en matière de programmation',
            content: [
              FeaturedProjectCard(
                title: "🔊​ HighDef",
                category: "Traitement du signal",
                shortDescription: "Mesure rapide d’un signal audio.",
                fullDescription:
                    "Le projet HighDef est une étude en trois phases portant sur la comparaison entre la qualité audio Haute Définition (HD) et Simple Définition (SD). Il vise à déterminer si l’amélioration de la qualité perçue est significative, justifiant l’usage de formats audio HD.",
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
                  "Extraction et analyse de caractéristiques audio (RMS, spectre, dynamique)",
                  "Utilisation de bibliothèques Python (NumPy, SciPy, Matplotlib)",
                  "Visualisation de signaux dans le domaine temporel et fréquentiel",
                  "Interprétation de résultats expérimentaux et rédaction scientifique",
                ],
                githubUrl: "https://github.com/Jerem-ctrl/HighDef",
              ),
              const SizedBox(height: 24),
              StandardProjectCard(
                title: 'Interface Web embarquée pour Thales',
                category: 'Projet Web & Système embarqué',
                shortDescription:
                    'Conception d\'une interface web sécurisée pour banc avionique dans le cadre d’un projet Thales.',
                fullDescription:
                    'Ce projet a consisté à développer une interface web intuitive permettant de prendre, visualiser et gérer des photos dans le cadre de la SAE 23. L’objectif principal était de concevoir une plateforme accessible à distance, avec authentification sécurisée et journalisation des actions utilisateur, le tout dans un environnement embarqué.',
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
                  'Développement front-end en HTML, CSS et JavaScript pour une interface responsive',
                  'Intégration d’un serveur web léger avec routage et gestion des sessions',
                  'Implémentation de fonctionnalités de sécurité (authentification, logging)',
                  'Gestion des formulaires et traitement des données utilisateur côté serveur',
                ],
                githubUrl:
                    'https://github.com/Jerem-ctrl/Secure_Embedded_Web_Interface_for_Thales',
              ),
              StandardProjectCard(
                title:
                    'Système de traçabilité Photo embarqué pour Banc Avionique',
                category: 'Systèmes embarqués & Programmation Python',
                shortDescription:
                    'Développement d’un système embarqué permettant la capture et la gestion sécurisée de photos sur un banc de test avionique, avec interface web, authentification et traçabilité des actions.',
                fullDescription:
                    'Dans le cadre de la SAE 24, ce projet visait à développer un système de capture photo embarqué sur Raspberry Pi, destiné à documenter les modifications sur un banc de test avionique. En combinant Python, un microcontrôleur Pico WH, une caméra USB, et des composants GPIO (LED, boutons, etc.), le système permet la prise de photos automatique ou manuelle avec gestion de l’éclairage. L\'ensemble s’intègre à une interface web sécurisée développée lors de la SAE 23, pour assurer la traçabilité et l’accessibilité des images à distance.',
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
                  'Programmation Python embarquée',
                  'Utilisation de Raspberry Pi et microcontrôleur',
                  'Communication série (UART)',
                  'Intégration de périphériques (caméra, GPIO)',
                ],
                githubUrl:
                    'https://github.com/Jerem-ctrl/Embedded_Photo-Logging_System_for_Avionics',
              ),
            ],
          ),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      );
    } else if (label == 'Explorez mes projets de réseaux' || label == 'Browse my networking projects') {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: 'Initiatives liées aux réseaux',
            content: [
              FeaturedProjectCard(
                title: "Infrastructure réseau sécurisée pour PME",
                category: "Réseaux & Sécurité",
                shortDescription:
                    "Ce projet simule une architecture réseau complète pour PME avec VLANs, DNS/DHCP, DMZ, pare-feu ASA, routage et sécurité.",
                fullDescription:
                    "Dans le cadre de la SAÉ 21, nous avons conçu l’architecture réseau d’une PME à l’aide de Cisco Packet Tracer. Le projet comprend la configuration de VLANs, de serveurs DHCP/DNS, d’une DMZ avec pare-feu ASA, de routage statique, ainsi que la mise en place de la sécurité via des ACL et du NAT. L’objectif était d’assurer la segmentation, la sécurité et la connectivité complète du réseau d’entreprise.",
                image: "assets/images/sae21ci1.jpg",
                gallery: [
                  "assets/images/sae21ci2.png",
                  "assets/images/sae21c3.png",
                  "assets/images/sae21c4.png",
                  "assets/images/sae21c5.png",
                ],
                competencies: [
                  "Configuration de VLANs et routage inter-VLAN",
                  "Mise en place d’un pare-feu ASA (DMZ, NAT, ACL)",
                  "Plan d’adressage et configuration DNS/DHCP",
                  "Simulation réseau complète sous Cisco Packet Tracer",
                ],
                githubUrl:
                    'https://github.com/Jerem-ctrl/Secure-Network-Infrastructure-for-Small-Businesses',
              ),
              const SizedBox(height: 24),
              StandardProjectCard(
                title: 'Analyse de cyberattaques & bonnes pratiques',
                category: 'Cybersécurité & Sensibilisation',
                shortDescription:
                    'Étude de cyberattaques réelles et sensibilisation aux menaces numériques.',
                fullDescription:
                    'Dans le cadre de la SAÉ 11, nous avons analysé plusieurs cyberattaques connues afin d’en comprendre les mécanismes, les conséquences et les moyens de prévention. Ce travail s’est appuyé sur des recherches approfondies concernant les bonnes pratiques d’hygiène informatique. L’objectif principal était de développer une culture de la cybersécurité et de renforcer les réflexes face aux menaces numériques.',
                image: 'assets/images/sae11c3.jpg',
                gallery: [
                  'assets/images/sae11c4.webp',
                  'assets/images/sae11c5.png',
                  'assets/images/sae11c6.png',
                ],
                competencies: [
                  "Comprendre les principes de base de la cybersécurité",
                  "Analyser une cyberattaque et ses vecteurs",
                  "Identifier les bonnes pratiques d’hygiène informatique",
                  "Communiquer efficacement à travers un support pédagogique",
                ],
                githubUrl:
                    'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
              ),
              StandardProjectCard(
                title:
                    'Exploration des réseaux domestiques & impacts énergétiques',
                category: 'Réseaux & Écoresponsabilité',
                shortDescription:
                    'Mise en pratique des connaissances réseaux via l’analyse d’un environnement domestique réel, combinée à une étude de la consommation énergétique des équipements.',
                fullDescription:
                    'Dans le cadre de la SAÉ 12, nous avons étudié le fonctionnement d’un réseau local domestique à travers l’analyse d’un équipement connecté (ordinateur, smartphone…). Cette démarche comprenait l’identification des composants réseau, l’observation du trafic (IP, DNS, ports) et la représentation schématique de l’infrastructure. En parallèle, une réflexion a été menée sur la consommation énergétique des équipements numériques et leur impact environnemental.',
                image: 'assets/images/sae12r3.jpeg',
                gallery: [
                  'assets/images/sae12r4.png',
                  'assets/images/sae12r5.png',
                  'assets/images/sae12r6.png',
                  'assets/images/sae12r7.png',
                ],
                competencies: [
                  "Comprendre et analyser un réseau local (IP, MAC, DHCP, DNS…)",
                  "Utiliser des outils de diagnostic réseau (Traceroute, Wireshark)",
                  "Interpréter des données techniques (consommation, émissions CO₂)",
                  "Schématiser et documenter une infrastructure réseau personnelle",
                ],
                githubUrl:
                    'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
              ),
            ],
          ),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      );
    } else if (label == 'Me contactez' || label == 'Contact me') {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => const ContactWindow(),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      );
    } else if (label == 'Accueil' || label == 'Home') {
      if (onRefresh != null) onRefresh!();
    } else if (url != null && await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: label ?? '',
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        preferBelow: false,
        verticalOffset: 55,
        child: GestureDetector(
          onTap: () => _handleTap(context),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
              ),
              if (badgeText != null)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
}
class ProfileDockIcon extends StatelessWidget {
  final String imagePath;
  final String? label;

  const ProfileDockIcon({super.key, required this.imagePath, this.label});

  void _handleTap(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => const ContactWindow(),
        transitionsBuilder: (_, animation, __, child) => ScaleTransition(
          scale: Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(opacity: animation, child: child),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: label ?? '',
        textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(6),
        ),
        preferBelow: false,
        verticalOffset: 55,
        child: GestureDetector(
          onTap: () => _handleTap(context),
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _projectCard(String title, String desc, String category, String img) {
  return Card(
    color: const Color(0xFF2A2A2A),
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(img, width: 72, height: 72, fit: BoxFit.cover),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                  child: const Text(
                    'Voir plus',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class CustomDesktopIcon extends StatelessWidget {
  final String label;
  final String imagePath;
  final String? badgeText;
  final String? url;
  final Lang lang;

  const CustomDesktopIcon({
    super.key,
    required this.label,
    required this.imagePath,
    this.badgeText,
    this.url,
    required this.lang,
  });

  void _handleTap(BuildContext context) async {
    if (label == '📸 SAE 23 - Prise de Photos') {
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: '📸 SAE 23 - Prise de Photos',
            content: [
              StandardProjectCard(
                title: 'SAE 23 - Banc Avionique',
                category: 'Projet Web & Système embarqué',
                shortDescription:
                    'Développement d’une interface web pour gérer une caméra connectée à un Raspberry Pi.',
                fullDescription:
                    'Ce projet vise à permettre la prise de photos sur un banc avionique avec accès utilisateur, gestion de compte, sécurité renforcée, journalisation des actions (logs), et un capteur de luminosité intégré via Raspberry Pi Pico. Une photo est prise automatiquement avant chaque test ou si aucune photo n’a été prise depuis 24h.',
                image: 'assets/images/sae23_main.jpg',
                gallery: [
                  'assets/images/sae23_capture1.png',
                  'assets/images/sae23_capture2.png',
                ],
                competencies: [
                  'Développement d\'une interface web responsive',
                  'Connexion à un Raspberry Pi & automatisation',
                  'Gestion des utilisateurs, sécurité et logs',
                  'Intégration d’un capteur via PICO WH',
                ],
                githubUrl: 'https://github.com/ton-projet-sae23',
              ),
            ],
          ),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      );
    } else if (url != null && await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url!), mode: LaunchMode.externalApplication);
    } else if (label == 'Projets' || label == 'Projects') {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: lang == Lang.fr ? 'Tous les projets' : 'All Projects',
            content: getAllProjects(lang),
          ),
          transitionsBuilder: (_, animation, __, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        ),
      );
    } else if (label == 'LinkedIn') {
      final url = 'https://www.linkedin.com/in/jérémy-girard-9575a7352';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } else if (label == 'Replit') {
      final url = 'https://replit.com/@Jeremy2077';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } else if (label == 'Plein écran' || label == 'Fullscreen') {
      // === MODIFICATION ICI ===
      if (kIsWeb) {
        // Sur le Web (PC), on force le plein écran
        html.document.documentElement?.requestFullscreen();
      } else {
        // Sur Mobile, on informe juste l'utilisateur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(label == 'Plein écran'
                ? 'Mode plein écran automatique sur mobile'
                : 'Fullscreen is automatic on mobile'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      // =========================
    } else if (label == 'CV' || label == 'Resume') {
      const url =
          'https://jerem-ctrl.github.io/portfolio/documents/cv_jeremy.pdf';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Impossible d\'ouvrir le CV / Cannot open Resume')),
        );
      }
    } else if (label == 'GitHub') {
      final url = 'https://github.com/Jerem-ctrl';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleTap(context),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                ),
                if (badgeText != null)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badgeText!,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});
  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String? city;
  int? temperature;
  String? condition;
  int? tempMax;
  int? tempMin;
  final String apiKey = '5e84cba2ae4aa1c301d5841b12b77f1e';

  @override
  void initState() {
    super.initState();
    _getWeather();
  }

  Future<void> _getWeather() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;
    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied)
      perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied ||
        perm == LocationPermission.deniedForever)
      return;
    Position pos = await Geolocator.getCurrentPosition();
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${pos.latitude}&lon=${pos.longitude}&units=metric&appid=$apiKey',
    );
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final d = json.decode(resp.body);
      setState(() {
        city = d['name'];
        temperature = (d['main']['temp'] as num).round();
        condition = d['weather'][0]['main'];
        tempMax = (d['main']['temp_max'] as num).round();
        tempMin = (d['main']['temp_min'] as num).round();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2E4E91), Color(0xFF6A86C7)],
        ),
      ),
      child: temperature == null
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$temperature°C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  condition ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Text(
                  'Max: ${tempMax ?? '-'}°C  Min: ${tempMin ?? '-'}°C',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
    );
  }
}

class CalendarDockIcon extends StatelessWidget {
  final String? url;
  final String? tooltip;
  final Lang lang;

  const CalendarDockIcon({super.key, this.url, this.tooltip, required this.lang,});

  void _handleTap() async {
    if (url != null && await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = now.day.toString();
    final month = _getMonthShortName(now.month);

    return Tooltip(
      message: tooltip ?? 'Planifiez',
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      preferBelow: false,
      verticalOffset: 55,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          width: 53,
          height: 53,
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                month.toUpperCase(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getMonthShortName(int month) {
    if (lang == Lang.en) {
      const monthsEn = [
        'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
        'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
      ];
      return monthsEn[month - 1];
    } else {
      const monthsFr = [
        'JAN', 'FÉV', 'MAR', 'AVR', 'MAI', 'JUN',
        'JUL', 'AOÛ', 'SEP', 'OCT', 'NOV', 'DÉC'
      ];
      return monthsFr[month - 1];
    }
  }
}
