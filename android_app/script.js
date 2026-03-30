gsap.registerPlugin(ScrollTrigger);

// Animation d'entrée du Hero
gsap.from(".animate-text", {
    y: 50,
    opacity: 0,
    duration: 1.5,
    stagger: 0.2,
    ease: "power3.out",
    delay: 0.5
});

// Animation de la vidéo au scroll (léger zoom arrière)
gsap.to(".video-container", {
    scale: 0.95,
    borderRadius: "50px",
    scrollTrigger: {
        trigger: ".hero-section",
        start: "bottom bottom",
        end: "bottom top",
        scrub: true
    }
});

// Apparition des cartes Bento
gsap.utils.toArray('.bento-card').forEach(card => {
    gsap.from(card, {
        y: 100,
        opacity: 0,
        duration: 1,
        ease: "power2.out",
        scrollTrigger: {
            trigger: card,
            start: "top 85%"
        }
    });
});