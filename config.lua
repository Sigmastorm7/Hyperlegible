local addon, db = ...

local frame = CreateFrame("Frame")
frame.name = addon
frame:Hide()

frame:RegisterEvent("ADDON_LOADED")

HYPER_REGULAR = db.paths.regular
HYPER_ITALIC = db.paths.italic
HYPER_BOLD = db.paths.bold
HYPER_BOLDITALIC = db.paths.bolditalic

NavigatorDetails_Update = function(...) return end
NavigatorDisplay_Update = function(...) return end

local pathTable = {
	HYPER_REGULAR,
	HYPER_ITALIC,
	HYPER_BOLD,
	HYPER_BOLDITALIC,
}

NAVIGATOR_DISPLAY_BACKDROP = {
	-- bgFile = "Interface\\FriendsFrame\\UI-Toast-Background",
	edgeFile = "Interface\\FriendsFrame\\UI-Toast-Border",
	tile = false,
	tileEdge = true,
	-- tileSize = 144,
	edgeSize = 12,
	insets = { left = 5, right = 5, top = 5, bottom = 5 },
}

local userConfig

-- Navigator frame
function Navigator_OnLoad(self)
	db.navigator = self
end

-- Font list
function NavigatorList_Update()

	local entry, entryIndex
	local numEntries = 354

	for i=1,16 do

		entryIndex = NavigatorList.offset + i

		entry = _G["NavigatorListEntry"..i]

		if entryIndex > numEntries then
			entry:Hide()
		else
			entry.ID = entryIndex
			entry:SetText(db.fonts[entryIndex])
			entry:Show()
		end

		if entry.ID == NavigatorList.selectedID then
			entry.highlight:SetVertexColor(0.144, 0.32, 0.88, 0.88);
			entry:LockHighlight()
		else
			entry.highlight:SetVertexColor(0.144, 0.32, 0.7, 0.4)
			entry:UnlockHighlight()
		end
	end
end

-- CONFIG_HANDLER
local function navDisplay_Update()

	local font = Navigator.activeFont or db.fonts[1]
	local data = db.data[font]

	local r, g, b, a
	r = data.info.color.r
	g = data.info.color.g
	b = data.info.color.b
	a = data.info.color.a

	local pOG, hOG = _G[font]:GetFont()

	local pNew = HYPER_REGULAR
	local hNew = hOG

	NavigatorFont:SetFont(pNew, hNew, data.flags)

	NavigatorDisplay.previewOld:SetFont(data.path, data.height, data.flags)
	NavigatorDisplay.previewNew:SetFontObject(NavigatorFont)

	NavigatorDisplay.previewNew:SetTextColor(r, g, b, a)
	NavigatorDisplay.previewOld:SetTextColor(r, g, b, a)

	NavigatorDisplay.previewNew:SetText(font)
	NavigatorDisplay.previewOld:SetText(font)

	if data.info.shadow then
		local sx = data.info.shadow.x
		local sy = data.info.shadow.y
		local sr = data.info.shadow.color.r
		local sg = data.info.shadow.color.g
		local sb = data.info.shadow.color.b
		local sa = data.info.shadow.color.a
		NavigatorDisplay.previewNew:SetShadowOffset(sx, sy)
		NavigatorDisplay.previewNew:SetShadowColor(sr, sg, sb, sa)
		NavigatorDisplay.previewOld:SetShadowOffset(sx, sy)
		NavigatorDisplay.previewOld:SetShadowColor(sr, sg, sb, sa)
	else
		NavigatorDisplay.previewNew:SetShadowOffset(0, 0)
		NavigatorDisplay.previewNew:SetShadowColor(0, 0, 0, 0)
		NavigatorDisplay.previewOld:SetShadowOffset(0, 0)
		NavigatorDisplay.previewOld:SetShadowColor(0, 0, 0, 0)
	end

end

-- CONFIG_HANDLER
-- Details panel
local function navDetails_Update()

	local font = Navigator.activeFont or db.fonts[1]

	-- local font = db.fonts[entryID]
	-- Navigator.activeFont = font

	local s = "No relations to other fonts"
	local plr

	if db.parent[font] then
		if #db.parent[font] > 1 then plr = " fonts" else plr = " font" end
		s = "Inherited by "..tostring(#db.parent[font])..plr..":|n"
		for _,v in pairs(db.parent[font]) do
			s = s..v.."|n"
		end
		NavigatorDetailsRelations:SetText(s)
	elseif db.child[font] then
		if #db.child[font] > 1 then plr = " fonts" else plr = " font" end
		s = "Inherits from "..tostring(#db.child[font])..plr..":|n"
		for _,v in pairs(db.child[font]) do
			s = s..v.."|n"
		end
		NavigatorDetailsRelations:SetText(s)
	else
		NavigatorDetailsRelations:SetText(s)
	end

	if UserConfig[font] then
		print("exists")
	elseif not UserConfig[font] then
		UserConfigStyle1:SetChecked(true)
	end

	NavigatorDetails.fontName:SetText(font)

	navDisplay_Update()

end

-- List entries
local lastID = 0
function NavigatorList_Entry_OnClick(self)
	if self.ID == lastID then return end
	NavigatorList.selectedID = self.ID
	Navigator.activeFont = self:GetText()
	NavigatorList_Update()
	navDetails_Update()
	lastID = self.ID
end

local lastEntry

function NavigatorDetails_OnHide()
	lastEntry = NavigatorList.selectedID
end

-- User config frames
local lastS
local styles = {"Regular", "Italic", "Bold", "Bold Italic"}
function UserConfigStyle_OnValueChanged(slider, value, user)
	if user then
		if value == lastS then
			return
		else

			UserConfig[Navigator.activeFont]["path"] = pathTable[value]

			slider.Text:SetText("Style: "..styles[value])

			UserConfigSave:Enable()
			UserConfigCancel:Enable()

			lastS = value
		end
	end
end

local tempConfig = {}
local lastH
function UserConfigHeight_OnValueChanged(slider, value, user)
	if user then
		if value == lastH then
			return
		else
			tempConfig["hOff"] = value

			UserConfigSave:Enable()
			UserConfigCancel:Enable()

			lastH = value
		end
	end
end

--[[
function UserConfigStyle_OnClick(button, index)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)

	for i=1, 4 do
		_G["UserConfigStyle"..i]:SetChecked(i == index)
	end
	tempConfig["path"] = button.path
end
]]

-- CONFIG_HANDLER
function UserConfigSave_OnClick()
	local font = Navigator.activeFont
	local p, hOff

	for k, v in pairs(tempConfig) do
		return -- userConfig[font][k] = v
	end

	p = HYPER_REGULAR -- userConfig[font].path
	hOff = 0 -- userConfig[font].hOff

	-- _G[font]:SetFont(p, db.data[font].height + hOff, db.data[font].flags)

	UserConfigSave:Disable()
	UserConfigCancel:Disable()
end

function UserConfigCancel_OnClick()
	UserConfigHeight:SetValue(0)
	for i=1, 4 do
		_G["UserConfigStyle"..i]:SetChecked(i == 1)
	end
	tempConfig = {}

	UserConfigSave:Disable()
	UserConfigCancel:Disable()
end

frame:SetScript("OnEvent", function(self, event, arg)

	if event == "ADDON_LOADED" and arg == "Hyperlegible" then

		frame:SetScript("OnShow", function(frame)

			local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
			title:SetPoint("TOPLEFT", 16, -16)
			title:SetText(addon)
		
			Navigator:SetParent(frame)
			Navigator:SetPoint("TOP", frame, "TOP", 0, -48)

			Navigator.activeFont = db.fonts[1]

			userConfig = UserConfig

			NavigatorDetails_Update = navDetails_Update
			NavigatorDisplay_Update = navDisplay_Update

			NavigatorList_Update()
			NavigatorDetails_Update()
		
			frame:SetScript("OnShow", nil)

		end)

		InterfaceOptions_AddCategory(frame)

		frame:Hide()

	end

end)