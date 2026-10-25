local GladiusEx = _G.GladiusEx
local L = LibStub("AceLocale-3.0"):GetLocale("GladiusEx")
local fn = LibStub("LibFunctional-1.0")
local timer

-- V: heavily inspired by Jaxington's Gladius-With-Interrupts
-- K: Improved

local defaults = {
	interruptPrio = GladiusEx.IS_MOPC and 9.1 or 3.0,
}

local Interrupt = GladiusEx:NewGladiusExModule("Interrupts", defaults, defaults)

local INTERRUPTS = GladiusEx.Data.Interrupts()

local CLASS_INTERRUPT_MODIFIERS = GladiusEx.Data.InterruptModifiers()
local schoolArt = {
    [1]="Ability_meleedamage", [2]="Spell_holy_holybolt",
    [4]="Spell_fire_selfdestruct", [8]="Spell_nature_protectionformnature",
    [16]="Spell_frost_icestorm", [32]="Spell_shadow_antishadow",
    [64]="Spell_nature_wispsplode", [28]="Shaman_talent_elementalblast",
    [124]="Ability_warlock_chaosbolt",
}
local schoolIDs = {1, 2, 4, 8, 16, 32, 64, 28, 124}

function Interrupt:OnEnable()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

	if not self.frame then
		self.frame = {}
	end
	self.interrupts = {}
	self.schoolLockouts = {}
end

function Interrupt:OnDisable()
	self:UnregisterAllEvents()
	for unit in pairs(self.frame) do
		self.frame[unit]:SetAlpha(0)
	end
end

function Interrupt:COMBAT_LOG_EVENT_UNFILTERED(event)
	Interrupt:CombatLogEvent(event, CombatLogGetCurrentEventInfo())
end

function Interrupt:CombatLogEvent(_, ...)
	local subEvent = select(2, ...)
	local destGUID = select(8, ...)
	local spellID = select(12, ...)

	local unit = GladiusEx:GetUnitIdByGUID(destGUID)
	if not unit then return end

	-- Only a confirmed SPELL_INTERRUPT starts a school-lockout indicator.
	if subEvent ~= "SPELL_INTERRUPT" then return end
	if INTERRUPTS[spellID] == nil then return end
	local duration = INTERRUPTS[spellID].duration
	if not duration then return end
	local button = GladiusEx.buttons[unit]
	if not button then return end

	local _, _, class = UnitClass(unit)
	if class == 7 then -- Shaman
		for buff, mult in ipairs(CLASS_INTERRUPT_MODIFIERS) do
			if AuraUtil.FindAuraByName(buff, unit, "HELPFUL") then
				duration = duration * mult
			end
		end
	end
	if GladiusEx.IS_MOPC then
		local school = select(17, ...)
		if type(school) == "number" and school > 0 then
			local list = self.schoolLockouts[unit] or {}
			self.schoolLockouts[unit] = list
			table.insert(list, {guid = destGUID, school = school, expires = GetTime() + duration})
		end
	end
	self:UpdateInterrupt(unit, spellID, duration)

end

function Interrupt:UpdateInterrupt(unit, spellid, duration, oldTime)
	local t = GetTime()
	if spellid and duration then
		self.interrupts[unit] = {spellid, t, duration}
	elseif oldTime then
		-- Clear only the interrupt that scheduled this callback, never a newer one.
		local active = self.interrupts and self.interrupts[unit]
		if not active or active[2] ~= oldTime then return end
		self.interrupts[unit] = nil
	end

	self:SendMessage("GLADIUSEX_INTERRUPT", unit)

	if oldTime or duration == nil then return end -- avoid triggering the c_timer again

	-- K: Clears the interrupt after end of duration (in case no new UNIT_AURA ticks clears it)
	C_Timer.After(
		duration + 0.1,
		function()
			self:UpdateInterrupt(unit, spellid, nil, t)
		end
	)
end

function Interrupt:GetInterruptFor(unit)
	local int = self.interrupts and self.interrupts[unit]
	if not int then return end

	local spellid, startedAt, duration = unpack(int)
	local endsAt = startedAt + duration
	if GetTime() > endsAt then
		self.interrupts[unit] = nil
	else

	local name, icon = nil

	if C_Spell and C_Spell.GetSpellTexture then
		name = C_Spell.GetSpellName(spellid)
		icon = C_Spell.GetSpellTexture(spellid)
	else
		name, _, icon = GetSpellInfo(spellid)
	end
		return name, icon, duration, endsAt, self.db[unit].interruptPrio
	end
end

-- School locks are taken from SPELL_INTERRUPT.extraSchool, not the interrupter.
function Interrupt:UpdateSchoolIcons(unit, frame, visible)
    if not frame or not GladiusEx.IS_MOPC then return end
    local icons = frame.lockoutSchoolIcons
    if icons then for _, icon in pairs(icons) do icon:Hide() end end
    if not visible or not self.schoolLockouts then return end
    local list = self.schoolLockouts[unit]
    if not list then return end
    local expiry, now, guid = {}, GetTime(), UnitGUID(unit)
    for i = #list, 1, -1 do
        local lock = list[i]
        if lock.guid ~= guid or lock.expires <= now then
            table.remove(list, i)
        else
            for _, mask in ipairs(schoolIDs) do
                if bit.band(lock.school, mask) == mask then
                    expiry[mask] = math.max(expiry[mask] or 0, lock.expires)
                end
            end
        end
    end
    if #list == 0 then self.schoolLockouts[unit] = nil end
    for _, combo in ipairs({124, 28}) do
        if expiry[combo] then
            for _, mask in ipairs(schoolIDs) do
                if mask ~= combo and bit.band(combo, mask) == mask
                    and expiry[mask] and expiry[mask] <= expiry[combo] then
                    expiry[mask] = nil
                end
            end
        end
    end
    local sorted = {}
    for mask, untilTime in pairs(expiry) do
        table.insert(sorted, {mask, untilTime})
    end
    table.sort(sorted, function(a, b)
        if a[2] == b[2] then return a[1] < b[1] end
        return a[2] > b[2]
    end)
    if #sorted == 0 then return end
    if not icons then icons = {}; frame.lockoutSchoolIcons = icons end
    -- One school occupies the exact bottom-right 50% x 50% quadrant.
    -- Use a 3x3 grid only when more than four schools need showing.
    local columns = #sorted > 4 and 3 or 2
    local width, height = frame:GetWidth() / columns, frame:GetHeight() / columns
    for n, entry in ipairs(sorted) do
        local mask = entry[1]
        local icon = icons[mask]
        if not icon then
            icon = frame:CreateTexture(nil, "OVERLAY", nil, 7)
            icon:SetTexture("Interface\\Icons\\" .. schoolArt[mask])
            icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
            icons[mask] = icon
        end
        icon:ClearAllPoints()
        icon:SetSize(width, height)
        icon:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",
            -((n - 1) % columns) * width,
            math.floor((n - 1) / columns) * height)
        icon:Show()
    end
end

function Interrupt:GetOptions(unit)
	-- TODO: enable/disable INTERRUPT_SPEC_MODIFIER, since they are talents, we're just guessing
	return {
		general = {
			type = "group",
			name = L["General"],
			order = 1,
			args = {
				sep2 = {
					type = "description",
					name = "This module shows interrupt durations over the Arena Enemy Class Icons when they are interrupted.",
					width = "full",
					order = 17,
				},
				interruptPrio = {
					type = "range",
					name = "InterruptPrio",
					desc = "Sets the priority of interrupts (as compared to regular Class Icon auras)",
					disabled = function() return not self:IsUnitEnabled(unit) end,
					softMin = 0.0, softMax = 10, step = 0.1,
					order = 19,
				},
			},
		},
	}
end
