
local backgroundColor = Color(0, 0, 0, 66)

local PANEL = {}

-- guides panel

AccessorFunc(PANEL, "animationTime", "AnimationTime", FORCE_NUMBER)
AccessorFunc(PANEL, "backgroundFraction", "BackgroundFraction", FORCE_NUMBER)

function PANEL:Init()
    local parent = self:GetParent()
    local padding = self:GetPadding()
    local halfWidth = parent:GetWide() * 0.5 - (padding * 2)
    local halfHeight = parent:GetTall() * 0.5 - (padding * 2)

    self.animationTime = 1
    self.backgroundFraction = 1

    -- main panel
    self.panel = self:AddSubpanel("main")
    self.panel:SetTitle("guides")
    self.panel.OnSetActive = function()
        self:CreateAnimation(self.animationTime, {
            index = 2,
            target = {backgroundFraction = 1},
            easing = "outQuint",
        })
    end

    local back = self.panel:Add("ixMenuButton")
    back:Dock(BOTTOM)
    back:SetText("return")
    back:SizeToContents()
    back.DoClick = function()
        self:SlideDown()
        parent.mainPanel:Undim()
    end

	self.panel.categories = {}
	self.panel.categorySubpanels = {}
	self.panel.categoryPanel = self.panel:Add("ixHelpMenuCategories")

	self.panel.canvasPanel = self.panel:Add("EditablePanel")
	self.panel.canvasPanel:Dock(FILL)

	self.idlePanel = self.panel.canvasPanel:Add("Panel")
	self.idlePanel:Dock(FILL)
	self.idlePanel:DockMargin(8, 0, 0, 0)
	self.idlePanel.Paint = function(_, width, height)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, width, height)

		derma.SkinFunc("DrawHelixCurved", width * 0.5, height * 0.5, height * 0.35)

		surface.SetFont("ixIntroSubtitleFont")
		local text = L("helix"):lower()
		local textWidth, textHeight = surface.GetTextSize(text)

		surface.SetTextColor(color_white)
		surface.SetTextPos(width * 0.5 - textWidth * 0.5, height * 0.5 - textHeight * 0.75)
		surface.DrawText(text)

		surface.SetFont("ixMediumLightFont")
		text = L("helpIdle")
		local infoWidth, _ = surface.GetTextSize(text)

		surface.SetTextColor(color_white)
		surface.SetTextPos(width * 0.5 - infoWidth * 0.5, height * 0.5 + textHeight * 0.25)
		surface.DrawText(text)
	end

	local categories = {}
	hook.Run("PopulateGuideMenu", categories)

	for k, v in SortedPairs(categories) do
		if (!isstring(k)) then
			ErrorNoHalt("expected string for guide menu key\n")
			continue
		elseif (!isfunction(v)) then
			ErrorNoHalt(string.format("expected function for guide menu entry '%s'\n", k))
			continue
		end

		self:AddCategory(k)
		self.panel.categories[k] = v
	end

	self.panel.categoryPanel:SizeToContents()

	if (ix.gui.lastGuideMenuTab) then
		self:OnCategorySelected(ix.gui.lastGuideMenuTab)
	end
end

function PANEL:AddCategory(name)
	local button = self.panel.categoryPanel:Add("ixMenuButton")
	button:SetText(L(name))
	button:SizeToContents()
	-- @todo don't hardcode this but it's the only panel that needs docking at the bottom so it'll do for now
	button:Dock(name == "credits" and BOTTOM or TOP)
	button.DoClick = function()
		self:OnCategorySelected(name)
	end

	local panel = self.panel.canvasPanel:Add("DScrollPanel")
	panel:SetVisible(false)
	panel:Dock(FILL)
	panel:DockMargin(8, 0, 0, 0)
	panel:GetCanvas():DockPadding(8, 8, 8, 8)

	panel.Paint = function(_, width, height)
		surface.SetDrawColor(backgroundColor)
		surface.DrawRect(0, 0, width, height)
	end

	-- reverts functionality back to a standard panel in the case that a category will manage its own scrolling
	panel.DisableScrolling = function()
		panel:GetCanvas():SetVisible(false)
		panel:GetVBar():SetVisible(false)
		panel.OnChildAdded = function() end
	end

	self.panel.categorySubpanels[name] = panel
end

function PANEL:OnCategorySelected(name)
	local panel = self.panel.categorySubpanels[name]

	if (!IsValid(panel)) then
		return
	end

	if (!panel.bPopulated) then
		self.panel.categories[name](panel)
		panel.bPopulated = true
	end

	if (IsValid(self.panel.activeCategory)) then
		self.panel.activeCategory:SetVisible(false)
	end

	panel:SetVisible(true)
	self.idlePanel:SetVisible(false)

	self.panel.activeCategory = panel
	ix.gui.lastGuideMenuTab = name
end

function PANEL:OnSlideUp()
    self.bActive = true
end

function PANEL:OnSlideDown()
    self.bActive = false
end

local gradient = surface.GetTextureID("vgui/gradient-d")
function PANEL:Paint(width, height)
	surface.SetDrawColor(20, 20, 20, 255)
	surface.DrawRect(0, 0, width, height)

	surface.SetTexture(gradient)
	surface.SetDrawColor(ColorAlpha(ix.config.Get("color"), 10))
	surface.DrawTexturedRect(0, ScrH() - height, width, height)

	if (!ix.option.Get("cheapBlur", false)) then
		surface.SetDrawColor(0, 0, 0, 100)
		surface.DrawTexturedRect(0, 0, width, height)
		ix.util.DrawBlur(self, Lerp((self.currentAlpha - 200) / 200, 0, 10))
	end
end

vgui.Register("ixCharMenuGuides", PANEL, "ixCharMenuPanel") 


hook.Add("PopulateGuideMenu", "ixHelpMenu", function(tabs)
	tabs["factions"] = function(container)
		for k, v in SortedPairs(ix.faction.indices) do
			local panel = container:Add("DLabel")
			panel:SetText(v.name)
			panel:SetTextColor(v.color)
			panel:SetFont("Font-Elements40")
			panel:Dock(TOP)
			panel:DockMargin(8, 8, 8, 0)
			panel:SizeToContents()

			local text = container:Add("RichText")
			text:SetText(v.description)
			text:Dock(TOP)
			text:DockMargin(8, 0, 8, 8)
			text:SetVerticalScrollbarEnabled(false)
			text:SetSize(container:GetWide() - 16, 200)
			text:SetMouseInputEnabled(false)
			
			timer.Simple(0, function()
				text:SetFontInternal("Font-Elements30-Light")
			end)
		end
	end
end)
