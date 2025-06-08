import 'package:flutter/material.dart';
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
  int currentImageIndex = 0;

  void showImageViewer(int index) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.transparent),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(widget.gallery[index], fit: BoxFit.contain),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  if (widget.gallery.length > 1 && index > 0)
                    Positioned(
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showImageViewer(index - 1);
                        },
                      ),
                    ),
                  if (widget.gallery.length > 1 && index < widget.gallery.length - 1)
                    Positioned(
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                          showImageViewer(index + 1);
                        },
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

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d\'ouvrir le lien')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E1E1E),
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 700),
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
                  const SizedBox(width: 6),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(widget.title, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
              child: Image.asset(widget.image, fit: BoxFit.cover, width: double.infinity, height: 220),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Scrollbar(
                  thumbVisibility: true,
                  radius: const Radius.circular(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(widget.category, style: const TextStyle(color: Colors.white60)),
                        const SizedBox(height: 14),
                        Text(
                          widget.fullDescription,
                          style: const TextStyle(color: Colors.white70, height: 1.5),
                        ),
                        if (widget.githubUrl != null) ...[
                          const SizedBox(height: 20),
                          TextButton.icon(
                            onPressed: () => _launchURL(widget.githubUrl!),
                            icon: const Icon(Icons.link, color: Colors.blue),
                            label: const Text("Voir le projet sur GitHub", style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                        if (widget.competencies.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          const Text("Compétences acquises:",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          for (final skill in widget.competencies)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Row(
                                children: [
                                  const Icon(Icons.check_circle, size: 16, color: Colors.greenAccent),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(skill,
                                        style: const TextStyle(color: Colors.white70)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                        if (widget.gallery.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          const Text("Galerie:",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.gallery.length,
                              separatorBuilder: (_, __) => const SizedBox(width: 12),
                              itemBuilder: (_, i) => MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () => showImageViewer(i),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(widget.gallery[i], fit: BoxFit.cover, width: 200),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
