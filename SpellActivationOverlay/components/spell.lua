local AddonName,SAO=...
local GetSpellAuraSecrecy=C_Secrets and C_Secrets.GetSpellAuraSecrecy
local GetSpellCooldownLegacy=GetSpellCooldown
local GetSpellCooldownModern=C_Spell and C_Spell.GetSpellCooldown
local GetSpellInfoLegacy=GetSpellInfo
local GetSpellInfoModern=C_Spell and C_Spell.GetSpellInfo
local GetSpellPowerCost=C_Spell and C_Spell.GetSpellPowerCost or GetSpellPowerCost
local IsSpellKnownOrOverridesKnown=IsSpellKnownOrOverridesKnown
if C_SpellBook and C_SpellBook.IsSpellInBook then
IsSpellKnownOrOverridesKnown=function(spellID)
return C_SpellBook.IsSpellInBook(spellID,false,true)
end
end
local SpellIDsByName={}
local ObservedSpellIDs={}
function SAO:DoesSpellExist(spellID)
if GetSpellInfoModern then
local spellInfo=GetSpellInfoModern(spellID)
return spellInfo~=nil
end
local spellName=GetSpellInfoLegacy(spellID)
return spellName~=nil
end
function SAO:GetSpellName(spellID,defaultName)
if GetSpellInfoModern then
local spellInfo=GetSpellInfoModern(spellID)
return spellInfo and spellInfo.name or defaultName
end
local spellName=GetSpellInfoLegacy(spellID)
return spellName or defaultName
end
function SAO:GetSpellIconAndText(spellID)
if GetSpellInfoModern then
local spellInfo=GetSpellInfoModern(spellID)
if spellInfo then
local spellName,spellIcon=spellInfo.name,spellInfo.iconID
return "|T"..spellIcon..":0|t "..spellName
end
return nil
end
local spellName,_,spellIcon=GetSpellInfoLegacy(spellID)
if spellName then
return "|T"..spellIcon..":0|t "..spellName
end
return nil
end
function SAO:GetSpellCooldown(spellID)
if GetSpellCooldownModern then
local cooldownInfo=GetSpellCooldownModern(spellID)
if cooldownInfo==nil then
return nil,nil,nil,nil
end
return cooldownInfo.startTime,
cooldownInfo.duration,
cooldownInfo.isActive==true,
cooldownInfo.isOnGCD==true
end
local startTime,duration=GetSpellCooldownLegacy(spellID)
local isOnCD=startTime > 0
local gcdDuration=SAO:GetGCD()
local isOnGCD=duration <=gcdDuration
return startTime,duration,isOnCD,isOnGCD
end
function SAO:GetSpellPowerCost(spellID)
return GetSpellPowerCost(spellID)
end
function SAO.GetSpellIDsByName(self,name)
local cached=SpellIDsByName[name]
if (cached)then
return cached
end
self:RefreshSpellIDsByName(name)
return SpellIDsByName[name]
end
function SAO.RefreshSpellIDsByName(self,name,awaken)
local spellsIDsByName=self:GetHomonymSpellIDs(name)
for spellID,spellName in pairs(ObservedSpellIDs)do
if not tContains(spellsIDsByName,spellID) and spellName==name then
tinsert(spellsIDsByName,spellID)
end
end
SpellIDsByName[name]=spellsIDsByName
if (awaken)then
for _,spellID in ipairs(spellsIDsByName)do
if (not self.RegisteredGlowSpellIDs[spellID])then
self.RegisteredGlowSpellIDs[spellID]=true
self:AwakeButtonsBySpellID(spellID)
end
end
end
end
function SAO:LearnNewSpell(spellID,observed)
local name=self:GetSpellName(spellID)
if not name then
return
end
if observed then
ObservedSpellIDs[spellID]=name
end
local cached=SpellIDsByName[name]
if not cached then
return
end
for _,id in ipairs(cached)do
if id==spellID then
return
end
end
table.insert(SpellIDsByName[name],spellID)
if (self.RegisteredGlowSpellNames[name])then
self.RegisteredGlowSpellIDs[spellID]=true
self:AwakeButtonsBySpellID(spellID)
end
end
function SAO:IsSpellIdentical(spellID,spellName,referenceID)
if spellID~=0 then
return spellID==referenceID
else
return spellName==self:GetSpellName(referenceID)
end
end
local canHaveMultipleRanks=SAO.IsProject(SAO.ALL_PROJECTS - SAO.CATA_AND_ONWARD)
function SAO:IsSpellLearned(spellID)
if IsSpellKnownOrOverridesKnown(spellID)then
return true
end
if canHaveMultipleRanks then
local spellName=self:GetSpellName(spellID)
for _,id in ipairs(SpellIDsByName[spellName] or {})do
if IsSpellKnownOrOverridesKnown(id)then
return true
end
end
end
return false
end
function SAO.GetSpellEndTime(self,spellID,suggestedEndTime,extra)
if type(suggestedEndTime)=='number'
or type(suggestedEndTime)=='table' and type(suggestedEndTime.endTime)=='number' then
return suggestedEndTime
end
if (not self.Frame.useTimer)then
return
end
if not extra or not extra.debuff then
local duration,expirationTime=self:GetPlayerAuraDurationExpirationTimeBySpellIdOrName(spellID)
if type(duration)=='number' and type(expirationTime)=='number' then
local startTime,endTime=expirationTime-duration,expirationTime
return {startTime=startTime,endTime=endTime}
elseif type(expirationTime)=='number' then
return expirationTime
end
local highestExpirationTime=0
local bestResult
for _,akaSpellID in ipairs(SAO:GetAkaSpellIDsByEffectSpellID(spellID) or {})do
local duration,expirationTime=self:GetPlayerAuraDurationExpirationTimeBySpellIdOrName(akaSpellID)
if type(duration)=='number' and type(expirationTime)=='number' then
local startTime,endTime=expirationTime-duration,expirationTime
if expirationTime > highestExpirationTime then
highestExpirationTime=expirationTime
bestResult={startTime=startTime,endTime=endTime}
end
elseif type(expirationTime)=='number' then
if expirationTime > highestExpirationTime then
highestExpirationTime=expirationTime
bestResult=expirationTime
end
end
end
return bestResult
end
if not C_UnitAuras or not C_UnitAuras.GetUnitAuras then
return
end
local filter=extra.mineOnly and "HARMFUL|PLAYER" or "HARMFUL"
local auras={}
for _,aura in ipairs(C_UnitAuras.GetUnitAuras("target",filter,spellID) or {})do
table.insert(auras,aura)
end
for _,akaSpellID in ipairs(SAO:GetAkaSpellIDsByEffectSpellID(spellID) or {})do
for _,aura in ipairs(C_UnitAuras.GetUnitAuras("target",filter,akaSpellID) or {})do
table.insert(auras,aura)
end
end
local bestResult
for _,aura in ipairs(auras)do
if type(aura.expirationTime)=='number' then
if aura.expirationTime > (bestResult and bestResult.endTime or 0)then
bestResult={startTime=aura.expirationTime-aura.duration,endTime=aura.expirationTime}
end
end
end
return bestResult
end
function SAO.IsSpellSecret(self,spellID)
if not GetSpellAuraSecrecy then
return false
end
local secrecy=GetSpellAuraSecrecy(spellID)
if secrecy then
if secrecy==Enum.SecrecyLevel.ContextuallySecret then
return 1
elseif secrecy==Enum.SecrecyLevel.AlwaysSecret then
return 2
end
end
return false
end
function SAO.IsFakeSpell(self,spellID)
if spellID >=1000000 then
return true
end
if (self.IsEra() or self.IsTBC() or self.IsWrath() or self.IsCata()) and spellID==48107 then
return true
end
if spellID==96215 then
return true
end
return false
end
