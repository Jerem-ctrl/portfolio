'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "12cd8ad4e9b5ff705dc8806684bce2bf",
"assets/AssetManifest.bin.json": "37635d24b2be92a9f85a7ca8f72c35f0",
"assets/AssetManifest.json": "a06a1f550d38688d54c4175acb389a41",
"assets/assets/images/a.jpg": "f1531e1bd7834e092b6c382cb2960b52",
"assets/assets/images/alive.jpeg": "04ee907901517c4e36cf81efc2fa847b",
"assets/assets/images/apple_logo.png": "1eeba8c3b7814a18e4320bcf3849aa27",
"assets/assets/images/apple_splash.png": "fb8b42d06198bb7d9bb955c0be3e91bc",
"assets/assets/images/atq.png": "e6f0e002f27eb5f77af9d9b21e6d2a88",
"assets/assets/images/background.jpg": "70314ebeb6985697a9f3bb051b49beca",
"assets/assets/images/c%2523.png": "e94c6f5b5e017a04b5abc2fbce01ffaf",
"assets/assets/images/c.jpg": "fb8be60f4b8c6c3ec6b5024ce9fde65f",
"assets/assets/images/chargement.gif": "21c50a7adc9471a7cb1a90d20671696b",
"assets/assets/images/ci.jpg": "9963ed2cfa4acfead4251faf1343ae9f",
"assets/assets/images/cis.png": "b2bb778d16d809fe8d8b67046cd23ec1",
"assets/assets/images/cisc.jpg": "0c14ea88c15b72e4744096b16117998b",
"assets/assets/images/cli.jpeg": "6bf1b8b3a42ed08c7fd698ee925c41f5",
"assets/assets/images/contacts.png": "c9ea98d145eb4c3933c469d19056e5e0",
"assets/assets/images/d.jpeg": "e071f118427ff6480c1c7289db452605",
"assets/assets/images/fe.jpeg": "8bb1a0b2ca8d9d0a88d726511e269ac3",
"assets/assets/images/fi.jpeg": "1fd4d24cdff9e48c054eaa4e05d687a1",
"assets/assets/images/flutter.png": "dc6f640025da9958a26744df17cd7857",
"assets/assets/images/flutter_icon.png": "0423e8f0e49052ce408f0952426d6d2b",
"assets/assets/images/full_screen.png": "f4a2cc8ff0d2977bedc1efe0e09191a4",
"assets/assets/images/github.png": "467414575df9be7f96b66c76860c1c09",
"assets/assets/images/home.png": "bd5e918433c2ef7e9d8cf51c1e4e3af3",
"assets/assets/images/linkedin_icon.png": "89e20b3d70c243a98e4b8ea9ac51ac3b",
"assets/assets/images/linu.png": "b8f53a6ba4f2a9de76d23989001cad68",
"assets/assets/images/mail.png": "dbf2f2988978402a76fb9a18cb45737e",
"assets/assets/images/moi.jpg": "add223daaccec4c11cd4d4aaec77a649",
"assets/assets/images/moi1.jpg": "bfbbe3bc3f34eb3c4131dc40237b6d87",
"assets/assets/images/packages_icon.png": "1c60bf15b14ac6d80b55490a26728367",
"assets/assets/images/pav.webp": "ec2275eaa987eb1fb41a98f4f550b006",
"assets/assets/images/pct.png": "b4d914005feff8c2f99d5733c3196282",
"assets/assets/images/pdf.png": "5e714483f89d0cdc8ec841ce495b70cb",
"assets/assets/images/ph.png": "ff207fec26bc10d386c4eaca60ed42f8",
"assets/assets/images/projetcts.png": "1607e8fc07453160a2c6d0729093421d",
"assets/assets/images/py.png": "c58faf6807d93107b0e0bf803daf99db",
"assets/assets/images/ra.png": "4644d3cf5651b54046ad87ed63d1e2a0",
"assets/assets/images/replit.png": "cbcad52c150960cae15cf5102ca8c6d4",
"assets/assets/images/sa11c2.jpg": "f39cff0a9093833a095e1a0e45d3ac2c",
"assets/assets/images/sae11c3.jpg": "925fc00c5a3e913c8161e59ce7008281",
"assets/assets/images/sae11c4.webp": "be4941f91dddc049a73774da0219ea96",
"assets/assets/images/sae11c5.png": "8f9bc89af80a21cb1fbc65e723227ab9",
"assets/assets/images/sae11c6.png": "1505eaf56a898b2d582a5df2c09a4021",
"assets/assets/images/sae12r3.jpeg": "32cd0c6e88626be4ff2d5bc69f7db8ee",
"assets/assets/images/sae12r4.png": "30c9a7a374ae4378f954583f50be7811",
"assets/assets/images/sae12r5.png": "4f28ce3a908324f98c8fcfc02bc3cee6",
"assets/assets/images/sae12r6.png": "21d018ca00dc05a54efd44d997bd86a7",
"assets/assets/images/sae12r7.png": "4ea649b2db827109d6d59bd0e697e259",
"assets/assets/images/sae21c3.png": "178f4b071ae0fc30825e6ff6df3ef362",
"assets/assets/images/sae21c4.png": "f8275666b25687f1560c974d179e6a9e",
"assets/assets/images/sae21c5.png": "649cbdc71ac080eaff2ce433fc0a5fa4",
"assets/assets/images/sae21ci1.jpg": "d535b193b4ab6a0e7b74b7cc3e9758f2",
"assets/assets/images/sae21ci2.png": "a73e0e09db2885e5282d5db7ee15774d",
"assets/assets/images/sae22frt.png": "c243f5b97e2ec41f57457b85f8828153",
"assets/assets/images/sae22ism.png": "fcc1391f6de9bdb6260de50bb08ba222",
"assets/assets/images/sae22plt.png": "bd4247e7baa95181c2f0e0d5efb19c54",
"assets/assets/images/sae22rad1.png": "36dbfcecebbfce48ba8b503f84397b7a",
"assets/assets/images/sae22spectre.png": "46650c28f0a81207b83ac233e503f2ec",
"assets/assets/images/sae22trs1.png": "2b6e19f5b13758bb793694a6d5361af8",
"assets/assets/images/sae23php1.jpg": "7aa7914031ed5dcc4baa76edbf07a743",
"assets/assets/images/sae23php10.png": "f82c8778b00768d642dbf8c87eeef279",
"assets/assets/images/sae23php11.png": "1fd33b1599d29c35f2ca3f410e525e0c",
"assets/assets/images/sae23php12.png": "b422e7b4d57352cadff825d5ecaf50bc",
"assets/assets/images/sae23php13.png": "9ce3f600cd6cec0c2058f877eac902cc",
"assets/assets/images/sae23php2.png": "04788c31b4850e7ca9070d12e6d70a14",
"assets/assets/images/sae23php3.png": "0941a70e689f1943429d43e2f9768d12",
"assets/assets/images/sae23php4.png": "c0603f76f303151df054a2f446eb8011",
"assets/assets/images/sae23php5.png": "a769708f06f596b9f521f68aebb845c8",
"assets/assets/images/sae23php6.png": "1891c493406270cb2efe25824fc2da43",
"assets/assets/images/sae23php7.png": "8d04673c8ba24a49c7b35686a70418b3",
"assets/assets/images/sae23php8.png": "8126e5672599d4314a0890cbbed55aed",
"assets/assets/images/sae23php9.png": "3851a930047b29464e21bae3a8be14f7",
"assets/assets/images/sae24py1.webp": "e1b37238f9fe309d7f33e351ce7dcb95",
"assets/assets/images/sae24py2.png": "eaa2f8b3d723420e75721489682d0edc",
"assets/assets/images/sae24py3.png": "3bb8f7e11a0fa70938e09151153944c5",
"assets/assets/images/sae24py4.png": "cffc02ad742de7b26eb425e097f0e023",
"assets/assets/images/sae24py5.png": "2c62a8d92a196b0e6e0f49fc8d1c4565",
"assets/assets/images/sae24py6.png": "fb21e1a476d3435118bf04209e64f8e0",
"assets/assets/images/sae24py7.png": "4639d52fd77466681f100c2f85637362",
"assets/assets/images/sae24py8.png": "02cbaa042f00bd30307fea7c744f13d2",
"assets/assets/images/safari.png": "4eaa77e771c0baa4f5a82933735a4260",
"assets/assets/images/sis.jpg": "b5fc001e68dd61246057c41c4af3ccd4",
"assets/assets/images/th.jpg": "b316f628cdc7d022c86fbd9bbac0c439",
"assets/assets/images/total.png": "a8ab88b9533eb3baa8a35de6048ac06e",
"assets/assets/images/tr.jpeg": "f381da152b7e032c1f0008730d4ec7d0",
"assets/assets/images/ts.jpg": "54143a8f66faa8ec398fff19c56263f9",
"assets/assets/images/tss.jpg": "81bd261ad96a9225d6e190d26994db2c",
"assets/assets/images/w.png": "43aaa29b25d9e667928f842b782d715e",
"assets/assets/images/wi.png": "763a3b2e34d86460ddd1e07937bd50a1",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "f1c8b4db4477269b3931ff3f8b7ad288",
"assets/NOTICES": "77fce6881aefe6bb98a73dbf34f2ac0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "825e75415ebd366b740bb49659d7a5c6",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "27361387bc24144b46a745f1afe92b50",
"canvaskit/canvaskit.wasm": "a37f2b0af4995714de856e21e882325c",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "f7c5e5502d577306fb6d530b1864ff86",
"canvaskit/chromium/canvaskit.wasm": "c054c2c892172308ca5a0bd1d7a7754b",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "9fe690d47b904d72c7d020bd303adf16",
"canvaskit/skwasm.wasm": "1c93738510f202d9ff44d36a4760126b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "ad9c467adc2fc0071c9fa8203e992b7e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "c7e6768757868d76707e3e49ab14f27d",
"/": "c7e6768757868d76707e3e49ab14f27d",
"main.dart.js": "3d5ac29a358650066ae0df2e4872d266",
"manifest.json": "d454795ec90f470ee481df70d1276310",
"version.json": "12a92ef79835b40a6093bcc932b54998"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
