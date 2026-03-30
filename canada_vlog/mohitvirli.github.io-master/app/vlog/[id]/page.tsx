import Image from "next/image";
import Link from "next/link";
import DisqusComments from "./DisqusComments";

export function generateStaticParams() {
  return [
    { id: 'preparation' },
    { id: 'arrivee' },
    { id: 'cours' },
    { id: 'roadtrip' }
  ];
}

const vlogs: Record<string, {title: string, date: string, content: string, img: string}> = {
  preparation: {
    title: "Préparation pour l'UQAC",
    date: "Août 2026",
    content: "Le grand départ approche. Billet d'avion sécurisé ! C'est le début d'une nouvelle vie académique au Canada. Les cours de cybersécurité s'annoncent passionnants, j'ai hâte de découvrir les infrastructures réseau de Chicoutimi.",
    img: "/preparation.png"
  },
  arrivee: {
    title: "Arrivée à Chicoutimi",
    date: "Sept 2026",
    content: "Atterrissage réussi. L'automne canadien est incroyable, les arbres sont déjà magnifiques. Le campus m'impressionne, l'UQAC dispose de laboratoires vraiment modernes pour tout ce qui touche à la sécurité informatique.",
    img: "/arrivee.png"
  },
  cours: {
    title: "Immersion Cybersécurité",
    date: "Oct 2026",
    content: "Mes premiers cours de double diplôme ! On attaque directement les vulnérabilités Active Directory et la défense des IA (AI Safety). C'est exactement l'objectif que je visais après mon BUT R&T à Sophia Antipolis.",
    img: "/cours.png"
  },
  roadtrip: {
    title: "Roadtrip au Nord",
    date: "Dec 2026",
    content: "Petite coupure dans les révisions. Direction le nord pour voir les aurores boréales et le fjord du Saguenay. Ce genre de paysage permet de revenir encore plus motivé pour décrocher ce double diplôme.",
    img: "/roadtrip.png"
  }
};

export default async function VlogPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const post = vlogs[id];

  if (!post) return <div>Vlog introuvable.</div>;

  return (
    <main className="min-h-[100dvh] bg-[#050510] text-white p-6 md:p-16 relative overflow-y-auto" style={{ zIndex: 9999 }}>
      <Link href="/" className="inline-block bg-white/10 px-6 py-2 rounded-full mb-8 hover:bg-white/20 transition-all font-sans text-sm tracking-widest font-bold">
        &larr; RETOUR
      </Link>
      
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl md:text-6xl font-black mb-4 tracking-tighter leading-tight" style={{ fontFamily: 'var(--font-soria)' }}>
          {post.title}
        </h1>
        <div className="opacity-60 mb-10 font-sans tracking-widest text-sm uppercase">
          {post.date} &nbsp;|&nbsp; Jérémy Girard
        </div>
        
        <div className="relative w-full aspect-video rounded-2xl md:rounded-[2rem] overflow-hidden mb-12 shadow-2xl border border-white/5 bg-black/50">
          <Image src={post.img} alt={post.title} fill className="object-cover" />
        </div>
        
        <article className="prose prose-invert lg:prose-xl mb-16 opacity-80 leading-relaxed font-sans text-lg md:text-xl">
          <p>{post.content}</p>
        </article>

        <h2 className="text-2xl font-bold mb-6 font-sans tracking-wide border-b border-white/10 pb-4">Commentaires 💬</h2>
        <DisqusComments id={id} />
      </div>
    </main>
  );
}
