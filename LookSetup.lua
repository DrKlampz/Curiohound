local ADDON_NAME, ns = ...
-- Customization (see Look.lua). Opens from the minimap button (Alt-click) or /curiohound options.
if not ns.WinLook then return end

local function Options()
    local L = ns.WinLook
    local db = function() return ns.db end
    local mmdb = function() return ns.db.minimap end
    local function live() if ns.Pins then ns.Pins.Refresh() end if ns.UI then ns.UI.Refresh() end end
    local function relayout() if ns.UI then ns.UI.ApplyLook() ns.UI.Refresh() end end
    local catChoices = {}
    for _, c in ipairs(ns.UI.CATS) do catChoices[#catChoices + 1] = { c.id, c.name } end
    return { sections = {
        { id = "tracker", title = "Tracker (live steps and distance)", open = true, rows = {
            L.Kon("Show the tracker", db, "tracker", live),
            L.Slider("Things shown in the tracker", db, "trackerRows", 1, 10, 1, nil, live),
            L.Choice("Order", db, "trackerOrder", { { "distance", "Nearest first" }, { "list", "Guide order" } }, live),
            L.Kon("Show the steps still to come under the Sleeping Bag", db, "trackerSteps", live),
            L.Kon("Show travel advice (zeppelin, boat, flight master)", db, "trackerTravel", live),
            L.Kon("Show distance in yards", db, "trackerDistance", live),
            L.Kon("Show the progress bars (solid = done, lighter = in hand, like rested XP)", db, "trackerBar", live),
            L.Kon("Hide the tracker while nothing is pursued", db, "trackerHideEmpty", live),
            L.Color("Progress bar: finished", db, "barColor", { 0.58, 0.1, 0.62 }, live),
            L.Color("Progress bar: in hand but not handed in", db, "restColor", { 0.1, 0.45, 0.95 }, live),
            L.Note("Click a tracker line to make it the active target. Right-click stops tracking it. The tracker's own look is in the Tracker tab."),
        } },
        { id = "pins", title = "Map and minimap pins", open = true, rows = {
            L.Kon("Pins on the world map", db, "worldPins", live),
            L.Kon("Pins on the minimap", db, "miniPins", live),
            L.Choice("Which pins", db, "pinScope", { { "pursued", "Only what I pursue" }, { "zone", "Everything missing in this zone" }, { "all", "Everything missing, everywhere" } }, live),
            L.Slider("World map pin size", db, "pinSize", 12, 48, 1, nil, live),
            L.Slider("Minimap pin size", db, "miniPinSize", 8, 32, 1, nil, live),
            L.Kon("Put names under world map pins", db, "pinLabels", live),
            L.Kon("Pins past the minimap edge stay on the rim as direction markers", db, "edgePins", live),
            L.Kon("Pulse the glow on the active target", db, "pinPulse", live),
            L.Color("Active target color", db, "activeColor", { 1, 0.82, 0.1 }, live),
            L.Color("Pin tint (white = none)", db, "pinColor", { 1, 1, 1 }, live),
        } },
        { id = "target", title = "Active target and waypoint", rows = {
            L.Kon("Pick the nearest pursued thing automatically", db, "autoNearest", live),
            L.Kon("Point the waypoint arrow at the active target", db, "autoWaypoint", live),
            L.Choice("Waypoint type", db, "waypoint", { { "blizzard", "Game waypoint arrow" }, { "tomtom", "TomTom" }, { "both", "Both" }, { "none", "None" } }),
            L.Note("Without the automatic pick, click a line in the list or tracker to choose the active target."),
        } },
        { id = "list", title = "List", rows = {
            L.Choice("Start on", db, "cat", catChoices, live),
            L.Choice("Sort by", db, "sort", { { "list", "Guide order" }, { "zone", "This zone first" }, { "level", "Level" }, { "distance", "Nearest first" } }, live),
            L.Slider("Rows shown", db, "listRows", 5, 24, 1, nil, relayout),
            L.Choice("Show things for", db, "factionFilter", { { "mine", "My faction only" }, { "all", "Both factions" } }, live),
            L.Koff("Hide things well above my level", db, "hideTooHigh", live),
            L.Slider("...how many levels above counts as well above", db, "levelGap", 1, 30, 1, nil, live),
            L.Koff("Hide what I have finished", db, "hideDone", live),
            L.Koff("Only this zone", db, "thisZoneOnly", live),
            L.Kon("Show coordinates", db, "showCoords", live),
            L.Kon("Show the hints (where to look, what to click)", db, "showHints", live),
            L.Kon("Show the minimap button", mmdb, "show", function() if ns.UI then ns.UI.UpdateMinimap() end end),
        } },
        { id = "notices", title = "Notices", rows = {
            L.Kon("Chat line when I pick something up or finish a step", db, "noticePickup"),
            L.Kon("Chat line when I enter a zone with things I pursue", db, "noticeZone"),
            L.Kon("Small sound when a step is finished", db, "noticeSound"),
            L.Kon("Remind me about books in my bags when I meet a librarian", db, "noticeLibrarian"),
            L.Note("Books and items are noticed in your bags, quest steps from your quest log, pets from your companion list. Anything can also be ticked by hand."),
        } },
    } }
end

ns.WinLook.Setup({
    options = Options,
    title = "Curiohound",
    slash = "curiohoundlook",
    syncDefault = false,
    media = "Interface\\AddOns\\Curiohound\\Media\\",
    db = function() return CuriohoundDB end,
    windows = {
        { id = "main", name = "List window", global = "CuriohoundFrame", strip = "backdrop", defaultOn = true, title = function(f) return f.titleFS end },
        { id = "tracker", name = "Tracker", global = "CuriohoundTracker", strip = "backdrop", defaultOn = true, title = function(f) return f.titleFS end },
    },
})
