local addonName, hyper = ...

local frame = CreateFrame("Frame")
frame.name = addonName
frame:Hide()

-- NavigatorActiveState = {"Quest", "QuestFont_Huge", "QuestFont_Shadow_Huge"}
-- FontFamily Numbers
-- Fancy 11
-- Friends 5
-- Game 38
-- Number 18
-- Quest 9
-- System 49
-- Misc 17

hyper.testing = function() end

hyper.selectedFont = nil
hyper.selectedStyle = nil
hyper.defaults = {"Quest", nil, nil}

local activeTab, activeFont, activeStyle = unpack(NavigatorActiveState or hyper.defaults)

local enabledFilters = {
	["family"] = {
		["fancy"] = 0,
		["game"] = 0,
		["number"] = 0,
		["quest"] = 0,
		["system"] = 0,
		["misc"] = 0,
	},
	["traits"] = {
		["small"] = 0,
		["medium"] = 0,
		["large"] = 0,
		["outline"] = 0,
		["thickoutline"] = 0,
		["monochrome"] = 0,
		["shadow"] = 0,
	},
}

-- Organized frame methods for easier navigation
	function Navigator_OnLoad(self)
		PanelTemplates_SetNumTabs(self, 6);
		Navigator.selectedTab = 1;
		activeTab = 1
		PanelTemplates_UpdateTabs(self);
	end
	function Navigator_OnShow(self)	FontList_Update() end
	function Navigator_OnHide(self)
		return
	end
	-- Children
		-- Tabs

			-- <NormalFont style="GameFontNormalSmall"/>
			-- <HighlightFont style="GameFontHighlightSmall"/>
			-- <DisabledFont style="GameFontDisableSmall"/>

			-- local tab = GetTabByIndex(frame, i);
			function FilterTab_Deselect(tab)
				local name = tab:GetName();
			
				local left = tab.Left or _G[name.."Left"];
				local middle = tab.Middle or _G[name.."Middle"];
				local right = tab.Right or _G[name.."Right"];
				left:Show();
				middle:Show();
				right:Show();
				-- tab:UnlockHighlight();
				-- tab:Enable();
				tab.Text:SetPoint("CENTER", tab, "CENTER", 0, 2);
			
				local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
				local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
				local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
				leftDisabled:Hide();
				middleDisabled:Hide();
				rightDisabled:Hide();
			end
			
			function FilterTab_Select(tab)
				local name = tab:GetName();
			
				local left = tab.Left or _G[name.."Left"];
				local middle = tab.Middle or _G[name.."Middle"];
				local right = tab.Right or _G[name.."Right"];
				left:Hide();
				middle:Hide();
				right:Hide();
				-- tab:LockHighlight();
				-- tab:Disable();
				tab:SetDisabledFontObject(GameFontHighlightSmall);
				tab.Text:SetPoint("CENTER", tab, "CENTER", 0, -3);
			
				local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
				local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
				local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
				leftDisabled:Show();
				middleDisabled:Show();
				rightDisabled:Show();
			
				local tooltip = GetAppropriateTooltip();
				if tooltip:IsOwned(tab) then
					tooltip:Hide();
				end
			end
			
			function FilterTab_Disable(tab)
				local name = tab:GetName();
				local left = tab.Left or _G[name.."Left"];
				local middle = tab.Middle or _G[name.."Middle"];
				local right = tab.Right or _G[name.."Right"];
				left:Show();
				middle:Show();
				right:Show();
				--tab:UnlockHighlight();
				tab:Disable();
				tab.text = tab:GetText();
				-- Gray out text
				tab:SetDisabledFontObject(GameFontDisableSmall);
				local leftDisabled = tab.LeftDisabled or _G[name.."LeftDisabled"];
				local middleDisabled = tab.MiddleDisabled or _G[name.."MiddleDisabled"];
				local rightDisabled = tab.RightDisabled or _G[name.."RightDisabled"];
				leftDisabled:Hide();
				middleDisabled:Hide();
				rightDisabled:Hide();
			end

			function FilterTab_OnClick(self)

				if self.selected then

					self.selected = false
					
					UpdateFilters(self, false)
					FilterTab_Deselect(self);
				elseif not self.selected then

					self.selected = true				

					UpdateFilters(self, true)
					FilterTab_Select(self);
				end
			end

			function UpdateFilters(tab, state)
				group = tab.group
				filter = tab.filter
				local tab, f
				for i=1, 6 do
					tab = _G["FamilyTab"..i]
					f = tab[tab.group]
					if enabledFilters[f] == 1 then
						
					elseif enabledFilters[f] == 0 then

					elseif enabledFilters[f] == -1 then
						FilterTab_Disable(tab)
					end	
				end
				for i=1, 7 do

				end
			end

			function Navigator_TabOnClick(self)
				ListEntry_SetSelected(nil, nil, "tab")
				NavigatorFontList.selected = nil
				NavigatorStyleList.selected = nil
			
				-- _G["NavigatorTab"..activeTab].Text:SetPoint("BOTTOM", 0, 3)
				-- self.Text:SetPoint("BOTTOM", 0, 5)
				activeTab = self:GetID()
				activeFont = nil
				FontList_Update()
				-- StyleList_Update()
			end
		-- Lists
			-- Shared methods
			function NavigatorList_OnLoad(self)
				local name = self:GetName()
				self.offset = 0;
				-- self:SetFrameStrata("HIGH");
				if name == "NavigatorFontList" then
					FontListScrollFrameScrollChildFrame:SetParent(NavigatorFontListScrollFrame)
				else
					StyleListScrollFrameScrollChildFrame:SetParent(NavigatorStyleListScrollFrame)
				end
			end
			function NavigatorList_OnShow()	FontList_Update() end
			function NavigatorList_OnHide()
				--[[if ( self.save ) then
					SaveAddOns();
				else
					ResetAddOns();
				end
				self.save = false;
				]]
			end
			function NavigatorList_OnVerticalScroll(self, offset, update)
				local scrollbar = _G[self:GetName().."ScrollBar"];
				scrollbar:SetValue(offset);
				_G[self:GetName()].offset = floor((offset / 18) + 0.5);
				update()
			end
			function FontList_Update()
				if true then return end
				local entry, entryIndex
				local numEntries = 0
			
				--[[for _ in pairs(#LIST_GOES_HERE) do
					numEntries = numEntries + 1
				end]]
			
				for i=1, 14 do
					entryIndex = NavigatorFontList.offset + i
					entry = _G["NavigatorFontListEntry"..i]
					if entryIndex > numEntries then
						entry:Hide()
					else
						entry:SetID(entryIndex);
						entry:SetText("Tab"..tostring(activeTab))
						entry:Show();
					end
				end
				-- StyleList_Update()
			end
			function FontList_OnScroll(self, offset)
				local scrollbar = _G[self:GetName().."ScrollBar"];
				scrollbar:SetValue(offset);
				FontList.offset = floor((offset / 16) + 0.5);
				FontList_Update();
				if ( EntryTooltip:IsShown() ) then
					EntryTooltip_Update(EntryTooltip:GetOwner());
					EntryTooltip:Show()
				end
			end
			--[[function StyleList_Update()
				local entry, entryIndex;
				local numEntries = 0
		
				local styleInfo = {}
				local children = {}
				local t = {}
		
				-- for _ in pairs(hyper.styleDB[activeGroup]) do
				-- 	  numEntries = numEntries + 1
				-- end
		
				for i, v in ipairs(#LIST_GOES_HERE) do
					-- print(v.parent)
					if v.parent == activeFont then
					
						t.name = v.name
						t.parent = v.parent
						if v.parentIsStyle then
							for _, w in pairs(hyper.styleDB) do
								if w.parent == v.name then
									table.insert(children, w.name)
								end
							end
							t.children = children
						else
							t.children = nil
						end
						table.insert(styleInfo, t)
					end
				end
			
				for i=1, 14 do
					entryIndex = NavigatorStyleList.offset + i
					entry = _G["NavigatorStyleListEntry"..i]
					print(styleInfo[entryIndex].name)
					if (entryIndex > numEntries) or (activeFont == nil) then
						entry:Hide()
					else
						entry:SetID(entryIndex);
						entry:SetText(styleInfo[entryIndex].name)
						entry:Show();
					end
				end
			end]]
			-- List children
				-- Entry methods
				function ListEntry_OnClick(self, list)
					ListEntry_SetSelected(self, list, "entry")
				end
				function ListEntry_SetSelected(self, list, who)
					if who == "entry" then
						if list.selected then
							list.selected.highlight:SetVertexColor(.196, .388, .8)
							list.selected:UnlockHighlight()
						end
				
						self.highlight:SetVertexColor(1, 1, 0);
						self:LockHighlight()
						list.selected = self
				
						if list.type == "Fonts" then
							hyper.selectedFont = self
							activeFont = self:GetText();
							StyleList_Update()
						elseif list.type == "Styles" then
							hyper.selectedStyle = self
							activeStyle = self:GetText();
						end
				
					elseif who == "tab" then
						local sFont = hyper.selectedFont
						local sStyle = hyper.selectedStyle
						if sFont then
							sFont.highlight:SetVertexColor(.196, .388, .8)
							sFont:UnlockHighlight()
							sFont = nil
						end
						if hyper.selectedStyle then
							sStyle.highlight:SetVertexColor(.196, .388, .8)
							sStyle:UnlockHighlight()
							sStyle = nil
						end
					end
				end
				-- Entry tooltip
				function EntryTooltip_Update(owner)
					local name = (owner:GetID())
					EntryTooltip:ClearLines();
					EntryTooltip:SetText("Hello");
					EntryTooltip:Show()
				end
		-- close
	-- close
-- close

frame:SetScript("OnShow", function(frame)
	local function newCheckbox(label, description, onClick)
		local check = CreateFrame("CheckButton", "BugSackCheck" .. label, frame, "InterfaceOptionsCheckButtonTemplate")
		check:SetScript("OnClick", function(self)
			local tick = self:GetChecked()
			onClick(self, tick and true or false)
			if tick then
				PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
			else
				PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
			end
		end)
		check.label = _G[check:GetName() .. "Text"]
		check.label:SetText(label)
		check.tooltipText = label
		check.tooltipRequirement = description
		return check
	end

	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(addonName)

	Navigator:SetParent(frame)
	Navigator:SetPoint("BOTTOM", frame, "BOTTOM", 0, 16)
	Navigator:Show()

	EntryTooltip = GameTooltip
	
--[[
	local chatFrame = newCheckbox(
	L["Chatframe output"],
	L.chatFrameDesc,
	function(self, value) addon.db.chatframe = value end)
	chatFrame:SetChecked(addon.db.chatframe)
	chatFrame:SetPoint("TOPLEFT", autoPopup, "BOTTOMLEFT", 0, -8)

	local mute = newCheckbox(
		L["Mute"],
		L.muteDesc,
		function(self, value) addon.db.mute = value end)
	mute:SetChecked(addon.db.mute)
	mute:SetPoint("TOPLEFT", minimap, "BOTTOMLEFT", 0, -8)

	local info = {}
	local fontSizeDropdown = CreateFrame("Frame", "BugSackFontSize", frame, "UIDropDownMenuTemplate")
	fontSizeDropdown:SetPoint("TOPLEFT", mute, "BOTTOMLEFT", -15, -10)
	fontSizeDropdown.initialize = function()
		wipe(info)
		local fonts = {"GameFontHighlightSmall", "GameFontHighlight", "GameFontHighlightMedium", "GameFontHighlightLarge"}
		local names = {L["Small"], L["Medium"], L["Large"], L["X-Large"]}
		for i, font in next, fonts do
			info.text = names[i]
			info.value = font
			info.func = function(self)
				addon.db.fontSize = self.value
				if _G.BugSackFrameScrollText then
					_G.BugSackFrameScrollText:SetFontObject(_G[self.value])
				end
				BugSackFontSizeText:SetText(self:GetText())
			end
			info.checked = font == addon.db.fontSize
			UIDropDownMenu_AddButton(info)
		end
	end
	BugSackFontSizeText:SetText(L["Font size"])

	local dropdown = CreateFrame("Frame", "BugSackSoundDropdown", frame, "UIDropDownMenuTemplate")
	dropdown:SetPoint("LEFT", fontSizeDropdown, "RIGHT", 150, 0)
	dropdown.initialize = function()
		wipe(info)
		for _, sound in next, LibStub("LibSharedMedia-3.0"):List("sound") do
			info.text = sound
			info.value = sound
			info.func = function(self)
				addon.db.soundMedia = self.value
				BugSackSoundDropdownText:SetText(self:GetText())
			end
			info.checked = sound == addon.db.soundMedia
			UIDropDownMenu_AddButton(info)
		end
	end
	BugSackSoundDropdownText:SetText(L["Sound"])

	local clear = CreateFrame("Button", "BugSackSaveButton", frame, "UIPanelButtonTemplate")
	clear:SetText(L["Wipe saved bugs"])
	clear:SetWidth(177)
	clear:SetHeight(24)
	clear:SetPoint("TOPLEFT", fontSizeDropdown, "BOTTOMLEFT", 17, -25)
	clear:SetScript("OnClick", function()
		addon:Reset()
	end)
	clear.tooltipText = L["Wipe saved bugs"]
	clear.newbieText = L.wipeDesc
]]

	frame:SetScript("OnShow", nil)
end)
InterfaceOptions_AddCategory(frame)