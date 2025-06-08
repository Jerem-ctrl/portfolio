// all_projects_data.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';

List<Widget> getAllProjects() {
  return [
    // === INITIATIVE PROGRAMMATION ===
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
    SizedBox(height: 24),
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
      githubUrl: 'https://github.com/Jerem-ctrl/Secure_Embedded_Web_Interface_for_Thales',
    ),
    StandardProjectCard(
      title: 'Système de traçabilité Photo embarqué pour Banc Avionique',
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

    // === INITIATIVE RÉSEAUX ===
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
      title: 'Exploration des réseaux domestiques & impacts énergétiques',
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
  ];
}

