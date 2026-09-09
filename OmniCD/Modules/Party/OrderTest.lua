local E, L = select(2, ...):unpack()
if not E.isMoP then
	return
end

local P, CM = E.Party, E.Comm

local localizedClasses = LOCALIZED_CLASS_NAMES_MALE or {}
local classes = {
	DEATHKNIGHT = localizedClasses.DEATHKNIGHT or "Death Knight",
	DRUID = localizedClasses.DRUID or "Druid",
	HUNTER = localizedClasses.HUNTER or "Hunter",
	MAGE = localizedClasses.MAGE or "Mage",
	MONK = localizedClasses.MONK or "Monk",
	PALADIN = localizedClasses.PALADIN or "Paladin",
	PRIEST = localizedClasses.PRIEST or "Priest",
	ROGUE = localizedClasses.ROGUE or "Rogue",
	SHAMAN = localizedClasses.SHAMAN or "Shaman",
	WARLOCK = localizedClasses.WARLOCK or "Warlock",
	WARRIOR = localizedClasses.WARRIOR or "Warrior",
}

local specIDs = {
	DEATHKNIGHT = {250, 251, 252},
	DRUID = {102, 103, 104, 105},
	HUNTER = {253, 254, 255},
	MAGE = {62, 63, 64},
	MONK = {268, 269, 270},
	PALADIN = {65, 66, 70},
	PRIEST = {256, 257, 258},
	ROGUE = {259, 260, 261},
	SHAMAN = {262, 263, 264},
	WARLOCK = {265, 266, 267},
	WARRIOR = {71, 72, 73},
}

local specs = {
	DEATHKNIGHT = {[250]="Blood", [251]="Frost", [252]="Unholy"},
	DRUID = {[102]="Balance", [103]="Feral", [104]="Guardian", [105]="Restoration"},
	HUNTER = {[253]="Beast Mastery", [254]="Marksmanship", [255]="Survival"},
	MAGE = {[62]="Arcane", [63]="Fire", [64]="Frost"},
	MONK = {[268]="Brewmaster", [269]="Windwalker", [270]="Mistweaver"},
	PALADIN = {[65]="Holy", [66]="Protection", [70]="Retribution"},
	PRIEST = {[256]="Discipline", [257]="Holy", [258]="Shadow"},
	ROGUE = {[259]="Assassination", [260]="Combat", [261]="Subtlety"},
	SHAMAN = {[262]="Elemental", [263]="Enhancement", [264]="Restoration"},
	WARLOCK = {[265]="Affliction", [266]="Demonology", [267]="Destruction"},
	WARRIOR = {[71]="Arms", [72]="Fury", [73]="Protection"},
}

local races = {
	[1] = "Human",
	[2] = "Orc",
	[3] = "Dwarf",
	[4] = "Night Elf",
	[5] = "Undead",
	[6] = "Tauren",
	[7] = "Gnome",
	[8] = "Troll",
	[9] = "Goblin",
	[10] = "Blood Elf",
	[11] = "Draenei",
	[22] = "Worgen",
	[25] = "Pandaren (Alliance)",
	[26] = "Pandaren (Horde)",
}

P.iconOrderTestClasses = classes
P.iconOrderTestSpecIDs = specIDs
P.iconOrderTestSpecs = specs
P.iconOrderTestRaces = races

local function GetDefaultSpec(class)
	local ids = specIDs[class]
	return ids and ids[1]
end

function P:GetIconOrderTestSelection()
	local selection = self.iconOrderTestSelection
	if selection then
		return selection
	end

	local class = E.userClass
	local spec
	local specIndex = GetSpecialization and GetSpecialization()
	if specIndex and GetSpecializationInfo then
		spec = GetSpecializationInfo(specIndex)
	end
	if not specs[class] or not specs[class][spec] then
		spec = GetDefaultSpec(class)
	end

	local raceID = races[E.userRaceID] and E.userRaceID or 1
	selection = {
		class = class,
		spec = spec,
		raceID = raceID,
	}
	self.iconOrderTestSelection = selection
	return selection
end

function P:RefreshIconOrderTest()
	if not self.isInTestMode then
		return
	end
	local zone = self.testZone
	self:Test()
	self:Test(zone)
end

function P:SetIconOrderTestClass(class)
	if not classes[class] then
		return
	end
	local selection = self:GetIconOrderTestSelection()
	if selection.class == class then
		return
	end
	selection.class = class
	if not specs[class][selection.spec] then
		selection.spec = GetDefaultSpec(class)
	end
	self:RefreshIconOrderTest()
end

function P:SetIconOrderTestSpec(spec)
	spec = tonumber(spec)
	local selection = self:GetIconOrderTestSelection()
	if not spec or not specs[selection.class][spec] or selection.spec == spec then
		return
	end
	selection.spec = spec
	self:RefreshIconOrderTest()
end

function P:SetIconOrderTestRace(raceID)
	raceID = tonumber(raceID)
	if not raceID or not races[raceID] then
		return
	end
	local selection = self:GetIconOrderTestSelection()
	if selection.raceID == raceID then
		return
	end
	selection.raceID = raceID
	self:RefreshIconOrderTest()
end

local previewBackup

local function ApplyIconOrderPreview()
	local info = P.userInfo
	if not info or previewBackup then
		return
	end

	local selection = P:GetIconOrderTestSelection()
	previewBackup = {
		class = info.class,
		spec = info.spec,
		specID = info.specID,
		raceID = info.raceID,
		level = info.level,
		talentData = info.talentData,
		isIconOrderTestInfo = info.isIconOrderTestInfo,
		barClass = info.bar and info.bar.class,
		barRaceID = info.bar and info.bar.raceID,
	}

	info.class = selection.class
	info.spec = selection.spec
	info.specID = selection.spec
	info.raceID = selection.raceID
	info.level = 90
	info.talentData = {}
	info.isIconOrderTestInfo = true

	if info.bar then
		info.bar.class = selection.class
		info.bar.raceID = selection.raceID
	end
end

local function RestoreIconOrderPreview()
	local backup = previewBackup
	if not backup then
		return
	end

	local info = P.userInfo
	if info then
		info.class = backup.class
		info.spec = backup.spec
		info.specID = backup.specID
		info.raceID = backup.raceID
		info.level = backup.level
		info.talentData = backup.talentData
		info.isIconOrderTestInfo = backup.isIconOrderTestInfo
		if info.bar then
			info.bar.class = backup.barClass
			info.bar.raceID = backup.barRaceID
		end
	end
	previewBackup = nil
end

local Test = P.Test
function P:Test(zone)
	if not self.isInTestMode then
		ApplyIconOrderPreview()
		local result = Test(self, zone)
		if not self.isInTestMode then
			-- Test mode can refuse to start in combat. Never leave simulated
			-- class/spec/race data behind when that happens.
			RestoreIconOrderPreview()
		end
		return result
	end

	RestoreIconOrderPreview()
	return Test(self, zone)
end

-- The normal user inspection routine would immediately replace the simulated
-- specialization and talents with the character actually logged in.
local InspectUser = CM.InspectUser
if InspectUser then
	function CM:InspectUser(...)
		local info = P.userInfo
		if P.isInTestMode and info and info.isIconOrderTestInfo then
			return true
		end
		return InspectUser(self, ...)
	end
end

local UpdateIndicator = P.TestMode and P.TestMode.UpdateIndicator
if UpdateIndicator then
	function P.TestMode:UpdateIndicator(zone)
		UpdateIndicator(self, zone)

		local selection = P:GetIconOrderTestSelection()
		local className = classes[selection.class] or selection.class
		local specName = specs[selection.class] and specs[selection.class][selection.spec] or tostring(selection.spec)
		local raceName = races[selection.raceID] or tostring(selection.raceID)
		local zoneName = E.L_ALL_ZONE[zone] or tostring(zone or "")

		self.indicator.anchor.text:SetFormattedText(
			"%s - %s - %s %s %s",
			L["Test"], zoneName, raceName, specName, className
		)
		self.indicator.anchor:SetWidth(self.indicator.anchor.text:GetWidth() + 20)
	end
end
