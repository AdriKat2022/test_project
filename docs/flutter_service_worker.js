'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "dc86fe49260c1042ab7bad33fd0b626f",
"assets/AssetManifest.bin.json": "ffbf9832dc5682b1eadd457d334288c6",
"assets/AssetManifest.json": "bc0c7b866a7145cfe8288d0a0f5306cd",
"assets/assets/audio/musics/main_music.wav": "957f2007bba1e5f15670f7df01d6823c",
"assets/assets/audio/sounds/click.wav": "13bd64a273ecce4dfe5566ae4095d928",
"assets/assets/audio/sounds/enemy_hurt.wav": "b0a43a84322c94f0760ae9704a92ca16",
"assets/assets/audio/sounds/explosion.wav": "ebb0afa8b0235eebbd4ed6ce694a1fa6",
"assets/assets/audio/sounds/player_bullet.wav": "74f5ef1224e6e57f08dc8cc4e43114d6",
"assets/assets/images/backgrounds/background_placeholder.png": "0ae62b1b1aae8b369d2f0ad80c7d7dbb",
"assets/assets/images/backgrounds/stars_1.png": "b5a52915f62e4c001b3f1e48fbe0322f",
"assets/assets/images/backgrounds/stars_2.png": "915d4532009be1887bc488dedc697dfa",
"assets/assets/images/bullets/player_bullet_sheet.png": "ee3732b0260ee2520076e715957335ff",
"assets/assets/images/effects/explosion.png": "0a8eaeaed96ec92ac2f2d78d555029b3",
"assets/assets/images/ships/enemy_basic.png": "4ffb84510e7701bb8a740dcebf52c18f",
"assets/assets/images/ships/player_idle.png": "eecde22e546f2edffade3fe0abdb5354",
"assets/assets/images/ships/player_sheet.png": "7e103ea127c72b067bb069cae7a27903",
"assets/assets/images/UI/buttons/arrow_left.png": "ba47afe8c9abb07d8b4781a502435d43",
"assets/assets/images/UI/buttons/arrow_left_hover.png": "fd034c909febd63a81a765ff731038de",
"assets/assets/images/UI/buttons/arrow_left_pressed.png": "3980ea3478396c6f2b4633e62082b2e0",
"assets/assets/images/UI/buttons/arrow_right.png": "6cf941e59431c758e9f458303657d5fa",
"assets/assets/images/UI/buttons/arrow_right_hover.png": "d65da5717dcdd3c05ddc929e87ac234a",
"assets/assets/images/UI/buttons/arrow_right_pressed.png": "6ae29ade8d5efd153fa44ec7f245b827",
"assets/assets/images/UI/buttons/button_1.png": "8cd940441d43dd4c77fcb490c0ba90f1",
"assets/assets/images/UI/buttons/button_1_hover.png": "c907d24aeac4684871b7b6e3fc77b566",
"assets/assets/images/UI/buttons/pause_btn.png": "e7d1517f7dd0a993bf145758da9ea951",
"assets/assets/images/UI/buttons/pause_btn_hover.png": "7cd569af90a09c177197405db1b6ff8b",
"assets/assets/images/UI/buttons/pause_btn_pressed.png": "b491f973e9603448fda41427f3fcf34e",
"assets/assets/images/UI/buttons/play_btn.png": "dede531bbae276a05a7f511be9b4bf58",
"assets/assets/images/UI/buttons/play_btn_hover.png": "fae7d10245c9b7b4222d66e59113cbab",
"assets/assets/images/UI/buttons/play_btn_pressed.png": "694aa653bd68423a15130c28c14847ef",
"assets/assets/images/UI/buttons/return_btn.pdn": "a7d5837f06243ed64c42a20e31e8baff",
"assets/assets/images/UI/buttons/return_btn.png": "6d7b23b31bcdf0cfde3abacd3f8dec41",
"assets/assets/images/UI/buttons/return_btn_hover.png": "11d5be517a053129855cd8c49d888604",
"assets/assets/images/UI/buttons/return_btn_pressed.png": "328cd3772803111748f10a2303a90976",
"assets/assets/images/UI/heart.png": "fb1b6137fdb472aa7fff8d325289105a",
"assets/FontManifest.json": "10d9c4b6f187456427ba3b137ae0f150",
"assets/fonts/fragile_bombers.otf": "60a3dec1aa395407ffc345f23e16a593",
"assets/fonts/good_timing.otf": "74ff63b97ad7a4f470501a0d841b1430",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "0fd1dfafa157db00951391478950c8a3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"flutter_bootstrap.js": "0f8bf20ebc18da68fa41c5ca00b8a7aa",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "6ffad52ed9546bf5352fbd3f39e26b44",
"/": "6ffad52ed9546bf5352fbd3f39e26b44",
"main.dart.js": "42672bda337e7545bff3fa4272064cfb",
"manifest.json": "ee159ae81f8f022d114dc8d0e06bab9f",
"version.json": "6b1b3d7c06b9ee276d1bc520a855ca01"};
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
