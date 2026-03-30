import { GoogleAnalytics } from "@next/third-parties/google";
import type { Metadata, Viewport } from "next";
import localFont from 'next/font/local';
import "./globals.css";

const soriaFont = localFont({
  src: "../public/soria-font.ttf",
  variable: "--font-soria",
});

const vercettiFont = localFont({
  src: "../public/Vercetti-Regular.woff",
  variable: "--font-vercetti",
});

export const metadata: Metadata = {
  title: "Vlog UQAC - Jérémy Girard 🇨🇦",
  description: "Mon aventure académique au Canada et mes ambitions en Cybersécurité IA.",
  keywords: "Jérémy Girard, Vlog, UQAC, Chicoutimi, Canada, Cybersécurité, IA",
  authors: [{ name: "Jérémy Girard" }],
  creator: "Jérémy Girard",
  publisher: "Jérémy Girard",
  formatDetection: {
    email: false,
    address: false,
    telephone: false,
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
  openGraph: {
    title: "Vlog UQAC - Jérémy Girard",
    description: "Mon aventure académique au Canada",
    type: "website",
  },
  twitter: {
    card: "summary_large_image",
    title: "Vlog UQAC - Jérémy Girard",
    description: "Mon aventure académique au Canada",
  },
};

export const viewport: Viewport = {
  themeColor: "#000000",
  initialScale: 1,
  minimumScale: 1,
  maximumScale: 1,
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="overscroll-y-none">
      <body
        className={`${soriaFont.variable} ${vercettiFont.variable} font-sans antialiased`}
      >
        {children}
      </body>
    </html>
  );
}
