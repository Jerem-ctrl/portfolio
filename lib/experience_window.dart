// Nouveau fichier : experience_window.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
import 'package:portofolio/project_windows.dart' show MacOSProjectWindow;


class ExperienceWindow extends StatelessWidget {
  const ExperienceWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return MacOSProjectWindow(
      title: 'Expérience',
      content: [
        _experienceCard(
          context,
          avatar: 'assets/images/total.png',
          company: 'Total',
          role: 'Borniste',
          period: 'Jul 2024 - Présent | Mougins',
          description: 'Accompagnement des clients dans la recharge de leur véhicule électrique, sensibilisation à l’optimisation du chargement, distribution de supports d’abonnement, et vérification du bon fonctionnement des équipements.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/fe.jpeg',
          company: 'INSTITUT FÉNELON',
          role: 'Surveillant Cantine',
          period: 'Jun 2024 - Jun 2024 | Grasse',
          description: 'Surveillance et animation des enfants durant la pause déjeuner afin d\'assurer leur sécurité et favoriser des interactions ludiques et éducatives.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/cli.jpeg',
          company: 'CliniqueSMR',
          role: 'Magasinier',
          period: 'Jun 2024 - Jun 2024 | Pégomas',
          description: 'Gestion des stocks (épicerie, frais, surgelé), mise en rayon, contrôle des dates de péremption et décontamination des produits avant leur envoi en cuisine.',
        ),
         _experienceCard(
          context,
          avatar: 'assets/images/tr.jpeg',
          company: 'TRANSCAN',
          role: 'Rider vélo',
          period: 'Mar 2024 - Jun 2024 | Cannes',
          description: 'Livraison de colis Amazon à vélo via l\'application Amazon Flex, avec gestion des retours, interaction client et optimisation des itinéraires adaptés au gabarit du vélo.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/pav.webp',
          company: 'Pavillon Traiteur',
          role: 'Plongeur (restauration)',
          period: 'Mar 2024 - Mar 2024 | Mouans-Sartoux',
          description: 'Participation à la logistique de chargement des camions et au nettoyage de la vaisselle et des ustensiles.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/sis.jpg',
          company: 'LE SIS',
          role: 'Opérateur après sinistre',
          period: 'Mar 2024 - Mar 2024 | Grasse',
          description: 'Participation au nettoyage après sinistres : décontamination des surfaces, assèchement des zones endommagées, et tri des déchets irrécupérables.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/atq.png',
          company: 'ANTOINE QUINTANE',
          role: 'Ouvrier du bâtiment',
          period: 'Mar 2024 - Mar 2024 | Mougins',
          description: 'Assistance sur chantier avec pose de fenêtres, port d’équipements de protection et participation aux tâches de terrain.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/alive.jpeg',
          company: 'Alive Group',
          role: 'Manutentionnaire de nuit',
          period: 'Mar 2024 - Mar 2024 | Cannes, Palais des festivals ',
          description: 'Chargement du mobilier dans les camions à quai et gestion des opérations d’installation et de désinstallation.',
        ),
        _experienceCard(
          context,
          avatar: 'assets/images/th.jpg',
          company: 'Thales',
          role: 'Stagiaire',
          period: 'Dec 2019 - Dec 2019 | Valbonne',
          description: 'Stage chez Thales Underwater Systems, où j’ai découvert le domaine sensible de la cybersécurité et confirmé mon intérêt pour l’informatique.',
        ),
      ],
    );
  }

  Widget _experienceCard(BuildContext context, {
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
        title: Text(company, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
