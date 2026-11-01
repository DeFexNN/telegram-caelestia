# Motion Lab

`motion_studio/index.html` is a standalone, Ukrainian language concept gallery for possible Telegram Desktop motion and interaction changes. It is separate from the CMake build and the Arch package recipe.

## Using the page

Open the HTML file directly in a browser. The page has category filters for chat, navigation, media, and microinteractions; speed controls; and interactive demonstrations embedded in the cards. Approval and rejection state is stored locally in browser storage with the key `caelestia-motion-votes`. The page does not send votes to a server. Use the copy control to copy a verdict summary.

The initial filter counts are calculated from the cards in the document. The current page contains cards numbered 1–24. GIF examples used by the page are in `gifs/` relative to the HTML file.

## Reading the concepts

The gallery includes interactive UI sketches, proposed source locations, and suggested durations. Treat the file locations and timings as design notes, not verified implementation requirements. Before porting a concept, locate the current widget or animation in the Telegram source and check its existing behavior, accessibility, and reduced-motion handling. The overview in the page itself also calls for restrained animation and reduced spatial movement.

The page uses inline CSS and JavaScript; there is no build step or external runtime dependency. Keep its image paths relative so the gallery continues to work when moved with its `gifs/` directory.
