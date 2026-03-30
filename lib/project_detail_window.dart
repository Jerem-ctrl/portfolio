import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailWindow extends StatefulWidget {
  final String title;
  final String category;
  final String shortDescription;
  final String fullDescription;
  final String image;
  final List<String> gallery;
  final List<String> competencies;
  final Function(String) onImageTap;
  final String? githubUrl;

  const ProjectDetailWindow({
    super.key,
    required this.title,
    required this.category,
    required this.shortDescription,
    required this.fullDescription,
    required this.image,
    required this.gallery,
    required this.competencies,
    required this.onImageTap,
    this.githubUrl,
  });

  @override
  State<ProjectDetailWindow> createState() => _ProjectDetailWindowState();
}

class _ProjectDetailWindowState extends State<ProjectDetailWindow> {
  bool _isMaximized = false;
  bool _isMinimized = false;
  bool _isPrivacyMode = false;
  bool _isHoveringGreen = false;

  void showGalleryViewer(int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.95),
      builder: (context) {
        final PageController pageController = PageController(
          initialPage: initialIndex,
        );
        return StatefulBuilder(
          builder: (context, setStateOverlay) {
            return Stack(
              alignment: Alignment.center,
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: widget.gallery.length,
                  itemBuilder: (context, index) {
                    return InteractiveViewer(
                      minScale: 0.5,
                      maxScale: 4.0,
                      child: Center(
                        child: Image.asset(
                          widget.gallery[index],
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 40,
                  right: 30,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () => pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800; // Détection Mobile

    // --- DIMENSIONS RESPONSIVE ---
    // Sur mobile, on prend presque toute la largeur (95%)
    // Sur PC, soit plein écran, soit 900px
    double targetWidth = isMobile
        ? size.width * 0.95
        : (_isMaximized ? size.width : 900);

    // Hauteur : Sur mobile, on prend de la hauteur. Sur PC, fixe ou plein écran.
    double targetHeight = _isMinimized
        ? 40
        : (isMobile ? size.height * 0.85 : (_isMaximized ? size.height : 750));

    final double borderRadius = _isMaximized ? 0 : 12;

    return GestureDetector(
      onTap: () {
        if (!_isMaximized) Navigator.pop(context);
      },
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: GestureDetector(
          onTap: () {},
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: targetWidth,
            height: targetHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Material(
              type: MaterialType.transparency,
              borderRadius: BorderRadius.circular(borderRadius),
              child: Column(
                children: [
                  // --- BARRE DE TITRE MACOS ---
                  GestureDetector(
                    onDoubleTap: () => setState(() {
                      _isMinimized = false;
                      _isMaximized = !_isMaximized;
                    }),
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius),
                          bottomLeft: _isMinimized
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                          bottomRight: _isMinimized
                              ? Radius.circular(borderRadius)
                              : Radius.zero,
                        ),
                        border: _isMinimized
                            ? null
                            : Border(
                                bottom: BorderSide(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                      ),
                      child: Row(
                        // Dans la Row de la barre de titre de ProjectDetailWindow
                        children: [
                          // Rouge
                          MacControlButton(
                            color: const Color(0xFFFF5F57),
                            icon: Icons.close,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          // Jaune
                          MacControlButton(
                            color: const Color(0xFFFFBD2E),
                            icon: _isPrivacyMode ? Icons.lock : Icons.visibility_off,
                            onTap: () => setState(() => _isPrivacyMode = !_isPrivacyMode),
                          ),
                          // Vert
                          MacControlButton(
                            color: const Color(0xFF28C840),
                            icon: _isMaximized
                                ? Icons.close_fullscreen
                                : Icons.open_in_full,
                            onTap: () =>
                                setState(() => _isMaximized = !_isMaximized),
                          ),
                          // ... Le titre ...
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 70),
                        ],
                      ),
                    ),
                  ),

                  // --- CONTENU PRINCIPAL ---
                  if (!_isMinimized)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: isMobile
                                  ? 180
                                  : 250, // Image moins haute sur mobile
                              width: double.infinity,
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                            ),

                            Padding(
                              // Moins de padding sur mobile
                              padding: EdgeInsets.all(isMobile ? 16.0 : 32.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- HEADER RESPONSIVE ---
                                  // Sur Mobile : Colonne. Sur PC : Ligne.
                                  isMobile
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            _CategoryTag(text: widget.category),
                                            const SizedBox(height: 16),
                                            if (widget.githubUrl != null)
                                              SizedBox(
                                                width: double
                                                    .infinity, // Bouton pleine largeur sur mobile
                                                child: _ProjectButton(
                                                  url: widget.githubUrl!,
                                                ),
                                              ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.title,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  _CategoryTag(
                                                    text: widget.category,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (widget.githubUrl != null)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 16,
                                                ),
                                                child: _ProjectButton(
                                                  url: widget.githubUrl!,
                                                ),
                                              ),
                                          ],
                                        ),

                                  const SizedBox(height: 32),
                                  const Divider(color: Colors.white10),
                                  const SizedBox(height: 24),

                                  const Text(
                                    "DESCRIPTION",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    widget.fullDescription,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      height: 1.6,
                                    ),
                                  ),

                                  const SizedBox(height: 32),

                                  if (widget.competencies.isNotEmpty) ...[
                                    const Text(
                                      "COMPÉTENCES CLÉS",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: widget.competencies
                                          .map(
                                            (comp) => Chip(
                                              backgroundColor: const Color(
                                                0xFF2A2A2A,
                                              ),
                                              label: Text(
                                                comp,
                                                style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              side: BorderSide(
                                                color: Colors.white.withOpacity(
                                                  0.1,
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    const SizedBox(height: 32),
                                  ],

                                  if (widget.gallery.isNotEmpty) ...[
                                    const Text(
                                      "GALERIE",
                                      style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.gallery.length,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(width: 16),
                                        itemBuilder: (_, i) => MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: GestureDetector(
                                            onTap: () => showGalleryViewer(i),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white
                                                        .withOpacity(0.1),
                                                  ),
                                                ),
                                                child: Image.asset(
                                                  widget.gallery[i],
                                                  height: 150,
                                                  width: 240,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --- WIDGETS UTILES POUR LE RESPONSIVE ---

class _CategoryTag extends StatelessWidget {
  final String text;
  const _CategoryTag({required this.text});

  @override
  Widget build(BuildContext context) {
    final Color cat = getCategoryColor(text);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cat.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: cat.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: cat,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProjectButton extends StatelessWidget {
  final String url;
  const _ProjectButton({required this.url});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) await launchUrl(uri);
      },
      icon: const Icon(Icons.open_in_new, size: 18),
      label: const Text("Voir le projet"),
    );
  }
}
