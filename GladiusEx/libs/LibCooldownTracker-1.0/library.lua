--[[
	Callbacks:
		LCT_CooldownUsed(unitid, spellid)
		LCT_CooldownsReset(unit)

	Functions:
		lib:RegisterUnit(unitid)
		lib:UnregisterUnit(unitid)
		tpu = lib:GetUnitCooldownInfo(unitid, spellid, used_start, used_end, cooldown_start)
		for spellid, spell_data in lib:IterateCooldowns(class, specID, race) do
		spell_data = lib:GetCooldownData(spellid)
		spells_data = lib:GetCooldownsData()
]]

local version = 15
local lib = LibStub:NewLibrary("LibCooldownTracker-1.0", version)
local IsRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
local LGIST = IsRetail and LibStub:GetLibrary("LibGroupInSpecT-1.1")
local fn = LibStub("LibFunctional-1.0")

local keys, map, filter, any = fn.keys, fn.map, fn.filter, fn.any

if not lib then return end

-- upvalues
local pairs, type, next, select, assert, unpack = pairs, type, next, select, assert, unpack
local tinsert, tremove = table.insert, table.remove
local GetTime, UnitGUID, IsInInstance = GetTime, UnitGUID, IsInInstance

lib.frame = lib.frame or CreateFrame("Frame")
lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

-- init event handler
local events = {}
do
	lib.frame:SetScript("OnEvent",
		function(self, event, ...)
			return events[event](lib, event, ...)
		end)
end

-- lookup tables
local class_spelldata = {}
local race_spelldata = {}
local item_spelldata = {}
local pvp_spelldata = {}
local universal_spelldata = {}

-- generate lookup tables
do
	for spellid, spelldata in pairs(LCT_SpellData) do
		if type(spelldata) == "table" then
			local name, icon

			if C_Spell and C_Spell.GetSpellInfo then
				local spellInfoTable = C_Spell.GetSpellInfo(spellid)
				if spellInfoTable then
					name = spellInfoTable.name
					icon = spellInfoTable.iconID
				end
			else
				name, _, icon = GetSpellInfo(spellid)
			end

			if not name then
				DEFAULT_CHAT_FRAME:AddMessage("LibCooldownTracker-1.0: bad spellid for " .. (spelldata.class or spelldata.race or "ITEM") .. ": " .. spellid)
				LCT_SpellData[spellid] = nil
			else
				-- add name and icon
				spelldata.name = name
				if not spelldata.icon then
					if type(spelldata.item) == 'number' then
						spelldata.icon = GetItemIcon(spelldata.item)
					else
						spelldata.icon = icon
					end
				end

				-- add required aura name
				if spelldata.requires_aura then
					if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
						local spellIconTable = C_Spell.GetSpellInfo(spelldata.requires_aura)
						spelldata.requires_aura_name = spellIconTable.name
					else
						spelldata.requires_aura_name = GetSpellInfo(spelldata.requires_aura)
					end
					if not spelldata.requires_aura_name then
						DEFAULT_CHAT_FRAME:AddMessage("LibCooldownTracker-1.0: bad aura spellid: " .. spelldata.requires_aura)
					end
				end

				-- convert specID list into lookups table
				if spelldata.specID then
					local specs = {}
					for i = 1, #spelldata.specID do
						specs[spelldata.specID[i]] = true
					end
					spelldata.specID_table = specs
				end

				-- insert into lookup tables
				if spelldata.class and not spelldata.hidden then
					class_spelldata[spelldata.class] = class_spelldata[spelldata.class] or {}
					class_spelldata[spelldata.class][spellid] = spelldata
				end
				if spelldata.universal and not spelldata.hidden then
					universal_spelldata[spellid] = spelldata
				end
				if spelldata.race then
					race_spelldata[spelldata.race] = race_spelldata[spelldata.race] or {}
					race_spelldata[spelldata.race][spellid] = spelldata
				end
				if spelldata.item then
					item_spelldata[spellid] = spelldata
				end
				if spelldata.pvp_trinket then
					pvp_spelldata[spellid] = spelldata
				end
			end
		end
	end
end

local SpellData = LCT_SpellData
local SpellAliases = LCT_SpellAliases or {}
local SymbiosisData = LCT_SymbiosisData or {}
LCT_SpellData = nil
LCT_SpellAliases = nil
LCT_SymbiosisData = nil

-- state
lib.guid_to_unitid = lib.guid_to_unitid or {} -- [guid] = unitid
lib.tracked_players = lib.tracked_players or {} --[[
	[unitid][spellid] = {
		["cooldown_start"] = time,
		["cooldown_end"] = time,
		["used_start"] = time,
		["used_end"] = time,
		["detected"] = boolean,
		[EVENT] = time
	}
]]
lib.registered_units = lib.registered_units or {} -- [unitid] = count
lib.active_symbiosis = lib.active_symbiosis or {} -- [unitid] = spellid
lib.symbiosis_bond_by_target = lib.symbiosis_bond_by_target or {} -- [recipient unitid] = Druid unitid
lib.symbiosis_target_by_druid = lib.symbiosis_target_by_druid or {} -- [Druid unitid] = recipient unitid

local function RemoveGUID(unit)
	-- find and delete old references to that unit
	for guid, unitid in pairs(lib.guid_to_unitid) do
		if unitid == unit then
			lib.guid_to_unitid[guid] = nil
		end
	end
end

local function GetPetUnit(unit)
	if unit == "player" or unit == "pet" then
		return "pet"
	end

	-- Indexed pet tokens place "pet" before the index:
	-- arena1 -> arenapet1, party1 -> partypet1, raid1 -> raidpet1.
	local unit_type, index = unit:match("^(arena)(%d+)$")
	if not unit_type then
		unit_type, index = unit:match("^(party)(%d+)$")
	end
	if not unit_type then
		unit_type, index = unit:match("^(raid)(%d+)$")
	end
	if unit_type then
		return unit_type .. "pet" .. index
	end

	return unit .. "pet"
end

local function UpdateGUID(unit)
	RemoveGUID(unit)

	local guid = UnitGUID(unit)
	if guid then lib.guid_to_unitid[guid] = unit end

	local pet_unit = GetPetUnit(unit)
	local pet_guid = UnitGUID(pet_unit)
	if pet_guid then lib.guid_to_unitid[pet_guid] = unit end
end

-- Pet tokens can become available after their owner was first registered.
-- Resolve a tracked pet lazily so the first observed pet cooldown is not lost
-- if UNIT_PET or ARENA_OPPONENT_UPDATE arrives after the combat-log event.
local function FindUnitByPetGUID(guid)
	if not guid then return end

	for unit in pairs(lib.registered_units) do
		if UnitGUID(GetPetUnit(unit)) == guid then
			lib.guid_to_unitid[guid] = unit
			return unit
		end
	end
end

-- simple timer used for updating number of charges
-- timers are stored ordered by their firing time so only the first
-- timer on the list is checked in the OnUpdate
local timers = {}
local timer_frame

local function Timer_OnUpdate()
	local t1 = timers[1]
	if t1 and GetTime() >= t1.time then
		tremove(timers, 1)
		t1.func(unpack(t1.args))
		if #timers == 0 then
			lib.frame:SetScript("OnUpdate", nil)
		end
	end
end

local function SetTimer(time, func, ...)
	local pos = 1
	while pos <= #timers do
		if timers[pos].time >= time then
			break
		end
		pos = pos + 1
	end

	tinsert(timers, pos, { time = time, func = func, args = { ... } })

	if #timers == 1 then
		lib.frame:SetScript("OnUpdate", Timer_OnUpdate)
	end

	return pos
end

local function ClearTimers()
	lib.frame:SetScript("OnUpdate", nil)
	timers = {}
end

local function GetCooldownTime(spellid, unit)
	local spelldata = SpellData[spellid]
	if not spelldata then
		return
	end

	local time = spelldata.cooldown

	-- Spec/class overrides are deterministic and can be applied on the first cast.
	-- Keep the GladiusEx dependency guarded because the library can receive events
	-- while unit buttons are being created or destroyed.
	local buttons = GladiusEx and GladiusEx.buttons
	local button = buttons and buttons[unit]
	if button and spelldata.cooldown_overload then
		local overloads = spelldata.cooldown_overload
		if button.specID and overloads[button.specID] then
			time = overloads[button.specID]
		else
			local class = button.class or select(2, UnitClass(unit))
			if class and overloads[class] then
				time = overloads[class]
			end
		end
	end

	-- Optional shorter cooldowns are learned only after an observed early recast.
	-- The nil guard matters when zoning/reset callbacks clear tracked_players while
	-- another cooldown callback is still finishing.
	local tpu = lib.tracked_players[unit]
	local tps = tpu and tpu[spellid]
	if tps and tps.cooldown then
		time = tps.cooldown
	end

	return time
end

-- Modifier cooldowns are not guessed from arbitrary early casts. Only values
-- explicitly supplied by the MoP data may replace the default duration.
local function LearnCooldownVariant(spelldata, tps, now)
	local variants = spelldata.cooldown_variants
	if not variants and spelldata.opt_lower_cooldown then
		variants = { spelldata.opt_lower_cooldown }
	end
	if not variants then return end

	local previous_start = tps.cooldown_start or tps.used_start
	if not previous_start then return end

	local observed = now - previous_start
	local current = tps.cooldown or spelldata.cooldown
	local selected
	for i = 1, #variants do
		local candidate = variants[i]
		if candidate < current and candidate <= observed + 1 and (not selected or candidate > selected) then
			selected = candidate
		end
	end
	if selected then
		tps.cooldown = selected
	end
end

local function AuraByIdPredicate(auraNameToFind, _, _, ...)
	return auraNameToFind == select(10, ...)
end
local function FindAuraById(auraId, unit, filter)
	return AuraUtil.FindAura(AuraByIdPredicate, unit, filter, auraId)
end 

-- Alter Time-style cooldowns remain pre-active while their aura is present.
-- Natural expiry/manual resolution retain the cast timestamp, while an early
-- cancel or dispel starts a fresh cooldown at the removal timestamp.
local function FinishAuraResolvedCooldown(unit, spellid, cast_start, restart_at)
	local tpu = lib.tracked_players[unit]
	local tps = tpu and tpu[spellid]
	local spelldata = SpellData[spellid]
	if not tps or not spelldata or not tps.aura_resolution_active then return end
	if cast_start and tps.used_start ~= cast_start then return end

	local now = GetTime()
	local cooldown_time = GetCooldownTime(spellid, unit)
	local cooldown_origin = restart_at or tps.used_start or now
	if cooldown_time then
		tps.cooldown_start = cooldown_origin
		tps.cooldown_end = cooldown_origin + cooldown_time
	end
	tps.used_end = now
	tps.aura_resolution_active = nil
	tps.aura_resolution_seen = nil
	tps.aura_resolution_expires = nil
	tps.aura_resolution_removal_pending = nil
	lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid, false, true, true)
end

local function GetUnitSpecID(unit)
	local buttons = GladiusEx and GladiusEx.buttons
	local button = buttons and buttons[unit]
	if button and button.specID then
		return button.specID
	end

	local testing = GladiusEx and GladiusEx.testing
	return testing and testing[unit] and testing[unit].specID
end

local function GetUnitClass(unit)
	local buttons = GladiusEx and GladiusEx.buttons
	local button = buttons and buttons[unit]
	if button and button.class then
		return button.class
	end

	local testing = GladiusEx and GladiusEx.testing
	if testing and testing[unit] and testing[unit].class then
		return testing[unit].class
	end

	return select(2, UnitClass(unit))
end

local function ResolveRegisteredUnit(unit)
	if not unit then return end
	if lib:IsUnitRegistered(unit) then
		return unit
	end

	local guid = UnitGUID(unit)
	return guid and lib.guid_to_unitid[guid]
end

-- C_UnitAuras is used by current MoP Classic clients. UnitBuff is retained as
-- a guarded fallback for older Classic API layouts.
local function GetBuffDataByIndex(unit, index)
	if C_UnitAuras then
		if C_UnitAuras.GetBuffDataByIndex then
			return C_UnitAuras.GetBuffDataByIndex(unit, index)
		elseif C_UnitAuras.GetAuraDataByIndex then
			return C_UnitAuras.GetAuraDataByIndex(unit, index, "HELPFUL")
		end
	end

	if not UnitBuff then return end
	local aura = { UnitBuff(unit, index, "HELPFUL") }
	if not aura[1] then return end

	local recipientByAura = SymbiosisData.recipientByAura or {}
	local spellID = recipientByAura[aura[10]] and aura[10] or aura[11]
	local sourceUnit = type(aura[7]) == "string" and aura[7] or aura[8]
	return {
		spellId = spellID,
		sourceUnit = type(sourceUnit) == "string" and sourceUnit or nil,
	}
end

local function ClearSymbiosisSpell(unit, silent)
	local spellID = lib.active_symbiosis[unit]
	if not spellID then return false end

	lib.active_symbiosis[unit] = nil
	local tracked = lib.tracked_players[unit]
	if tracked then
		tracked[spellID] = nil
	end

	if not silent then
		lib.callbacks:Fire("LCT_CooldownDetected", unit, spellID)
	end
	return true
end

local function SetSymbiosisSpell(unit, spellID)
	local spelldata = SpellData[spellID]
	if type(spelldata) == "number" then
		spellID = spelldata
		spelldata = SpellData[spellID]
	end
	if type(spelldata) ~= "table" or not spelldata.symbiosis then
		return false
	end

	if not lib.tracked_players[unit] then
		lib.tracked_players[unit] = {}
	end

	local previous = lib.active_symbiosis[unit]
	local changed = previous ~= spellID
	if changed and previous then
		lib.tracked_players[unit][previous] = nil
	end

	local spell = lib.tracked_players[unit][spellID]
	if not spell then
		spell = {}
		lib.tracked_players[unit][spellID] = spell
	end
	local newlyDetected = not spell.detected
	spell.detected = true
	lib.active_symbiosis[unit] = spellID

	if changed or newlyDetected then
		lib.callbacks:Fire("LCT_CooldownDetected", unit, spellID)
	end
	return true
end

local function ClearSymbiosisBondByTarget(targetUnit)
	local druidUnit = lib.symbiosis_bond_by_target[targetUnit]
	lib.symbiosis_bond_by_target[targetUnit] = nil

	if druidUnit and lib.symbiosis_target_by_druid[druidUnit] == targetUnit then
		lib.symbiosis_target_by_druid[druidUnit] = nil
		ClearSymbiosisSpell(druidUnit)
	end
	ClearSymbiosisSpell(targetUnit)
end

local function ClearSymbiosisBondByDruid(druidUnit)
	local targetUnit = lib.symbiosis_target_by_druid[druidUnit]
	if targetUnit then
		ClearSymbiosisBondByTarget(targetUnit)
	else
		ClearSymbiosisSpell(druidUnit)
	end
end

local function ApplySymbiosisBond(sourceUnit, targetUnit, auraID)
	local recipientInfo = SymbiosisData.recipientByAura and SymbiosisData.recipientByAura[auraID]
	if not recipientInfo or not targetUnit or not lib:IsUnitRegistered(targetUnit) then
		return false
	end

	sourceUnit = ResolveRegisteredUnit(sourceUnit)
	if sourceUnit then
		local previousDruid = lib.symbiosis_bond_by_target[targetUnit]
		if previousDruid and previousDruid ~= sourceUnit then
			ClearSymbiosisBondByTarget(targetUnit)
		end

		local previousTarget = lib.symbiosis_target_by_druid[sourceUnit]
		if previousTarget and previousTarget ~= targetUnit then
			ClearSymbiosisBondByTarget(previousTarget)
		end

		lib.symbiosis_bond_by_target[targetUnit] = sourceUnit
		lib.symbiosis_target_by_druid[sourceUnit] = targetUnit
	end

	local recipientSpecID = GetUnitSpecID(targetUnit)
	local recipientSpell = recipientInfo.bySpec and recipientInfo.bySpec[recipientSpecID]
	if recipientSpell then
		SetSymbiosisSpell(targetUnit, recipientSpell)
	elseif recipientSpecID then
		ClearSymbiosisSpell(targetUnit)
	end

	if sourceUnit then
		local druidByClass = SymbiosisData.druidByTargetClass and
			SymbiosisData.druidByTargetClass[recipientInfo.class]
		local druidSpecID = GetUnitSpecID(sourceUnit)
		local druidSpell = druidByClass and druidByClass[druidSpecID]
		if druidSpell then
			SetSymbiosisSpell(sourceUnit, druidSpell)
		elseif druidSpecID then
			ClearSymbiosisSpell(sourceUnit)
		end
	end

	return true
end

local function ScanSymbiosisTarget(targetUnit, clearMissing)
	if not lib:IsUnitRegistered(targetUnit) or not UnitGUID(targetUnit) then
		return false
	end

	local recipientByAura = SymbiosisData.recipientByAura or {}
	for index = 1, 50 do
		local aura = GetBuffDataByIndex(targetUnit, index)
		if not aura then break end

		if recipientByAura[aura.spellId] then
			local sourceUnit = ResolveRegisteredUnit(aura.sourceUnit)
			ApplySymbiosisBond(sourceUnit, targetUnit, aura.spellId)
			return true
		end
	end

	if clearMissing then
		local activeSpell = lib.active_symbiosis[targetUnit]
		local activeData = activeSpell and SpellData[activeSpell]
		if lib.symbiosis_bond_by_target[targetUnit] or
			(type(activeData) == "table" and activeData.symbiosis and activeData.class ~= "DRUID") then
			ClearSymbiosisBondByTarget(targetUnit)
		end
	end
	return false
end

-- Refreshes the recipient directly. For Druids, scan all registered recipients
-- because the class-specific aura is carried by the linked non-Druid unit.
function lib:RefreshSymbiosis(unit, clearMissing)
	if not unit or not lib:IsUnitRegistered(unit) then return end

	if GetUnitClass(unit) == "DRUID" then
		for targetUnit in pairs(lib.registered_units) do
			if targetUnit ~= unit and GetUnitClass(targetUnit) ~= "DRUID" then
				ScanSymbiosisTarget(targetUnit, clearMissing)
			end
		end
	else
		ScanSymbiosisTarget(unit, clearMissing)
	end
end


local function AddCharge(unit, spellid)
	local tps = lib.tracked_players[unit][spellid]
	if not tps then
		return
	end
	tps.charges = (tps.charges or 0) + 1
	lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid)

	-- schedule another timer if there are more charges in cooldown
	if tps.max_charges and tps.charges < tps.max_charges then
		local now = GetTime()
		local spelldata = SpellData[spellid]
		tps.cooldown_start = now
		tps.cooldown_end = now + GetCooldownTime(spellid, unit)
		tps.charge_timer = SetTimer(tps.cooldown_end, AddCharge, unit, spellid)
	else
		tps.charge_timer = false
	end
end

local function check_reduce(reduce, unit, spellid)
	if reduce.spell_cast_buff then
		if not FindAuraById(spellid, unit) then
			return false
		end
	end

	local buffs = reduce.buffs or reduce.buff and { reduce.buff }
	if buffs then
		for _, buff in ipairs(buffs) do
			if not FindAuraById(buff, unit) then
				return false
			end
		end
	end

	local specIDs = reduce.specIDs or reduce.specID and { reduce.specID }
	local unitSpec = GladiusEx and GladiusEx.buttons[unit] and GladiusEx.buttons[unit].specID
	if specIDs then
		if not unitSpec then
			return false
		end
		local hasSpec = any(specIDs, function (spec) return spec == unitSpec end) 
		if not hasSpec then
			-- we're not one of the required specs
			return false
		end
	end

	return true
end

-- A Counterspell used during an existing cast/channel proves glyph 115703.
-- A late recast alone cannot prove the glyph (the player may simply wait).
local function CounterspellHasGlyph(unit, now)
	local _, _, _, startMS, endMS = UnitCastingInfo(unit)
	if not startMS then
		_, _, _, startMS, endMS = UnitChannelInfo(unit)
	end
	return startMS and endMS and startMS < now * 1000 - 100 and endMS > now * 1000
end

local function CounterspellEvent(event, unit, spellid)
	if event ~= "UNIT_SPELLCAST_SUCCEEDED" and event ~= "SPELL_CAST_SUCCESS" and event ~= "SPELL_INTERRUPT" then return end
	local now = GetTime()
	lib.tracked_players[unit] = lib.tracked_players[unit] or {}
	local tpu = lib.tracked_players[unit]
	local tps = tpu[spellid] or {}
	tpu[spellid] = tps
	if CounterspellHasGlyph(unit, now) then tps.counterspellGlyph = true end

	-- All three events may describe the same cast, in either delivery order.
	local newCast = not tps.used_start or now - tps.used_start > 1
	if newCast then
		tps.used_start = now
		tps.cooldown_start = now
		tps.counterspellInterrupted = nil
	end
	if event == "SPELL_INTERRUPT" then tps.counterspellInterrupted = true end
	local _, instanceType = IsInInstance()
	-- Enemy gear is not inspectable in arenas. Explicit arena assumption:
	-- enemy mages wear the PvP two-piece; never apply it to a missed interrupt.
	local reduction = instanceType == "arena" and UnitCanAttack("player", unit) and tps.counterspellInterrupted and 4 or 0
	tps.cooldown_end = tps.cooldown_start + (tps.counterspellGlyph and 28 or 24) - reduction
	tps.detected = true
	lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid, newCast, false, true)
end

local function CooldownEvent(event, unit, spellid)
	local raw_spellid = spellid
	local cast_override = SpellAliases[raw_spellid]
	local spelldata = SpellData[spellid]

	if type(spelldata) == "number" then
		spellid = spelldata
		spelldata = SpellData[spelldata]
	end
	if cast_override and cast_override.spellid then
		spellid = cast_override.spellid
		spelldata = SpellData[spellid]
	end
	if not spelldata then
    -- TODO log error
    return
  end

	if spelldata.counterspell then
		if lib:IsUnitRegistered(unit) then CounterspellEvent(event, unit, spellid) end
		return
	end

	-- Some cooldowns begin on the actual cast and must not be touched by their
	-- aura lifecycle. In particular, purging/consuming Fear Ward removes only
	-- the buff; it does not restart or otherwise change the spell cooldown.
	if spelldata.cooldown_starts_on_cast and
	   event ~= "UNIT_SPELLCAST_SUCCEEDED" and
	   event ~= "SPELL_CAST_SUCCESS" then
		return
	end

	local duration = spelldata.duration

	if lib:IsUnitRegistered(unit) then
    local now = GetTime()

    if not lib.tracked_players[unit] then
      lib.tracked_players[unit] = {}
    end

    local tpu = lib.tracked_players[unit]

    if tpu[spellid] then
      -- check if the same spell cast was detected recently
      -- if so, we assume that the first detection time is more accurate and ignore this one
      -- this can happen because we listen to both UNIT_SPELLCAST_SUCCEEDED and SPELL_CAST_SUCCESS from COMBAT_LOG_EVENT_UNFILTERED
      -- and because both SPELL_CAST_SUCCESS and SPELL_AURA_APPLIED are considered events for cooldown uses
      local margin = 1
      if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "SPELL_CAST_SUCCESS" or event == "SPELL_AURA_APPLIED" then
        if (event ~= "UNIT_SPELLCAST_SUCCEEDED" and tpu[spellid]["UNIT_SPELLCAST_SUCCEEDED"] and (tpu[spellid]["UNIT_SPELLCAST_SUCCEEDED"] + margin) > now) or
          (event ~= "SPELL_AURA_APPLIED"       and tpu[spellid]["SPELL_AURA_APPLIED"]       and (tpu[spellid]["SPELL_AURA_APPLIED"]       + margin) > now) or
          (event ~= "SPELL_CAST_SUCCESS"       and tpu[spellid]["SPELL_CAST_SUCCESS"]       and (tpu[spellid]["SPELL_CAST_SUCCESS"]       + margin) > now) then
          return
        end
      end

      -- register event time
      tpu[spellid][event] = now
    else
      tpu[spellid] = {
        charges = spelldata.charges or spelldata.opt_charges,
        max_charges = spelldata.charges or spelldata.opt_charges,
        charges_detected = spelldata.charges and true or false,
        [event] = now,
      }
    end
    local tps = tpu[spellid]

		-- Find out if casting this spell reduces any cooldown
		local reduced_any = false
		local reduces = spelldata.reduces or spelldata.reduce and { spelldata.reduce }
		if reduces then
			for i = 1, #reduces do
				local reduce = reduces[i]

				-- Make sure the reduction applies in this case (spec id, aura present, ...)
				if check_reduce(reduce, unit, spellid) then
					local reduce_spellids = reduce.spellids or reduce.spellid and { reduce.spellid }
					if reduce_spellids then
						for _, each_spellid in ipairs(reduce_spellids) do
							if tpu[each_spellid] and tpu[each_spellid].cooldown_start then
								tpu[each_spellid].cooldown_end = tpu[each_spellid].cooldown_end - reduce.duration
								reduced_any = true
							end
						end
					end

					if reduce.all then
						for _, each_tps in pairs(tpu) do
							if each_tps.cooldown_start then
								each_tps.cooldown_end = each_tps.cooldown_end - reduce.duration
								reduced_any = true
							end
						end
					end
				end
			end
		end

		if spelldata.ignore_cooldown_event then
			if reduced_any then
				lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid)
			end
			return
		end

    -- find what actions are needed
    local used_start, used_end, cooldown_start, cooldown_backdated

    local buff_was_full_duration = false
    if spelldata.cooldown_starts_on_dispel then
      if event == "SPELL_DISPEL" then
        used_start = true
        cooldown_start = true
      end
    elseif spelldata.cooldown_starts_on_aura_duration then
      if event == "SPELL_AURA_APPLIED" then
        local n, _, _, _, aura_duration = FindAuraById(spellid, unit)
        -- Some leeway... If the aura isn't present, pretend the spell has actually been used.
        if not aura_duration or aura_duration >= spelldata.duration - 2 then
          used_start = true
          cooldown_start = true
        end
      end
    elseif spelldata.cooldown_starts_on_aura_resolution then
		if cast_override and cast_override.aura_resolution then
			used_end = true
			cooldown_start = true
			cooldown_backdated = true
		elseif event == "UNIT_SPELLCAST_SUCCEEDED" or event == "SPELL_CAST_SUCCESS" then
			used_start = true
		end
    elseif spelldata.cooldown_starts_on_aura_fade then
      if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "SPELL_CAST_SUCCESS" or event == "SPELL_AURA_APPLIED" then
        used_start = true
      elseif event == "SPELL_AURA_REMOVED" then
        cooldown_start = true
      end
    else
      if event == "UNIT_SPELLCAST_SUCCEEDED" or event == "SPELL_CAST_SUCCESS" or event == "SPELL_AURA_APPLIED" then
        used_start = true
        cooldown_start = true
      elseif event == "SPELL_AURA_REMOVED" then
        used_end = true
        local applied = tpu[spellid]["SPELL_AURA_APPLIED"]
        buff_was_full_duration = applied and spelldata.duration and (now - applied) >= (spelldata.duration - 0.5) -- 0.5 for leeway
      end
    end

    -- Only detect the spell if it's actually used (i.e. not if it's just a random proc)
    if used_start or used_end or cooldown_start then
      if not tpu[spellid].detected then
        if spelldata.symbiosis then
          SetSymbiosisSpell(unit, spellid)
        else
          tpu[spellid].detected = true
        end
      end
    end

    -- apply actions
    if used_start then
      local previous_cooldown_start = tps.cooldown_start
      local previous_used_start = tps.used_start
      tps.used_start = now
      tps.used_end = duration and (now + duration)

      -- is the cooldown still in progress?
      local on_cd = tps.cooldown_end and (tps.cooldown_end - 2) > now

      local use_lower_cd = false

      -- remove charge
      if tps.charges then
        if tps.charges > 0 then
          tps.charges = tps.charges - 1
          -- if cooldown is still in progress and the spell can optionally have charges (with a talent),
          --  then it must have charges
          if not tps.charges_detected and on_cd then
            tps.charges_detected = true
            if spelldata.opt_charges_linked then
              for i = 1, #spelldata.opt_charges_linked do
                local lspellid = spelldata.opt_charges_linked[i]
                local lspelldata = SpellData[lspellid]
                if not tpu[lspellid] then
                  tpu[lspellid] = {
                    charges = lspelldata.opt_charges,
                    max_charges = lspelldata.opt_charges,
                  }
                end
                tpu[lspellid].charges_detected = true
              end
            end
          else
            -- We'd go into negative charges. Adjust timer
            use_lower_cd = true
          end
				else
					-- No charges left.
					use_lower_cd = true
        end
      elseif on_cd then
        -- No potential charges, yet the spell was cast while on CD? Adjust timer
        use_lower_cd = true
      end

      -- Did we figure out we got our timer wrong?
      if use_lower_cd and not cast_override then
        tps.cooldown_start = previous_cooldown_start
        tps.used_start = previous_used_start
        LearnCooldownVariant(spelldata, tps, now)
        tps.cooldown_start = previous_cooldown_start
        tps.used_start = now
      end

      tps.icon = cast_override and cast_override.icon or nil

		if spelldata.cooldown_starts_on_aura_resolution then
			tps.aura_resolution_active = true
			tps.aura_resolution_removal_pending = nil
			local _, _, _, _, _, expiration_time = FindAuraById(spelldata.aura_resolution_spellid, unit)
			if expiration_time then
				tps.aura_resolution_seen = true
				tps.aura_resolution_expires = expiration_time
			end
			local cast_start = tps.used_start
			SetTimer(now + (spelldata.duration or 6) + 0.15, FinishAuraResolvedCooldown, unit, spellid, cast_start, nil)
		end

      -- Some cooldown-reset abilities restore charges instead of resetting the
      -- entire spell. This generic behavior was accidentally removed by the
      -- modifier experiment and is required by existing cooldown data.
      if spelldata.restore_charges then
        for i = 1, #spelldata.restore_charges do
          local restored_spellid = spelldata.restore_charges[i]
          local restored_spelldata = SpellData[restored_spellid]

          if restored_spelldata then
            local restored = tpu[restored_spellid]
            local max_charges = restored_spelldata.charges or restored_spelldata.opt_charges

            if not restored then
              restored = {
                charges = max_charges,
                max_charges = max_charges,
              }
              tpu[restored_spellid] = restored
            elseif max_charges then
              restored.max_charges = restored.max_charges or max_charges
              restored.charges = math.min((restored.charges or 0) + 1, restored.max_charges)
            end

            restored.charges_detected = true
          end
        end
      end

      -- reset other cooldowns (Cold Snap, Preparation)
      if spelldata.resets then
        for i = 1, #spelldata.resets do
          local rspellid = spelldata.resets[i]
          if tpu[rspellid] then
            tpu[rspellid].cooldown_start = 0
            tpu[rspellid].cooldown_end = 0
          end
        end
      end
    end

    if used_end then
      tps.used_end = now
      -- A spell might have a different cooldown if its buff stayed on for the whole duration (and didnt proc before) 
      if tps.cooldown_end and buff_was_full_duration and spelldata.cooldown_on_full_aura_duration then
        tps.cooldown_end = now + spelldata.cooldown_on_full_aura_duration
      end
    end

    if cooldown_start then
      -- if the spell has charges and the cooldown is already in progress, it does not need to be reset
      if not tps.charges or not tps.cooldown_end or tps.cooldown_end <= now then
        local cooldown_time = cast_override and cast_override.cooldown or GetCooldownTime(spellid, unit)
        local cooldown_origin = cooldown_backdated and (tps.used_start or now) or now
        tps.cooldown_start = cooldown_time and cooldown_origin
        tps.cooldown_end = cooldown_time and (cooldown_origin + cooldown_time)

		if spelldata.cooldown_starts_on_aura_resolution then
			tps.aura_resolution_active = nil
			tps.aura_resolution_seen = nil
			tps.aura_resolution_expires = nil
			tps.aura_resolution_removal_pending = nil
		end

        -- set charge timer
        if tps.charges and not tps.charge_timer then
          tps.charge_timer = SetTimer(tps.cooldown_end, AddCharge, unit, spellid)
        end

        -- V: set other cooldown(s)
        local sets_cooldowns = spelldata.sets_cooldowns or spelldata.sets_cooldown and { spelldata.sets_cooldown } or {}

        for i = 1, #sets_cooldowns do
          local cd = sets_cooldowns[i]
          local cspellid = cd.spellid
          local cspelldata = SpellData[cspellid]
          if cspelldata and ((tpu[cspellid] and tpu[cspellid].detected) or (not cspelldata.talent)) then
            if not tpu[cspellid] then
              tpu[cspellid] = {}
            end
            if not tpu[cspellid].cooldown_end or (tpu[cspellid].cooldown_end < (now + cd.cooldown)) then
              tpu[cspellid].cooldown_start = now
              tpu[cspellid].cooldown_end = now + cd.cooldown
              tpu[cspellid].used_start = tpu[cspellid].used_start or 0
              tpu[cspellid].used_end = tpu[cspellid].used_end or 0
            end
          end
        end
      end
    end

    lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid, used_start, used_end, cooldown_start)
  end
end

local function enable()
  lib.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
  lib.frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
  lib.frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
  lib.frame:RegisterEvent("UNIT_AURA")
  lib.frame:RegisterEvent("UNIT_NAME_UPDATE")
  lib.frame:RegisterEvent("UNIT_PET")
  lib.frame:RegisterEvent("ARENA_CROWD_CONTROL_SPELL_UPDATE")
  lib.frame:RegisterEvent("ARENA_COOLDOWNS_UPDATE")
  lib.frame:RegisterEvent("ARENA_OPPONENT_UPDATE")

  if IsRetail then
    lib.frame:RegisterEvent("PVP_MATCH_ACTIVE")
  end

  lib.tracked_players = {}
  lib.guid_to_unitid = {}
  lib.active_symbiosis = {}
  lib.symbiosis_bond_by_target = {}
  lib.symbiosis_target_by_druid = {}

  for unitid in pairs(lib.registered_units) do
    UpdateGUID(unitid)
    lib:RefreshSymbiosis(unitid)
  end

  if LGIST then
    LGIST.RegisterCallback(lib, "GroupInSpecT_Update")
  end
end

local function disable()
  lib.frame:UnregisterAllEvents()
end

-- Removes all the talent spells from a tracked unit
function lib:ClearTalents(unit)
  local tpu = lib.tracked_players[unit]
  if not tpu then return end

  -- find out which detected spells are talents/items/trinkets, and un-detect them
  local remove_spells = filter(keys(tpu), function (k)
    local spell = SpellData[k]
    return tpu[k].detected and type(spell) == "table" and (spell.talent or spell.item and spell.pvp_trinket)
	end)
	for i = 1, #remove_spells do
		tpu[remove_spells[i]] = nil
	end
end

local function GetPartyUnit(unit, guid)
	if unit == "player" then return unit end
	if string.sub(unit, 1, 5) == "party" then return unit end
	if string.sub(unit, 1, 4) == "raid" then
		-- XXX: this is a very ugly for, replace it with *something else*
		for i = 1, GetNumGroupMembers() do
			if UnitGUID("party"..i) == guid then return "party"..i end
		end
	end
end

function lib:GroupInSpecT_Update(event, guid, raw_unit, info)
	local unit = GetPartyUnit(raw_unit, guid)
	if not unit then return end

	local tpu = lib.tracked_players[unit]
	if not tpu then lib.tracked_players[unit] = {} end

	lib:ClearTalents(unit)

	-- we didn't detect any talent. wait for follow-up message.
	if not next(info.talents) then
		return
	end

	for talentId, talent in pairs(info.talents) do
		-- XXX only detect spells if SpellData[talent.spell_id]?
		lib:DetectSpell(unit, talent.spell_id)

		-- TODO have some kind of LCT_TalentData so that we can detect charges and other stuff
	end
end

function lib.callbacks:OnUsed(target, event)
	if event == "LCT_CooldownUsed" then
		enable()
	end
end

function lib.callbacks:OnUnused(target, event)
	if event == "LCT_CooldownUsed" then
		disable()
	end
end

--- Registers an unit to be tracked by the library.
-- @param unitid The unitid to register.
function lib:RegisterUnit(unitid)
	local count = (lib.registered_units[unitid] or 0) + 1
	lib.registered_units[unitid] = count
	if count == 1 then
		UpdateGUID(unitid)
		lib:RefreshSymbiosis(unitid)
	end
	return count
end

--- Unregisters an unit.
-- While the same unit may be registered more than once, it is important that
-- UnregisterUnit is called exactly once for each call to RegisterUnit.
-- @param unitid The unitid to unregister.
function lib:UnregisterUnit(unitid)
	assert(lib.registered_units[unitid] ~= nil, "Attempting to unregister a unit not registered")

	local count = lib.registered_units[unitid] - 1
	if count == 0 then
		if lib.symbiosis_target_by_druid[unitid] then
			ClearSymbiosisBondByDruid(unitid)
		elseif lib.symbiosis_bond_by_target[unitid] then
			ClearSymbiosisBondByTarget(unitid)
		else
			ClearSymbiosisSpell(unitid)
		end
		lib.registered_units[unitid] = nil
		RemoveGUID(unitid)
	else
		lib.registered_units[unitid] = count
	end
	return count
end

function lib:IsUnitRegistered(unitid)
	return lib.registered_units[unitid]
end

--- Returns a table with the state of a unit's cooldown, or nil if there is no state stored about it.
-- @param unitid The unit unitid.
-- @param spellid The cooldown spellid.
-- @usage
-- local tracked = lib:GetUnitCooldownInfo(unitid, spellid)
-- if tracked then
--     print(tracked.cooldown_start) -- times are based on GetTime()
--     print(tracked.cooldown_end)
--     print(tracked.used_start)
--     print(tracked.used_end)
--     print(tracked.detected) -- use this to check if the unit has used this spell before (useful for detecting talents)
-- end
function lib:GetUnitCooldownInfo(unitid, spellid)
	local tpu = lib.tracked_players[unitid]
	return tpu and tpu[spellid]
end

function lib:DetectSpell(unit, spellid)
	if not spellid then
		return
	end
	local spelldata = SpellData[spellid]
	if type(spelldata) == "number" then
		spellid = spelldata
		spelldata = SpellData[spellid]
	end
	if type(spelldata) == "table" and spelldata.symbiosis then
		SetSymbiosisSpell(unit, spellid)
		return
	end
	if not lib.tracked_players[unit] then
		lib.tracked_players[unit] = {}
	end
	local spell = lib.tracked_players[unit][spellid]
	if not spell then
		lib.tracked_players[unit][spellid] = {
			detected = true
		}
	elseif not spell.detected then
		spell.detected = true
	end
	lib.callbacks:Fire("LCT_CooldownDetected", unit, spellid)
end

--- Returns the raw data of all the cooldowns. See the cooldowns_*.lua data files for more details about its structure.
function lib:GetCooldownsData()
	return SpellData
end

--- Returns the raw data of a specified cooldown spellid.
-- @param spellid The cooldown spellid.
function lib:GetCooldownData(spellid)
	return SpellData[spellid]
end

local function CooldownIterator(state, spellid)
	while true do
		spellid = next(state.data_source, spellid)
		if spellid == nil then
			return
		end
		local spelldata = state.data_source[spellid]
		-- ignore references to other spells
		if type(spelldata) ~= "number" then
			if state.class and state.class == spelldata.class then
        if spelldata.specID_table then
          if state.specID and spelldata.specID_table[state.specID] then
            -- add spec
            return spellid, spelldata
          end
				else
					-- add base
					return spellid, spelldata
				end
			end

			if state.universal and spelldata.universal then
				return spellid, spelldata
			end

			if state.race and state.race == spelldata.race then
				-- return racial
				return spellid, spelldata
			end

			if spelldata.item or spelldata.pvp_trinket then
				-- return item or pvp trinket
				if not spelldata.race or spelldata.race == state.race  then
					return spellid, spelldata
				end
			end
		end
	end
end

-- uses lookup tables
local function FastCooldownIterator(state, spellid)
	local spelldata
	-- class
	if state.class then
		if state.data_source then
			spellid, spelldata = CooldownIterator(state, spellid)
		end

		if spellid then
			return spellid, spelldata
		else
			-- Universal encounter mechanics (for example, the Demonic Gateway
			-- reuse debuff) apply to every class.
			state.data_source = universal_spelldata
			state.class = nil
			spellid = nil
		end
	end

	-- universal
	if state.universal then
		if state.data_source then
			spellid, spelldata = CooldownIterator(state, spellid)
		end

		if spellid then
			return spellid, spelldata
		else
			-- do race next
			state.data_source = race_spelldata[state.race]
			state.universal = nil
			spellid = nil
		end
	end

	-- race
	if state.race then
		if state.data_source then
			spellid, spelldata = CooldownIterator(state, spellid)
		end

		if spellid then
			return spellid, spelldata
		else
			-- do items next
			state.data_source = item_spelldata
			state.race = nil
			spellid = nil
		end
	end

	-- item
	if state.item then
		if state.data_source then
			spellid, spelldata = CooldownIterator(state, spellid)
		end

		if spellid then
			return spellid, spelldata
		else
			-- do pvp next
			state.data_source = pvp_spelldata
			state.item = nil
			spellid = nil
		end
	end

	-- pvp
	if state.pvp then
		if state.data_source then
			spellid, spelldata = CooldownIterator(state, spellid)
		end
		if spellid then
			return spellid, spelldata
		else
			state.data_source = nil
			state.pvp = nil
			spellid = nil
		end
	end
end

--- Iterates over the cooldowns that apply to a unit of the specified //class//, //specID// and //race//.
-- @param class The unit class. Can be nil.
-- @param specID The unit talent spec ID. Can be nil.
-- @param race The unit race. Can be nil.
function lib:IterateCooldowns(class, specID, race)
	local state = {}
	state.class = class
	state.specID = specID
	state.race = race or ""
	state.universal = true
	state.item = true
	state.pvp = true

	if class then
		state.data_source = class_spelldata[class]

		return FastCooldownIterator, state
	else
		state.data_source = SpellData
		return CooldownIterator, state
	end
end

function events:PVP_MATCH_ACTIVE()
  events:PLAYER_ENTERING_WORLD()
end

function events:PLAYER_ENTERING_WORLD()
	local isInInstance = IsInInstance()

	-- reset cooldowns if we're entering an instance
  -- this might be incorrect (only bgs & arenas reset cooldowns), but is important to reset talents when zoning in
	if isInInstance then
		ClearTimers()
		lib.active_symbiosis = {}
		lib.symbiosis_bond_by_target = {}
		lib.symbiosis_target_by_druid = {}
		for unit in pairs(lib.tracked_players) do
			lib.tracked_players[unit] = nil
			lib.callbacks:Fire("LCT_CooldownsReset", unit)
		end
	end
end

function events:UNIT_SPELLCAST_SUCCEEDED(event, unit, lineID, spellId)
	CooldownEvent(event, unit, spellId)
end

function events:CombatLogEvent(_, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId, spellName, spellSchool, auraType)
	if event == "SWING_DAMAGE" or event == "RANGE_DAMAGE" or
	   event == "SPELL_DAMAGE" or event == "SPELL_PERIODIC_DAMAGE" then
		local damaged_unit = lib.guid_to_unitid[destGUID]
		local tracked = damaged_unit and lib.tracked_players[damaged_unit]
		if tracked then
			local now = GetTime()
			local changed = false
			for tracked_spellid, tracked_spell in pairs(tracked) do
				local tracked_data = SpellData[tracked_spellid]
				local reduction = tracked_data and tracked_data.reduce_on_damage_taken
				if reduction and tracked_spell.cooldown_end and tracked_spell.cooldown_end > now then
					tracked_spell.cooldown_end = math.max(now, tracked_spell.cooldown_end - reduction)
					changed = true
				end
			end
			if changed then
				lib.callbacks:Fire("LCT_CooldownUsed", damaged_unit)
			end
		end
	end

	-- SPELL_DISPEL reports the removed aura as its first event-specific value.
	-- This remains observable even when the aura itself has the "do not log" flag.
	if event == "SPELL_DISPEL" then
		local target_unit = lib.guid_to_unitid[destGUID]
		local tracked = target_unit and lib.tracked_players[target_unit]
		if tracked then
			for tracked_spellid, state in pairs(tracked) do
				local tracked_spelldata = SpellData[tracked_spellid]
				if tracked_spelldata and tracked_spelldata.cooldown_starts_on_aura_resolution and tracked_spelldata.aura_resolution_spellid == auraType then
					FinishAuraResolvedCooldown(target_unit, tracked_spellid, state.used_start, GetTime())
					break
				end
			end
		end
	end

	local recipientInfo = SymbiosisData.recipientByAura and SymbiosisData.recipientByAura[spellId]
	if recipientInfo then
		local targetUnit = lib.guid_to_unitid[destGUID]
		if targetUnit then
			if event == "SPELL_AURA_APPLIED" or event == "SPELL_AURA_REFRESH" then
				ApplySymbiosisBond(lib.guid_to_unitid[sourceGUID], targetUnit, spellId)
			elseif event == "SPELL_AURA_REMOVED" then
				ClearSymbiosisBondByTarget(targetUnit)
			end
		end
		return
	end

	if spellId == SymbiosisData.baseAuraID then
		if event == "SPELL_AURA_REMOVED" then
			local druidUnit = lib.guid_to_unitid[destGUID] or lib.guid_to_unitid[sourceGUID]
			if druidUnit then
				ClearSymbiosisBondByDruid(druidUnit)
			end
		end
		return
	end

	-- Check the spell before doing the slower pet-owner fallback.
	local spelldata = SpellData[spellId]
	local spell_alias = SpellAliases[spellId]
	if not spelldata and spell_alias then
		spelldata = SpellData[spell_alias.spellid]
	end
	if not spelldata then return end

	-- Pet abilities are cast by the pet GUID but their cooldown belongs to the
	-- registered owner unit (for example, arenapet1 belongs to arena1).
	-- Some encounter mechanics belong to the aura destination instead of its
	-- caster; Demonic Gateway's reuse debuff is the important arena example.
	local resolved_spelldata = type(spelldata) == "number" and SpellData[spelldata] or spelldata
	local unit
	if resolved_spelldata and resolved_spelldata.track_on_destination then
		unit = lib.guid_to_unitid[destGUID]
	else
		unit = lib.guid_to_unitid[sourceGUID]
	end
	if not unit and resolved_spelldata and resolved_spelldata.pet then
		unit = FindUnitByPetGUID(sourceGUID)
	end
	if not unit then return end

	if (event == "SPELL_INTERRUPT" and resolved_spelldata and resolved_spelldata.counterspell) or
	   event == "SPELL_DISPEL" or
	   event == "SPELL_AURA_REMOVED" or
	   event == "SPELL_AURA_APPLIED" or
	   event == "SPELL_CAST_SUCCESS" then
		CooldownEvent(event, unit, spellId)
	end
end

function events:COMBAT_LOG_EVENT_UNFILTERED(event)
	events:CombatLogEvent(event, CombatLogGetCurrentEventInfo())
end

function events:UNIT_NAME_UPDATE(event, unit)
	-- UNIT_NAME_UPDATE also fires for unregistered units such as arenapet1.
	-- Do not let those overwrite the pet GUID -> owner mapping.
	if lib:IsUnitRegistered(unit) then
		UpdateGUID(unit)
		lib:RefreshSymbiosis(unit)
	end
end

function events:UNIT_AURA(event, unit)
	if lib:IsUnitRegistered(unit) then
		lib:RefreshSymbiosis(unit, true)

		local tracked = lib.tracked_players[unit]
		if tracked then
			local now = GetTime()
			for spellid, state in pairs(tracked) do
				local spelldata = SpellData[spellid]
				if spelldata and spelldata.cooldown_starts_on_aura_resolution and state.aura_resolution_active then
					local _, _, _, _, _, expiration_time = FindAuraById(spelldata.aura_resolution_spellid, unit)
					if expiration_time then
						state.aura_resolution_seen = true
						state.aura_resolution_expires = expiration_time
						state.aura_resolution_removal_pending = nil
					elseif state.aura_resolution_seen and not state.aura_resolution_removal_pending then
						local natural = state.aura_resolution_expires and now >= state.aura_resolution_expires - 0.05
						if natural then
							FinishAuraResolvedCooldown(unit, spellid, state.used_start, nil)
						else
							-- UNIT_AURA can precede SPELL_CAST_SUCCESS for manual return.
							-- Delay the cancel decision briefly so 127140 can win that race.
							local cast_start = state.used_start
							local removed_at = now
							state.aura_resolution_removal_pending = true
							SetTimer(now + 0.10, FinishAuraResolvedCooldown, unit, spellid, cast_start, removed_at)
						end
					end
				end
			end
		end
	end
end

function events:UNIT_PET(event, unit)
	if lib:IsUnitRegistered(unit) then
		UpdateGUID(unit)
	end
end

function events:ARENA_CROWD_CONTROL_SPELL_UPDATE(event, unit, spellID)
  -- V: sometimes we receive such an event for "nameplateX" or "focus"
  --print("unit = " .. unit .. ", spellId = " .. (spellID or "nil"))
  if string.sub(unit, 1, 5) ~= "arena" then return end

  if not spellID or spellID == 0 then
    return
  end

  lib:DetectSpell(unit, spellID)
  lib.callbacks:Fire("LCT_CooldownDetected", unit, spellID)
end

function events:ARENA_OPPONENT_UPDATE(event, unit, unitEvent)
  -- Refresh both the opponent and arenapetN GUID as soon as the arena unit
  -- becomes visible (and clear stale mappings when it changes).
  if lib:IsUnitRegistered(unit) then
    UpdateGUID(unit)
    lib:RefreshSymbiosis(unit)
  end

  if unitEvent == "seen" then
    C_PvP.RequestCrowdControlSpell(unit)
  end
end

function events:ARENA_COOLDOWNS_UPDATE(event, unit)
  if not unit or string.sub(unit, 1, 5) ~= "arena" then return end
  --print("unit = " .. unit .. ", spellId = " .. (spellID or "nil") .. ", start = " .. (startTime or "nil") .. ", duration = " .. (duration or "nil"))

  local spellid, startTime, duration = C_PvP.GetArenaCrowdControlInfo(unit)

  if WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE then
    -- K: Haxx to make up for Blizzard mistakes carrying over DF changes to Classic during early Cata Classic

    -- K: Blizzard made the API return 60sec CD for regular PvP Trinket in Classic (carry-over from Mainline)
    -- and are also supplying the duration/startTime the wrong format / order
    -- that's why the bug only appears sometimes (i.e. not vs Humans with EMFH/WtS)

    -- print("LibCooldownTracker", "ARENA_COOLDOWNS_UPDATE", spellid, startTime, duration)

    local tempDuration

    -- Hardcoded fix or WotF
    if spellid == 7744 then -- WotF
      tempDuration = 30 * 1000
    else
      tempDuration = 120 * 1000
    end

    if duration ~= tempDuration then
      duration = tempDuration
      startTime = GetTime() * 1000
    end

    return
  end

  if not spellid then
    C_PvP.RequestCrowdControlSpell(unit)
    return
  end

  lib:DetectSpell(unit, spellid)
  lib.callbacks:Fire("LCT_CooldownDetected", unit, spellid)

  if not startTime or not duration then return end

  lib.tracked_players[unit][spellid].cooldown_start = (startTime / 1000)
  lib.tracked_players[unit][spellid].cooldown_end = (startTime / 1000) + (duration / 1000)
  lib.callbacks:Fire("LCT_CooldownUsed", unit, spellid)
end
