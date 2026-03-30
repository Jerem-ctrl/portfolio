import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:portofolio/project_detail_window.dart';
import 'package:portofolio/all_projects_data.dart';


Color getCategoryColor(String category) {
  final cat = category.toLowerCase();
  if (cat.contains('dév') || cat.contains('dev') || cat.contains('web') || cat.contains('python') || cat.contains('signal') || cat.contains('mobile')) {
    return const Color(0xFF007AFF); // Bleu macOS (Dev)
  } else if (cat.contains('réseau') || cat.contains('network') || cat.contains('telecom') || cat.contains('fibre') || cat.contains('télécommunication')) {
    return const Color(0xFF28C840); // Vert macOS (Réseau)
  } else if (cat.contains('sécurité') || cat.contains('security') || cat.contains('pentest') || cat.contains('cyber')) {
    return const Color(0xFFFF5F57); // Rouge macOS (Cyber)
  }
  return Colors.grey; // Par défaut
}

class FeaturedProjectCard extends StatelessWidget {
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final String image;
  final List<String> gallery;
  final List<String> competencies;
  final String? githubUrl;

  const FeaturedProjectCard({
    super.key,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.image,
    required this.gallery,
    required this.competencies,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Détection si l'écran est petit (Mobile)
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        // On garde ta modification de contraintes
        constraints: isMobile ? null : const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: isMobile
            ? _buildMobileLayout(context) // Layout dédié Mobile
            : _buildDesktopLayout(context), // Layout dédié PC
      ),
    );
  }

  // --- VERSION MOBILE (Colonne simple) ---
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image en haut
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          child: Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // Texte en dessous
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(category, style: TextStyle(color: getCategoryColor(category))),
              const SizedBox(height: 12),
              Text(shortDescription,
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 16),
              _buildSeeMoreButton(context),
            ],
          ),
        ),
      ],
    );
  }

  // --- VERSION PC (Ligne avec hauteur intrinsèque) ---
  Widget _buildDesktopLayout(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Texte à gauche (ou à droite selon ton choix, ici je remets comme ton code : Flex puis Image)
          // Mais attention, ton code précédent mettait l'image à droite si !isMobile.
          // Je vais garder ton ordre : Texte à Gauche, Image à Droite ?
          // Ah non, dans ton code précédent :
          // if (isMobile) => Image en haut.
          // if (!isMobile) => Image à droite (via Flexible à la fin).
          // MAIS le Expanded est au début. Donc Texte à Gauche, Image à Droite.

          // Texte (Expanded pour prendre la place restante)
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center, // Centrer verticalement
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24, // Un peu plus gros sur PC
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(category, style: TextStyle(color: getCategoryColor(category), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(shortDescription,
                      style: const TextStyle(color: Colors.white70, height: 1.5)),
                  const SizedBox(height: 20),
                  _buildSeeMoreButton(context),
                ],
              ),
            ),
          ),

          // Image (Flexible)
          Flexible(
            flex: 2,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(image, fit: BoxFit.cover),
                  // Petit dégradé pour le style
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Colors.transparent, const Color(0xFF2A2A2A).withOpacity(0.8)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeeMoreButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => ProjectDetailWindow(
            title: title,
            category: category,
            shortDescription: shortDescription,
            fullDescription: fullDescription,
            image: image,
            gallery: gallery,
            competencies: competencies,
            onImageTap: (String imagePath) {},
            githubUrl: githubUrl,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.1),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text("En savoir plus"),
    );
  }
}
class MacOSProjectWindow extends StatefulWidget {
  final String title;
  final List<Widget> content;
  final String? description;

  const MacOSProjectWindow({
    super.key,
    required this.title,
    required this.content,
    this.description
  });

  @override
  State<MacOSProjectWindow> createState() => _MacOSProjectWindowState();
}

class _MacOSProjectWindowState extends State<MacOSProjectWindow> {
  bool _isLoading = true;
  bool _isMinimized = false;
  bool _isMaximized = false;
  bool _isPrivacyMode = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isLoading = false);
    });
  }

  void _toggleMaximize() {
    setState(() {
      _isMaximized = !_isMaximized;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcul des dimensions
    double currentWidth;
    double currentHeight;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_isMaximized) {
      currentWidth = screenWidth;
      currentHeight = screenHeight;
    } else {
      // --- MODIFICATION ICI : Responsive mobile ---
      // Si l'écran est petit (mobile), on prend 95% de la largeur. 
      // Sinon on garde 800px.
      currentWidth = screenWidth < 820 ? screenWidth * 0.95 : 800;
      
      // Pareil pour la hauteur : on s'assure que ça rentre
      double defaultHeight = 600;
      currentHeight = _isMinimized 
          ? 40 
          : (screenHeight < defaultHeight ? screenHeight * 0.9 : defaultHeight);
    }
    return Dialog(
      backgroundColor: Colors.transparent, // Fond transparent pour gérer nous-mêmes le clic
      insetPadding: EdgeInsets.zero,       // On prend tout l'espace pour capter les clics partout
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. COUCHE DE FOND (CLIC EXTÉRIEUR)
          // Ce widget invisible capture les clics hors de la fenêtre
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // On ferme SEULEMENT si la fenêtre n'est pas en plein écran
              if (!_isMaximized) {
                Navigator.of(context).pop();
              }
            },
            child: Container(color: Colors.transparent),
          ),

          // 2. LA FENÊTRE (CONTENU)
          // On protège le clic ici pour ne pas fermer quand on clique DANS la fenêtre
          GestureDetector(
            onTap: () {}, // Ne rien faire (absorbe le clic)
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: currentWidth,
              height: currentHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                // Pas d'arrondi si maximisé, sinon arrondi 12
                borderRadius: _isMaximized ? null : BorderRadius.circular(12),
                // Ombre portée (nécessaire car on a retiré celle du Dialog par défaut)
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // --- BARRE DE TITRE ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: _isMaximized ? null : const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Row(
                      children: [
                        MacControlButton(
                          color: const Color(0xFFFF5F57),
                          icon: Icons.close,
                          onTap: () => Navigator.of(context).pop(),
                        ),
                        // --- MODIFICATION BOUTON JAUNE (MODE CONFIDENTIEL) ---
                        MacControlButton(
                          color: const Color(0xFFFFBD2E),
                          // Si le mode est actif, on affiche un cadenas, sinon un œil barré
                          icon: _isPrivacyMode ? Icons.lock : Icons.visibility_off,
                          // Action : On inverse la valeur de _isPrivacyMode
                          onTap: () => setState(() => _isPrivacyMode = !_isPrivacyMode),
                        ),
                        MacControlButton(
                          color: const Color(0xFF28C840),
                          icon: _isMaximized ? Icons.close_fullscreen : Icons.open_in_full,
                          onTap: _toggleMaximize,
                        ),
                        const SizedBox(width: 10),
                        Text(widget.title, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),

                  // --- CONTENU AVEC EFFET FLOU (PRIVACY) ---
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // 1. Le contenu réel (Flouté si mode privacy actif)
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: _isPrivacyMode ? 10.0 : 0.0, // Flou horizontal
                            sigmaY: _isPrivacyMode ? 10.0 : 0.0, // Flou vertical
                          ),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator(color: Colors.white))
                              : (widget.title.toLowerCase().contains("projet") || widget.title.toLowerCase().contains("project"))
                                  ? _ProjectGallery(
                                      projects: widget.content,
                                      description: widget.description,
                                      title: widget.title,
                                    )
                                  : ListView(padding: const EdgeInsets.all(16), children: widget.content),
                        ),

                        // 2. L'overlay "Cadenas" (Visible seulement en mode privacy)
                        if (_isPrivacyMode)
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.lock_outline, size: 64, color: Colors.white.withOpacity(0.8)),
                                const SizedBox(height: 16),
                                Text(
                                  "CONFIDENTIAL",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StandardProjectCard extends StatelessWidget {
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final String image;
  final List<String> gallery;
  final List<String> competencies;
  final String? githubUrl;

  const StandardProjectCard({
    super.key,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.image,
    required this.gallery,
    required this.competencies,
    this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    // 1. On récupère la couleur associée à ce projet
    final Color catColor = getCategoryColor(category);

    return Card(
      color: const Color(0xFF2A2A2A),
      clipBehavior: Clip.antiAlias, // Important pour que le bandeau respecte les bords arrondis
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        // Astuce : On simule le "Bandeau" avec une bordure gauche épaisse
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: catColor, width: 6), // Largeur du bandeau couleur
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Contenu texte
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    
                    // Catégorie colorée (Style Tag macOS)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: catColor.withOpacity(0.15), // Fond très léger
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category.toUpperCase(), // En majuscule pour faire "titre"
                        style: TextStyle(
                          color: catColor, // Texte de la couleur du thème
                          fontSize: 10, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 6),
                    Text(shortDescription,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 13)),
                  ],
                ),
              ),
              // Bouton Voir plus
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black38,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.zero,
                      child: ProjectDetailWindow(
                        title: title,
                        category: category,
                        shortDescription: shortDescription,
                        fullDescription: fullDescription,
                        image: image,
                        gallery: gallery,
                        competencies: competencies,
                        githubUrl: githubUrl,
                        onImageTap: (img) {},
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. Colle tout ça à la fin du fichier project_windows.dart

class _ProjectGallery extends StatefulWidget {

  final List<Widget> projects;
  final String? description;
  final String title;

  const _ProjectGallery({
    required this.projects,
    this.description,
    this.title = "Projets",
  });

  @override
  State<_ProjectGallery> createState() => _ProjectGalleryState();
}

class _ProjectGalleryState extends State<_ProjectGallery> {
  int _selectedIndex = 0; // 0=Tous, 1=Cyber, 2=Dev, 3=Réseau
  String _searchQuery = ""; // <--- AJOUTE CETTE LIGNE
  final TextEditingController _searchController = TextEditingController();

  // Fonction utilitaire pour détecter si c'est Cyber
  bool _isCyberProject(String title, String category) {
    final t = title.toLowerCase();
    final c = category.toLowerCase();
    return c.contains('sécurité') || c.contains('security') || 
           c.contains('pentest') || c.contains('cyber') || 
           c.contains('audit') || c.contains('offensive') ||
           c.contains('malware') || c.contains('forensic') ||
           t.contains('audit') || t.contains('cyber');
  }

  @override
  Widget build(BuildContext context) {
    // Cette liste contiendra TOUS les projets Cyber formatés pour le carrousel
    final List<FeaturedProjectCard> carouselProjects = []; 

    // 1. Remplissage intelligent de la liste Carrousel
    for (var w in widget.projects) {
      FeaturedProjectCard? projectToAdd;

      // CAS A : C'est déjà une FeaturedProjectCard
      if (w is FeaturedProjectCard) {
        if (_isCyberProject(w.title, w.category)) {
          projectToAdd = w;
        }
      } 
      // CAS B : C'est une StandardProjectCard (ex: Malware Analysis)
      // On la convertit en FeaturedProjectCard pour qu'elle ait le beau design dans le carrousel
      else if (w is StandardProjectCard) {
        if (_isCyberProject(w.title, w.category)) {
          projectToAdd = FeaturedProjectCard(
            title: w.title,
            category: w.category,
            shortDescription: w.shortDescription,
            fullDescription: w.fullDescription,
            image: w.image,
            gallery: w.gallery,
            competencies: w.competencies,
            githubUrl: w.githubUrl,
          );
        }
      }

      // Si on a trouvé un candidat, on l'ajoute
      if (projectToAdd != null) {
        carouselProjects.add(projectToAdd);
      }
    }

    // 2. Filtrage de la liste principale (Grille du bas)
    final List<Widget> filteredList = widget.projects.where((w) {
      // Récupération des données du projet pour la recherche
      String title = "";
      String desc = "";
      String cat = "";
      List<String> comps = [];

      if (w is FeaturedProjectCard) {
        title = w.title.toLowerCase();
        desc = w.fullDescription.toLowerCase();
        cat = w.category.toLowerCase();
        comps = w.competencies.map((e) => e.toLowerCase()).toList();
      } else if (w is StandardProjectCard) {
        title = w.title.toLowerCase();
        desc = w.fullDescription.toLowerCase();
        cat = w.category.toLowerCase();
        comps = w.competencies.map((e) => e.toLowerCase()).toList();
      } else {
        return false; // On cache les éléments non-projets lors d'une recherche
      }

      // --- FILTRE 1 : Les Boutons (Catégories) ---
      bool matchesCategory = false;
      if (_selectedIndex == 0) matchesCategory = true;
      else if (_selectedIndex == 1) matchesCategory = _isCyberProject(title, cat);
      else if (_selectedIndex == 2) matchesCategory = cat.contains('dév') || cat.contains('dev') || cat.contains('web') || cat.contains('python') || cat.contains('mobile') || cat.contains('signal');
      else if (_selectedIndex == 3) matchesCategory = cat.contains('réseau') || cat.contains('network') || cat.contains('telecom') || cat.contains('fibre');

      // --- FILTRE 2 : La Barre de Recherche ---
      bool matchesSearch = true;
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        // On cherche dans le titre, la description ou les compétences
        matchesSearch = title.contains(query) || 
                        desc.contains(query) || 
                        comps.any((c) => c.contains(query));
      }

      return matchesCategory && matchesSearch;
    }).toList();

    // Tri : Featured en premier, puis Dev → Réseau → Cyber
    filteredList.sort((a, b) {
      int sortPriority(Widget w) {
        if (w is FeaturedProjectCard) return 0;
        if (w is StandardProjectCard) {
          final cat = w.category.toLowerCase();
          if (cat.contains('dév') || cat.contains('dev') || cat.contains('web') || cat.contains('python') || cat.contains('signal') || cat.contains('mobile')) return 1;
          if (cat.contains('réseau') || cat.contains('network') || cat.contains('telecom') || cat.contains('fibre')) return 2;
          return 3;
        }
        return 4;
      }
      return sortPriority(a).compareTo(sortPriority(b));
    });

    return Scaffold( // Utiliser Scaffold ou Container transparent
      backgroundColor: Colors.transparent,
      body: ListView( // <--- TOUT est maintenant dans la ListView
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24), // Marges globales
        children: [
          
          // 1. ON INSÈRE L'EN-TÊTE ICI (Titre + Description)
          // On récupère le titre depuis le widget parent s'il le faut, ou on peut le passer en paramètre.
          // Pour faire simple, on utilise la description. Si tu veux le titre, il faut le passer au widget _ProjectGallery.
          _buildMacHeader(widget.title, widget.description),

          // 2. BARRE D'OUTILS (Recherche + Filtres sur la même ligne pour gagner de la place)
          LayoutBuilder(builder: (context, constraints) {
            // Sur mobile on met en colonne, sur PC en ligne
            bool isSmall = constraints.maxWidth < 600;
            return Flex(
              direction: isSmall ? Axis.vertical : Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: isSmall ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
              children: [
                // Barre de recherche à gauche
                Container(
                  width: isSmall ? double.infinity : 250,
                  height: 36,
                  margin: EdgeInsets.only(bottom: isSmall ? 12 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _searchQuery = value),
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: "Rechercher...",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
                      prefixIcon: const Icon(Icons.search, size: 16, color: Colors.white54),
                      suffixIcon: _searchQuery.isNotEmpty
                        ? GestureDetector(onTap: () { _searchController.clear(); setState(() => _searchQuery = ""); }, child: const Icon(Icons.cancel, size: 14, color: Colors.white38))
                        : null,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                    ),
                  ),
                ),

                // Filtres à droite
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterBtn("Tous", 0),
                      const SizedBox(width: 4),
                      _buildFilterBtn("Cyber", 1), // Emojis retirés pour faire plus 'Pro'
                      const SizedBox(width: 4),
                      _buildFilterBtn("Dev", 2),
                      const SizedBox(width: 4),
                      _buildFilterBtn("Réseau", 3),
                    ],
                  ),
                ),
              ],
            );
          }),

          const SizedBox(height: 24), // Espace avant les projets

          // 3. LE CARROUSEL (S'il y a lieu)
          if ((_selectedIndex == 0 || _selectedIndex == 1) && carouselProjects.isNotEmpty) ...[
             const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "À LA UNE", // Plus sobre que "CYBERSÉCURITÉ"
                  style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
              _AutoScrollingCarousel(projects: carouselProjects),
              const SizedBox(height: 30),
              Divider(color: Colors.white.withOpacity(0.1)), // Séparateur
              const SizedBox(height: 20),
          ],

          // 4. LA LISTE DES PROJETS (Grille du bas)
          // On n'utilise plus Expanded ici car on est déjà dans une ListView
          ...filteredList,
          
          const SizedBox(height: 40), // Marge de fin
        ],
      ),
    );
  }

  // Design du bouton filtre style macOS
  Widget _buildFilterBtn(String label, int index) {
    bool isSelected = _selectedIndex == index;
    final Color accentColor = index == 1
        ? const Color(0xFFFF5F57)
        : index == 2
            ? const Color(0xFF007AFF)
            : index == 3
                ? const Color(0xFF28C840)
                : Colors.white;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? accentColor.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? accentColor : Colors.white60,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal
          )
        ),
      ),
    );
  }

  // Ajoute ceci dans la classe _ProjectGalleryState (vers la ligne 870)
  // C'est le design du titre + description style Apple
  Widget _buildMacHeader(String title, String? description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alignement gauche (macOS standard)
        children: [
          // Le Gros Titre
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32, // Très gros
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            // La description en gris, lisible
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6), // Gris doux
                fontSize: 15,
                height: 1.4, // Bonne hauteur de ligne
                fontFamily: '.SF UI Text',
              ),
            ),
          ],
          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.1)), // Séparateur subtil
        ],
      ),
    );
  }
}

// --- NOUVEAU WIDGET : Élément individuel du carrousel style "Bannière" ---
class _CarouselBannerItem extends StatelessWidget {
  final FeaturedProjectCard project;

  const _CarouselBannerItem({required this.project});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand, // L'image prend toute la place
        children: [
          // 1. L'image en fond (Bannière)
          Image.asset(
            project.image,
            fit: BoxFit.cover,
          ),

          // 2. Un dégradé sombre par-dessus pour que le texte reste lisible
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.5, 0.7, 1.0],
              ),
            ),
          ),

          // 3. Le contenu superposé (Titre + Bouton) en bas
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Titre du projet uniquement
                Expanded(
                  child: Text(
                    project.title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      shadows: [Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 2))],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                // Bouton "discret" style macOS
                _buildMacOsButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMacOsButton(BuildContext context) {
    // On utilise un InkWell pour l'effet de clic sur un conteneur stylisé
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Action : ouvrir la popup de détails
          showDialog(
            context: context,
            barrierColor: Colors.black.withOpacity(0.5),
            builder: (_) => Dialog(
               backgroundColor: Colors.transparent,
               insetPadding: EdgeInsets.zero,
               child: ProjectDetailWindow(
                 title: project.title,
                 category: project.category,
                 shortDescription: project.shortDescription,
                 fullDescription: project.fullDescription,
                 image: project.image,
                 gallery: project.gallery,
                 competencies: project.competencies,
                 githubUrl: project.githubUrl,
                 onImageTap: (img) {},
               ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            // Fond semi-transparent style "verre"
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 0.5),
          ),
          child: const Text(
            "En savoir plus",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Remplacement complet de la classe _AutoScrollingCarousel ---

class _AutoScrollingCarousel extends StatefulWidget {
  final List<FeaturedProjectCard> projects;
  const _AutoScrollingCarousel({required this.projects});

  @override
  State<_AutoScrollingCarousel> createState() => _AutoScrollingCarouselState();
}

class _AutoScrollingCarouselState extends State<_AutoScrollingCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.95);
    // On ne lance le timer que s'il y a plus d'1 projet
    if (widget.projects.length > 1) {
      _startAutoScroll();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < widget.projects.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 260, 
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
               setState(() => _currentPage = page);
            },
            itemCount: widget.projects.length,
            itemBuilder: (ctx, idx) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _CarouselBannerItem(project: widget.projects[idx]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // --- LES PETITS POINTS (INDICATEURS) ---
        if (widget.projects.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.projects.length, (index) {
              final bool isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 24 : 8, // S'allonge si actif
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.white24,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
      ],
    );
  }
}

// --- COMPOSANT UNIVERSEL : Bouton macOS interactif AMÉLIORÉ ---
// À placer à la fin de project_windows.dart
class MacControlButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const MacControlButton({
    super.key,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  State<MacControlButton> createState() => _MacControlButtonState();
}

class _MacControlButtonState extends State<MacControlButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // 1. Change le curseur pour indiquer que c'est cliquable
      cursor: SystemMouseCursors.click,
      // 2. Détecte le survol
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      // 3. Zone de détection qui inclut la marge (plus facile à viser)
      hitTestBehavior: HitTestBehavior.translucent,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          // On inclut la marge de droite DANS le conteneur cliquable
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 16, 
            height: 16,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            // 4. Vraie animation de fondu (Fade In/Out)
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200), // Durée fluide
              opacity: _isHovered ? 1.0 : 0.0, // Visible ou invisible
              child: Icon(
                widget.icon,
                size: 10, // Taille ajustée pour être nette
                color: Colors.black.withOpacity(0.6), // Contraste style macOS
              ),
            ),
          ),
        ),
      ),
    );
  }
}