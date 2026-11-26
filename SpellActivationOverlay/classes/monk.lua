local AddonName,SAO=...
local tranquilizingShot=19801
local blackoutKick=100784
local tigerPalm=100787
local touchOfDeath=115080
local IsUsableSpell=C_Spell and C_Spell.IsSpellUsable or IsUsableSpell
local function useComboBreakerBlackoutKick()
SAO:CreateEffect(
"cb_blackout_kick",
SAO.MOP,
116768,
"aura",
{
overlay={texture="monk_tiger",position="Right (Flipped)"},
button={spellID=blackoutKick,option={isNative=true}},
}
)
end
local function useComboBreakerTigerPalm()
SAO:CreateEffect(
"cb_tiger_palm",
SAO.MOP,
118864,
"aura",
{
overlay={texture="monk_tiger",position="Left",color={0,255,127}},
button={spellID=tigerPalm,option={isNative=true}},
}
)
end
local function useVitalMists()
SAO:CreateEffect(
"vital_mists",
SAO.MOP,
118674,
"aura",
{
aka=122107,
overlay={stacks=5,texture="monk_serpent",position="Left + Right (Flipped)"},
}
)
end
local function isTouchOfDeathAvailable()
if not SAO:IsSpellLearned(touchOfDeath) or not UnitCanAttack("player", "target") or UnitIsDead("target") then
return false
end
local targetHealth=UnitHealth("target")
local playerHealth=UnitHealth("player")
local targetMaxHealth=UnitHealthMax("target")
if type(targetHealth)~="number" or targetHealth<=0
or type(playerHealth)~="number" or playerHealth<=0
or type(targetMaxHealth)~="number" or targetMaxHealth<=0 then
return false
end
if UnitIsPlayer("target") then
-- A player below 10% is executable even if the Death Note aura has not updated yet.
if targetHealth/targetMaxHealth>0.10 then
return false
end
elseif select(2,IsInInstance())=="arena" or targetHealth>playerHealth then
-- Pets can be executable normally, but must not trigger arena PvP glows.
return false
end
-- A spell-range check is more accurate than an estimated distance to the target.
-- Nil means this client cannot check the range, not that the target is out of range.
local inRange
if C_Spell and type(C_Spell.IsSpellInRange)=="function" then
inRange=C_Spell.IsSpellInRange(touchOfDeath,"target")
elseif type(IsSpellInRange)=="function" then
local spellName=SAO:GetSpellName(touchOfDeath)
if spellName then
inRange=IsSpellInRange(spellName,"target")
end
end
if inRange==false or inRange==0 then
return false
end
-- Let the client resolve Chi cost (including the glyph) and other usability rules.
if not IsUsableSpell(touchOfDeath) then
return false
end
local _,_,onCooldown,onGCD=SAO:GetSpellCooldown(touchOfDeath)
return not onCooldown or onGCD
end
local function refreshTouchOfDeath(bucket)
bucket.trigger:manualCheck(SAO.TRIGGER_CUSTOM)
end
-- Movement alone may not fire a health or usability event; check range while fighting.
-- Reuse the custom event frame, with one throttled OnUpdate and no repeating timers.
local function updateTouchOfDeathRange(frame,elapsed)
frame.todElapsed=(frame.todElapsed or 0)+elapsed
if frame.todElapsed>=0.15 then
frame.todElapsed=0
if UnitExists("target") then
refreshTouchOfDeath(frame.todBucket)
end
end
end
local function updateTouchOfDeathCombat(bucket)
local frame=bucket.custom and bucket.custom.frame
if frame then
if InCombatLockdown() then
frame.todBucket=bucket
frame.todElapsed=0
frame:SetScript("OnUpdate",updateTouchOfDeathRange)
else
frame:SetScript("OnUpdate",nil)
frame.todBucket=nil
end
end
refreshTouchOfDeath(bucket)
end
local function refreshTouchOfDeathPower(bucket,state,unit,powerType)
if unit=="player" and powerType=="CHI" then
refreshTouchOfDeath(bucket)
end
end
local function useTouchOfDeath()
SAO:CreateEffect(
"touch_of_death",
SAO.MOP,
touchOfDeath,
"custom",
{
button=touchOfDeath,
custom={
isActivated=isTouchOfDeathAvailable,
events={
["PLAYER_TARGET_CHANGED"]=refreshTouchOfDeath,
["PLAYER_ENTERING_WORLD"]=updateTouchOfDeathCombat,
["PLAYER_REGEN_DISABLED"]=updateTouchOfDeathCombat,
["PLAYER_REGEN_ENABLED"]=updateTouchOfDeathCombat,
["SPELL_UPDATE_USABLE"]=refreshTouchOfDeath,
["SPELL_UPDATE_COOLDOWN"]=refreshTouchOfDeath,
["SPELLS_CHANGED"]=refreshTouchOfDeath,
["PLAYER_EQUIPMENT_CHANGED"]=refreshTouchOfDeath,
[{"UNIT_AURA", "player"}]=refreshTouchOfDeath,
[{"UNIT_HEALTH", "target", "player"}]=refreshTouchOfDeath,
[{"UNIT_HEALTH_FREQUENT", "target", "player"}]=refreshTouchOfDeath,
[{"UNIT_MAXHEALTH", "target", "player"}]=refreshTouchOfDeath,
[{"UNIT_POWER_UPDATE", "player"}]=refreshTouchOfDeathPower,
},
},
}
)
end
local function registerClass(self)
useComboBreakerBlackoutKick()
useComboBreakerTigerPalm()
useVitalMists()
useTouchOfDeath()
end
SAO.Class["MONK"]={
["Register"]=registerClass,
}
