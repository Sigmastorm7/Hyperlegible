local addonName, hyper = ...
local lsm = LibStub("LibSharedMedia-3.0")
lsm:Register("font", "Hyper Regular", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf")
lsm:Register("font", "Hyper Bold", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Bold-102.ttf")
lsm:Register("font", "Hyper Italic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Italic-102.ttf")
lsm:Register("font", "Hyper BoldItalic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-BoldItalic-102.ttf")

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")

frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Hyperlegible" then
		STANDARD_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		UNIT_NAME_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		-- NAMEPLATE_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
		NAMEPLATE_SPELLCAST_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DAMAGE_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DEFAULT_AURA_DURATION_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
		SMALLER_AURA_DURATION_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		TRADESKILL_REAGENT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
	end
	if event == "PLAYER_LOGIN" then

		-- Check user's locale and exit before changing fonts to prevent an issues for non-Latin language users
		if not hyper.locale[GetLocale()] then print("Hyperlegible Disabled: Unsupported Locale") return end

		hyper.makeDB()

		do -- Exceptions that we'll handle manually
			WorldMapFrameHomeButtonText:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		end

		local font

		for n, f in pairs(FontDB) do
			if _G[n] then
				font = _G[n] or n
				if f.height > 0 then
					font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", f.height, f.flags)
				end
			end
		end
	end
end)