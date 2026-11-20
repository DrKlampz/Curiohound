# Changelog

## v0.3.1
- Emblem list: Pinnacle star, Sunburst, Crown, Crossed swords, Flame and Compass rose; the game's own race sigils and city banners (Stormwind, Orgrimmar and the rest); religious symbols (cross, Celtic cross, Star of David, crescent and star, Wheel of Dharma, yin and yang, ankh, lotus, hamsa, triquetra, torii gate).
- Pointing at an entry in the emblem, corner, crest, edge, banner and divider lists shows a small preview of it.
- The Horde and Alliance crests use the game's round PvP emblem; the title banner is centered with the title.

## v0.3.0
- Gradients: pick both colors, each end's opacity, vertical, horizontal, diagonal, middle-out or center-to-borders, over or instead of the background texture; plus a theme with its own emblem, corners, crest and edge for every talent spec, and a "My spec" automatic theme.
- Look profiles: save your look under a name and switch between saved looks at any time; every character remembers which profile it wears (Look panel, top).
- World of Warcraft flavored art, all optional: nine class themes (Warrior to Druid) with an original emblem, corner pieces, crest and colors for each class, plus a "My class (automatic art)" theme that picks yours; Blue and gold kingdom, Red and iron war camp, Moonlit grove and Plaguelands themes; new spiked corners, horn, crescent and skull crests, and an iron spike edge. The emblem in the middle of the window can also show your class or your talent tree using the game's own icons. Find them in the window options under Colors > Theme and Artwork.
- More optional artwork for the window box: ornament strips along the edges (rope, chain, pearls, runes, vine), a banner behind the title (ribbon, riveted plaque, scroll, jeweled plate), a divider with an ornament under the title, and a faint emblem in the middle of the window (compass rose, shield, laurel wreath, star, runic rings). All in the new Artwork section of the window options; the eight art themes now use them, and the crest sits above the top edge.
- New optional artwork in the window look: seven textured backgrounds (wood planks, aged paper, arcane starfield, runed slate, riveted iron, damask tapestry, dragon scales), five carved corner pieces (filigree, vines, runes, iron plates, arcane sigil), four crests for the top edge (winged, jeweled, scrollwork, crown), and eight ready-made art themes (Arcane library, Dwarven forge, Elven glade, Old tome, Runestone, Royal court, Dragonscale, Oak lodge). Pick them in the window options (Colors > Theme, Background, Border > Corner artwork and Crest). Everything is off until you choose it and syncs between your add-ons like the rest of the look.
- The minimap button now uses the add-on's own icon instead of a stock game icon.
- Issue recorder: Ctrl-click the minimap button (or type /issues) to see any errors or blocked actions this add-on logged, with a built-in self-test.
- A better tooltip on every entry: icon and name, a colored type and status line, class, faction and level, then Where, Quest and item, How to get it (long steps split into short lines), Reward, and library or chain progress.
- A small spinning 3D model appears beside the tooltip for pets and tames, so you can see what one looks like before you chase it. It works for the Ghost Saber and Broken Tooth now, and for any companion pet once you have owned it. Others say 'not available yet' until their creature ids are added.
- Fishing gear you have to find: the Blump pole, Nat Pagle's FC-5000, the Big Iron pole, the Stranglethorn Fishing Extravaganza hats, boots, line and Arcanite pole, Nat Pagle's quest, and more lures and drops.
- More to collect: the Legacy reward track (air rifle toy, tabard, Spectral Bear mount), how your first mount works, the mounts nobody has found a source for yet, the Horde Riverglades ring and the Broken Tooth hunter tame.
- More collectibles: 13 more companion pets with known sources (whelps, Zephras and Riverglades pets, Engineering and Tailoring pets), the unsolved Stone Key trail, Among the Faithful, the Hidden Blade clue, the Zephras Galestriders and the Pack Kodo.
- More class secrets: the Skyborne Mage wand and Warrior shield, the unsolved Mage battle sword, the new Horde Paladin quest rewards, the Alliance Shaman fire quest, the level 60 epic mounts for Warlock and Paladin, and Kyle's Gone Missing in Mulgore.
- New: class secrets and class-only rewards in Gear and perks, shown only for that class. Hunter ghost tames (Ghost Saber from the cat figurines, Coldrasp, Ghostfang, Ghostmaw), the Rogue Eye of Bhossca chain, the Warrior, Shaman, Mage, Warlock and Alliance Paladin weapon quests, and the free class mounts.
- New: how to get your first mount for free as a Human (pick up the 'Your First Horse' quest in Menethil Harbor instead of Elwynn Forest to get the Black Stallion).
- New: the full Dawn Waker secret, step by step. It starts with the Ancient Heirloom ring on Zephras Isle (Thendal Village), then the Night Watchman's Torch, the hilt, the sword Eluvi'ana, the Befouled Water Globe, the Highborne Spirit and Narassin's Tome, the three cleansing materials, the Hyjal ritual and Prince Tortheldrin. Each step has its spot, level and notes, and is ticked automatically when the item is in your bags.
- New: the Dawn Waker secret that starts with the Ancient Heirloom ring on Zephras Isle is now a full step-by-step chain under Secrets: the ring, the Duskwood torch, the hilt, Eluvi'ana, the water globe, the Highborne Spirit and tome, Mordent Evenshade, the three cleansing materials, the Hyjal ritual and Prince Tortheldrin, each with its spot, level and what to carry. Ashenvale added as a zone.
- The tooltip on each list entry now shows far more: what kind of collectible it is, where it is (zone, spot and map coordinates), the level and faction it needs, the quest and item behind it, how to get it, what it rewards, and for library books how many are handed in, the next library reward and who to hand it to.
- Removed the add-on-to-add-on theming hooks and cross-add-on names from the window look code; the shared look sync between your add-ons works the same.
- Books in your bags are now matched by name ignoring punctuation and capitals, and a book that leaves your bags right after a quest was handed in counts as turned in, not only at the librarian. Curiohound also records what is in your bags and what you hand in (saved data: bagDump, turnLog, bagLog) so odd names can be sorted out.
- The "Pulse the flair" option now also pulses the edge finish (soft, bevel, double line and glow), not just the corner studs.

## v0.2.4
- Look sync: the first time your add-ons meet, they now all take on the same look right away instead of waiting for you to change something.

## v0.2.3
- Your custom look is now shared with your other add-ons: change colors, background, border or opacity in one and the rest follow (the newest change wins). It is on by default; untick "Sync my look with my other add-ons" in the Look window to turn it off.
- The tracker is hidden while the world map is open (switch it back on in Options > Tracker).
- The main window now sits above the tracker, so the tracker no longer draws over the book list.

## v0.2.2
- Every library book is now linked to its hand-in quest by name, so turning one in (or having done it before) ticks that exact book.

## v0.2.1
- Linked the CurseForge and Wago projects. Library books are now matched to your finished quests, the library line shows how many books you have turned in, and the scan records details to help match old turn-ins.

## v0.2.0
- First public release: library books, Cozy Sleeping Bag chain, early big bags, perks, pets and secrets, with auto-detected progress, an on-screen tracker with travel hints, and map and minimap pins.
