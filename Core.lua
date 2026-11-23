-- Whatnot: tracks the things worth collecting (library books, the Cozy Sleeping Bag, pets, secrets) and
-- points you at the ones you choose to chase. Core.lua = saved settings and helpers. Data.lua = the list,
-- Track.lua = what you have and what to do next, Pins.lua = map and minimap pins, UI.lua = what you see.
local ADDON_NAME, ns = ...
ns.name = ADDON_NAME
function ns.IsSecret(v) return issecretvalue ~= nil and issecretvalue(v) end
function ns.Print(msg) print("|cff66ddffWhatnot:|r " .. tostring(msg)) end
ns.ICON = "Interface\\Icons\\INV_Misc_Book_09"

ns.DEFAULTS = {
    -- list
    cat = "pursuing",          -- pursuing, all, book, bag, pet, secret, custom
    sort = "list",             -- list, zone, level, distance
    hideDone = false,
    thisZoneOnly = false,
    factionFilter = "mine",    -- mine = hide the other faction's things, all = show everything
    hideTooHigh = false,       -- hide things above my level + levelGap
    levelGap = 10,
    listRows = 12,
    showCoords = true,
    showHints = true,
    -- tracker
    tracker = true,
    trackerRows = 5,
    trackerOrder = "distance", -- distance or list
    trackerTravel = true,      -- show boat / zeppelin / flight master advice on the tracker
    trackerSteps = true,       -- show the steps still to do under a chain
    trackerBar = true,         -- rested-XP-style progress bar
    trackerDistance = true,
    trackerHideEmpty = true,   -- hide the tracker when nothing is pursued
    trackerHideOnMap = true,   -- hide the tracker while the world map is open
    trackerPos = nil,
    barColor = { 0.58, 0.1, 0.62 },   -- finished part of the progress bar
    restColor = { 0.1, 0.45, 0.95 }, -- the part you hold but have not turned in yet (like rested XP)
    -- map pins
    worldPins = true,
    miniPins = true,
    pinScope = "pursued",      -- pursued, zone (all missing in the zone), all
    pinSize = 22,
    miniPinSize = 14,
    pinLabels = false,
    pinColor = nil,            -- tint colour { r, g, b }
    activeColor = { 1, 0.82, 0.1 },
    pinPulse = true,
    edgePins = true,           -- pins past the minimap edge stick to the rim as direction markers
    -- waypoint
    autoWaypoint = true,       -- point the Blizzard waypoint arrow at the active target
    waypoint = "blizzard",     -- blizzard, tomtom, both, none
    autoNearest = true,        -- the active target is the nearest pursued one
    -- notices
    noticePickup = true,       -- chat line when a tracked thing is picked up or finished
    noticeZone = true,         -- chat line when you enter a zone that has pursued things
    noticeSound = true,        -- small sound when a step is finished
    noticeLibrarian = true,    -- remind me about books in my bags at the librarian
    pos = nil,
    minimap = { show = true, angle = 150 },
    custom = {},               -- { { key = "cu:1", name = "..." }, ... }
    nextCustom = 1,
    chars = {},                -- chars[name-realm] = { s = { [key] = 1 have / 2 done }, p = { [key] = true } }
}

local function Merge(dst, src)
    for k, v in pairs(src) do
        if type(v) == "table" then
            if type(dst[k]) ~= "table" then dst[k] = {} end
            if next(v) ~= nil then Merge(dst[k], v) end
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
    return dst
end

local hooks = {}
function ns.AddHook(name, fn) hooks[name] = hooks[name] or {} table.insert(hooks[name], fn) end
function ns.Fire(name, ...)
    for _, fn in ipairs(hooks[name] or {}) do
        local ok, err = pcall(fn, ...)
        if not ok then
            if ns.Issue then pcall(ns.Issue, "lua", name, tostring(err)) end
            ns.Print("|cffff5555error in " .. name .. ":|r " .. tostring(err))
        end
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function(_, event, arg)
    if event == "ADDON_LOADED" and arg == ADDON_NAME then
        WhatnotDB = WhatnotDB or {}
        ns.db = Merge(WhatnotDB, ns.DEFAULTS)
    elseif event == "PLAYER_LOGIN" then
        ns.Fire("login")
    end
end)

function Whatnot_OnAddonCompartmentClick() if ns.UI then ns.UI.Toggle() end end
