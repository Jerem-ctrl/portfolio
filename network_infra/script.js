gsap.registerPlugin(ScrollTrigger);

// 1. ANIMATION LETTRE PAR LETTRE
function animateTextLetterByLetter() {
    const texts = document.querySelectorAll(".animate-text");
    
    texts.forEach(paragraph => {
        const content = paragraph.textContent;
        paragraph.innerHTML = content.split("").map(char => {
            if (char === " ") return "&nbsp;";
            return `<span class="char">${char}</span>`;
        }).join("");
    });

    gsap.to(".char", {
        opacity: 1,
        y: 0,
        duration: 0.05,
        stagger: 0.02,
        ease: "power2.out",
        delay: 0.5 
    });
}

// 2. CACHER L'INDICATEUR DE SCROLL
function hideScrollIndicator() {
    gsap.to(".scroll-indicator", {
        opacity: 0,
        scrollTrigger: {
            trigger: "body",
            start: "top top",
            end: "100px top",
            scrub: true
        }
    });
}

// 3. ZOOM IMAGE
function addImageScaleAnimation() {
  gsap.utils.toArray("section").forEach((section, index) => {
    const image = document.querySelector(`#preview-${index + 1} img`);
    if (!image) return;

    const startCondition = index === 0 ? "top top" : "bottom bottom";

    gsap.to(image, {
      scrollTrigger: {
        trigger: section,
        start: startCondition,
        end: () => {
          const viewportHeight = window.innerHeight;
          const sectionBottom = section.offsetTop + section.offsetHeight;
          const additionalDistance = viewportHeight * 0.5;
          const endValue = sectionBottom - viewportHeight + additionalDistance;
          return `+=${endValue}`;
        },
        scrub: 1,
      },
      scale: 3, 
      ease: "none",
    });
  });
}

function animateClipPath(sectionId, previewId, startClipPath, endClipPath, start = "top center", end = "bottom top") {
  let section = document.querySelector(sectionId);
  let preview = document.querySelector(previewId);

  if(!section || !preview) return;

  ScrollTrigger.create({
    trigger: section,
    start: start,
    end: end,
    onEnter: () => {
      gsap.to(preview, {
        scrollTrigger: {
          trigger: section,
          start: start,
          end: end,
          scrub: 0.125,
        },
        clipPath: endClipPath,
        ease: "none",
      });
    },
  });
}

// Lancement
animateTextLetterByLetter();
hideScrollIndicator();
addImageScaleAnimation();

// Configuration des transitions
animateClipPath(
  "#section-1", "#preview-1",
  "polygon(0% 100%, 100% 100%, 100% 100%, 0% 100%)",
  "polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)"
);

const totalSections = 5;

for (let i = 2; i <= totalSections; i++) {
  let currentSection = `#section-${i}`;
  let prevPreview = `#preview-${i - 1}`;
  let currentPreview = `#preview-${i}`;

  // Masquer l'image précédente
  animateClipPath(
    currentSection, prevPreview,
    "polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)",
    "polygon(0% 0%, 100% 0%, 100% 0%, 0% 0%)",
    "top center", "bottom center"
  );

  // Révéler la nouvelle image
  animateClipPath(
    currentSection, currentPreview,
    "polygon(0% 100%, 100% 100%, 100% 100%, 0% 100%)",
    "polygon(0% 0%, 100% 0%, 100% 100%, 0% 100%)",
    "top center", "bottom center"
  );
}