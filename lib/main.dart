// [file name]: main.dart
// [file content begin]

import 'package:universal_html/html.dart' as html;
import 'package:flutter/foundation.dart';
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
import 'package:portofolio/certification_window.dart';
import 'dart:ui_web' as ui_web;
import 'dart:js_util' as js_util;

bool _hasFastConnection() {
  // On force à "true" pour s'assurer que le fond en direct (ISS) s'affiche toujours,
  // car l'API navigator.connection.downlink peut renvoyer des fausses valeurs.
  return true;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    ui_web.platformViewRegistry.registerViewFactory(
      'youtube-live-iss',
      (int viewId) {
        final iframe = html.IFrameElement()
          ..width = '100%'
          ..height = '100%'
          ..src = 'https://www.youtube.com/embed/fO9e9jnhYK8?autoplay=1&mute=1&controls=0&showinfo=0&loop=1&playlist=fO9e9jnhYK8&playsinline=1&modestbranding=1'
          ..style.border = 'none'
          ..style.pointerEvents = 'none' // Empêche l'iframe d'intercepter les clics
          ..allow = 'autoplay; fullscreen';
        return iframe;
      },
    );
  }

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

    // PRE-CACHING ACTIF DES GROS ASSETS
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/mont_fuji.jpg'), context);
      precacheImage(const AssetImage('assets/images/th.jpg'), context);
    });

    // DELAI ULTRA-OPTIMISÉ (1.5s vs 5s)
    Future.delayed(const Duration(milliseconds: 1500), () {
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
    List<Widget> content, {
    String? description,
  }) {
    return PageRouteBuilder(
      opaque: false,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) =>
          MacOSProjectWindow(title: title, content: content, description: description),
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
              'assets/images/apple_splash1.png',
              width: 125,
              height: 125,
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
    
    final bool hasFastConn = _hasFastConnection();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 0. FOND D'ECRAN
          if (kIsWeb && hasFastConn)
            Positioned.fill(
              child: Transform.scale(
                scale: 1.35, // Effet "Cover" géant pour cacher le bandeau du bas et les logos sur les bords
                child: const HtmlElementView(viewType: 'youtube-live-iss'),
              ),
            )
          else
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.jpg',
                fit: BoxFit.cover,
              ),
            ),
          
          // Léger filtre noir sur la vidéo pour lisibilité du texte
          if (kIsWeb && hasFastConn)
             Positioned.fill(
               child: Container(color: Colors.black.withOpacity(0.15)),
             ),

          // 1. BARRE DE MENU macOS - UN SEUL POSITIONED !
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
                              image: AssetImage('assets/images/apple_logo1.png'),
                              height: 50,
                              width: 50,
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
                                  description: _lang == Lang.fr
                                      ? 'Explorez l\'ensemble de mes réalisations : développement, réseaux et cybersécurité.'
                                      : 'Explore all my work: development, networking, and cybersecurity.',
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
            
            // ICÔNES DU BUREAU (RESPONSIVE — Colonne de paires style macOS)
            Positioned(
              top: 60,
              left: 20,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width < 500
                        ? MediaQuery.of(context).size.width - 40
                        : 200, // 2 icônes (55+55) + spacing (40) + marge
                  ),
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'Projets' : 'Projects',
                        imagePath: 'assets/images/projetcts.png',
                        badgeText: '8+',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: 'LinkedIn',
                        imagePath: 'assets/images/linkedin_icon.png',
                        badgeText: '4K+',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: 'Replit', 
                        imagePath: 'assets/images/replit.png',
                        badgeText: '3',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'Plein écran' : 'Fullscreen',
                        imagePath: 'assets/images/full_screen.png',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'CV' : 'Resume',
                        imagePath: 'assets/images/pdf.png',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: 'Vlog UQAC',
                        emoji: '🇨🇦',
                        lang: _lang,
                        onTapOverride: () {
                          if (kIsWeb) {
                            html.window.open('canada_vlog/mohitvirli.github.io-master/out/index.html', '_blank');
                          }
                        },
                      ),
                      CustomDesktopIcon(
                        label: 'GitHub',
                        imagePath: 'assets/images/github.png',
                        badgeText: '10+',
                        lang: _lang,
                      ),
                      CustomDesktopIcon(
                        label: _lang == Lang.fr ? 'Certifications' : 'Certifications',
                        emoji: '🏅',
                        lang: _lang,
                      ),
                    ],
                  ),
                ),
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
                        lang: _lang,
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/mail.png',
                        label: _lang == Lang.fr ? 'Menvoyez un e-mail' : 'Email me',
                        url: 'https://outlook.office.com/mail/deeplink/compose?to=jeremy.girard@etu.unice.fr&subject=Contact%20depuis%20le%20portfolio&body=Bonjour%20Jérémy',
                        lang: _lang,
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/cmd.png',
                        label: _lang == Lang.fr
                            ? 'Consultez mes projets de programmation'
                            : 'See my programming projects',
                        badgeText: '8+',
                        lang: _lang,
                      ),
                      const SizedBox(width: 15),
                      DockIconImage(
                        imagePath: 'assets/images/reseau.png',
                        label: _lang == Lang.fr
                            ? 'Explorez mes projets de réseaux'
                            : 'Browse my networking projects',
                        lang: _lang,
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
                        label: _lang == Lang.fr ? 'Me contacter' : 'Contact me',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
  final Lang lang;

  const DockIconImage({
    super.key,
    required this.imagePath,
    this.badgeText,
    this.label,
    this.url,
    this.onRefresh,
    this.lang = Lang.fr,
  });

  void _handleTap(BuildContext context) async {
    // 1. On récupère TOUS les projets depuis la source unique
    final List<Widget> allProjects = getAllProjects(lang);

    if (label == 'Consultez mes projets de programmation' || label == 'See my programming projects') {
      
      // 2. FILTRAGE : On garde seulement ceux qui contiennent des mots clés "Dev"
      final devProjects = allProjects.where((widget) {
        String cat = "";
        // On vérifie le type de widget pour accéder à la catégorie
        if (widget is FeaturedProjectCard) cat = widget.category.toLowerCase();
        else if (widget is StandardProjectCard) cat = widget.category.toLowerCase();
        else return false; // On ignore les SizedBox ou autres

        // Liste des mots-clés pour la programmation
        return cat.contains('dev') || cat.contains('web') || cat.contains('python') || 
               cat.contains('mobile') || cat.contains('signal') || cat.contains('programmation') ||
               cat.contains('embarqué') || cat.contains('embedded');
      }).toList();

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: lang == Lang.fr ? 'Projets Programmation' : 'Programming Projects',
            // AJOUTE LA DESCRIPTION ICI :
            description: lang == Lang.fr 
                ? "Explorez mes développements d'applications mobiles et web, ainsi que mes outils d'analyse de signal et scripts d'automatisation."
                : "Explore my mobile and web application developments, as well as my signal analysis tools and automation scripts.",
            content: devProjects,
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
      
      // 3. FILTRAGE : On garde seulement ceux qui contiennent des mots clés "Réseau"
      final netProjects = allProjects.where((widget) {
        String cat = "";
        if (widget is FeaturedProjectCard) cat = widget.category.toLowerCase();
        else if (widget is StandardProjectCard) cat = widget.category.toLowerCase();
        else return false;

        // Liste des mots-clés pour le réseau/cyber
        return cat.contains('réseau') || cat.contains('network') || cat.contains('cyber') || 
               cat.contains('sécurité') || cat.contains('security') || cat.contains('infra') ||
               cat.contains('telecom') || cat.contains('cisco');
      }).toList();

      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => MacOSProjectWindow(
            title: lang == Lang.fr ? 'Projets Réseaux & Cyber' : 'Network & Cyber Projects',
            description: lang == Lang.fr
                ? "Découvrez mes conceptions d'architectures réseaux sécurisées, mes déploiements d'infrastructures fibres et mes audits de cybersécurité."
                : "Discover my secure network architecture designs, fiber infrastructure deployments, and cybersecurity audits.",
            content: netProjects,
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
      // ... (Le reste de ton code ne change pas) ...
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
  final String? imagePath;
  final String? emoji;
  final String? badgeText;
  final String? url;
  final Lang lang;
  final VoidCallback? onTapOverride;

  const CustomDesktopIcon({
    super.key,
    required this.label,
    this.imagePath,
    this.emoji,
    this.badgeText,
    this.url,
    required this.lang,
    this.onTapOverride,
  });

  void _handleTap(BuildContext context) async {
    if (onTapOverride != null) {
      onTapOverride!();
      return;
    }
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
            description: lang == Lang.fr
                ? 'Explorez l\'ensemble de mes réalisations : développement, réseaux et cybersécurité.'
                : 'Explore all my work: development, networking, and cybersecurity.',
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
    } else if (label == 'Certifications' || label == 'Certifications') {
      // Ouvre la fenêtre des certifications de la même manière que pour Expériences ou Compétences
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => CertificationWindow(lang: lang),
          transitionsBuilder: (_, anim, __, child) => ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOut),
            ),
            child: FadeTransition(opacity: anim, child: child),
          ),
        ),
      );
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
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(12),
                    image: (imagePath != null && emoji == null)
                        ? DecorationImage(
                            image: AssetImage(imagePath!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: emoji != null
                      ? Center(
                          child: Text(
                            emoji!,
                            style: const TextStyle(
                              fontSize: 32,
                              fontFamilyFallback: ['Apple Color Emoji', 'Segoe UI Emoji', 'Noto Color Emoji'],
                            ),
                          ),
                        )
                      : null,
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