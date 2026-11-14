local AddonName,SAO=...
function SAO.ApplyAllVariables(self)
self:ApplySpellAlertOpacity(true)
self:ApplySpellAlertGeometry()
self:ApplySpellAlertTimer()
self:ApplySpellAlertSound()
self:ApplyGlowingButtonsToggle()
end
function SAO.ApplySpellAlertOpacity(self,enableChanged)
SpellActivationOverlayContainerFrame:SetShown(SpellActivationOverlayDB.alert.enabled)
SpellActivationOverlayContainerFrame:SetAlpha(SpellActivationOverlayDB.alert.opacity)
if enableChanged then
SAO:ForEachBucket(function(bucket) bucket:checkOption() end)
end
end
function SAO.ApplySpellAlertGeometry(self)
SpellActivationOverlayAddonFrame.scale=SpellActivationOverlayDB.alert.scale
SpellActivationOverlayAddonFrame.offset=SpellActivationOverlayDB.alert.offset
SpellActivationOverlay_OnChangeGeometry(SpellActivationOverlayAddonFrame)
end
function SAO.ApplySpellAlertTimer(self)
SpellActivationOverlayAddonFrame.useTimer=SpellActivationOverlayDB.alert.timer~=0
SpellActivationOverlay_OnChangeTimerVisibility(SpellActivationOverlayAddonFrame)
end
function SAO.ApplySpellAlertSound(self)
local useSound=SpellActivationOverlayDB.alert.sound~=0
SpellActivationOverlayAddonFrame.useSound=useSound
SpellActivationOverlay_OnChangeSoundToggle(SpellActivationOverlayAddonFrame)
SAO.AuraSoundLibrary:setGlobalEnabled(useSound)
end
function SAO.ApplyGlowingButtonsToggle(self)
self:ForEachBucket(function(bucket)
bucket:reset()
bucket.trigger:manualCheckAll()
bucket:checkOption()
end)
end
