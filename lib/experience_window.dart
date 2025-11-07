// experience_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;
import 'package:portofolio/main.dart' show Lang; // pour réutiliser l'enum

class ExperienceWindow extends StatelessWidget {
  final Lang lang;
  const ExperienceWindow({super.key, required this.lang});

  bool get isFr => lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  @override
  Widget build(BuildContext context) {
    return MacOSProjectWindow(
      title: tr('Expérience', 'Experience'),
      content: [
        _experienceCard(
          context,
          avatar: 'assets/images/total.png',
          company: 'Total',
          role: tr('Borniste', 'Charging assistant'),
          period: tr('Juil 2024 - Présent | Mougins', 'Jul 2024 – Present | Mougins'),
          description: tr(
            'Accompagnement des clients dans la recharge de leur véhicule électrique, sensibilisation à l’optimisation du chargement, distribution de supports d’abonnement, et vérification du bon fonctionnement des équipements.',
            'Assist customers during EV charging, promote best charging practices, hand out subscription materials, and verify proper operation of the equipment.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/fe.jpeg',
          company: 'INSTITUT FÉNELON',
          role: tr('Surveillant Cantine', 'Cafeteria supervisor'),
          period: tr('Juin 2024 - Juin 2024 | Grasse', 'Jun 2024 – Jun 2024 | Grasse'),
          description: tr(
            'Surveillance et animation des enfants durant la pause déjeuner afin d\'assurer leur sécurité et favoriser des interactions ludiques et éducatives.',
            'Supervised and engaged children during lunch to ensure safety and encourage fun, educational interactions.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/cli.jpeg',
          company: 'Clinique SMR',
          role: tr('Magasinier', 'Storekeeper'),
          period: tr('Juin 2024 - Juin 2024 | Pégomas', 'Jun 2024 – Jun 2024 | Pégomas'),
          description: tr(
            'Gestion des stocks (épicerie, frais, surgelé), mise en rayon, contrôle des dates de péremption et décontamination des produits avant leur envoi en cuisine.',
            'Managed stock (dry, fresh, frozen), shelving, expiry-date checks, and product decontamination before sending to the kitchen.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/tr.jpeg',
          company: 'TRANSCAN',
          role: tr('Rider vélo', 'Bike courier'),
          period: tr('Mar 2024 - Juin 2024 | Cannes', 'Mar 2024 – Jun 2024 | Cannes'),
          description: tr(
            'Livraison de colis Amazon à vélo via l\'application Amazon Flex, avec gestion des retours, interaction client et optimisation des itinéraires adaptés au gabarit du vélo.',
            'Delivered Amazon parcels by bike using Amazon Flex, handled returns, customer interactions, and route optimization for bike constraints.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/pav.webp',
          company: 'Pavillon Traiteur',
          role: tr('Plongeur (restauration)', 'Kitchen porter (catering)'),
          period: tr('Mar 2024 - Mar 2024 | Mouans-Sartoux', 'Mar 2024 – Mar 2024 | Mouans-Sartoux'),
          description: tr(
            'Participation à la logistique de chargement des camions et au nettoyage de la vaisselle et des ustensiles.',
            'Helped load trucks and handled dishwashing/utensil cleaning.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/sis.jpg',
          company: 'LE SIS',
          role: tr('Opérateur après sinistre', 'Post-disaster operator'),
          period: tr('Mar 2024 - Mar 2024 | Grasse', 'Mar 2024 – Mar 2024 | Grasse'),
          description: tr(
            'Participation au nettoyage après sinistres : décontamination des surfaces, assèchement des zones endommagées, et tri des déchets irrécupérables.',
            'Assisted with post-disaster cleaning: surface decontamination, drying damaged areas, and sorting unrecoverable waste.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/atq.png',
          company: 'ANTOINE QUINTANE',
          role: tr('Ouvrier du bâtiment', 'Construction worker'),
          period: tr('Mar 2024 - Mar 2024 | Mougins', 'Mar 2024 – Mar 2024 | Mougins'),
          description: tr(
            'Assistance sur chantier avec pose de fenêtres, port d’équipements de protection et participation aux tâches de terrain.',
            'On-site assistance: window installation, use of PPE, and various field tasks.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/alive.jpeg',
          company: 'Alive Group',
          role: tr('Manutentionnaire de nuit', 'Night warehouse operative'),
          period: tr('Mar 2024 - Mar 2024 | Cannes, Palais des festivals', 'Mar 2024 – Mar 2024 | Cannes, Palais des Festivals'),
          description: tr(
            'Chargement du mobilier dans les camions à quai et gestion des opérations d’installation et de désinstallation.',
            'Loaded furniture onto trucks at the dock and handled install/uninstall operations.',
          ),
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/th.jpg',
          company: 'Thales',
          role: tr('Stagiaire', 'Intern'),
          period: tr('Dec 2019 - Dec 2019 | Valbonne', 'Dec 2019 – Dec 2019 | Valbonne'),
          description: tr(
            'Stage chez Thales Underwater Systems, où j’ai découvert le domaine sensible de la cybersécurité et confirmé mon intérêt pour l’informatique.',
            'Internship at Thales Underwater Systems; discovered sensitive cybersecurity topics and confirmed my interest in computing.',
          ),
        ),
      ],
    );
  }

  Widget _experienceCard(
    BuildContext context, {
    required String avatar,
    required String company,
    required String role,
    required String period,
    required String description,
  }) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(avatar), radius: 24),
        title: Text(
          company,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(role, style: const TextStyle(color: Colors.white70)),
            Text(period, style: const TextStyle(color: Colors.white38, fontSize: 12)),
            const SizedBox(height: 6),
            Text(description, style: const TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}