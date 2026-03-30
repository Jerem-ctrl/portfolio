import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portofolio/main.dart' show Lang;
import 'package:portofolio/project_windows.dart' show MacControlButton;

class CertificationWindow extends StatefulWidget {
  final Lang lang;

  const CertificationWindow({super.key, required this.lang});

  @override
  State<CertificationWindow> createState() => _CertificationWindowState();
}

class _CertificationWindowState extends State<CertificationWindow> {
  bool _isLoading = true;
  bool _isMaximized = false;
  bool _isPrivacyMode = false;

  static const List<Map<String, String>> _certifications = [
    {
      'title': 'CCNA 1 – Introduction to Networks',
      'issuer': 'Cisco Networking Academy',
      'image': 'documents/certification/CCNA1.png',
      'color': '0xFF1BA0D8',
    },
    {
      'title': 'CCNA 2 – Switching, Routing & Wireless',
      'issuer': 'Cisco Networking Academy',
      'image': 'documents/certification/CCNA2.png',
      'color': '0xFF1BA0D8',
    },
    {
      'title': 'Introduction to Cybersecurity',
      'issuer': 'Cisco NetAcad Cup IUT',
      'image': 'documents/certification/NetAcadCup_IUT_Intro_Cyber.png',
      'color': '0xFFE53935',
    },
    {
      'title': 'Introduction to IoT',
      'issuer': 'Cisco NetAcad Cup IUT',
      'image': 'documents/certification/NetAcadCup_IUT_Intro_IOT.png',
      'color': '0xFF43A047',
    },
    {
      'title': 'Introduction to Modern AI',
      'issuer': 'Cisco NetAcad Cup IUT',
      'image': 'documents/certification/NetAcadCup_IUT_Intro_Modern_IA.png',
      'color': '0xFF8E24AA',
    },
    {
      'title': 'Networking Basics',
      'issuer': 'Cisco NetAcad Cup IUT',
      'image': 'documents/certification/NetAcadCup_IUT_Networking_Basics.png',
      'color': '0xFFFF8F00',
    },
    {
      'title': 'Sécurité Numérique',
      'issuer': 'Cisco NetAcad Cup IUT',
      'image': 'documents/certification/NetAcadCup_IUT_Secu_Num.png',
      'color': '0xFFD32F2F',
    },
    {
      'title': 'SecNumAcadémie – ANSSI',
      'issuer': 'ANSSI',
      'image': 'documents/certification/attestationSecNumacademie.png',
      'color': '0xFF1565C0',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _isLoading = false);
    });
  }

  void _toggleMaximize() {
    setState(() => _isMaximized = !_isMaximized);
  }

  @override
  Widget build(BuildContext context) {
    final isFr = widget.lang == Lang.fr;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double currentWidth;
    double currentHeight;

    if (_isMaximized) {
      currentWidth = screenWidth;
      currentHeight = screenHeight;
    } else {
      currentWidth = screenWidth < 820 ? screenWidth * 0.95 : 800;
      double defaultHeight = 600;
      currentHeight = screenHeight < defaultHeight ? screenHeight * 0.9 : defaultHeight;
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Fond cliquable pour fermer
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!_isMaximized) Navigator.of(context).pop();
            },
            child: Container(color: Colors.transparent),
          ),

          // Fenêtre
          GestureDetector(
            onTap: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: currentWidth,
              height: currentHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: _isMaximized ? null : BorderRadius.circular(12),
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
                  // ——— BARRE DE TITRE macOS ———
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: _isMaximized
                          ? null
                          : const BorderRadius.vertical(top: Radius.circular(12)),
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
                          icon: _isPrivacyMode ? Icons.lock : Icons.visibility_off,
                          onTap: () => setState(() => _isPrivacyMode = !_isPrivacyMode),
                        ),
                        MacControlButton(
                          color: const Color(0xFF28C840),
                          icon: _isMaximized ? Icons.close_fullscreen : Icons.open_in_full,
                          onTap: _toggleMaximize,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isFr ? '🏆 Mes Certifications' : '🏆 My Certifications',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),

                  // ——— CONTENU ———
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Contenu principal (flouté si mode privacy)
                        ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: _isPrivacyMode ? 10.0 : 0.0,
                            sigmaY: _isPrivacyMode ? 10.0 : 0.0,
                          ),
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator(color: Colors.white))
                              : _buildContent(context, isFr),
                        ),

                        // Overlay cadenas
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

  Widget _buildContent(BuildContext context, bool isFr) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: Row(
            children: [
              const Text('🏆', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isFr ? 'Certifications Professionnelles' : 'Professional Certifications',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isFr
                          ? '${_certifications.length} certifications en réseaux, cybersécurité & IA'
                          : '${_certifications.length} certifications in networking, cybersecurity & AI',
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.45)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white10, height: 1),

        // Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 700 ? 2 : 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
              ),
              itemCount: _certifications.length,
              itemBuilder: (context, index) {
                final cert = _certifications[index];
                return _CertificationCard(
                  title: cert['title']!,
                  issuer: cert['issuer']!,
                  imagePath: cert['image']!,
                  accentColor: Color(int.parse(cert['color']!)),
                  onTap: () => _showCertificateDetail(context, cert),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showCertificateDetail(BuildContext context, Map<String, String> cert) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.transparent),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width < 800 
                   ? MediaQuery.of(context).size.width * 0.95 
                   : MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height < 800 
                   ? MediaQuery.of(context).size.height * 0.85 
                   : MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.7), blurRadius: 40),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    // Title bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          MacControlButton(
                            color: const Color(0xFFFF5F57),
                            icon: Icons.close,
                            onTap: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              cert['title']!,
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Full image with zoom
                    Expanded(
                      child: InteractiveViewer(
                        maxScale: 4,
                        child: Image.asset(cert['image']!, fit: BoxFit.contain),
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

class _CertificationCard extends StatefulWidget {
  final String title;
  final String issuer;
  final String imagePath;
  final Color accentColor;
  final VoidCallback onTap;

  const _CertificationCard({
    required this.title,
    required this.issuer,
    required this.imagePath,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<_CertificationCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.accentColor.withOpacity(_hovered ? 0.2 : 0.08),
                const Color(0xFF2C2C2E).withOpacity(0.9),
              ],
            ),
            border: Border.all(
              color: _hovered
                  ? widget.accentColor.withOpacity(0.4)
                  : Colors.white.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: _hovered
                ? [BoxShadow(color: widget.accentColor.withOpacity(0.12), blurRadius: 16, offset: const Offset(0, 4))]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.issuer,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.verified, color: widget.accentColor, size: 13),
                          const SizedBox(width: 4),
                          Text(
                            'Validée',
                            style: TextStyle(color: widget.accentColor, fontSize: 10, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                AnimatedOpacity(
                  opacity: _hovered ? 1.0 : 0.3,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.arrow_forward_ios_rounded, color: widget.accentColor, size: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
