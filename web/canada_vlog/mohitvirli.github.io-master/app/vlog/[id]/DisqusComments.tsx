'use client';
import { useEffect } from 'react';

export default function DisqusComments({ id }: { id: string }) {
  useEffect(() => {
    const existingScript = document.getElementById('disqus-script');
    if (!existingScript) {
      // eslint-disable-next-line
      (window as any).disqus_config = function (this: any) {
        this.page.url = window.location.href;
        this.page.identifier = id;
      };
      const s = document.createElement('script');
      s.id = 'disqus-script';
      s.src = 'https://jeremy-vlog-canada.disqus.com/embed.js'; // Generic shortname, can change later
      s.setAttribute('data-timestamp', (+new Date()).toString());
      (document.head || document.body).appendChild(s);
    } else {
      // eslint-disable-next-line
      if (typeof (window as any).DISQUS !== 'undefined') {
        // eslint-disable-next-line
        (window as any).DISQUS.reset({
          reload: true,
          config: function (this: any) {
            this.page.identifier = id;
            this.page.url = window.location.href;
          }
        });
      }
    }
  }, [id]);

  return <div id="disqus_thread" className="mt-12 bg-white/5 p-6 rounded-xl"></div>;
}
