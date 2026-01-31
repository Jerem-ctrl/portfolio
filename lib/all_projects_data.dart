// all_projects_data.dart
import 'package:flutter/material.dart';
import 'package:portofolio/project_windows.dart';
import 'package:portofolio/main.dart' show Lang;

List<Widget> getAllProjects(Lang lang) {
  bool isFr = lang == Lang.fr;
  String tr(String fr, String en) => isFr ? fr : en;

  return [
    // === INITIATIVE PROGRAMMATION ===

    FeaturedProjectCard(
      title: tr("🛡️ Audit & Pentest Infrastructure Docker", 
                "🛡️ Docker Infrastructure Audit & Pentest"),
      category: tr("Cybersécurité & Sécurité Offensive", 
                   "Cybersecurity & Offensive Security"),
      shortDescription: tr(
        "Test d'intrusion (Pentest) en boîte noire : exploitation de failles critiques (RCE), pivot réseau et exfiltration de données.",
        "Black-box penetration test: exploitation of critical vulnerabilities (RCE), network pivoting, and data exfiltration.",
      ),
      fullDescription: tr(
        "Dans le cadre d'une mission de sécurité offensive, j'ai réalisé un audit complet d'une infrastructure conteneurisée (Docker). L'objectif était d'éprouver la résistance du système face à une attaque externe sans information préalable (Boîte Noire).\n\n"
        "Le scénario d'attaque s'est déroulé en plusieurs phases techniques :\n"
        "• Reconnaissance : Identification des services via Nmap, révélant un serveur de fichiers vulnérable.\n"
        "• Exploitation : Utilisation de la vulnérabilité 'SambaCry' (CVE-2017-7494) via Metasploit pour obtenir un accès Root à distance.\n"
        "• Mouvement Latéral (Pivot) : Mise en place d'un tunnel SSH pour contourner la segmentation réseau et atteindre la zone interne protégée.\n"
        "• Compromission Finale : Attaque de l'application web interne et exfiltration de la base de données clients.\n\n"
        "Ce projet a abouti à la rédaction d'un rapport d'audit professionnel incluant l'analyse des risques et des recommandations de durcissement (Hardening).",
        
        "As part of an offensive security mission, I conducted a comprehensive audit of a containerized infrastructure (Docker). The goal was to test system resilience against an external attack with zero prior knowledge (Black Box).\n\n"
        "The attack scenario involved several technical phases:\n"
        "• Reconnaissance: Service identification via Nmap, revealing a vulnerable file server.\n"
        "• Exploitation: Leveraging the 'SambaCry' vulnerability (CVE-2017-7494) via Metasploit to gain remote Root access.\n"
        "• Lateral Movement (Pivoting): Establishing an SSH tunnel to bypass network segmentation and reach the protected internal zone.\n"
        "• Final Compromise: Attacking the internal web application and exfiltrating the client database.\n\n"
        "This project concluded with a professional audit report including risk analysis and hardening recommendations."
      ),
      image: "assets/images/pentest_docker_cover.webp", // Mets l'image du schéma d'architecture ici
      gallery: [
        "assets/images/Sae34Presentation.png",
        "assets/images/Sae34Sommaire.png",
        "assets/images/Sae34Perimetre01.png",
        "assets/images/Sae34Perimetre02.png",
        "assets/images/Sae34CompromissionInitial01.png",
        "assets/images/Sae34CompromissionInitial02.png",
        "assets/images/Sae34Pivotage01.png",
        "assets/images/Sae34Pivotage02.png",
        "assets/images/Sae34CompromissionAppWeb01.png",
        "assets/images/Sae34CompromissionAppWeb02.png",
        "assets/images/Sae34CompromissionAppWeb03.png",
        "assets/images/Sae34CompromissionAppWeb04.png",
        "assets/images/Sae34Recommandation01.png",
        "assets/images/Sae34Recommandation02.png",
        "assets/images/Sae34Conclusion.png",
      ],
      competencies: [
        tr("Test d'intrusion & Audit (Black Box)", 
           "Penetration Testing & Auditing (Black Box)"),
        tr("Exploitation de vulnérabilités (SambaCry, RCE)", 
           "Vulnerability Exploitation (SambaCry, RCE)"),
        tr("Mouvement latéral & Pivot réseau (SSH Tunneling)", 
           "Lateral Movement & Network Pivoting (SSH Tunneling)"),
        tr("Rédaction de rapports d'audit & Recommandations", 
           "Audit Reporting & Remediation Recommendations"),
        tr("Outils : Metasploit, Nmap, Wireshark, Docker", 
           "Tools: Metasploit, Nmap, Wireshark, Docker"),
      ],
      // J'ai mis un lien générique, pense à créer le repo sur ton GitHub si tu veux partager le rapport
      githubUrl: "https://jerem-ctrl.github.io/portfolio/pentest_docker/index.html",
    ),
    const SizedBox(height: 24),

    StandardProjectCard(
      title: "HighDef",
      category: tr("Traitement du signal", "Signal processing"),
      shortDescription: tr("Mesure rapide d’un signal audio.",
                          "Fast measurement of an audio signal."),
      fullDescription: tr(
        "Le projet HighDef est une étude en trois phases portant sur la comparaison entre la qualité audio Haute Définition (HD) et Simple Définition (SD). Il vise à déterminer si l’amélioration de la qualité perçue est significative, justifiant l’usage de formats audio HD.",
        "HighDef is a three-phase study comparing High Definition (HD) and Standard Definition (SD) audio quality to assess whether the perceived improvement is significant enough to justify HD formats.",
      ),
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
        tr("Extraction et analyse de caractéristiques audio (RMS, spectre, dynamique)",
           "Feature extraction & analysis (RMS, spectrum, dynamics)"),
        tr("Utilisation de bibliothèques Python (NumPy, SciPy, Matplotlib)",
           "Python libs (NumPy, SciPy, Matplotlib)"),
        tr("Visualisation de signaux dans le domaine temporel et fréquentiel",
           "Time/frequency-domain visualization"),
        tr("Interprétation de résultats expérimentaux et rédaction scientifique",
           "Experimental result analysis & technical writing"),
      ],
      githubUrl: "https://github.com/Jerem-ctrl/HighDef",
    ),
    const SizedBox(height: 24),

    StandardProjectCard(
      title: tr('Interface Web embarquée pour Thales',
                'Embedded Web Interface for Thales'),
      category: tr('Projet Web & Système embarqué',
                   'Web Project & Embedded System'),
      shortDescription: tr(
        "Conception d'une interface web sécurisée pour banc avionique dans le cadre d’un projet Thales.",
        "Design of a secure web interface for an avionics test bench as part of a Thales project.",
      ),
      fullDescription: tr(
        "Ce projet a consisté à développer une interface web intuitive permettant de prendre, visualiser et gérer des photos dans le cadre de la SAE 23. L’objectif principal était de concevoir une plateforme accessible à distance, avec authentification sécurisée et journalisation des actions utilisateur, le tout dans un environnement embarqué.",
        "Built an intuitive web interface to take, view, and manage photos (SAE 23). Focus on remote access, secure authentication, and user action logging in an embedded environment.",
      ),
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
        tr('Développement front-end en HTML, CSS et JavaScript pour une interface responsive',
           'Responsive front-end in HTML, CSS, JavaScript'),
        tr('Intégration d’un serveur web léger avec routage et gestion des sessions',
           'Lightweight web server with routing & sessions'),
        tr('Implémentation de fonctionnalités de sécurité (authentification, logging)',
           'Security features (auth, logging)'),
        tr('Gestion des formulaires et traitement des données utilisateur côté serveur',
           'Form handling and server-side processing'),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Secure_Embedded_Web_Interface_for_Thales',
    ),

    StandardProjectCard(
      title: tr('Système de traçabilité Photo embarqué pour Banc Avionique',
                'Embedded Photo-Logging System for Avionics'),
      category: tr('Systèmes embarqués & Programmation Python',
                   'Embedded Systems & Python'),
      shortDescription: tr(
        "Développement d’un système embarqué permettant la capture et la gestion sécurisée de photos sur un banc de test avionique, avec interface web, authentification et traçabilité des actions.",
        "Embedded system to capture and securely manage photos on an avionics bench with web UI, authentication, and action logging.",
      ),
      fullDescription: tr(
        "Dans le cadre de la SAE 24, ce projet visait à développer un système de capture photo embarqué sur Raspberry Pi, destiné à documenter les modifications sur un banc de test avionique. En combinant Python, un microcontrôleur Pico WH, une caméra USB, et des composants GPIO (LED, boutons, etc.), le système permet la prise de photos automatique ou manuelle avec gestion de l’éclairage. L'ensemble s’intègre à une interface web sécurisée développée lors de la SAE 23, pour assurer la traçabilité et l’accessibilité des images à distance.",
        "As part of SAE 24, built a Raspberry Pi-based photo capture system to document changes on a test bench. Python + Pico WH + USB camera + GPIO (LEDs, buttons). Automatic/manual shots with light control and a secure web interface (from SAE 23) for remote traceability.",
      ),
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
        tr('Programmation Python embarquée','Embedded Python programming'),
        tr('Utilisation de Raspberry Pi et microcontrôleur','Raspberry Pi & microcontroller use'),
        tr('Communication série (UART)','Serial communication (UART)'),
        tr('Intégration de périphériques (caméra, GPIO)','Peripheral integration (camera, GPIO)'),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Embedded_Photo-Logging_System_for_Avionics',
    ),

    // === INITIATIVE RÉSEAUX ===
    FeaturedProjectCard(
      title: tr("Infrastructure réseau sécurisée pour PME",
                "Secure Network Infrastructure for SMB"),
      category: tr("Réseaux & Sécurité","Networking & Security"),
      shortDescription: tr(
        "Ce projet simule une architecture réseau complète pour PME avec VLANs, DNS/DHCP, DMZ, pare-feu ASA, routage et sécurité.",
        "Simulates a full SMB network architecture: VLANs, DNS/DHCP, DMZ, ASA firewall, routing, and security.",
      ),
      fullDescription: tr(
        "Dans le cadre de la SAÉ 21, nous avons conçu l’architecture réseau d’une PME à l’aide de Cisco Packet Tracer. Le projet comprend la configuration de VLANs, de serveurs DHCP/DNS, d’une DMZ avec pare-feu ASA, de routage statique, ainsi que la mise en place de la sécurité via des ACL et du NAT. L’objectif était d’assurer la segmentation, la sécurité et la connectivité complète du réseau d’entreprise.",
        "As part of SAE 21, designed an SMB network with Cisco Packet Tracer: VLANs, DHCP/DNS servers, DMZ with ASA firewall, static routing, ACLs and NAT for secure segmentation and full connectivity.",
      ),
      image: "assets/images/sae21ci1.jpg",
      gallery: [
        "assets/images/sae21ci2.png",
        "assets/images/sae21c3.png",
        "assets/images/sae21c4.png",
        "assets/images/sae21c5.png",
      ],
      competencies: [
        tr("Configuration de VLANs et routage inter-VLAN",
           "VLAN configuration & inter-VLAN routing"),
        tr("Mise en place d’un pare-feu ASA (DMZ, NAT, ACL)",
           "ASA firewall setup (DMZ, NAT, ACL)"),
        tr("Plan d’adressage et configuration DNS/DHCP",
           "Addressing plan + DNS/DHCP configuration"),
        tr("Simulation réseau complète sous Cisco Packet Tracer",
           "End-to-end network simulation in Packet Tracer"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Secure-Network-Infrastructure-for-Small-Businesses',
    ),

    StandardProjectCard(
      title: tr('Analyse de cyberattaques & bonnes pratiques',
                'Analysis of Cyberattacks & Best Practices'),
      category: tr('Cybersécurité & Sensibilisation',
                   'Cybersecurity & Awareness'),
      shortDescription: tr(
        'Étude de cyberattaques réelles et sensibilisation aux menaces numériques.',
        'Study of real-world cyberattacks and awareness of digital threats.',
      ),
      fullDescription: tr(
        'Dans le cadre de la SAÉ 11, nous avons analysé plusieurs cyberattaques connues afin d’en comprendre les mécanismes, les conséquences et les moyens de prévention. Ce travail s’est appuyé sur des recherches approfondies concernant les bonnes pratiques d’hygiène informatique. L’objectif principal était de développer une culture de la cybersécurité et de renforcer les réflexes face aux menaces numériques.',
        'As part of SAE 11, analyzed known cyberattacks to understand mechanisms, impact, and defenses. Emphasis on security hygiene and building a strong cybersecurity culture.',
      ),
      image: 'assets/images/sae11c3.jpg',
      gallery: [
        'assets/images/sae11c4.webp',
        'assets/images/sae11c5.png',
        'assets/images/sae11c6.png',
      ],
      competencies: [
        tr("Comprendre les principes de base de la cybersécurité",
           "Understand cybersecurity fundamentals"),
        tr("Analyser une cyberattaque et ses vecteurs",
           "Analyze attacks and vectors"),
        tr("Identifier les bonnes pratiques d’hygiène informatique",
           "Identify security hygiene best practices"),
        tr("Communiquer efficacement à travers un support pédagogique",
           "Communicate via clear educational material"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
    ),

    StandardProjectCard(
      title: tr('Exploration des réseaux domestiques & impacts énergétiques',
                'Home Networks Exploration & Energy Impact'),
      category: tr('Réseaux & Écoresponsabilité',
                   'Networking & Eco-responsibility'),
      shortDescription: tr(
        'Mise en pratique des connaissances réseaux via l’analyse d’un environnement domestique réel, combinée à une étude de la consommation énergétique des équipements.',
        'Hands-on networking through analysis of a real home environment, plus a study of device energy consumption.',
      ),
      fullDescription: tr(
        'Dans le cadre de la SAÉ 12, nous avons étudié le fonctionnement d’un réseau local domestique à travers l’analyse d’un équipement connecté (ordinateur, smartphone…). Cette démarche comprenait l’identification des composants réseau, l’observation du trafic (IP, DNS, ports) et la représentation schématique de l’infrastructure. En parallèle, une réflexion a été menée sur la consommation énergétique des équipements numériques et leur impact environnemental.',
        'As part of SAE 12, analyzed a home LAN via a connected device (PC, smartphone). Identified network components, observed traffic (IP, DNS, ports), and diagrammed the infrastructure. Also assessed energy consumption and environmental impact.',
      ),
      image: 'assets/images/sae12r3.jpeg',
      gallery: [
        'assets/images/sae12r4.png',
        'assets/images/sae12r5.png',
        'assets/images/sae12r6.png',
        'assets/images/sae12r7.png',
      ],
      competencies: [
        tr("Comprendre et analyser un réseau local (IP, MAC, DHCP, DNS…)",
           "Understand & analyze a LAN (IP, MAC, DHCP, DNS…)"),
        tr("Utiliser des outils de diagnostic réseau (Traceroute, Wireshark)",
           "Use network diagnostics (Traceroute, Wireshark)"),
        tr("Interpréter des données techniques (consommation, émissions CO₂)",
           "Interpret technical data (consumption, CO₂)"),
        tr("Schématiser et documenter une infrastructure réseau personnelle",
           "Diagram & document a personal network"),
      ],
      githubUrl: 'https://github.com/Jerem-ctrl/Analysis-of-Cyberattacks-and-Security-Best-Practices',
    ),
  ];
}
