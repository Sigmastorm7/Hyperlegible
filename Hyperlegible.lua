local addon, db = ...

local lsm = LibStub("LibSharedMedia-3.0")

lsm:Register("font", "Hyper Regular", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf")
lsm:Register("font", "Hyper Bold", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Bold-102.ttf")
lsm:Register("font", "Hyper Italic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Italic-102.ttf")
lsm:Register("font", "Hyper BoldItalic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-BoldItalic-102.ttf")

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
-- frame:RegisterEvent("DISPLAY_SIZE_CHANGED")

frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Hyperlegible" then
		STANDARD_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		UNIT_NAME_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		NAMEPLATE_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
		NAMEPLATE_SPELLCAST_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DAMAGE_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DEFAULT_AURA_DURATION_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
		SMALLER_AURA_DURATION_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		TRADESKILL_REAGENT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

	end
	if event == "PLAYER_LOGIN" then

		-- Check user's locale and exit before changing fonts to prevent an issues for non-Latin language users
		if not db.locale[GetLocale()] then print("Hyperlegible Disabled: Unsupported Locale") return end

		do -- Exceptions that we'll handle manually
			WorldMapFrameHomeButtonText:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		end

		local font, p, hOff
		for n, f in pairs(db.data) do
			if _G[n] then
				font = _G[n] or n
				if f.height > 0 then
					if f.height > 120 then print(n) end
					if false then -- UserConfig[n] ~= nil then
						p = UserConfig[n].path or db.paths.regular
						hOff = UserConfig[n].hOff or 0
						font:SetFont(p, f.height + hOff, f.flags)
					else
						font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", f.height, f.flags)
					end
				end
			end
		end

		if UserConfigHistory == nil then
			UserConfigHistory = {}
		end
		UserConfig = nil

		local itr = 1
		if UserConfig == nil then
			UserConfig = {}
			for _,_font in pairs(db.fonts) do
				if itr % 2 == 0 then
					UserConfig[_font] = {["path"] = db.paths.regular, ["hOff"] = 0}
				end
				itr = itr + 1
			end
		end
	end
	--[[
	if event == "DISPLAY_SIZE_CHANGED" then
		local w, h = GetPhysicalScreenSize()
		if h <= 1200 then
			print("FONTS SWAPPED TO BIG")
		end
	end
	]]
end)