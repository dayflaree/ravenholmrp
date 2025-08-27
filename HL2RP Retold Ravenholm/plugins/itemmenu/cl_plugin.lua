local PLUGIN = PLUGIN

function PLUGIN:CreateMenuButtons(tabs)
    local ply, char = LocalPlayer(), LocalPlayer():GetCharacter()
    if not ( ply:IsAdmin() ) then return end

    tabs["items"] = {
        Create = function(info, container)
            local scrollpanel = container:Add("DScrollPanel")
            scrollpanel:Dock(LEFT)
            scrollpanel:DockMargin(0, 0, 8, 0)
            scrollpanel:SetWide(300)
            scrollpanel.Paint = function(self, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 66))
            end

            local categories = {}
            for _, item in pairs(ix.item.list) do
                if ( table.HasValue(categories, item.category) ) then continue end

                if ( item.category ) then
                    table.insert(categories, item.category)
                end
            end

            for k2, v2 in SortedPairs(categories) do
                local button = scrollpanel:Add("ixMenuButton")
                button:Dock(TOP)
                button:SetTall(50)
                button:SetText(v2)
                button:SetFont("Font-Elements30-Light")
                button.DoClick = function()
                    if ( self.itemScrollPanel ) then
                        self.itemScrollPanel:Remove()
                    end
                    
                    self.itemScrollPanel = container:Add("DScrollPanel")
                    self.itemScrollPanel:Dock(FILL)
                    self.itemScrollPanel:DockMargin(8, 0, 0, 0)
                    self.itemScrollPanel.Paint = function(self, w, h)
                        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 66))
                    end

                    local label = self.itemScrollPanel:Add("DLabel")
                    label:Dock(TOP)
                    label:DockMargin(8, 8, 8, 8)
                    label:SetText(v2)
                    label:SetFont("Font-Elements40-Shadow")
                    label:SetTextColor(Color(255, 255, 255))
                    label:SetContentAlignment(5)
                    label:SizeToContents()

                    for k, v in SortedPairs(ix.item.list) do
                        if ( v.category == v2 ) then
                            local itemButton = self.itemScrollPanel:Add("ixMenuButton")
                            itemButton:Dock(TOP)
                            itemButton:SetTall(30)
                            itemButton:SetText("   "..tostring(v.name))
                            itemButton:SetFont("Font-Elements20-Light")
                            itemButton.DoClick = function(self)
                                net.Start("ixItemMenuSpawn")
                                    net.WriteString(v.uniqueID)
                                    net.WriteString(v.name or "unknown item name")
                                net.SendToServer()
                            end
                            itemButton.DoRightClick = function(self)
                                local menu = DermaMenu(nil, self)
                                menu:AddOption("Copy uniqueID", function()
                                    SetClipboardText(v.uniqueID)
                                end)
                                menu:AddSpacer()
                                menu:AddOption("Spawn (Where you are looking at)", function()
                                    net.Start("ixItemMenuSpawn")
                                        net.WriteString(v.uniqueID)
                                        net.WriteString(v.name or "unknown item name")
                                    net.SendToServer()
                                end)
                                menu:AddSpacer()
                                menu:AddOption("Give", function()
                                    net.Start("ixItemMenuGive")
                                        net.WriteString(v.uniqueID)
                                        net.WriteString(v.name or "unknown item name")
                                        net.WriteUInt(1, 5)
                                    net.SendToServer()
                                end)
                                menu:AddSpacer()
                                for i = 1, 10 do
                                    menu:AddOption("Give "..i.."x", function()
                                        net.Start("ixItemMenuGive")
                                            net.WriteString(v.uniqueID)
                                            net.WriteString(v.name or "unknown item name")
                                            net.WriteUInt(i, 5)
                                        net.SendToServer()
                                    end)
                                end
                                menu:Open()
            
                                for _, v in pairs(menu:GetChildren()[1]:GetChildren()) do
                                    if v:GetClassName() == "Label" then
                                        v:SetFont("Font-Elements18")
                                    end
                                end
                            end
            
                            local itemButtonModel = itemButton:Add("SpawnIcon")
                            itemButtonModel:Dock(LEFT)
                            itemButtonModel:SetWide(30)
                            itemButtonModel:SetModel(tostring(v.model))
                            itemButtonModel:SetSkin(v.skin or 0)
                        end
                    end
                end
            end
        end,
    }
end