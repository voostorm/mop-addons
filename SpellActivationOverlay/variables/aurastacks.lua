local AddonName,SAO=...
local Module="aurastacks"
local canaccessvalue=canaccessvalue
local InCombatLockdown=InCombatLockdown
local ShouldAurasBeSecret=C_Secrets and C_Secrets.ShouldAurasBeSecret or function() return false; end
local inverseStacks=SAO.Constants.InverseAuraStacks
local anyStacks=SAO.Constants.AnyAuraStacks
SAO.AURASTACKS={
LEGACY=C_UnitAuras==nil,
MODERN=C_UnitAuras~=nil,
}
local HASH_AURA_ABSENT=1
local HASH_AURA_ANY=2
local HASH_AURA_ZERO=HASH_AURA_ANY
local HASH_AURA_MAX=HASH_AURA_ZERO + 10
local HASH_AURA_MASK=0xF
local bucketsByAuraInstanceID={}
local hasPlayerBuckets=false
local hasTargetBuckets=false
local playerBuckets={}
local targetBuckets={}
local secretBuckets={}
local secretlessBuckets={}
local function getAuraBucket(spellID,isPlayer,isTarget)
local checkBucketCompatibility=function(bucket)
if not bucket or not bucket.trigger:reactsWith(SAO.TRIGGER_AURA)then
return false
end
local isDebuffBucket=bucket.auraProps and bucket.auraProps.debuff
local isBuffBucket=not isDebuffBucket
return (isPlayer and isBuffBucket) or (isTarget and isDebuffBucket)
end
local bucket=SAO:GetBucketBySpellID(spellID)
if checkBucketCompatibility(bucket)then
return bucket
end
bucket=SAO:GetAkaBucket(spellID)
if checkBucketCompatibility(bucket)then
return bucket
end
return nil
end
SAO.Variable:register({
order=1,
core="AuraStacks",
trigger={
flag=SAO.TRIGGER_AURA,
name="aura",
},
hash={
mask=HASH_AURA_MASK,
key="aura_stacks",
setterFunc=function(self,stacks,bucket)
if type(stacks)~='number' or stacks < -1 then
SAO:Warn(Module, "Invalid stack count "..tostring(stacks))
elseif stacks==inverseStacks then
self:setMaskedHash(HASH_AURA_ABSENT,HASH_AURA_MASK)
elseif bucket and bucket.stackAgnostic then
self:setMaskedHash(HASH_AURA_ANY,HASH_AURA_MASK)
elseif stacks > 10 then
SAO:Debug(Module, "Stack overflow ("..stacks..") truncated to 10")
self:setMaskedHash(HASH_AURA_MAX,HASH_AURA_MASK)
else
self:setMaskedHash(HASH_AURA_ZERO + stacks,HASH_AURA_MASK)
end
end,
getterFunc=function(self)
local maskedHash=self:getMaskedHash(HASH_AURA_MASK)
if maskedHash==nil then return nil; end
if maskedHash==HASH_AURA_ABSENT then
return inverseStacks
end
return maskedHash - HASH_AURA_ZERO
end,
toAnyFunc=function(self)
return bit.band(self.hash,bit.bnot(HASH_AURA_MASK)) + HASH_AURA_ANY
end,
toValue=function(hash)
local auraStacks=hash:getAuraStacks()
return (auraStacks==inverseStacks and "missing") or (auraStacks==anyStacks and "any" or tostring(auraStacks))
end,
fromValue=function(hash,value)
if value=="missing" then
hash:setAuraStacks(inverseStacks)
return true
elseif value=="any" then
hash:setAuraStacks(anyStacks)
return true
elseif tostring(tonumber(value))==value then
hash:setAuraStacks(tonumber(value))
return true
else
return nil
end
end,
getHumanReadableKeyValue=function(hash)
local auraStacks=hash:getAuraStacks()
if auraStacks and auraStacks > 0 then
return SAO:NbStacks(auraStacks)
elseif auraStacks==inverseStacks then
return ACTION_SPELL_AURA_REMOVED_DEBUFF
else
return nil
end
end,
optionIndexer=function(hash)
return hash:getAuraStacks()
end,
},
bucket={
impossibleValue=-2,
fetchAndSet=function(bucket)
if bucket.auraProps and bucket.auraProps.hasSecretRestrictions and ShouldAurasBeSecret()then
return
end
local isDebuffBucket=bucket.auraProps and bucket.auraProps.debuff
local isBuffBucket=not isDebuffBucket
local auraStacks,auraInstanceID
if isBuffBucket then
local includeAka=SAO.IsModern()
auraStacks,auraInstanceID=SAO:GetPlayerAuraStacksBySpellID(bucket.spellID,includeAka)
else
local filter=bucket.auraProps.mineOnly and "HARMFUL|PLAYER" or "HARMFUL"
local includeAka=SAO.IsModern()
auraStacks,auraInstanceID=SAO:GetUnitAuraStacksBySpellID("target",filter,bucket.spellID,includeAka)
end
if auraStacks~=nil then
if bucket.stackAgnostic then
bucket:setAuraStacks(anyStacks)
else
bucket:setAuraStacks(auraStacks)
end
else
bucket:setAuraStacks(inverseStacks)
end
if SAO.AURASTACKS.MODERN then
bucket.lastKnownAuraStacks=auraStacks
if bucket.auraInstanceID~=auraInstanceID then
if bucket.auraInstanceID~=nil then
bucketsByAuraInstanceID[bucket.auraInstanceID]=nil
end
bucket.auraInstanceID=auraInstanceID
if auraInstanceID~=nil then
bucketsByAuraInstanceID[auraInstanceID]=bucket
end
end
end
end,
},
event={
isRequired=true,
names=SAO.AURASTACKS.MODERN and {
"PLAYER_TARGET_CHANGED",
C_Secrets and "ADDON_RESTRICTION_STATE_CHANGED" or nil,
} or {
"COMBAT_LOG_EVENT_UNFILTERED"
},
unitNames=SAO.AURASTACKS.MODERN and {player="UNIT_AURA",target={"UNIT_AURA", "UNIT_FACTION"}} or nil,
COMBAT_LOG_EVENT_UNFILTERED=SAO.AURASTACKS.LEGACY and function(...)
local _,event,_,srcGUID,_,_,_,destGUID=CombatLogGetCurrentEventInfo()
local isPlayer=destGUID==UnitGUID("player")
local isTarget=destGUID==UnitGUID("target")
local acceptedUnit=(hasPlayerBuckets and isPlayer) or (hasTargetBuckets and isTarget)
if not acceptedUnit then
return
end
if ((event:sub(0,11)=="SPELL_AURA_") and (isPlayer or isTarget))then
local spellID,spellName=select(12,CombatLogGetCurrentEventInfo())
local auraApplied=event:sub(0,18)=="SPELL_AURA_APPLIED"; -- includes "SPELL_AURA_APPLIED" and "SPELL_AURA_APPLIED_DOSE"
local auraRemovedLast=event=="SPELL_AURA_REMOVED"
local auraRemovedDose=event=="SPELL_AURA_REMOVED_DOSE"
local auraRefresh=event=="SPELL_AURA_REFRESH"
if not auraApplied and not auraRemovedLast and not auraRemovedDose and not auraRefresh then
return
end
local bucket
bucket,spellID=SAO:GetBucketBySpellIDOrSpellName(spellID,spellName)
if not bucket then
return
end
if not bucket.trigger:reactsWith(SAO.TRIGGER_AURA)then
return
end
local getBuffDebuffBucket=function(bucket)
local isDebuffBucket=bucket.auraProps and bucket.auraProps.debuff
local isBuffBucket=not isDebuffBucket
return isBuffBucket,isDebuffBucket
end
local isBucketCompatible=function(bucket,isPlayer,isTarget)
local isBuffBucket,isDebuffBucket=getBuffDebuffBucket(bucket)
return (isBuffBucket and isPlayer) or (isDebuffBucket and isTarget)
end
if not isBucketCompatible(bucket,isPlayer,isTarget)then
local otherBucket=SAO:GetAkaBucket(spellID)
if otherBucket and otherBucket.trigger:reactsWith(SAO.TRIGGER_AURA) and isBucketCompatible(otherBucket,isPlayer,isTarget)then
bucket=otherBucket
else
return
end
end
local isBuffBucket,isDebuffBucket=getBuffDebuffBucket(bucket)
if isDebuffBucket and bucket.auraProps.mineOnly and srcGUID~=UnitGUID("player")then
return
end
if (auraRefresh)then
bucket:refresh()
return
end
if (auraRemovedLast)then
bucket:setAuraStacks(inverseStacks); -- inverseStacks means "not currently holding any stacks"
return
end
local stacks=anyStacks
if not bucket.stackAgnostic then
if event~="SPELL_AURA_REMOVED" then
if isBuffBucket then
stacks=SAO:GetPlayerAuraStacksBySpellID(spellID) or anyStacks
elseif isDebuffBucket then
local filter=bucket.auraProps.mineOnly and "HARMFUL|PLAYER" or "HARMFUL"
stacks=SAO:GetUnitAuraStacksBySpellID("target",filter,spellID) or anyStacks
end
end
end
bucket:setAuraStacks(stacks)
end
end or nil,
UNIT_AURA=SAO.AURASTACKS.MODERN and function(unitTarget,updateInfo)
local isPlayer=unitTarget=="player" -- or (canaccessvalue(UnitIsUnit(unitTarget, "player")) and UnitIsUnit(unitTarget, "player"))
local isTarget=unitTarget=="target" -- or (canaccessvalue(UnitIsUnit(unitTarget, "target")) and UnitIsUnit(unitTarget, "target"))
local acceptedUnit=(hasPlayerBuckets and isPlayer) or (hasTargetBuckets and isTarget)
if not acceptedUnit then
return
end
if not canaccessvalue(updateInfo.isFullUpdate) or
not canaccessvalue(updateInfo.updatedAuraInstanceIDs) or
not canaccessvalue(updateInfo.removedAuraInstanceIDs) or
not canaccessvalue(updateInfo.addedAuras)
then
for _,bucket in ipairs(secretlessBuckets)do
SAO:Debug(Module, "Checking buckets manually for secretless aura",bucket.name)
bucket.trigger:manualCheck(SAO.TRIGGER_AURA)
end
if SAO.IsModern()then
return
else
SAO:Warn(Module, "Dealing with secret aura information in a flavor which is not supposed to have them:",SAO.GetFlavorName())
end
end
if canaccessvalue(updateInfo.isFullUpdate) and updateInfo.isFullUpdate then
SAO:Debug(Module, "Full aura update detected,rechecking all buckets")
SAO:CheckManuallyAllBuckets(SAO.TRIGGER_AURA)
return
end
local addAura=function(auraInstanceID,aura,bucket)
local isDebuffBucket=bucket.auraProps and bucket.auraProps.debuff
if isDebuffBucket and bucket.auraProps.mineOnly and not aura.isFromPlayerOrPlayerPet then
return
end
bucket:setAuraStacks((bucket.stackAgnostic and anyStacks) or aura.applications)
bucket.lastKnownAuraStacks=aura.applications
if bucket.auraInstanceID then
bucketsByAuraInstanceID[bucket.auraInstanceID]=nil
bucket:refresh()
end
bucket.auraInstanceID=auraInstanceID
bucketsByAuraInstanceID[auraInstanceID]=bucket
end
local removeAura=function(auraInstanceID,bucket)
bucket:setAuraStacks(inverseStacks)
bucket.lastKnownAuraStacks=nil
bucket.auraInstanceID=nil
bucketsByAuraInstanceID[auraInstanceID]=nil
end
local updateAura=function(auraInstanceID,aura,bucket)
if bucket.lastKnownAuraStacks~=aura.applications then
bucket:setAuraStacks((bucket.stackAgnostic and anyStacks) or aura.applications)
bucket.lastKnownAuraStacks=aura.applications
else
bucket:refresh()
end
end
for _,aura in ipairs(canaccessvalue(updateInfo.addedAuras) and updateInfo.addedAuras or {})do
local bucket=getAuraBucket(aura.spellId,isPlayer,isTarget)
if bucket and bucket.trigger:reactsWith(SAO.TRIGGER_AURA)then
local auraInstanceID=aura.auraInstanceID
if bucket.auraInstanceID==auraInstanceID then
updateAura(auraInstanceID,aura,bucket)
else
addAura(auraInstanceID,aura,bucket)
end
end
end
for _,auraInstanceID in ipairs(canaccessvalue(updateInfo.updatedAuraInstanceIDs) and updateInfo.updatedAuraInstanceIDs or {})do
local bucket=bucketsByAuraInstanceID[auraInstanceID]
if bucket then
local aura=C_UnitAuras.GetAuraDataByAuraInstanceID(unitTarget,auraInstanceID)
if not aura then
removeAura(auraInstanceID,bucket)
else
updateAura(auraInstanceID,aura,bucket)
end
end
end
for _,auraInstanceID in ipairs(canaccessvalue(updateInfo.removedAuraInstanceIDs) and updateInfo.removedAuraInstanceIDs or {})do
local bucket=bucketsByAuraInstanceID[auraInstanceID]
if bucket then
removeAura(auraInstanceID,bucket)
end
end
end or nil,
UNIT_FACTION=SAO.AURASTACKS.MODERN and function(self,unitTarget)
if #secretBuckets==0 then
return
end
local isTarget=unitTarget=="target" -- or (canaccessvalue(UnitIsUnit(unitTarget, "target")) and UnitIsUnit(unitTarget, "target"))
if isTarget then
SAO.AuraContainer:updateAll()
end
end or nil,
PLAYER_TARGET_CHANGED=SAO.AURASTACKS.MODERN and function(self)
if not hasTargetBuckets then
return
end
for _,bucket in ipairs(secretlessBuckets)do
SAO:Debug(Module, "Checking buckets manually for secretless aura due to target change",bucket.name)
bucket.trigger:manualCheck(SAO.TRIGGER_AURA)
end
if #secretBuckets > 0 then
SAO.AuraContainer:updateAll()
end
end or nil,
ADDON_RESTRICTION_STATE_CHANGED=SAO.AURASTACKS.MODERN and C_Secrets and function(self)
if ShouldAurasBeSecret()then
return
end
for _,bucket in ipairs(secretBuckets)do
SAO:Debug(Module, "Checking buckets manually for secret aura",bucket.name)
bucket.trigger:manualCheck(SAO.TRIGGER_AURA)
end
end or nil,
},
condition={
noeVar="aura",
hreVar="stacks",
noeDefault=anyStacks,
description="number of stacks",
checker=function(value) return type(value)=='number' and value >=-1 and value <=10 end,
noeToHash=function(value) return value end,
},
import={
noeTrigger="aura",
hreTrigger="requireAura",
dependency={
name="auraProps",
expectedType="table",
default=function(effect) return {} end,
prepareBucket=function(bucket,value)
bucket.auraProps={}
local allowedProps={hasSecretRestrictions='boolean',debuff='boolean',mineOnly='boolean'}
for key,prop in pairs(value)do
bucket.auraProps[key]=prop
end
if bucket.auraProps.debuff==true then
table.insert(targetBuckets,bucket)
hasTargetBuckets=true
else
table.insert(playerBuckets,bucket)
hasPlayerBuckets=true
end
if type(bucket.auraProps.hasSecretRestrictions)~='boolean' then
local doesSpellHaveSecretRestrictions=function(auraID)
if not C_Secrets or not C_Secrets.GetSpellAuraSecrecy then
return false
end
local secrecy=SAO:IsSpellSecret(auraID)
if secrecy==1 then
SAO:Debug(Module,bucket.description.." is based on spell "..auraID.." which has secret restrictions")
elseif secrecy==2 then
SAO:Debug(Module,bucket.description.." is based on spell "..auraID.." which is always secret")
end
return type(secrecy)=='number' and secrecy > 0
end
local hasSecretRestrictions=doesSpellHaveSecretRestrictions(bucket.spellID)
for _,akaSpellID in ipairs(SAO:GetAkaSpellIDsByEffectSpellID(bucket.spellID) or {})do
hasSecretRestrictions=doesSpellHaveSecretRestrictions(akaSpellID) or hasSecretRestrictions
end
bucket.auraProps.hasSecretRestrictions=hasSecretRestrictions
end
if bucket.auraProps.hasSecretRestrictions then
table.insert(secretBuckets,bucket)
else
table.insert(secretlessBuckets,bucket)
end
end,
},
classes={
force="aura",
ignore=nil,
},
},
macro={
getCondition=nil,
},
})
