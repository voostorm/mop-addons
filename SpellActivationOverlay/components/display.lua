local AddonName,SAO=...
local Module="display"
local InCombatLockdown=InCombatLockdown
SAO.Display={
new=function(self,parent,hash,optionIndex)
local display={
parent=parent,
spellID=parent.spellID,
hash=hash,
overlays={},
buttons={},
combatOnly=false,
status='off',
softTimer=nil,
}
if hash==0 then
SAO:Debug(Module, "Creating display with invalid hash==0 for "..parent.description)
end
local hashData={
optionIndex=nil,
optionAnyStacks=nil,
legacyGlowingOption=true,
}
if optionIndex then
hashData.optionIndex=optionIndex
local legacyReady=type(hashData.optionIndex)=='number'
if not legacyReady then
SAO:Warn(Module, "Display of "..parent.description.." is based on option index "..tostring(hashData.optionIndex).." which requires migrating its option")
end
else
local tempHash=SAO.Hash:new(hash)
hashData.optionIndex=tempHash:toOptionIndex()
local legacyReady=type(hashData.optionIndex)=='number'
if not legacyReady then
SAO:Warn(Module, "Display of "..parent.description.." is based on hash "..hash.." ("..tempHash:toString()..") which requires migrating its option")
end
if tempHash:hasAuraStacks()then
local stacks=tempHash:getAuraStacks()
if stacks~=0 then
tempHash.hash=tempHash:toAnyAuraStacks()
hashData.optionAnyStacks=tempHash:toOptionIndex()
end
end
end
display.hashData=hashData
self.__index=nil
setmetatable(display,self)
self.__index=self
return display
end,
addOverlay=function(self,overlay)
if type(overlay.texture)=='string' or type(overlay.texture)=='number' then
SAO:MarkTexture(overlay.texture)
end
local _overlay={
index=overlay.index,
spellID=overlay.spellID,
texture=overlay.texture,
position=overlay.position,
level=overlay.level,
scale=overlay.scale or 1,
r=overlay.color and overlay.color[1] or 255,
g=overlay.color and overlay.color[2] or 255,
b=overlay.color and overlay.color[3] or 255,
a=overlay.color and overlay.color[4] or 255,
autoPulse=type(overlay.autoPulse)=='function' and overlay.autoPulse or overlay.autoPulse~=false,
combatOnly=overlay.combatOnly==true,
hash=overlay.hash,
macroCondition=self.parent:craftMacroCondition(overlay.hash),
auraContainerItem=nil,
}
if self.parent and self.parent.auraProps and self.parent.auraProps.hasSecretRestrictions then
local extra=self:getExtra()
_overlay.auraContainerItem=SAO.AuraContainer:registerOverlay(_overlay,extra)
end
tinsert(self.overlays,_overlay)
end,
addButton=function(self,button)
if type(button)~='number' and type(button)~='string' then
SAO:Warn(Module, "Wrong spell for button")
end
tinsert(self.buttons,button)
end,
setCombatOnly=function(self,combatOnly)
self.combatOnly=combatOnly
end,
checkCombat=function(self,inCombat)
if not self.combatOnly then
return
end
if self.status=='off' then
return
elseif self.status=='soft' and inCombat then
self:setStatus('hard')
elseif self.status=='hard' and not inCombat then
self:setStatus('soft')
end
end,
checkOption=function(self)
if #self.overlays > 0 then
local isDiscarded=SAO:IsOverlayDiscardedByOption(self.spellID,self.hashData.optionIndex,self.hashData.optionAnyStacks)
local isEnabled=not isDiscarded
for _,overlay in ipairs(self.overlays)do
if overlay.auraContainerItem then
overlay.auraContainerItem:setEnabled(isEnabled)
else
end
end
end
end,
getExtra=function(self,overlay)
local extra
if overlay and overlay.level then
extra=extra or {}
extra.level=overlay.level
end
if self.parent and self.parent.auraProps and self.parent.auraProps.debuff then
extra=extra or {}
extra.debuff=true
end
if self.parent and self.parent.auraProps and self.parent.auraProps.mineOnly then
extra=extra or {}
extra.mineOnly=true
end
return extra
end,
showOverlays=function(self,options)
for _,overlay in ipairs(self.overlays)do
local forcePulsePlay
if options and options.mimicPulse then
forcePulsePlay=overlay.autoPulse
end
if overlay.auraContainerItem then
SpellActivationOverlayFrame_ResetCombatFade(SAO.Frame)
overlay.auraContainerItem:setVisible(true)
else
local extra=self:getExtra(overlay)
SAO:ActivateOverlay(self.hashData,overlay.spellID,overlay.texture,overlay.position,overlay.scale,overlay.r,overlay.g,overlay.b,overlay.a,overlay.autoPulse,forcePulsePlay,nil,overlay.combatOnly,extra)
end
end
end,
hideOverlays=function(self)
if #self.overlays > 0 then
for _,overlay in ipairs(self.overlays)do
if overlay.auraContainerItem then
overlay.auraContainerItem:setVisible(false)
end
end
SAO:DeactivateOverlay(self.spellID)
end
end,
showButtons=function(self,options)
if #self.buttons > 0 then
SAO:AddGlow(self.spellID,self.buttons,self.hashData)
end
end,
hideButtons=function(self)
if #self.buttons > 0 then
SAO:RemoveGlow(self.spellID,self.buttons)
end
end,
show=function(self,options)
if SAO:HasDebug()then
local hashCalculator=SAO.Hash:new(self.hash)
local hashDescription=string.format("%s (0x%X=%d)",hashCalculator:toString(),self.hash,self.hash)
SAO:Debug(Module, "Showing hash "..hashDescription.." of "..self.parent.description)
end
self.parent:setDisplayed(self.hash,true)
if not self.combatOnly or InCombatLockdown()then
self:setStatus('hard',options)
else
self:setStatus('soft',options)
end
end,
hide=function(self)
if SAO:HasDebug()then
local hashCalculator=SAO.Hash:new(self.hash)
local hashDescription=string.format("%s (0x%X=%d)",hashCalculator:toString(),self.hash,self.hash)
SAO:Debug(Module, "Hiding hash "..hashDescription.." of "..self.parent.description)
end
self.parent:setDisplayed(self.hash,false)
self:setStatus('off')
end,
refresh=function(self)
SAO:Debug(Module, "Refreshing aura of "..self.spellID.." "..SAO:GetSpellName(self.spellID, ""))
local extra=self:getExtra()
SAO:RefreshOverlayTimer(self.spellID,nil,extra)
end,
setStatus=function(self,status,options)
local oldStatus,newStatus=self.status,status
if oldStatus==newStatus then
return
end
local statusChanged=false
if oldStatus=='off' and newStatus=='hard' then
self:showOverlays(options)
self:showButtons(options)
self.status=newStatus
statusChanged=true
elseif oldStatus=='hard' and newStatus=='off' then
self:hideOverlays(options)
self:hideButtons(options)
self.status=newStatus
statusChanged=true
elseif oldStatus=='off' and newStatus=='soft' then
self:showOverlays(options)
self:showButtons(options)
local TimetoLingerForSoft=7.5
self.softTimer=C_Timer.NewTimer(
TimetoLingerForSoft,
function() self:hideButtons() end
)
self.status=newStatus
statusChanged=true
elseif oldStatus=='soft' and newStatus=='off' then
self.softTimer:Cancel()
self:hideOverlays(options)
self:hideButtons(options)
self.status=newStatus
statusChanged=true
elseif oldStatus=='soft' and newStatus=='hard' then
self.softTimer:Cancel()
self:showButtons(options)
self.status=newStatus
statusChanged=true
elseif oldStatus=='hard' and newStatus=='soft' then
local TimetoLingerForSoft=2.5
self.softTimer=C_Timer.NewTimer(
TimetoLingerForSoft,
function() self:hideButtons() end
)
self.status=newStatus
statusChanged=true
end
if statusChanged then
SAO:Debug(Module, "Display status of "..self.parent.description.." for hash "..self.hash.." changed from '"..oldStatus.."' to '"..newStatus.."'")
end
end,
}
