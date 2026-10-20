--[[
-------------------------------------------------------------------------------
LoseControl Profiles

Profile implementation intentionally follows flyPlateBuffsFixed:
  * AceDB-3.0 owns account-wide named profiles.
  * AceDBOptions-3.0 provides the standard profile controls.
  * AceConfig-3.0 / AceConfigDialog-3.0 register "Profiles" beneath LoseControl.
  * "Default" is the shared profile for all characters unless a character
    explicitly selects another profile.

LoseControl.lua still consumes the traditional LoseControlDB table. This
module points LoseControlDB at the active AceDB profile before ADDON_LOADED
fires, so the combat/aura engine does not need to know about AceDB.
-------------------------------------------------------------------------------
]]

local addonName = ...
local _G = _G

local LibStub = _G.LibStub
if not LibStub then
    return
end

local AceDB = LibStub("AceDB-3.0", true)
if not AceDB then
    -- Safe fallback: LoseControl.lua will continue using SavedVariablesPerCharacter.
    return
end

local AceDBOptions = LibStub("AceDBOptions-3.0", true)
local AceConfig = LibStub("AceConfig-3.0", true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0", true)

local function DeepCopy(value, seen)
    if type(value) ~= "table" then
        return value
    end

    seen = seen or {}
    if seen[value] then
        return seen[value]
    end

    local copy = {}
    seen[value] = copy

    for key, child in pairs(value) do
        copy[DeepCopy(key, seen)] = DeepCopy(child, seen)
    end

    return copy
end

local function ReplaceTable(destination, source)
    if type(destination) ~= "table" or type(source) ~= "table" then
        return
    end

    for key in pairs(destination) do
        destination[key] = nil
    end

    for key, value in pairs(source) do
        destination[DeepCopy(key)] = DeepCopy(value)
    end
end

local function CharacterKey()
    local name = UnitName("player") or "Unknown"
    local realm = GetRealmName() or ""
    return name .. " - " .. realm
end

local defaultsSource = _G.LoseControlDBDefaults
if type(defaultsSource) ~= "table" then
    -- Defensive fallback. This should never occur with the provided TOC order.
    return
end

-- Preserve the old per-character table before LoseControlDB is redirected.
local legacyCharacterDB =
    type(_G.LoseControlDB) == "table" and DeepCopy(_G.LoseControlDB) or nil

-- Also recognize the custom profile DB from the earlier profile implementation.
local existingProfileRoot =
    type(_G.LoseControlDBProfiles) == "table" and _G.LoseControlDBProfiles or nil

local hadExistingNamedProfiles =
    existingProfileRoot
    and type(existingProfileRoot.profiles) == "table"
    and next(existingProfileRoot.profiles) ~= nil

local priorSharedDefault =
    existingProfileRoot
    and type(existingProfileRoot.defaultProfile) == "string"
    and existingProfileRoot.defaultProfile
    or nil

if priorSharedDefault
    and (not existingProfileRoot.profiles
         or type(existingProfileRoot.profiles[priorSharedDefault]) ~= "table") then
    priorSharedDefault = nil
end

-- Persist concrete profile values. AceDB's profile-default cleanup can otherwise
-- prune settings during logout and obscure values during legacy migrations.
local DefaultSettings = {
    global = {
        profileMigrationVersion = 1,
        legacyDefaultImported = false,
        migratedCharacters = {},
    },
}

-- The third argument mirrors flyPlateBuffsFixed's `true` behavior: all
-- characters share "Default" unless they explicitly select another profile.
-- If the earlier custom profile module had a different account default,
-- preserve that choice.
local db = AceDB:New(
    "LoseControlDBProfiles",
    DefaultSettings,
    priorSharedDefault or true
)

_G.LoseControlProfileDB = db

-- Existing profiles from the previous custom implementation are already close
-- to AceDB's storage shape (`profiles` + `profileKeys`). Never overwrite them
-- with a per-character legacy import.
if hadExistingNamedProfiles then
    db.global.legacyDefaultImported = true
end

-------------------------------------------------------------------------------
-- One-time migration from the original SavedVariablesPerCharacter DB.
-------------------------------------------------------------------------------

local charKey = CharacterKey()

if not db.global.migratedCharacters[charKey] then
    if legacyCharacterDB and legacyCharacterDB.version then
        if not db.global.legacyDefaultImported then
            local originalProfile = db:GetCurrentProfile()

            db:SetProfile(priorSharedDefault or "Default")
            ReplaceTable(db.profile, legacyCharacterDB)

            db.global.legacyDefaultImported = true

            if originalProfile ~= db:GetCurrentProfile() then
                db:SetProfile(originalProfile)
            end
        else
            -- Preserve another character's old configuration without making it
            -- active. This prevents data loss while keeping the shared Default.
            local originalProfile = db:GetCurrentProfile()
            local legacyName = "Legacy - " .. charKey

            local alreadyExists = false
            local profiles = db:GetProfiles({})
            for _, name in ipairs(profiles) do
                if name == legacyName then
                    alreadyExists = true
                    break
                end
            end

            if not alreadyExists then
                db:SetProfile(legacyName)
                ReplaceTable(db.profile, legacyCharacterDB)
                db:SetProfile(originalProfile)
            end
        end
    end

    db.global.migratedCharacters[charKey] = true
end

-- Materialize missing defaults directly in the active saved profile.
-- Never overwrite existing choices, including explicit false values. Because no
-- AceDB profile defaults are registered, these values remain in SavedVariables.
local function MergeMissingDefaults(destination, source)
    for key, value in pairs(source) do
        local existing = rawget(destination, key)
        if existing == nil then
            destination[key] = DeepCopy(value)
        elseif type(value) == "table" and type(existing) == "table" then
            MergeMissingDefaults(existing, value)
        end
    end
end

MergeMissingDefaults(db.profile, defaultsSource)

-- This is the compatibility bridge used by the existing LoseControl engine.
_G.LoseControlDB = db.profile

-------------------------------------------------------------------------------
-- Profile callbacks
--
-- LoseControl frame objects cache references to per-frame settings. A reload
-- is therefore the safest profile transition: all frame references are rebuilt
-- from the newly selected profile, with no stale combat-time references.
-------------------------------------------------------------------------------

local ProfileController = {}
local reloadPending = false
local combatFrame = CreateFrame("Frame")

local function ReloadForProfileChange()
    if InCombatLockdown and InCombatLockdown() then
        if not reloadPending then
            reloadPending = true
            combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
            DEFAULT_CHAT_FRAME:AddMessage(
                "|cff33ff99LoseControl:|r Profile changed. UI will reload when combat ends."
            )
        end
        return
    end

    ReloadUI()
end

combatFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_ENABLED" and reloadPending then
        reloadPending = false
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        ReloadUI()
    end
end)

function ProfileController:OnProfileChanged()
    ReloadForProfileChange()
end

function ProfileController:OnProfileCopied()
    ReloadForProfileChange()
end

function ProfileController:OnProfileReset()
    ReloadForProfileChange()
end

db.RegisterCallback(ProfileController, "OnProfileChanged", "OnProfileChanged")
db.RegisterCallback(ProfileController, "OnProfileCopied", "OnProfileCopied")
db.RegisterCallback(ProfileController, "OnProfileReset", "OnProfileReset")

-------------------------------------------------------------------------------
-- Standard AceDB profile options, matching flyPlateBuffsFixed's implementation.
-------------------------------------------------------------------------------

if AceDBOptions and AceConfig and AceConfigDialog then
    local profileOptions = AceDBOptions:GetOptionsTable(db)

    -- Avoid switching/copying/resetting a profile while protected frames may
    -- be combat-locked.
    profileOptions.disabled = function()
        return InCombatLockdown and InCombatLockdown()
    end

    local appName = addonName .. " Profiles"
    AceConfig:RegisterOptionsTable(appName, profileOptions)
    AceConfigDialog:AddToBlizOptions(appName, "Profiles", addonName)
end
