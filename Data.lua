-- Curiohound: the list of things to collect. Coordinates and details come from community guides
-- (Warcraft Tavern, LFCarry, wowclassicforever.info, Icy Veins) and can be a little off. Anything can be ticked by hand.
local ADDON_NAME, ns = ...

local Z = {   -- zone key = { display name, uiMapID }
    elwynn = { "Elwynn Forest", 1429 }, ironforge = { "Ironforge", 1455 }, tirisfal = { "Tirisfal Glades", 1420 },
    silverpine = { "Silverpine Forest", 1421 }, lochmodan = { "Loch Modan", 1432 }, westfall = { "Westfall", 1436 },
    duskwood = { "Duskwood", 1431 }, wetlands = { "Wetlands", 1437 }, alterac = { "Alterac Mountains", 1416 },
    arathi = { "Arathi Highlands", 1417 }, stv = { "Stranglethorn Vale", 1434 }, badlands = { "Badlands", 1418 },
    swamp = { "Swamp of Sorrows", 1435 }, hinterlands = { "The Hinterlands", 1425 }, searing = { "Searing Gorge", 1427 },
    blasted = { "Blasted Lands", 1419 }, burning = { "Burning Steppes", 1428 }, wpl = { "Western Plaguelands", 1422 },
    epl = { "Eastern Plaguelands", 1423 }, orgrimmar = { "Orgrimmar", 1454 }, darkshore = { "Darkshore", 1439 },
    barrens = { "The Barrens", 1413 }, stonetalon = { "Stonetalon Mountains", 1442 }, needles = { "Thousand Needles", 1441 },
    desolace = { "Desolace", 1443 }, dustwallow = { "Dustwallow Marsh", 1445 }, tanaris = { "Tanaris", 1446 },
    azshara = { "Azshara", 1447 }, felwood = { "Felwood", 1448 }, winterspring = { "Winterspring", 1452 },
    stormwind = { "Stormwind City", 1453 }, undercity = { "Undercity", 1458 }, thunderbluff = { "Thunder Bluff", 1456 },
    darnassus = { "Darnassus", 1457 }, dunmorogh = { "Dun Morogh", 1426 }, feralas = { "Feralas", 1444 },
    hillsbrad = { "Hillsbrad Foothills", 1424 }, redridge = { "Redridge Mountains", 1433 },
    zephras = { "Zephras Isle", nil }, brm = { "Blackrock Mountain", nil },
    teldrassil = { "Teldrassil", 1438 }, durotar = { "Durotar", 1411 }, mulgore = { "Mulgore", 1412 },
    hyjal = { "Mount Hyjal", nil }, riverglades = { "Riverglades", nil },
}
ns.ZONES = Z

ns.CATS = {
    { id = "book",   name = "Library books" },
    { id = "bag",    name = "Cozy Sleeping Bag" },
    { id = "pet",    name = "Companion pets" },
    { id = "secret", name = "Secrets and extras" },
    { id = "bagq",   name = "Bags and storage" },
    { id = "perk",   name = "Gear and perks" },
    { id = "custom", name = "My own list" },
}

local E = {}
ns.Entries = E

local function slug(s) return (s:lower():gsub("[^%w]+", "")) end
local function add(t)
    local z = t.zone and Z[t.zone]
    if z then t.zoneName = z[1] t.map = t.map or z[2] end
    t.key = t.key or (t.cat .. ":" .. slug(t.name))
    E[#E + 1] = t
end

---------------------------------------------------------------------------
-- Library books (turn them in to Garion Wendell in Stormwind or Owen Thadd in Undercity)
---------------------------------------------------------------------------
ns.LIBRARIANS = {
    ["Garion Wendell"] = "Stormwind City, Mage Quarter, top of the tower in the Wizard's Sanctum (49.0, 86.3)",
    ["Owen Thadd"] = "Undercity, inner Magic Quarter (74.0, 32.5)",
}
ns.LIBRARIAN_POINTS = {
    A = { zone = "stormwind", x = 49.0, y = 86.3, name = "Garion Wendell (Stormwind library)" },
    H = { zone = "undercity", x = 74.0, y = 32.5, name = "Owen Thadd (Undercity library)" },
}
-- cumulative books needed, the character level, and the rewards you choose from
ns.MILESTONES = {
    { books = 10, lvl = 1,  quest = "Friend of the Library", rewards = "Scholarly Pendant or Erudite's Amulet" },
    { books = 20, lvl = 20, quest = "Greater Friend of the Library", rewards = "Field Researcher's Loop or Philanthropist's Ring" },
    { books = 25, lvl = 35, quest = "Greater Friend of the Library", rewards = "Truthseeker's Bow, Crest of Elucidation or Researcher's Night Light" },
    { books = 35, lvl = 50, quest = "Greater Friend of the Library", rewards = "Antique Bulwark, Artifact Seeker's Pendant or Museum Keeper's Chain" },
}

local function Book(zone, place, x, y, lvl, fac, name, hint, key)
    add({ cat = "book", zone = zone, x = x, y = y, lvl = lvl, fac = fac, name = name, place = place, note = hint, item = name, key = key })
end
Book("elwynn", "Tower of Azora, top floor", 65.4, 70.1, 1, "A", "Archmage Theocritus' Research Journal")
Book("ironforge", "Hall of Explorers, library table", 75.7, 10.5, 1, "A", "Archmage Antonidas: The Unabridged Autobiography")
Book("tirisfal", "Brill, alchemy building", 59.4, 52.3, 1, "H", "The Apothecary's Metaphysical Primer")
Book("silverpine", "The Sepulcher", 43.4, 41.2, 10, "H", "Ataeric: On Arcane Curiosities")
Book("silverpine", "Ambermill town hall, bookshelf", 63.5, 63.1, 10, "H", "The Dalaran Digest, Vol. 23")
Book("lochmodan", "Thelsamar inn", 35.6, 48.9, 10, "A", "Rumi of Gnomeregan: The Collected Works", "The same book is also at Sentinel Hill. You can only take one copy.", "book:rumi")
Book("lochmodan", "Mo'grosh Stronghold, left branch of the ogre cave", 77.5, 14.1, 10, "A", "Runes of the Sorcerer-Kings")
Book("westfall", "Moonbrook, house near the Deadmines", 45.4, 70.5, 10, "A", "Bewitchments and Glamours")
Book("westfall", "Sentinel Hill inn", 52.7, 53.8, 10, "A", "Rumi of Gnomeregan: The Collected Works", "The same book is also at Thelsamar. You can only take one copy.", "book:rumi")
Book("duskwood", "Raven Hill Cemetery, bottom of the stairs in the west crypt", 16.7, 28.5, 18, nil, "Crimes Against Anatomy")
Book("wetlands", "Whelgar's Excavation Site, lower pit", 33.6, 47.9, 20, nil, "Goaz Scrolls")
Book("alterac", "Gallows' Corner, behind crates in the first ogre tower", 48.4, 57.5, 30, nil, "Defensive Magics 101")
Book("arathi", "Witherbark Village, eastern hut", 73.6, 65.2, 30, nil, "A Web of Lies: Debunking Myths and Legends")
Book("stv", "Mistvale Valley, table outside Crystalvein Mine", 41.3, 50.9, 30, nil, "Basilisks: Should Petrification be Feared?")
Book("badlands", "Hilltop crypt east of Hammertoe's Digsite", 56.7, 39.7, 35, nil, "Mummies: A Guide to the Unsavory Undead")
Book("feralas", "South of Jademir Lake, open ground", 50.6, 15.7, 40, nil, "The Liminal and the Arcane", "Players report no library hand-in quest for this one, so it may not count toward the 40.")
Book("swamp", "Fallow Sanctuary (needs a Rusted Cage Key from nearby Lost Ones)", 61.0, 22.0, 35, nil, "A Luddite's Guide to Caring for Your Demonic Pet", "Unverified: players report no hand-in quest for this one and the spot is not confirmed.")
Book("swamp", "Temple of Atal'Hakkar, upper terrace", 70.2, 51.9, 35, nil, "Sanguine Sorcery")
Book("hinterlands", "Shadra'Alor, troll altar compound", 35.8, 72.5, 40, nil, "Venomous Journeys")
Book("searing", "The Cauldron, Dark Iron work area", 38.1, 49.8, 43, nil, "A Mind of Metal")
Book("blasted", "Road rubble, no named place", 55.3, 32.2, 47, nil, "Conjurer's Codex")
Book("brm", "Inside Blackrock Mountain, central altar vault (29.1, 28.9)", nil, nil, 50, nil, "Stonewrought Design")
Book("brm", "Inside Blackrock Mountain, platform past Lothos Riftwaker (48.4, 63.6)", nil, nil, 50, nil, "Magma or Lava?")
Book("wpl", "Caer Darrow, upstairs near Scholomance", 69.2, 72.3, 50, nil, "Necromancy 101")
Book("wpl", "Felstone Field, second floor of the farmhouse", 38.3, 54.6, 50, nil, "Undead Potatoes")
Book("epl", "Light's Hope Chapel", 71.8, 48.2, 53, nil, "A Study of the Light")
Book("epl", "Stratholme gate", 26.6, 14.5, 53, nil, "Scourge: Undead Menace or Misunderstood?")
Book("epl", "Blackwood Lake, lake house", 47.3, 42.3, 53, nil, "The Knight and the Lady")
Book("orgrimmar", "Valley of Spirits, mural at Darkbriar Lodge", 38.6, 78.4, 1, "H", "The Lessons of Ta'zo")
Book("darkshore", "Ruins of Mathystra, stone stairs", 59.6, 22.2, 10, "A", "Nar'thalas Almanac, Vol. 74")
Book("barrens", "The Sludge Fen, control room atop the Venture Co. rig", 56.3, 8.8, 10, "H", "Arcanic Systems Manual")
Book("barrens", "Ratchet, upstairs in the engineering house", 62.7, 36.3, 10, nil, "Baxtan: On Destructive Magics")
Book("barrens", "Cavern of Mists, back chamber near Wailing Caverns", 46.0, 36.4, 10, "H", "Secrets of the Dreamers")
Book("stonetalon", "Grimtotem Post, barrel in a tent", 74.4, 85.7, 15, nil, "Fury of the Land")
Book("needles", "Darkcloud Pinnacle, largest hut", 34.4, 40.0, 25, nil, "Geomancy: The Stone-Cold Truth")
Book("desolace", "Thunder Axe Fortress, bench in the main hall", 55.1, 26.2, 30, nil, "Demons and You")
Book("dustwallow", "North of Witch Hill, east edge of the murloc camp", 57.1, 20.8, 35, nil, "RwlRwlRwlRwl!")
Book("tanaris", "Lost Rigger Cove, bookshelf in the pirate building", 72.6, 47.5, 40, nil, "Legends of the Tidesages")
Book("azshara", "Haldarr Encampment, satyr ruins", 20.4, 62.3, 48, nil, "Everyday Etiquette")
Book("felwood", "Timbermaw Hold, beside the bridge in the tunnel", 65.1, 3.2, 48, nil, "Northern Kalimdor: A Comprehensive Guide")
Book("winterspring", "Everlook, shelf behind the alchemy vendor", 60.4, 37.4, 53, nil, "Ka-Boom!")

---------------------------------------------------------------------------
-- Cozy Sleeping Bag (a chain of world clicks, no quest giver)
---------------------------------------------------------------------------
local BAGNOTE = "Level 14 or higher. Horde players report level 20 to 30 is safer because of the level 30 guards at the dam."
local function Step(zone, place, x, y, name, hint, fac, key, quest, extra)
    local t = { cat = "bag", zone = zone, x = x, y = y, lvl = 14, fac = fac, name = name, place = place, note = hint, quest = quest or name, key = key }
    if extra then for k, v in pairs(extra) do t[k] = v end end
    add(t)
end
Step("westfall", "Alexston Farmstead, wrecked cart. Click the Burned-Out Remains.", 37.1, 50.1, "1. ...and that note you found", BAGNOTE, "A", "bag:1", "...and that note you found", { qid = 79008 })
Step("barrens", "Burnt tower south of Camp Taurajo. Click the Burned-Out Remains.", 46.1, 74.3, "1. ...and that note you found", BAGNOTE, "H", "bag:1", "...and that note you found", { qid = 79007 })
Step("stonetalon", "Abandoned camp northeast of Sun Rock Retreat. Click the Pocket Litter on the box.", 40.7, 52.4, "2. Stepping Stones", "Gives an Old Toolbox (12-slot bag). The optional quest Rekindle uses the Flint and Wood.", nil, "bag:2", "Stepping Stones", { qid = 79192 })
Step("stonetalon", "Jump from the hill north of the camp onto the Mound of Dirt.", 39.6, 49.8, "3. Scramble", nil, nil, "bag:3", "Scramble", { qid = 79980 })
Step("lochmodan", "Stonewrought Dam: drop onto the carved dwarf heads. The Eagle Figurine is on the easternmost one.", 49.4, 12.9, "4. Wet Job", "Alliance guards and tunnels here are level 30. Horde can reach Loch Modan through Arathi and Thandol Span.", nil, "bag:4", "Wet Job", { qid = 79974 })
Step("hillsbrad", "Thoradin's Wall, Hillsbrad side: use the cart, climb in and look right for the hanging Messenger Bag.", 87.4, 49.6, "5. Eagle's Fist", nil, nil, "bag:5", "Eagle's Fist", { qid = 79975 })
Step("hillsbrad", "Open the Hastily Rolled-Up Satchel below the Messenger Bag to get the Cozy Sleeping Bag.", 87.4, 49.6, "6. This Must Be The Place", "Reward: Cozy Sleeping Bag (resting in it gives +1% XP per minute, up to +3%) and Student Fodder.", nil, "bag:6", "This Must Be The Place", { item = "Cozy Sleeping Bag", qid = 79976 })

---------------------------------------------------------------------------
-- Companion pets (the ones with a known source) and the hidden ones
---------------------------------------------------------------------------
local function Pet(name, src, fac, zone, x, y, key)
    add({ cat = "pet", name = name, note = src, fac = fac, zone = zone, x = x, y = y, pet = name, key = key })
end
for _, p in ipairs({ "Bombay", "Cornish Rex", "Orange Tabby", "Silver Tabby" }) do
    Pet(p, "Sold by Donni Anthania, Elwynn Forest.", "A", "elwynn")
end
Pet("White Kitten", "Sold by Lil Timmy, Stormwind City.", "A", "stormwind")
Pet("Cockatiel", "Sold by Narkk, Stranglethorn Vale.", nil, "stv")
Pet("Senegal", "Sold by Narkk, Stranglethorn Vale.", nil, "stv")
Pet("Ancona Chicken", "Sold by Magus Tirth, Thousand Needles.", nil, "needles")
Pet("Cockroach", "Sold by Jeremiah Payson, Undercity.", "H", "undercity")
Pet("Wood Frog", "Sold by Flik, Thunder Bluff.", nil, "thunderbluff")
Pet("Tree Frog", "Sold by Flik, Thunder Bluff.", nil, "thunderbluff")
Pet("Hawk Owl", "Sold by Shylenai, Darnassus.", "A", "darnassus")
Pet("Great Horned Owl", "Sold by Shylenai, Darnassus.", "A", "darnassus")
Pet("Brown Prairie Dog", "Sold by Halpa, Thunder Bluff.", "H", "thunderbluff")
Pet("Snowshoe Rabbit", "Sold by Yarlyn Amberstill, Dun Morogh.", "A", "dunmorogh")
Pet("Black Kingsnake", "Sold by Xan'tish, Orgrimmar.", "H", "orgrimmar")
Pet("Brown Snake", "Sold by Xan'tish, Orgrimmar.", "H", "orgrimmar")
Pet("Crimson Snake", "Sold by Xan'tish, Orgrimmar.", "H", "orgrimmar")
Pet("Black Tabby", "Drops from Dalaran Spellscribes in Silverpine Forest (about 15%).", nil, "silverpine")
Pet("Siamese", "Drops from Cookie in the Deadmines (about 10%).", nil)
Pet("Green Wing Macaw", "Drops from Defias Pirates in the Deadmines (about 3%).", nil)
Pet("Sprite Darter Hatchling", "Quest 'Becoming a Parent' in Feralas.", "A", "feralas")
Pet("Worg Pup", "Quest 'Kibler's Exotic Pets' in Blackrock Spire.", nil)
Pet("Smolderweb Hatchling", "Quest 'En-Ay-Es-Tee-Why' in Blackrock Spire.", nil)
Pet("Mechanical Chicken", "Quest 'An OOX of Your Own' in Booty Bay.", nil)
Pet("Speedy", "Quest 'A Warden of the Alliance' or 'A Warden of the Horde'.", nil)
Pet("Mr. Wiggles", "Quest 'A Warden of the Alliance' or 'A Warden of the Horde'.", nil)
Pet("Whiskers the Rat", "Quest 'A Warden of the Alliance' or 'A Warden of the Horde'.", nil)
Pet("Spirit of Summer", "Quest 'A Light in Dark Places' in Orgrimmar.", "H", "orgrimmar")
for _, p in ipairs({ "Mechanical Squirrel", "Tiny Walking Bomb", "Lil' Smoky", "Lifelike Toad", "Tranquil Mechanical Yeti" }) do
    Pet(p, "Made by an Engineer.", nil)
end
Pet("Spectral Bear Cub", "Legacy reward: 25 Legacy points.", nil)
Pet("Musical Gustjumper", "Hidden pet. Zephras Isle (51.5, 72.1): stand by the frogs on the rock and type /sing, then pick up the frog that hops next to you and use it.", nil, "zephras", 51.5, 72.1)
Pet("Excitable Slime", "Hidden pet (Horde). Buy a Nutritious Slime Sludge from Boyle (56.2, 64.6), find the slime in the Undercity canal and /dance at it until it dances back and gives the quest WRIGGLE.", "H", "undercity", 56.2, 64.6)
Pet("Baby Crocolisk", "Hidden pet (Alliance). Drops from Sewer Beast, a level 50 elite in the Stormwind canals. Needs a group.", "A", "stormwind")

---------------------------------------------------------------------------
-- Secrets and extras
---------------------------------------------------------------------------
local function Secret(name, note, zone, x, y, extra)
    local t = { cat = "secret", name = name, note = note, zone = zone, x = x, y = y }
    if extra then for k, v in pairs(extra) do t[k] = v end end
    add(t)
end
Secret("Silver of the Waves", "Dive to the Discarded Fishing Toolbox (45.6, 43.4), loot the Monogrammed Silver Hair Clip, turn it in to Khara Deepwater (39.5, 39.2). Reward: Repurposed Hair Band.", "lochmodan", 45.6, 43.4, { quest = "Silver of the Waves", item = "Repurposed Hair Band" })
Secret("Early relics (Druid and Shaman)", "Horde only, level 5. Shen'dar Village on Zephras Isle: turn in Welcome to Shen'dar Village, take Meddlesome Mages from Illaya Amberwind. Reward: Idol of Shifting Tides (Druid) or Totem of Charged Flames (Shaman).", "zephras", nil, nil, { fac = "H", quest = "Meddlesome Mages", item = { "Idol of Shifting Tides", "Totem of Charged Flames" } })
Secret("Dawn Waker: Eluvi'ana", "Multi-step secret. Night Watchman's Torch from a Duskwood guard, sword hilt at the Ruins of Ban'aethal, cleanse the blade with a Befouled Water Globe, then Prince Tortheldrin in Dire Maul. The Star of Elune part is in a hidden Shen'dralar vault in southern Feralas.", "feralas", nil, nil, { item = "Eluvi'ana" })
Secret("Lyn the Ignored", "Secret boss, needs a group. Shadowfang Keep: kill Archmage Arugal and click the book for the Black Tome. At Ambermill's Leyline Focus make the Tome of Dalaran. In the City of Dalaran dungeon kill Atrexis, take the sewer to the purple rune and use the Tome.", nil, nil, nil, { item = "Tome of Dalaran" })
Secret("Alcaz Operative Disguise", "Secret toy in Alcaz Prison. Do not kill the first boss, The Questioner. Mason Connery at the end needs his key.", nil, nil, nil, { item = "Alcaz Operative Disguise" })
Secret("Strahnbrad mystery", "Outside the Strahnbrad forge, Alterac Mountains: hit both bellows with fire damage.", "alterac")
Secret("Embrace of the Viper", "Druids: wear all five pieces of the Wailing Caverns 'of the Fang' set (one from each boss) to turn into a serpent.", nil)
Secret("Blessing of Kalimdor", "Collect two pieces of the Barrens rare set (Humar the Pridelord, Swiftmane, Takk the Leaper): +5% movement speed in the Barrens and Stonetalon.", "barrens")
Secret("Savory Whimsyfin Delight", "Recipe drops from random mobs (for example Great Goretusks in Redridge). Cook it and eat it for an orc ninja or pirate outfit.", "redridge")
Secret("Riverglades black market goblin", "A goblin vendor in Riverglades who sells Gift of Galloping (15 days, +10% mounted speed, 150 gold) and caps prices on rare crafting materials.", nil)
Secret("Hyjal legendary questline", "The legendary questline (six vessels and the Bough of the World Tree, tied to Hyjal) has no details yet. Tick it when you find out more.", nil)

---------------------------------------------------------------------------
-- Bags and storage: free and quest bags worth picking up (more slots, usually for no gold)
---------------------------------------------------------------------------
local function BagQ(zone, bag, slots, quest, fac, lvl, note, x, y, extra)
    local t = { cat = "bagq", zone = zone, x = x, y = y, lvl = lvl, fac = fac, name = ("%s (%s slots)"):format(bag, slots),
        quest = quest, item = bag, note = (quest and ("Quest '" .. quest .. "'. ") or "") .. (note or ""), key = "bagq:" .. slug(bag) }
    if extra then for k, v in pairs(extra) do t[k] = v end end
    add(t)
end
-- starter bags (6 slots)
BagQ("elwynn", "Book Bag", 6, "Book Return", "A", 1, "Human start. Marshal Dughan, Northshire.", 42.2, 65.8)
BagQ("dunmorogh", "Canvas Latchbag", 6, "Grund and Gozwin", "A", 4, "Dwarf and Gnome start. Grund Drokda.", 28.6, 67.4)
BagQ("teldrassil", "Soft Saber Sack", 6, "Soft Saber Pelts", "A", 4, "Night Elf start. Aldia.", 55.4, 57.2)
BagQ("tirisfal", "Collecting Basket", 6, "Sticks and Bones", "H", 4, "Undead start. Deathguard Bartholomew.", 58.4, 51.4)
BagQ("durotar", "Handmade Leather Bag", 6, "Carry Your Weight", "H", 4, "Orc and Troll start. Furl Scornbrow.", 49.8, 40.4)
BagQ("mulgore", "Scorched Leather Pouch", 6, "Grace of An'she and Mu'sha", "H", 1, "Tauren start. Seer Graytongue at Camp Narache.")
BagQ("zephras", "Simple Leather Satchel", 6, "The Problem With Prideclaws", nil, 4, "Zephras Isle start. Indari Sunseam (44.6, 44.4).")
-- early quest bags (6 to 10 slots)
BagQ("westfall", "Old Blanchy's Feed Pouch", 8, "Poor Old Blanchy", nil, 8, "Very early in Westfall.")
BagQ("westfall", "Captain Sander's Booty Bag", 8, "Captain Sander's Hidden Treasure", nil, 10, "A murloc-dropped map and four clues lead to Captain Sander's Locker. Bind on pickup, unique.")
BagQ("duskwood", "Wizbang's Gunnysack", 8, "Buzzbox 525", nil, 15, "Darkshire. Unique.")
BagQ("barrens", "Scuffed Shipping Crate", 8, "Parts and Pieces", nil, 10, "Bind on pickup.")
BagQ("barrens", "Old Moneybag", 6, "Miner's Fortune", nil, 10, "Unique.")
BagQ("duskwood", "Shipwright's Satchel", 6, "Making Do", "A", 20, "Darkshire. A reagent bag.")
BagQ("wetlands", "Ooze-covered Bag", 10, "Digging Through the Ooze", nil, 20)
BagQ("barrens", "Deviate Hide Pack", 10, "Deviate Hides", nil, 17, "Handed in from the Wailing Caverns hides.")
BagQ("lochmodan", "Hunting Satchel", 10, "Vyrin's Revenge", nil, 12, "Hunters also get an ammo sack or quiver from this quest.")
BagQ("duskwood", "Gunnysack of the Night Watch", 10, "The Night Watch", nil, 20, "Hunters can take the Bandolier or Quiver of the Night Watch instead.")
BagQ("teldrassil", "Ban'ethil Quiver", 10, "Escaping Ban'ethil", "A", 9, "Bind on pickup. A quiver, so it is for hunters.", nil, nil, { class = "HUNTER" })
BagQ(nil, "Jewelry Box", 6, "Blueleaf Tubers", nil, 30, "Razorfen Kraul. Unique.")
-- 12 slots and up
BagQ("mulgore", "Spidersilk Pouch", 12, "Stronger than Steel", "H", 30, "You can take a Spidersilk Sack (10-slot reagent bag) instead.")
BagQ("ironforge", "Thawpelt Sack", 14, "The Platinum Discs", "A", 30, "Handed in at Ironforge for the Alliance.")
BagQ("thunderbluff", "Thawpelt Sack", 14, "The Platinum Discs", "H", 30, "The same bag as the Ironforge one.")
BagQ("stv", "Explorer's Knapsack", 14, "Cortello's Riddle", nil, 35)
BagQ("blasted", "Demon Hide Sack", 16, "You Are Rakh'likh, Demon", nil, 48)
BagQ("tanaris", "Red Bag", 16, "Beach Bot", nil, 40, "Unique.")
BagQ("hyjal", "Hyjal Postal Satchel", 18, "Top of the Post", nil, 50)
BagQ("hyjal", "Barkskin Satchel", 18, nil, nil, 50, "Bought from Dala Fairmaw once you are Honored with Barkskin Burrow. Bind on pickup, unique.")
BagQ(nil, "Darkmoon Storage Box", 14, nil, nil, 30, "Bought at the Darkmoon Faire for 50 Darkmoon Prize Tickets. Unique.")
BagQ("riverglades", "Matriarch Quiver", 14, "A Hunter's Quiver", nil, 40, "A quiver, so it is for hunters.", nil, nil, { class = "HUNTER" })
BagQ(nil, "Onyxia Hide Backpack", 18, nil, nil, 60, "Drops from Onyxia.")
BagQ(nil, "Wayfarer's Knapsack", 16, nil, nil, 55, "Drops from Ribbly Screwspigot in Blackrock Depths. Unique.")

---------------------------------------------------------------------------
-- Gear and perks: secrets and rewards that help you play (many are tied to a class)
---------------------------------------------------------------------------
local function Perk(name, note, zone, x, y, extra)
    local t = { cat = "perk", name = name, note = note, zone = zone, x = x, y = y }
    if extra then for k, v in pairs(extra) do t[k] = v end end
    add(t)
end
Perk("Night Watchman's Torch", "Take it from the fallen watchman on the main road in Duskwood. It gives light from your bags.", "duskwood", nil, nil, { item = "Night Watchman's Torch", lvl = 20 })
Perk("Coldflame Saber (Mage)", "Shadowfang Keep: combine the Blade of Silverlaine with the Scroll of the Saber. +7 Intellect and 32 spell power. Still being worked out by players.", nil, nil, nil, { class = "MAGE", lvl = 22, item = "Coldflame Saber" })
Perk("Wolfsbane (Horde Paladin)", "A 13-step chain that starts in Tirisfal Glades, runs through two dungeons and ends at Old Fire-Eye on the Blackfathom coast. Reward: a two-hand sword.", "tirisfal", nil, nil, { class = "PALADIN", fac = "H", lvl = 18 })
Perk("Ruins of Lordaeron bosses", "Summon them at the glowing knight statue. Viktor comes from a ruined house fireplace. Caster gear and the Scepter of the Abandoned.", nil, nil, nil, { lvl = 15 })
Perk("Thunder Applejack", "Alliance. Find four Shiny Red Apples and the unmarked still in Elwynn Forest.", "elwynn", nil, nil, { fac = "A", item = "Thunder Applejack" })
Perk("Whispering Horror (XP)", "Hidden quest. A Whispering Horror drops in Tirisfal Glades; hand it in for experience.", "tirisfal", nil, nil, { lvl = 5 })
Perk("Malignant Root", "Hidden quest. Rotheap Innards come from the Nightveiled Rotheap in the Wetlands. Reward: a ring.", "wetlands", nil, nil, { lvl = 20, item = "Malignant Root" })
Perk("Graverobber's Shovel and Rockslicer", "Level 20s dungeons. The shovel digs graves; the Rockslicer mines 30 veins. How to start is still unknown.", nil, nil, nil, { lvl = 20 })
Perk("The Bloody Map", "Horde, level 31. Track the Dragonmaw from Hammerfall to the Excavation Site in the Wetlands. You get the map and a gear choice.", "arathi", nil, nil, { fac = "H", lvl = 31 })
Perk("Partners in Crime", "The Deadmines. First Mate Band comes from Mr. Smite and starts a two-ring set (+22 Strength). The level 60 ring is not found yet.", nil, nil, nil, { lvl = 18 })
Perk("Drunken Dwarf Tavern", "Climb the mountain to the tavern in Dun Algaz. Food and Aetherstill Spirits; the cellar is not solved yet.", "dunmorogh")
Perk("Brother Zendraas", "Zephras Isle, Shrine of Akir vendor. 24 Al'Aketh armor pieces for Windstones. Players say it has been missing since the October 10 beta build.", "zephras")
