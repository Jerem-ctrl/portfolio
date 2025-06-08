import 'package:flutter/material.dart';
import 'package:portofolio/project_detail_window.dart';
import 'package:portofolio/all_projects_data.dart';


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
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Texte à gauche
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(category,
                        style: const TextStyle(color: Colors.white54), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    Text(shortDescription,
                        style: const TextStyle(color: Colors.white70), maxLines: 3, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 12),
                    TextButton(
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
                            onImageTap: (String imagePath) {
                              showDialog(
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.4),
                                builder: (_) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.all(20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        Image.asset(imagePath, fit: BoxFit.contain),
                                        IconButton(
                                          icon: const Icon(Icons.close, color: Colors.white),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            githubUrl: githubUrl,
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                      ),
                      child: const Text("Voir plus",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),

            // Image à droite avec fondu
            Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF2A2A2A).withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MacOSProjectWindow extends StatefulWidget {
  final String title;
  final List<Widget> content;

  const MacOSProjectWindow({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  State<MacOSProjectWindow> createState() => _MacOSProjectWindowState();
}

class _MacOSProjectWindowState extends State<MacOSProjectWindow> {
  bool _isLoading = true;
  bool _isMinimized = false;
  bool _isMaximized = false;

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
    final double dialogWidth = _isMaximized ? MediaQuery.of(context).size.width : 800;
    final double dialogHeight = _isMaximized ? MediaQuery.of(context).size.height : 600;

    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 6),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => _isMinimized = !_isMinimized),
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 6),
                    ),
                  ),
                  GestureDetector(
                    onTap: _toggleMaximize,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      margin: const EdgeInsets.only(right: 12),
                    ),
                  ),
                  Text(widget.title, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            if (_isMinimized)
              const SizedBox.shrink()
            else
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.white),
                            SizedBox(height: 16),
                            Text('Chargement...', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      )
                    : Scrollbar(
                        thumbVisibility: true,
                        thickness: 6,
                        radius: const Radius.circular(10),
                        trackVisibility: true,
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: widget.content,
                        ),
                      ),
              ),
          ],
        ),
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
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                  Text(category, style: const TextStyle(color: Colors.white60)),
                  const SizedBox(height: 6),
                  Text(shortDescription,
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.black),
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
                    githubUrl: githubUrl,
                    onImageTap: (img) {},
                  ),
                );
              },
              child: const Text("Voir plus", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
