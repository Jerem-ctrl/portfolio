const video = document.getElementById('source-video');
const canvas = document.getElementById('main-canvas');
const ctx = canvas.getContext('2d', { willReadFrequently: true });
const startBtn = document.getElementById('init-btn');
const splashScreen = document.getElementById('splash-screen');
const statusText = document.getElementById('status-text');

// Optimisation : Canvas temporaire créé une seule fois (pas à chaque frame)
const tempCanvas = document.createElement('canvas');
const tempCtx = tempCanvas.getContext('2d');

// Jeu de caractères ASCII (Ajusté pour être visible même si sombre)
// J'ai enlevé les espaces à la fin pour qu'il y ait toujours un petit point visible
const density = "Ñ@#W$9876543210?!abc;:+=-,._."; 
const spacing = 10; // Espacement des lettres (plus gros = plus fluide)

let audioContext, analyser, frequencyData;
let isRunning = false;

// --- INITIALISATION ---
startBtn.addEventListener('click', async () => {
    try {
        statusText.innerText = "CONNEXION AUX PÉRIPHÉRIQUES...";
        
        // 1. Démarrage Caméra
        const stream = await navigator.mediaDevices.getUserMedia({ 
            video: { width: 640, height: 480 }, // Résolution standard pour fluidité ASCII
            audio: true 
        });
        
        video.srcObject = stream;
        
        // CORRECTION ÉCRAN NOIR : On force la lecture
        await video.play(); 

        // 2. Démarrage Audio
        setupAudio(stream);

        // 3. Transition UI
        splashScreen.style.opacity = '0';
        splashScreen.style.transition = 'opacity 0.8s ease';
        
        setTimeout(() => { 
            splashScreen.style.display = 'none';
            statusText.innerText = "FLUX ACTIF // AUDIO-RÉACTIF";
            isRunning = true;
            render(); // Lancement de la boucle
        }, 800);

    } catch (err) {
        console.error("Erreur:", err);
        statusText.innerText = "ERREUR D'ACCÈS (Vérifiez les permissions)";
        alert("Impossible d'accéder à la caméra. Vérifiez qu'elle n'est pas utilisée ailleurs.");
    }
});

// --- CONFIGURATION AUDIO ---
function setupAudio(stream) {
    // Création du contexte audio
    const AudioContext = window.AudioContext || window.webkitAudioContext;
    audioContext = new AudioContext();
    
    const source = audioContext.createMediaStreamSource(stream);
    analyser = audioContext.createAnalyser();
    
    analyser.fftSize = 256; // Analyse rapide
    analyser.smoothingTimeConstant = 0.5; // Très réactif

    source.connect(analyser);
    frequencyData = new Uint8Array(analyser.frequencyBinCount);
}

// --- BOUCLE DE RENDU ---
function render() {
    if (!isRunning) return;

    // Si la vidéo n'est pas prête, on attend la prochaine frame
    if (video.readyState !== video.HAVE_ENOUGH_DATA) {
        requestAnimationFrame(render);
        return;
    }

    // 1. Analyse Audio (Basses et Médiums)
    analyser.getByteFrequencyData(frequencyData);
    let bass = 0;
    let mids = 0;
    
    // On moyenne les fréquences
    for (let i = 0; i < 10; i++) bass += frequencyData[i];
    for (let i = 10; i < 50; i++) mids += frequencyData[i];
    
    bass = bass / 10 / 255; // Valeur entre 0 et 1
    mids = mids / 40 / 255; // Valeur entre 0 et 1

    // Amplification des effets pour que ça se voie bien
    const beatForce = bass * 2; // Coup de basse
    const waveForce = mids * 10; // Vagues sur la voix

    // 2. Préparation Canvas
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    
    // Fond noir
    ctx.fillStyle = '#050505';
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    // Calcul de la grille
    const cols = Math.floor(canvas.width / spacing);
    const rows = Math.floor(canvas.height / spacing);

    // Redimensionnement du canvas temporaire
    tempCanvas.width = cols;
    tempCanvas.height = rows;

    // Dessin de la vidéo en petit (pour lire les pixels)
    // Miroir horizontal pour effet naturel
    tempCtx.translate(cols, 0);
    tempCtx.scale(-1, 1);
    tempCtx.drawImage(video, 0, 0, cols, rows);
    tempCtx.setTransform(1, 0, 0, 1, 0, 0); // Reset transform

    // Récupération des pixels
    const imageData = tempCtx.getImageData(0, 0, cols, rows);
    const pixels = imageData.data;

    // Configuration Police
    ctx.font = `${spacing}px 'Space Mono', monospace`;
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";

    // 3. Dessin des caractères ASCII
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            const index = (i * cols + j) * 4;
            const r = pixels[index];
            const g = pixels[index + 1];
            const b = pixels[index + 2];
            
            // Luminosité (Moyenne)
            const brightness = (r + g + b) / 3;
            
            // Si c'est tout noir, on passe (optimisation)
            if (brightness < 10) continue;

            // Mapping vers un caractère
            const charIndex = Math.floor(map(brightness, 0, 255, density.length - 1, 0));
            const char = density[charIndex];

            // EFFETS VISUELS
            
            // 1. Déformation (Vagues) basée sur les médiums (Voix/Musique)
            // On utilise le temps et la position pour créer une ondulation
            const noise = Math.sin(i * 0.2 + performance.now() * 0.005);
            const waveX = noise * waveForce * 5; 
            
            // 2. Couleur
            // Blanc pur sur les beats (basses), sinon gris/bleuté tech
            const hue = 200; // Bleu cyan tech
            const sat = 20 + (beatForce * 80); // Saturation monte avec la basse
            const light = 30 + (brightness / 255 * 50) + (beatForce * 50); // Lumière
            
            ctx.fillStyle = `hsl(${hue}, ${sat}%, ${light}%)`;

            // Position finale
            const x = j * spacing + (spacing / 2) + waveX;
            const y = i * spacing + (spacing / 2);

            ctx.fillText(char, x, y);
        }
    }

    requestAnimationFrame(render);
}

// Fonction utilitaire
function map(value, start1, stop1, start2, stop2) {
    return start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
}

// Gestion redimensionnement
window.addEventListener('resize', () => {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
});