# Changelog

## Unreleased
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
