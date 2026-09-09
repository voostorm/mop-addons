local E = select(2, ...):unpack()
local P = E.Party

local IconMixin = P.BarFrameIconMixin
local sorters = P.sorters

if not IconMixin or not sorters then
	return
end

local function GetMainBar(icon)
	local container = icon:GetParent()
	local bar = container and container:GetParent()
	if bar and bar.info and bar.container == container then
		return bar
	end
end

local function GetSpecOrder(info, create)
	if not info or not info.class or not info.spec or not E.db then
		return
	end

	local root = E.db.manualIconOrder
	if not root then
		if not create then
			return
		end
		root = {}
		E.db.manualIconOrder = root
	end

	local classOrder = root[info.class]
	if not classOrder then
		if not create then
			return
		end
		classOrder = {}
		root[info.class] = classOrder
	end

	local specKey = tostring(info.spec)
	local specOrder = classOrder[specKey]
	if not specOrder then
		if not create then
			return
		end
		specOrder = {}
		classOrder[specKey] = specOrder
	end

	-- MoP order is saved per race as well as class/spec so racials have a
	-- deterministic position. Existing flat class/spec orders remain a fallback.
	local raceKey = info.raceID and tostring(info.raceID)
	if not E.isMoP or not raceKey then
		return specOrder
	end

	local raceOrders = specOrder.__races
	if not raceOrders and create then
		raceOrders = {}
		specOrder.__races = raceOrders
	end

	local order = raceOrders and raceOrders[raceKey]
	if not order and create then
		order = {}
		raceOrders[raceKey] = order
	end
	return order or specOrder
end

local function GetManualRank(icon)
	local bar = GetMainBar(icon)
	if not bar then
		return
	end

	local order = GetSpecOrder(bar.info)
	return order and order[icon.spellID]
end

-- Manual drag order takes precedence over OmniCD's normal type/priority sort.
-- Specs that have never been manually reordered keep the original behavior.
local defaultSorter1 = sorters[1]
local defaultSorter2 = sorters[2]

local function WrapSorter(defaultSorter)
	return function(a, b)
		local rankA = GetManualRank(a)
		local rankB = GetManualRank(b)
		if rankA or rankB then
			if rankA and rankB then
				if rankA ~= rankB then
					return rankA < rankB
				end
				return defaultSorter(a, b)
			end
			return rankA ~= nil
		end
		return defaultSorter(a, b)
	end
end

sorters[1] = WrapSorter(defaultSorter1)
sorters[2] = WrapSorter(defaultSorter2)

local function FindIconIndex(bar, icon)
	for i = 1, bar.numIcons do
		if bar.icons[i] == icon then
			return i
		end
	end
end

local function RestoreDraggedIcon(icon, bar)
	if icon.isReorderDragging then
		icon:StopMovingOrSizing()
	end
	icon.isReorderDragging = nil
	icon.reorderBar = nil
	icon.reorderStartX = nil
	icon.reorderStartY = nil
	if icon.reorderFrameLevel then
		icon:SetFrameLevel(icon.reorderFrameLevel)
		icon.reorderFrameLevel = nil
	end
	if bar then
		bar:UpdateLayout(true)
	end
	icon:SetOpacity()
end

local function SaveBarOrder(bar)
	local order = GetSpecOrder(bar.info, true)
	if not order then
		return
	end

	wipe(order)
	for i = 1, bar.numIcons do
		order[bar.icons[i].spellID] = i
	end
end

local function UpdateMatchingBars(sourceBar)
	local sourceInfo = sourceBar.info
	for bar in P.BarPool:EnumerateActive() do
		local info = bar.info
		if info
			and info.class == sourceInfo.class
			and info.spec == sourceInfo.spec
			and info.raceID == sourceInfo.raceID then
			bar:UpdateLayout(true)
		end
	end
end

local function GetDropTarget(icon, bar, x, y)
	local targetIndex
	local bestDistance
	local minLeft, maxRight, minBottom, maxTop

	for i = 1, bar.numIcons do
		local other = bar.icons[i]
		if other ~= icon and other:IsShown() then
			local left, right = other:GetLeft(), other:GetRight()
			local bottom, top = other:GetBottom(), other:GetTop()
			local otherX, otherY = other:GetCenter()
			if left and right and bottom and top and otherX and otherY then
				minLeft = not minLeft and left or math.min(minLeft, left)
				maxRight = not maxRight and right or math.max(maxRight, right)
				minBottom = not minBottom and bottom or math.min(minBottom, bottom)
				maxTop = not maxTop and top or math.max(maxTop, top)

				local dx, dy = x - otherX, y - otherY
				local distance = dx * dx + dy * dy
				if not bestDistance or distance < bestDistance then
					bestDistance = distance
					targetIndex = i
				end
			end
		end
	end

	if not targetIndex then
		return
	end

	-- A one-icon margin lets the first/last icon be dropped just beyond the
	-- visible row while still keeping the operation inside the list domain.
	local margin = math.max(icon:GetWidth(), icon:GetHeight())
	if minLeft and (x < minLeft - margin or x > maxRight + margin
		or y < minBottom - margin or y > maxTop + margin) then
		return
	end

	return targetIndex
end

local function CanReorderBar(bar)
	return not P.inLockdown
		and bar
		and bar.info
		and (not E.isMoP or (P.isInTestMode and bar.info.isIconOrderTestInfo))
end

local function OmniCDIcon_OnDragStart(self)
	local bar = GetMainBar(self)
	if not CanReorderBar(bar) or not bar.info.spec or bar.numIcons < 2 then
		return
	end

	local x, y = self:GetCenter()
	if not x or not y then
		return
	end

	self.isReorderDragging = true
	self.reorderBar = bar
	self.reorderStartX = x
	self.reorderStartY = y
	self.reorderFrameLevel = self:GetFrameLevel()
	self:SetFrameLevel(bar:GetFrameLevel() + 100)
	self:SetAlpha(0.7)
	self:StartMoving()
end

local function OmniCDIcon_OnDragStop(self)
	if not self.isReorderDragging then
		return
	end

	local bar = self.reorderBar
	self:StopMovingOrSizing()

	local x, y = self:GetCenter()
	local startX, startY = self.reorderStartX, self.reorderStartY
	if not bar or not x or not y or not startX or not startY then
		RestoreDraggedIcon(self, bar)
		return
	end

	local dx, dy = x - startX, y - startY
	local minDrag = math.max(self:GetWidth(), self:GetHeight()) * 0.25
	if dx * dx + dy * dy < minDrag * minDrag then
		RestoreDraggedIcon(self, bar)
		return
	end

	local sourceIndex = FindIconIndex(bar, self)
	local targetIndex = GetDropTarget(self, bar, x, y)
	if not sourceIndex or not targetIndex then
		RestoreDraggedIcon(self, bar)
		return
	end

	-- Keeping targetIndex from the pre-removal list naturally inserts after the
	-- target when dragging forward and before it when dragging backward.
	tremove(bar.icons, sourceIndex)
	tinsert(bar.icons, targetIndex, self)
	SaveBarOrder(bar)

	self.isReorderDragging = nil
	self.reorderBar = nil
	self.reorderStartX = nil
	self.reorderStartY = nil
	if self.reorderFrameLevel then
		self:SetFrameLevel(self.reorderFrameLevel)
		self.reorderFrameLevel = nil
	end
	self:SetOpacity()
	UpdateMatchingBars(bar)
end

local function ConfigureIcon(icon)
	if icon.isReorderConfigured then
		return
	end
	icon.isReorderConfigured = true
	icon:SetMovable(true)
	icon:RegisterForDrag("LeftButton")
	icon:SetScript("OnDragStart", OmniCDIcon_OnDragStart)
	icon:SetScript("OnDragStop", OmniCDIcon_OnDragStop)

	-- Dragging requires mouse input even when the tooltip option is disabled.
	-- Guard the original OnEnter so enabling mouse does not implicitly enable
	-- tooltips.
	local onEnter = icon:GetScript("OnEnter")
	if onEnter then
		icon:SetScript("OnEnter", function(self)
			if E.db.icons.showTooltip or self.tooltipID then
				onEnter(self)
			end
		end)
	end
end

local SetTooltip = IconMixin.SetTooltip
function IconMixin:SetTooltip()
	ConfigureIcon(self)
	SetTooltip(self)

	local bar = GetMainBar(self)
	if not CanReorderBar(bar) then
		-- Live MoP bars keep OmniCD's original mouse behavior. Reordering is
		-- intentionally available only inside the icon-order test preview.
		return
	end

	self:EnableMouse(true)
	if self.SetPassThroughButtons and self.isPassThrough then
		-- Right-click keeps OmniCD's click-through behavior; left-click is held
		-- by the icon so it can start a drag.
		self:SetPassThroughButtons("RightButton")
	end
end

local function CancelMainBarDrags()
	if not P.BarPool then
		return
	end
	for bar in P.BarPool:EnumerateActive() do
		for i = 1, bar.numIcons do
			local icon = bar.icons[i]
			if GetMainBar(icon) and icon.isReorderDragging then
				RestoreDraggedIcon(icon, bar)
			end
		end
	end
end

local function EnableMainBarDrags()
	if not P.BarPool then
		return
	end
	for bar in P.BarPool:EnumerateActive() do
		for i = 1, bar.numIcons do
			local icon = bar.icons[i]
			if GetMainBar(icon) then
				icon:SetTooltip()
			end
		end
	end
end

local PlayerRegenDisabled = P.PLAYER_REGEN_DISABLED
function P:PLAYER_REGEN_DISABLED(...)
	PlayerRegenDisabled(self, ...)
	CancelMainBarDrags()
end

local PlayerRegenEnabled = P.PLAYER_REGEN_ENABLED
function P:PLAYER_REGEN_ENABLED(...)
	PlayerRegenEnabled(self, ...)
	EnableMainBarDrags()
end
