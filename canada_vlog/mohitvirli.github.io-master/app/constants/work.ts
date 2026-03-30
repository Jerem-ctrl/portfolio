import * as THREE from "three";
import { WorkTimelinePoint } from "../types";

export const WORK_TIMELINE: WorkTimelinePoint[] = [
  {
    point: new THREE.Vector3(0, 0, 0),
    year: '2024',
    title: 'BUT R&T Campus Sophia',
    subtitle: 'Réseaux & Télécoms',
    position: 'right',
  },
  {
    point: new THREE.Vector3(-4, -4, -3),
    year: 'Avril 2026',
    title: 'Thales Alenia Space',
    subtitle: 'Stage Cybersécurité',
    position: 'left',
  },
  {
    point: new THREE.Vector3(-3, -1, -6),
    year: 'Sept 2026',
    title: 'UQAC (Canada) 🇨🇦',
    subtitle: 'Double Diplôme Cyber',
    position: 'left',
  },
  {
    point: new THREE.Vector3(0, -1, -10),
    year: '2028',
    title: 'Master Suisse 🇨🇭',
    subtitle: 'EPFL ou HES-SO',
    position: 'left',
  },
  {
    point: new THREE.Vector3(1, 1, -12),
    year: '2030',
    title: 'PhD Royaume-Uni 🇬🇧',
    subtitle: 'Recherche AI Safety',
    position: 'right',
  }
]