local AddonName,SAO=...
local Module="stance"
local GetNumShapeshiftForms=GetNumShapeshiftForms
local GetShapeshiftForm=GetShapeshiftForm
local GetShapeshiftFormInfo=GetShapeshiftFormInfo
local HASH_STANCE_NO=0x08000
local HASH_STANCE_YES=0x10000
local HASH_STANCE_MASK=0x18000
SAO.Variable:register({
order=7,
core="MatchStance",
trigger={
flag=SAO.TRIGGER_STANCE,
name="stance",
},
hash={
mask=HASH_STANCE_MASK,
key="match_stance",
setterFunc=function(self,matchStance)
if type(matchStance)~='boolean' then
SAO:Warn(Module, "Invalid MatchStance flag "..tostring(matchStance))
else
local maskedHash=matchStance and HASH_STANCE_YES or HASH_STANCE_NO
self:setMaskedHash(maskedHash,HASH_STANCE_MASK)
end
end,
getterFunc=function(self)
local maskedHash=self:getMaskedHash(HASH_STANCE_MASK)
if maskedHash==nil then return nil; end
return maskedHash==HASH_STANCE_YES
end,
toAnyFunc=nil,
toValue=function(hash)
local stance=hash:getMatchStance()
return stance and "yes" or "no"
end,
fromValue=function(hash,value)
if value=="yes" then
hash:setMatchStance(true)
return true
elseif value=="no" then
hash:setMatchStance(false)
return true
else
return nil
end
end,
getHumanReadableKeyValue=function(hash)
return nil
end,
optionIndexer=function(hash)
return hash:getMatchStance() and 0 or -1
end,
},
bucket={
impossibleValue=nil,
fetchAndSet=function(bucket)
local currentStanceIndex=GetShapeshiftForm()
if currentStanceIndex==nil then
bucket:setMatchStance(nil)
elseif currentStanceIndex==0 then
bucket:setMatchStance(false)
elseif currentStanceIndex > GetNumShapeshiftForms()then
bucket:setMatchStance(false)
else
local _,_,_,currentStanceSpellID=GetShapeshiftFormInfo(currentStanceIndex)
if not currentStanceSpellID then
bucket:setMatchStance(nil)
elseif bucket.stanceID then
bucket:setMatchStance(currentStanceSpellID==bucket.stanceID)
elseif bucket.stanceIDs then
for _,expectedStanceID in ipairs(bucket.stanceIDs)do
if currentStanceSpellID==expectedStanceID then
bucket:setMatchStance(true)
return
end
end
bucket:setMatchStance(false)
end
end
end,
},
event={
isRequired=true,
names={"UPDATE_SHAPESHIFT_FORM"},
UPDATE_SHAPESHIFT_FORM=function(...)
SAO:CheckManuallyAllBuckets(SAO.TRIGGER_STANCE)
end,
},
condition={
noeVar="stance",
hreVar="matchStance",
noeDefault=true,
description="stance match flag",
checker=function(value) return type(value)=='boolean' end,
noeToHash=function(value) return value end,
},
import={
noeTrigger="stance",
hreTrigger="useStance",
dependency={
name="stances",
expectedType="table",
default=function(effect) return nil end,
prepareBucket=function(bucket,value)
if #value==1 then
bucket.stanceID=value[1]
else
bucket.stanceIDs=value
end
end,
},
classes={
force=nil,
ignore=nil,
},
},
macro={
getCondition=function(bucket,hash)
if not hash:hasMatchStance()then
return nil
end
local getMacroStanceIndex=function(spellID)
for i=1,GetNumShapeshiftForms()do
local _,_,_,formSpellID=GetShapeshiftFormInfo(i)
if spellID==formSpellID then
return i
end
end
return nil
end
local stances={}
if type(bucket.stanceID)=='number' then
local stanceIndex=getMacroStanceIndex(bucket.stanceID)
if stanceIndex then
table.insert(stances,stanceIndex)
end
elseif type(bucket.stanceIDs)=='table' then
local stanceSet={}
for _,stanceID in ipairs(bucket.stanceIDs)do
local stanceIndex=getMacroStanceIndex(stanceID)
if stanceIndex then
stanceSet[stanceIndex]=true
end
end
for stanceIndex,_ in pairs(stanceSet)do
table.insert(stances,stanceIndex)
end
end
local matchStance=hash:getMatchStance()
if matchStance then
return "stance:"..table.concat(stances,'/')
else
return "nostance:"..table.concat(stances,'/')
end
end,
},
})
