-- Pins.lua: pins on the world map and the minimap, and the live "what am I chasing" state they share with the tracker.
local ADDON_NAME, ns = ...
local P = {}
ns.Pins = P
local T = ns.T

local ICONS = {
    book = "Interface\\Icons\\INV_Misc_Book_09",
    bag = "Interface\\Icons\\INV_Misc_Bag_09",
    pet = "Interface\\Icons\\INV_Box_PetCarrier_01",
    secret = "Interface\\Icons\\INV_Misc_Note_01",
    custom = "Interface\\Icons\\INV_Misc_Gem_Variety_01",
}
P.ICONS = ICONS
local GLOW = "Interface\\Buttons\\UI-ActionButton-Border"

-- live state, refreshed twice a second and on every change
P.live = { list = {}, pins = {}, active = nil }

local function BuildPins(pm)
    local out = {}
    local scope = ns.db.pinScope
    local active, pursuits = T.Active()
    local isPursued = {}
    for _, e in ipairs(pursuits) do isPursued[e.key] = e end
    local seen = {}
    local function Add(e, pursued)
        local t = T.Target(e)
        if not (t and t.map and t.x) then return end
        local id = e.key .. ":" .. tostring(t.map) .. ":" .. tostring(t.x)
        if seen[id] then return end
        seen[id] = true
        out[#out + 1] = { e = e, t = t, pursued = pursued, active = (active and active.key == e.key) and true or false }
    end
    for _, e in ipairs(pursuits) do Add(e, true) end
    if scope == "zone" or scope == "all" then
        for _, e in ipairs(T.all) do
            if T.State(e.key) < 2 and T.FactionOK(e) and not isPursued[e.key] and (scope == "all" or (pm and e.map == pm)) then
                Add(e, T.Pursued(e.key))
            end
        end
    end
    return out, active, pursuits
end

function P.Update()
    if not ns.db then return end
    local pm, px, py = T.PlayerPos()
    local pins, active, pursuits = BuildPins(pm)
    local L = P.live
    L.pm, L.px, L.py = pm, px, py
    L.pins, L.active, L.list = pins, active, pursuits
    L.at = GetTime()
    -- keep the Blizzard waypoint on the active target
    local key = active and active.key
    if key ~= L.lastKey or (active and T.State(key) ~= L.lastState) then
        L.lastKey = key
        L.lastState = active and T.State(key) or nil
        if active and ns.db.autoWaypoint then T.SetWaypoint(active, true) end
        if not active and L.hadWaypoint then T.ClearWaypoint() end
        L.hadWaypoint = active ~= nil and ns.db.autoWaypoint
    end
    return L
end

local function Tint(tex, pin)
    local c = ns.db.pinColor
    if pin.active then
        local a = ns.db.activeColor or { 1, 0.82, 0.1 }
        return a[1], a[2], a[3]
    end
    if c and c[1] then return c[1], c[2], c[3] end
    return 1, 1, 1
end

local function Tooltip(self)
    local p = self.pin
    if not p then return end
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(p.e.name, 1, 0.82, 0)
    if p.t.zone then GameTooltip:AddLine(T.Where({ zoneName = p.t.zone, x = p.t.x, y = p.t.y }), 0.8, 0.8, 0.8) end
    GameTooltip:AddLine(p.t.text, 1, 1, 1, true)
    local d = T.Distance(p.e)
    if d then GameTooltip:AddLine(("%d yards away"):format(math.floor(d + 0.5)), 0.5, 1, 0.5) end
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine("Left-click: track or stop tracking.", 0.7, 0.7, 0.7)
    GameTooltip:AddLine("Right-click: make it the active target (waypoint).", 0.7, 0.7, 0.7)
    GameTooltip:Show()
end

local function PinClick(self, btn)
    local p = self.pin
    if not p then return end
    if btn == "RightButton" then
        T.manualKey = p.e.key
        T.SetWaypoint(p.e)
        P.Refresh()
    else
        T.TogglePursued(p.e.key)
    end
end

local function NewPin(parent, pool)
    local b = CreateFrame("Button", nil, parent)
    b:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    b.glow = b:CreateTexture(nil, "OVERLAY")
    b.glow:SetTexture(GLOW)
    b.glow:SetBlendMode("ADD")
    b.glow:SetPoint("CENTER")
    b.glow:Hide()
    b.tex = b:CreateTexture(nil, "ARTWORK")
    b.tex:SetAllPoints()
    b.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    b.label = b:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    b.label:SetPoint("TOP", b, "BOTTOM", 0, -1)
    b:SetScript("OnEnter", Tooltip)
    b:SetScript("OnLeave", function() GameTooltip:Hide() end)
    b:SetScript("OnClick", PinClick)
    pool[#pool + 1] = b
    return b
end

local function Style(b, pin, size, labels)
    b.pin = pin
    b:SetSize(size, size)
    b.tex:SetTexture(ICONS[pin.e.cat] or ICONS.custom)
    local r, g, bl = Tint(b.tex, pin)
    b.tex:SetVertexColor(pin.active and 1 or r, pin.active and 1 or g, pin.active and 1 or bl)
    if pin.active then
        local ar, ag, ab = Tint(nil, pin)
        b.glow:SetVertexColor(ar, ag, ab)
        b.glow:SetSize(size * 1.9, size * 1.9)
        b.glow:Show()
    else
        b.glow:Hide()
    end
    if labels then b.label:SetText(pin.e.name) b.label:Show() else b.label:Hide() end
    b:Show()
end

---------------------------------------------------------------------------
-- World map
---------------------------------------------------------------------------
local worldPool = {}
local function Canvas()
    if not WorldMapFrame then return nil end
    if WorldMapFrame.GetCanvas then return WorldMapFrame:GetCanvas() end
    return WorldMapFrame.ScrollContainer and WorldMapFrame.ScrollContainer.Child
end

function P.RefreshWorld()
    for _, b in ipairs(worldPool) do b:Hide() end
    if not ns.db or not ns.db.worldPins then return end
    if not (WorldMapFrame and WorldMapFrame:IsShown()) then return end
    local canvas = Canvas()
    if not canvas then return end
    local map = WorldMapFrame.GetMapID and WorldMapFrame:GetMapID()
    if not map then return end
    local w, h = canvas:GetWidth(), canvas:GetHeight()
    if not w or w <= 0 then return end
    local n = 0
    local lvl = (canvas.GetFrameLevel and canvas:GetFrameLevel() or 1) + 60
    for _, pin in ipairs(P.live.pins) do
        if pin.t.map == map then
            n = n + 1
            local b = worldPool[n] or NewPin(canvas, worldPool)
            if b:GetParent() ~= canvas then b:SetParent(canvas) end
            b:SetFrameLevel(lvl)
            Style(b, pin, ns.db.pinSize or 22, ns.db.pinLabels)
            b:ClearAllPoints()
            b:SetPoint("CENTER", canvas, "TOPLEFT", pin.t.x / 100 * w, -pin.t.y / 100 * h)
        end
    end
end

---------------------------------------------------------------------------
-- Minimap
---------------------------------------------------------------------------
local miniPool = {}
local OUT = { [0] = 466.67, 400, 333.33, 266.67, 200, 133.33 }
local IN = { [0] = 300, 240, 180, 120, 80, 50 }

local function MiniRadiusYards()
    local z = Minimap.GetZoom and Minimap:GetZoom() or 0
    local indoors = false
    if IsIndoors then local ok, v = pcall(IsIndoors) indoors = ok and v end
    local tbl = indoors and IN or OUT
    return (tbl[z] or tbl[0]) / 2
end

function P.RefreshMini()
    for _, b in ipairs(miniPool) do b:Hide() end
    if not ns.db or not ns.db.miniPins or not Minimap then return end
    local L = P.live
    if not L.pm then return end
    local ry = MiniRadiusYards()
    local rpx = (Minimap:GetWidth() or 140) / 2
    local rotate = GetCVar and GetCVar("rotateMinimap") == "1"
    local facing = rotate and GetPlayerFacing and GetPlayerFacing() or nil
    local square = GetMinimapShape and GetMinimapShape() == "SQUARE"
    local n = 0
    for _, pin in ipairs(L.pins) do
        if pin.t.map == L.pm then
            local dx, dy = T.Offset(pin.t.map, pin.t.x, pin.t.y, L.pm, L.px, L.py)
            if dx then
                local ox, oy
                if facing then
                    local c, s = math.cos(facing), math.sin(facing)
                    ox, oy = dx * c + dy * s, -dx * s + dy * c
                else
                    ox, oy = dx, dy
                end
                ox, oy = ox / ry * rpx, oy / ry * rpx
                local edge = rpx - 4
                local outside
                if square then
                    local m = math.max(math.abs(ox), math.abs(oy))
                    outside = m > edge
                    if outside then ox, oy = ox * edge / m, oy * edge / m end
                else
                    local d = math.sqrt(ox * ox + oy * oy)
                    outside = d > edge
                    if outside and d > 0 then ox, oy = ox * edge / d, oy * edge / d end
                end
                if not outside or ns.db.edgePins then
                    n = n + 1
                    local b = miniPool[n] or NewPin(Minimap, miniPool)
                    b:SetFrameStrata("HIGH")
                    Style(b, pin, ns.db.miniPinSize or 14, false)
                    b:SetAlpha(outside and 0.75 or 1)
                    b:ClearAllPoints()
                    b:SetPoint("CENTER", Minimap, "CENTER", ox, oy)
                end
            end
        end
    end
end

function P.Refresh()
    P.Update()
    P.RefreshWorld()
    P.RefreshMini()
    ns.Fire("live")
end

---------------------------------------------------------------------------
-- One ticker for everything live
---------------------------------------------------------------------------
local tick = CreateFrame("Frame")
local acc, pulse = 0, 0
tick:SetScript("OnUpdate", function(_, dt)
    if not ns.db then return end
    pulse = pulse + dt
    -- the glow around the active pin breathes
    if ns.db.pinPulse then
        local a = 0.55 + 0.45 * math.sin(pulse * 4)
        for _, pool in ipairs({ worldPool, miniPool }) do
            for _, b in ipairs(pool) do if b:IsShown() and b.glow:IsShown() then b.glow:SetAlpha(a) end end
        end
    end
    acc = acc + dt
    if acc < 0.5 then return end
    acc = 0
    P.Refresh()
end)

local hooked
local function HookMap()
    if hooked or not WorldMapFrame then return end
    hooked = true
    WorldMapFrame:HookScript("OnShow", function() P.RefreshWorld() end)
    pcall(hooksecurefunc, WorldMapFrame, "OnMapChanged", function() P.RefreshWorld() end)
end

ns.AddHook("login", function()
    HookMap()
    P.Refresh()
end)
ns.AddHook("changed", function() P.Refresh() end)
ns.AddHook("pursuit", function() P.Refresh() end)
local ld = CreateFrame("Frame")
ld:RegisterEvent("ADDON_LOADED")
ld:SetScript("OnEvent", function(_, _, name) if name == "Blizzard_WorldMap" then HookMap() end end)
