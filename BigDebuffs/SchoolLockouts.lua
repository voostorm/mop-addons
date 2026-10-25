-- MoP interrupt lockout school icons, based on LoseControl's mini icons.
local BD = BigDebuffs
BD.schoolLockouts = {}
local art = {
  [1]="Ability_meleedamage", [2]="Spell_holy_holybolt",
  [4]="Spell_fire_selfdestruct", [8]="Spell_nature_protectionformnature",
  [16]="Spell_frost_icestorm", [32]="Spell_shadow_antishadow",
  [64]="Spell_nature_wispsplode", [28]="Shaman_talent_elementalblast",
  [124]="Ability_warlock_chaosbolt",
}
local masks = {1, 2, 4, 8, 16, 32, 64, 28, 124}

function BD:RecordSchoolLockout(guid, school, expires)
  if WOW_PROJECT_ID ~= WOW_PROJECT_MISTS_CLASSIC or not guid or
     type(school) ~= "number" or school <= 0 then return end
  local list = self.schoolLockouts[guid] or {}
  self.schoolLockouts[guid] = list
  table.insert(list, {school=school, expires=expires})
end

function BD:UpdateSchoolLockoutIcons(frame, guid, visible)
  if WOW_PROJECT_ID ~= WOW_PROJECT_MISTS_CLASSIC or not frame then return end
  local icons = frame.lockoutSchoolIcons
  if icons then for _, icon in pairs(icons) do icon:Hide() end end
  if not visible or not guid then return end
  local list = self.schoolLockouts[guid]
  if not list then return end
  local expiry, now = {}, GetTime()
  for i=#list,1,-1 do
    local lock = list[i]
    if lock.expires <= now then
      table.remove(list,i)
    else
      for _,mask in ipairs(masks) do
        if bit.band(lock.school,mask)==mask then
          expiry[mask]=math.max(expiry[mask] or 0,lock.expires)
        end
      end
    end
  end
  if #list==0 then self.schoolLockouts[guid]=nil end
  for _,combo in ipairs({124,28}) do
    if expiry[combo] then
      for _,mask in ipairs(masks) do
        if mask~=combo and bit.band(combo,mask)==mask and
           expiry[mask] and expiry[mask]<=expiry[combo] then
          expiry[mask]=nil
        end
      end
    end
  end
  local sorted={}
  for mask,ends in pairs(expiry) do table.insert(sorted,{mask,ends}) end
  table.sort(sorted,function(a,b)
    if a[2]==b[2] then return a[1]<b[1] end
    return a[2]>b[2]
  end)
  if #sorted==0 then return end
  if not icons then icons={}; frame.lockoutSchoolIcons=icons end
  local size=math.max(5,math.floor(math.min(frame:GetWidth(),frame:GetHeight())*0.28))
  for n,entry in ipairs(sorted) do
    local mask=entry[1]
    local icon=icons[mask]
    if not icon then
      icon=frame:CreateTexture(nil,"OVERLAY",nil,7)
      icon:SetTexture("Interface\\Icons\\"..art[mask])
      icon:SetTexCoord(0.08,0.92,0.08,0.92)
      icons[mask]=icon
    end
    icon:ClearAllPoints()
    icon:SetSize(size,size)
    icon:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",
      -1-((n-1)%3)*(size+1),1+math.floor((n-1)/3)*(size+1))
    icon:Show()
  end
end
