// experience_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;
import 'package:portofolio/main.dart' show Lang; // pour réutiliser l'enum

class ExperienceWindow extends StatelessWidget {
  final Lang lang;
  const ExperienceWindow({super.key, required this.lang});

  bool get isFr => lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  // Dans la classe ExperienceWindow
  List<ExperienceItem> _getExperiences(bool isFr) {
    return [
      // 1. LE STAGE À VENIR (Thales)
      ExperienceItem(
        company: 'Thales Services Numériques',
        role: isFr ? 'Stagiaire Cybersécurité' : 'Cybersecurity Intern',
        period: isFr ? 'Avril 2025 (À venir)' : 'April 2025 (Upcoming)',
        description: isFr
            ? 'Participation à des missions d\'audit, tests d\'intrusion et sécurisation d\'architectures critiques.'
            : 'Participation in audit missions, penetration testing and securing critical architectures.',
        avatar: 'assets/images/th.jpg', // Assure-toi d'avoir l'image (ou remets th.jpg)
        isUpcoming: true, // <--- Marqué comme futur
        softSkills: isFr 
            ? ['Pentest', 'Audit', 'Réseaux', 'Cryptographie'] 
            : ['Pentest', 'Audit', 'Networks', 'Cryptography'],
      ),
      
      // 2. TOTAL (Actuel)
      ExperienceItem(
        company: 'Total',
        role: isFr ? 'Borniste' : 'Charging assistant',
        period: isFr ? 'Juil 2024 - Présent' : 'Jul 2024 – Present',
        description: isFr
            ? 'Accompagnement des clients, optimisation du chargement et maintenance.'
            : 'Customer assistance, charging optimization and maintenance.',
        avatar: 'assets/images/total.png',
        isCurrent: true,
        softSkills: isFr 
            ? ['Relation Client', 'Autonomie', 'Gestion du stress']
            : ['Customer Service', 'Autonomy', 'Stress Management'],
      ),

      // 3. LES AUTRES EXPÉRIENCES...
      ExperienceItem(
        company: 'INSTITUT FÉNELON',
        role: isFr ? 'Surveillant Cantine' : 'Cafeteria supervisor',
        period: 'Juin 2024',
        description: isFr
            ? 'Surveillance, sécurité et animation des enfants.'
            : 'Supervision, safety and entertainment for children.',
        avatar: 'assets/images/fe.jpeg',
        softSkills: isFr ? ['Pédagogie', 'Vigilance'] : ['Pedagogy', 'Vigilance'],
      ),
      ExperienceItem(
        company: 'Clinique SMR',
        role: isFr ? 'Magasinier' : 'Storekeeper',
        period: 'Juin 2024',
        description: isFr
            ? 'Gestion des stocks, contrôle qualité et hygiène.'
            : 'Stock management, quality control and hygiene.',
        avatar: 'assets/images/cli.jpeg',
        softSkills: isFr ? ['Organisation', 'Rigueur'] : ['Organization', 'Rigor'],
      ),
      ExperienceItem(
        company: 'TRANSCAN',
        role: isFr ? 'Rider vélo' : 'Bike courier',
        period: 'Mar 2024 - Juin 2024',
        description: isFr
            ? 'Livraison Amazon, logistique et relation client.'
            : 'Amazon delivery, logistics and customer relations.',
        avatar: 'assets/images/tr.jpeg',
        softSkills: isFr ? ['Ponctualité', 'Endurance'] : ['Punctuality', 'Endurance'],
      ),
      ExperienceItem(
        company: 'Pavillon Traiteur',
        role: isFr ? 'Plongeur' : 'Kitchen porter',
        period: 'Mar 2024',
        description: isFr ? 'Logistique et hygiène.' : 'Logistics and hygiene.',
        avatar: 'assets/images/pav.webp',
        softSkills: ['Travail d\'équipe', 'Rapidité'],
      ),
      ExperienceItem(
        company: 'LE SIS',
        role: isFr ? 'Opérateur après sinistre' : 'Post-disaster operator',
        period: 'Mar 2024',
        description: isFr ? 'Nettoyage technique et décontamination.' : 'Technical cleaning and decontamination.',
        avatar: 'assets/images/sis.jpg',
        softSkills: ['Adaptabilité', 'Résilience'],
      ),
      ExperienceItem(
        company: 'Alive Group',
        role: isFr ? 'Manutentionnaire' : 'Warehouse operative',
        period: 'Mar 2024',
        description: isFr ? 'Chargement et logistique événementielle.' : 'Loading and event logistics.',
        avatar: 'assets/images/alive.jpeg',
        softSkills: ['Coordination', 'Sécurité'],
      ),
      ExperienceItem(
        company: 'Thales',
        role: isFr ? 'Stagiaire' : 'Intern',
        period: 'Dec 2019',
        description: isFr
            ? 'Découverte de la cybersécurité et des systèmes critiques.'
            : 'Discovery of cybersecurity and critical systems.',
        avatar: 'assets/images/th.jpg',
        softSkills: ['Curiosité', 'Observation'],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 1. Récupérer les données
    final experiences = _getExperiences(isFr);

    return MacOSProjectWindow(
      title: tr('Expérience', 'Experience'),
      content: [
        // Titre introduction
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Text(
            tr("Mon parcours professionnel", "My professional journey"),
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
          ),
        ),

        // 2. Générer la liste (Frise)
        ListView.builder(
          shrinkWrap: true, // Important car on est déjà dans une liste/scrollview
          physics: const NeverScrollableScrollPhysics(), // On laisse la fenêtre gérer le scroll
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            return _buildTimelineItem(
              context, 
              experiences[index], 
              index == experiences.length - 1 // Vérifie si c'est le dernier pour couper la ligne
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, ExperienceItem item, bool isLast) {
    // Définition de la couleur d'accentuation (Vert = Actuel, Bleu = Futur, Gris = Passé)
    final Color accentColor = item.isUpcoming 
        ? const Color(0xFF007AFF) // Bleu macOS
        : (item.isCurrent ? const Color(0xFF28C840) : Colors.white24);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Colonne de gauche (Ligne + Avatar)
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: accentColor, 
                      width: (item.isCurrent || item.isUpcoming) ? 2 : 1
                    ),
                    image: DecorationImage(image: AssetImage(item.avatar), fit: BoxFit.cover),
                    boxShadow: (item.isCurrent || item.isUpcoming)
                      ? [BoxShadow(color: accentColor.withOpacity(0.4), blurRadius: 10)] 
                      : null,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 16),

          // 2. Carte de contenu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête : Titre + Badge "Actuel" ou "À venir"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.role,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (item.isCurrent || item.isUpcoming)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item.isUpcoming 
                                  ? (isFr ? "À venir" : "Upcoming") 
                                  : (isFr ? "Actuel" : "Current"),
                              style: TextStyle(color: accentColor, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.company.toUpperCase(),
                      style: TextStyle(color: Colors.blueAccent.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: item.isUpcoming ? accentColor : Colors.white38),
                        const SizedBox(width: 6),
                        Text(
                          item.period,
                          style: TextStyle(
                            color: item.isUpcoming ? accentColor : Colors.white38, 
                            fontSize: 12, 
                            fontFamily: '.SF UI Text'
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    
                    Text(
                      item.description,
                      style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                    ),

                    // --- AJOUT : SECTION SOFT SKILLS ---
                    if (item.softSkills.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: item.softSkills.map((skill) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08), // Fond très léger
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: Text(
                            skill, 
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10),
                          ),
                        )).toList(),
                      ),
                    ],
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

class ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String description;
  final String avatar;
  final bool isCurrent;  // Poste actuel (Vert)
  final bool isUpcoming; // Futur stage (Bleu)
  final List<String> softSkills; // <--- NOUVEAU

  ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.avatar,
    this.isCurrent = false,
    this.isUpcoming = false, // <--- NOUVEAU
    required this.softSkills, // <--- NOUVEAU
  });
}