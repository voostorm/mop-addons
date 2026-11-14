local AddonName,SAO=...
local Module="sound"
local GetTime=GetTime
local PlaySound=PlaySound
local PlaySoundFile=PlaySoundFile
local StopSound=StopSound
local timeOfLastPlayedAlert
local mustUseLocalSound=SAO.IsProject(
SAO.ERA + SAO.TBC + SAO.WRATH +
SAO.FOREVER + SAO.RETAIL
)
local localSound="Interface\\AddOns\\SpellActivationOverlay\\sounds\\UI_PowerAura_Generic.ogg"
local gameSound=SOUNDKIT.UI_POWER_AURA_GENERIC
function SAO.PlaySpellAlertSound(self)
if GetTime()==timeOfLastPlayedAlert then
return
end
local willPlay,soundHandle
if mustUseLocalSound then
willPlay,soundHandle=PlaySoundFile(localSound)
else
willPlay,soundHandle=PlaySound(gameSound)
end
if willPlay then
timeOfLastPlayedAlert=GetTime()
return soundHandle
end
end
function SAO.StopSpellAlertSound(self,handle,fadeoutTime)
if handle then
StopSound(handle,fadeoutTime)
end
end
SAO.AuraSoundLibrary={
globalEnabled=true,
enableItem=function(self,item)
for spellID,_ in pairs(item.includeSpellIDs)do
if not self[spellID] then
self[spellID]={
items={},
auraSoundIDs=nil,
}
end
self[spellID].items[item.id]=item
if not self[spellID].auraSoundIDs and self.globalEnabled then
local auraSoundID1,auraSoundID2=self:_internalAddSound(spellID,item.unit)
SAO:Debug(Module, "Enabling sound for spell ID",spellID)
self[spellID].auraSoundIDs={auraSoundID1,auraSoundID2}
end
end
end,
disableItem=function(self,item)
for spellID,_ in pairs(item.includeSpellIDs)do
if self[spellID] then
self[spellID].items[item.id]=nil
if next(self[spellID].items)==nil and self[spellID].auraSoundIDs then
self:_internalRemoveSound(unpack(self[spellID].auraSoundIDs))
SAO:Debug(Module, "Disabling sound for spell ID",spellID)
self[spellID].auraSoundIDs=nil
end
end
end
end,
setGlobalEnabled=function(self,enabled)
if self.globalEnabled==enabled then
return
end
self.globalEnabled=enabled
for spellID,soundData in pairs(self)do
if type(spellID)=='number' then
if soundData.auraSoundIDs and not enabled then
self:_internalRemoveSound(unpack(soundData.auraSoundIDs))
SAO:Debug(Module, "Global sound disable is disabling sound of spell ID",spellID)
soundData.auraSoundIDs=nil
elseif not soundData.auraSoundIDs and enabled then
local firstItemID,firstItem=next(soundData.items)
if firstItemID and firstItem then
local unit=firstItem.unit
local auraSoundID1,auraSoundID2=self:_internalAddSound(spellID,unit)
SAO:Debug(Module, "Global sound enable is enabling sound of spell ID",spellID)
soundData.auraSoundIDs={auraSoundID1,auraSoundID2}
end
end
end
end
end,
_internalAddSound=function(self,spellID,unit)
local trigger1=Enum.UnitAuraSoundTrigger.Added
local trigger2=Enum.UnitAuraSoundTrigger.ApplicationsIncreased
local sound={
unitToken=unit,
spellID=spellID,
soundFileName=mustUseLocalSound and localSound or nil,
soundFileID=not mustUseLocalSound and gameSound or nil,
}
local auraSoundID1=C_UnitAuras.AddAuraSound(trigger1,sound)
local auraSoundID2=C_UnitAuras.AddAuraSound(trigger2,sound)
return auraSoundID1,auraSoundID2
end,
_internalRemoveSound=function(self,auraSoundID1,auraSoundID2)
C_UnitAuras.RemoveAuraSound(auraSoundID1)
C_UnitAuras.RemoveAuraSound(auraSoundID2)
end,
}
