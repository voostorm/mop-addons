local AddonName,SAO=...
local Module="auracontainer"
local LoadAddOn=C_AddOns and C_AddOns.LoadAddOn or LoadAddOn
local useAuraContainer=SAO.IsModern() and C_Secrets~=nil and C_Secrets.GetSpellAuraSecrecy~=nil
local function splitPositions(position)
local positions={}
for component in string.gmatch(position or "", "[^%+]+")do
component=string.match(component, "^%s*(.-)%s*$")
tinsert(positions,component)
end
return positions
end
local function getInfoFromHash(hash,macroCondition,spellID,extra)
local requiresAura=type(SAO.Hash.hasAuraStacks)=='function' and hash:hasAuraStacks()
if not requiresAura then
return nil
end
local unit="player"
local filterString="HELPFUL"
if extra and extra.debuff then
unit="target"
filterString="HARMFUL"
end
if extra and extra.mineOnly then
filterString=filterString .. "|PLAYER"
end
local itemInfo={unit=unit,filterString=filterString}
local nbAuraStacks=hash:getAuraStacks()
itemInfo.nbAuraStacks=nbAuraStacks
if nbAuraStacks==SAO.Constants.InverseAuraStacks then
return nil
end
local containerInfo={unit=unit}
local hasStance=type(SAO.Hash.hasMatchStance)=='function' and hash:hasMatchStance()
local hashOnlyAnyStacks=SAO.Hash:new(SAO.Hash:new():toAnyAuraStacks())
if hasStance and hash:toWithoutMatchStance()~=hashOnlyAnyStacks.hash then
SAO:Warn(Module, "Spell "..tostring(spellID).." has a hash that has more than aura stacks and a stance trigger:",hash.hash)
return nil
end
if hasStance then
containerInfo.matchStance=hash:getMatchStance()
end
if hasStance and type(macroCondition)~='string' then
return nil
end
containerInfo.macroCondition=macroCondition
containerInfo.key=unit ..
"_" .. (type(macroCondition)=='string' and macroCondition or "nomacro")
return {container=containerInfo,item=itemInfo}
end
local positionInfo={
CENTER={location="CENTER"},
LEFT={location="LEFT"},
RIGHT={location="RIGHT"},
TOP={location="TOP"},
BOTTOM={location="BOTTOM"},
TOPRIGHT={location="TOPRIGHT"},
TOPLEFT={location="TOPLEFT"},
BOTTOMRIGHT={location="BOTTOMRIGHT"},
BOTTOMLEFT={location="BOTTOMLEFT"},
["RIGHT (FLIPPED)"]={location="RIGHT",hFlip=true},
["LEFT (OUTER)"]={location="LEFT",outer=true},
["RIGHT (OUTER)"]={location="RIGHT",outer=true,hFlip=true},
["BOTTOM (FLIPPED)"]={location="BOTTOM",vFlip=true},
["LEFT (CW)"]={location="LEFT",cw=1},
["LEFT (CCW)"]={location="LEFT",cw=-1},
["LEFT (180)"]={location="LEFT",hFlip=true,vFlip=true},
["LEFT (VFLIPPED)"]={location="LEFT",vFlip=true},
["RIGHT (CW)"]={location="RIGHT",cw=1},
["RIGHT (CCW)"]={location="RIGHT",cw=-1},
["RIGHT (180)"]={location="RIGHT",hFlip=true,vFlip=true},
["RIGHT (VFLIPPED)"]={location="RIGHT",vFlip=true},
["TOP (CW)"]={location="TOP",cw=1},
["TOP (CCW)"]={location="TOP",cw=-1},
["TOP (180)"]={location="TOP",hFlip=true,vFlip=true},
["TOP (HFLIPPED)"]={location="TOP",hFlip=true},
["BOTTOM (CW)"]={location="BOTTOM",cw=1},
["BOTTOM (CCW)"]={location="BOTTOM",cw=-1},
["BOTTOM (180)"]={location="BOTTOM",hFlip=true,vFlip=true},
["BOTTOM (HFLIPPED)"]={location="BOTTOM",hFlip=true},
}
SAO.AuraContainerItem={
new=function(self,id,container,overlay,options)
local item={
id=id,
container=container,
spellID=overlay.spellID,
unit=options.unit,
filter=options.filterString,
scale=overlay.scale,
fontScale=3,
positions=splitPositions(overlay.position),
level=overlay.level,
autoPulse=overlay.autoPulse,
useSound=overlay.autoPulse,
texture=overlay.texture,
r=overlay.r,
g=overlay.g,
b=overlay.b,
a=overlay.a,
enabled=true,
visible=true,
internallyEnabled=true,
auraButtons={},
slotKeys={},
includeSpellIDs={[overlay.spellID]=true}
}
self.__index=nil
setmetatable(item,self)
self.__index=self
local akaSpellIDs=SAO:GetAkaSpellIDsByEffectSpellID(overlay.spellID)
if akaSpellIDs then
for _,akaSpellID in ipairs(akaSpellIDs)do
item.includeSpellIDs[akaSpellID]=true
end
end
for index,position in ipairs(item.positions)do
local slotKey="item_"..id.."_index_"..index
local auraSlotOptions={
globalGeometry=options.globalGeometry,
position=position,
applications=options.nbAuraStacks,
}
local auraButton=container:AddAuraSlot(slotKey,options.filterString,{
templateNames={"SAOAuraButtonTemplate"},
initializeFrame=function(auraButton)
item:initializeAuraButton(auraButton,auraSlotOptions)
end,
sortMethod=AuraContainerSortMethod.ExpirationOnly,
sortDirection=AuraContainerSortDirection.Reverse,
candidateFilters={
includeSpellIDs=item.includeSpellIDs,
},
})
item.auraButtons[index]=auraButton
item.slotKeys[index]=slotKey
end
if item.useSound then
SAO.AuraSoundLibrary:enableItem(item)
end
return item
end,
initializeAuraButton=function(self,auraButton,options)
auraButton:EnableMouse(false)
self:setTexture(auraButton,options.position)
self:setApplications(auraButton,options.applications)
self:setCooldown(auraButton)
auraButton:SetFrameLevel(self.level or 3)
auraButton.staticItem:SetFrameLevel(auraButton:GetFrameLevel() + 1)
self:setButtonGeometry(auraButton,options.globalGeometry,options.position)
if auraButton.pulsableItem.pulse then
local mustPulse=self.autoPulse~=false
if mustPulse then
auraButton.pulsableItem.pulse:Play()
end
end
if auraButton:GetIcon()then
auraButton:GetIcon():Hide()
end
end,
setTexture=function(self,auraButton,position)
local texture=auraButton.pulsableItem.applicationBar.customTexture
local textureFilenameOrID=self.texture
if textureFilenameOrID and type(textureFilenameOrID)=='function' then
textureFilenameOrID=textureFilenameOrID()
end
if type(textureFilenameOrID)=='string' and tonumber(textureFilenameOrID,10)then
textureFilenameOrID=tonumber(textureFilenameOrID,10)
end
texture:SetTexture(textureFilenameOrID)
position=position and strupper(position)
local info=positionInfo[position]
local texLeft,texRight,texTop,texBottom=0,1,0,1
if info and info.cw and info.cw > 0 then
texture:SetTexCoord(texLeft,texBottom,texRight,texBottom,texLeft,texTop,texRight,texTop)
elseif info and info.cw and info.cw < 0 then
texture:SetTexCoord(texRight,texTop,texLeft,texTop,texRight,texBottom,texLeft,texBottom)
else
if info and info.hFlip then
texLeft,texRight=1,0
end
if info and info.vFlip then
texTop,texBottom=1,0
end
texture:SetTexCoord(texLeft,texRight,texTop,texBottom)
end
texture:SetVertexColor(self.r / 255,self.g / 255,self.b / 255,self.a / 255)
end,
setApplications=function(self,auraButton,applications)
local applicationBar=auraButton.pulsableItem.applicationBar
local minApplications,maxApplications=0,1
if applications~=0 then
minApplications,maxApplications=applications,applications
applicationBar:SetFillStyle(Enum.StatusBarFillStyle.StandardNoRangeFill)
end
auraButton:SetApplicationBar(applicationBar,{
minApplications=minApplications,
maxApplications=maxApplications,
})
end,
setCooldown=function(self,auraButton)
local cooldown=auraButton.pulsableItem.applicationBar.cooldown
auraButton:SetDurationCooldown(cooldown)
end,
setButtonGeometry=function(self,auraButton,globalGeometry,position)
position=position and strupper(position)
local info=positionInfo[position]
local parent=auraButton:GetParent()
local width,height
local longSide=globalGeometry.longSide
local shortSide=globalGeometry.shortSide
local outerSide=info and info.outer and shortSide * self.scale or 0
auraButton:ClearAllPoints()
if info and info.location=="CENTER" then
width,height=longSide,longSide
auraButton:SetPoint("CENTER",parent, "CENTER",0,0)
elseif info and info.location=="LEFT" then
width,height=shortSide,longSide
auraButton:SetPoint("RIGHT",parent, "LEFT",-outerSide,0)
elseif info and info.location=="RIGHT" then
width,height=shortSide,longSide
auraButton:SetPoint("LEFT",parent, "RIGHT",outerSide,0)
elseif info and info.location=="TOP" then
width,height=longSide,shortSide
auraButton:SetPoint("BOTTOM",parent, "TOP")
elseif info and info.location=="BOTTOM" then
width,height=longSide,shortSide
auraButton:SetPoint("TOP",parent, "BOTTOM")
elseif info and info.location=="TOPRIGHT" then
width,height=shortSide,shortSide
auraButton:SetPoint("BOTTOMLEFT",parent, "TOPRIGHT",outerSide,0)
elseif info and info.location=="TOPLEFT" then
width,height=shortSide,shortSide
auraButton:SetPoint("BOTTOMRIGHT",parent, "TOPLEFT",-outerSide,0)
elseif info and info.location=="BOTTOMRIGHT" then
width,height=shortSide,shortSide
auraButton:SetPoint("TOPLEFT",parent, "BOTTOMRIGHT",outerSide,0)
elseif info and info.location=="BOTTOMLEFT" then
width,height=shortSide,shortSide
auraButton:SetPoint("TOPRIGHT",parent, "BOTTOMLEFT",-outerSide,0)
else
return
end
auraButton.staticItem.applicationCount:SetScale(self.fontScale * globalGeometry.scale)
auraButton:SetSize(width * self.scale,height * self.scale)
end,
setGeometry=function(self,globalGeometry)
for index,auraButton in ipairs(self.auraButtons)do
self:setButtonGeometry(auraButton,globalGeometry,self.positions[index])
end
end,
setEnabled=function(self,enabled)
if enabled==self.enabled then
return
end
self.enabled=enabled
self:_internalSetAuraSlotEnabled(self.enabled and self.visible)
end,
setVisible=function(self,visible)
if visible==self.visible then
return
end
self.visible=visible
self:_internalSetAuraSlotEnabled(self.enabled and self.visible)
end,
_internalSetAuraSlotEnabled=function(self,enabled)
if self.internallyEnabled==enabled then
return
end
self.internallyEnabled=enabled
if self.useSound then
if enabled then
SAO.AuraSoundLibrary:enableItem(self)
else
SAO.AuraSoundLibrary:disableItem(self)
end
end
if not self.container.SetAuraSlotEnabled then
SAO:Debug(Module, "Cannot change internal enabling state of aura container item ",tostring(self.id))
return
end
for _,slotKey in ipairs(self.slotKeys)do
self.container:SetAuraSlotEnabled(slotKey,enabled)
end
end,
}
SAO.AuraContainer={
initialize=function(self,parent,initialGlobalGeometry)
if not useAuraContainer or self.initialized then
return
end
if LoadAddOn then
local loaded,reason=LoadAddOn("Blizzard_AuraContainer")
if not loaded and reason~="ALREADY_LOADED" then
SAO:Warn(Module, "Unable to load Blizzard_AuraContainer: "..tostring(reason))
return
end
end
self.globalGeometry={
geometry=initialGlobalGeometry,
updatedAt=GetTime(),
pendingTimer=nil,
}
self.parent=parent
self.containers={}
self.items={}
self.initialized=true
end,
getOrCreateContainer=function(self,hashInfo)
local container=self.containers[hashInfo.container.key]
if container then
return container
end
container=CreateFrame("AuraContainer", "SpellActivationOverlayAuraContainer",self.parent, "CustomAuraContainerTemplate")
container:SetAllPoints()
container:SetPoint("CENTER")
container:SetUnit(hashInfo.container.unit)
container:SetEnabled(true)
if type(hashInfo.container.macroCondition)=='string' then
if InCombatLockdown()then
SAO:Debug(Module, "Delaying macro conditional until leaving combat:",hashInfo.container.macroCondition)
container:Hide()
SAO:AddPendingOperation("ooc",function()
container:Show()
RegisterStateDriver(container, "visibility",hashInfo.container.macroCondition .. " show; hide")
end)
else
RegisterStateDriver(container, "visibility",hashInfo.container.macroCondition .. " show; hide")
end
end
self.containers[hashInfo.container.key]=container
return container
end,
registerOverlay=function(self,overlay,extra)
if not useAuraContainer then
return nil
end
if not self.initialized then
SAO:Error(Module, "Registering an overlay of spell "..tostring(overlay.spellID).." before AuraContainer is initialized")
return nil
end
local hashInfo=getInfoFromHash(SAO.Hash:new(overlay.hash),overlay.macroCondition,overlay.spellID,extra)
if not hashInfo then
return nil
end
local container=self:getOrCreateContainer(hashInfo)
local id=("container:"..hashInfo.container.key) ..
("_spell:"..overlay.spellID) ..
("_hash:"..tostring(overlay.hash)) ..
("_pos:"..overlay.position)
if self.items[id] then
SAO:Error(Module, "Overlay already registered for id "..tostring(id))
return
end
local buttonOptions=hashInfo.item
buttonOptions.globalGeometry=self.globalGeometry.geometry
local button=SAO.AuraContainerItem:new(id,container,overlay,buttonOptions)
self.items[id]=button
return button
end,
updateAll=function(self)
if not useAuraContainer or not self.initialized then
return
end
for _,container in pairs(self.containers)do
SAO:RunNextFrame(function()
container:UpdateAllAuras()
end)
end
end,
updateGeometry=function(self,globalGeometry)
if not useAuraContainer or not self.initialized then
return
end
for _,item in pairs(self.items)do
item:setGeometry(globalGeometry)
end
self.globalGeometry.geometry=globalGeometry
self.globalGeometry.updatedAt=GetTime()
end,
}
