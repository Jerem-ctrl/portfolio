import { Project } from "../types";

// TODO: Move this to API
export const PROJECTS: Project[] = [
  {
    title: 'Préparation UQAC',
    date: 'Août 2026',
    subtext: 'Billet d\'avion en poche, valises prêtes. Le grand départ pour le Canada approche à grands pas pour le double diplôme !',
    url: '/vlog/preparation',
  },
  {
    title: 'Arrivée à Chicoutimi',
    date: 'Sept 2026',
    subtext: 'Découverte du campus de l\'UQAC, premiers contacts avec le froid canadien et l\'accent québécois. Le début d\'une aventure épique.',
    url: '/vlog/arrivee',
  },
  {
    title: 'Immersion Cyberdéfense',
    date: 'Oct 2026',
    subtext: 'Les cours de spécialisation en cyber commencent. Infrastructures réseau, sécurité IA... le niveau est intense.',
    url: '/vlog/cours',
  },
  {
    title: 'Roadtrip au Nord',
    date: 'Dec 2026',
    subtext: 'Pause dans les études pour aller voir les Fjord du Saguenay sous la neige. Des paysages à couper le souffle.',
    url: '/vlog/roadtrip',
  }
];
