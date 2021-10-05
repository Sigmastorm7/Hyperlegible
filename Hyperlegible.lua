local addonName, hyper = ...
-- Hyperlegible = LibStub("AceAddon-3.0"):NewAddon(Hyperlegible, "Hyperlegible", "LibSharedMedia-3.0")
local lsm = LibStub("LibSharedMedia-3.0")
lsm:Register("font", "Hyper Regular", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf")
lsm:Register("font", "Hyper Bold", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Bold-102.ttf")
lsm:Register("font", "Hyper Italic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Italic-102.ttf")
lsm:Register("font", "Hyper BoldItalic", "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-BoldItalic-102.ttf")

------------------------------------------------------------
-- ATTENTION: Greetings, Seeker of Knowledge! As of now this
-- is a very dirty implementation of how this addon is
-- intended to work. Please don't bully me. 
------------------------------------------------------------

local frame = CreateFrame("Frame")

frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
-- frame:RegisterEvent("PLAYER_LOGOUT")
-- frame:RegisterEvent("PLAYER_ENTERING_WORLD")
-- frame:RegisterEvent("PLAYER_LEAVING_WORLD")

-- HyperFrame = CreateFrame("Frame", "HyperFrame", UIParent, "OptionsBoxTemplate")
-- HyperFrame:SetPoint("TOPLEFT", "$parent", "CENTER", -100, 20)
-- HyperFrame:SetPoint("BOTTOMRIGHT", "$parent", "CENTER", 100, -20)

-- This macro causes a weird interaction in the text box
-- /run print(unpack(WorldMapFrameText))


	
frame:SetScript("OnEvent", function(self, event, arg)
	if event == "ADDON_LOADED" and arg == "Hyperlegible" then
		-- [A-Z]+_[A-Z]+_FONT
		STANDARD_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		UNIT_NAME_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		NAMEPLATE_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
		NAMEPLATE_SPELLCAST_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DAMAGE_TEXT_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

		DEFAULT_AURA_DURATION_FONT = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"

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
	--[[
		AchievementFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		ChatBubbleFont:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674)
		CoreAbilityFont:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		DestinyFontHuge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		DestinyFontLarge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		DestinyFontMed:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		Fancy12Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		Fancy14Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		Fancy16Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		Fancy18Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		Fancy20Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20)
		Fancy22Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 22.000001907349)
		Fancy24Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		Fancy27Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 27)
		Fancy30Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 30)
		Fancy32Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		Fancy48Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 48)
		FriendsFont_11:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		FriendsFont_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		FriendsFont_Normal:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		FriendsFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		FriendsFont_UserText:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		Game10Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10, "OUTLINE")
		Game11Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		Game11Font_Shadow:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		Game11Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674, "OUTLINE")
		Game120Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 120)
		Game12Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		Game12Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12, "OUTLINE")
		Game13Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674)
		Game13FontShadow:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674)
		Game13Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674, "OUTLINE")
		Game15Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15)
		Game15Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15, "OUTLINE")
		Game16Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		Game17Font_Shadow:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 17)
		Game18Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		Game20Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20)
		Game24Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		Game27Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 27)
		Game30Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 30)
		Game32Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		Game32Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		Game36Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 36)
		Game36Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 36)
		Game40Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 40)
		Game40Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 40)
		Game42Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 42.000003814697)
		Game46Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 46)
		Game46Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 46)
		Game48Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 48)
		Game48FontShadow:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 48)
		Game52Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 52.000003814697)
		Game58Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 58.000003814697)
		Game60Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 60)
		Game69Font_Shadow2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 69)
		Game72Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 72)
		Game72Font_Shadow:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 72)
		GameFont_Gigantic:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32)
		GameTooltipHeader:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		InvoiceFont_Med:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		InvoiceFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		MailFont_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15)
		Number11Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		Number12Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		Number12Font_o1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12, "OUTLINE")
		Number13Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674)
		Number15Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15)
		Number16Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		Number18Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		NumberFont_GameNormal:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		NumberFont_Normal_Med:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		NumberFont_OutlineThick_Mono_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12, "OUTLINE", "THICKOUTLINE", "MONOCHROME")
		NumberFont_Outline_Huge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 30, "OUTLINE")
		NumberFont_Outline_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16, "OUTLINE")
		NumberFont_Outline_Med:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326, "OUTLINE")
		NumberFont_Shadow_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20)
		NumberFont_Shadow_Med:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		NumberFont_Shadow_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		NumberFont_Shadow_Tiny:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		NumberFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		PriceFont:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		QuestFont_30:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 30)
		QuestFont_39:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 39)
		QuestFont_Enormous:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 30)
		QuestFont_Huge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		QuestFont_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15)
		QuestFont_Outline_Huge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18, "OUTLINE")
		QuestFont_Shadow_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		QuestFont_Super_Huge:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		QuestFont_Super_Huge_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24, "OUTLINE")
		ReputationDetailFont:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		SpellFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		SplashHeaderFont:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		System15Font:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15)
		SystemFont22_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 22.000001907349, "OUTLINE")
		SystemFont22_Shadow_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 22.000001907349, "OUTLINE")
		SystemFont_Huge1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20)
		SystemFont_Huge1_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20, "OUTLINE")
		SystemFont_Huge2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		SystemFont_Huge4:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 27)
		SystemFont_InverseShadow_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		SystemFont_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		SystemFont_LargeNamePlate:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		SystemFont_LargeNamePlateFixed:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 31330.236328125)
		SystemFont_Med1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		SystemFont_Med2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674)
		SystemFont_Med3:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		SystemFont_NamePlate:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 9)
		SystemFont_NamePlateCastBar:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 15665.118164062, "OUTLINE")
		SystemFont_NamePlateFixed:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 21931.166015625)
		SystemFont_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.000000953674, "OUTLINE")
		SystemFont_OutlineThick_Huge2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 22.000001907349, "OUTLINE", "THICKOUTLINE")
		SystemFont_OutlineThick_Huge4:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 26.000001907349, "OUTLINE", "THICKOUTLINE")
		SystemFont_OutlineThick_WTF:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 32, "OUTLINE", "THICKOUTLINE")
		SystemFont_Outline_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10, "OUTLINE")
		SystemFont_Outline_WTF2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 36, "OUTLINE")
		SystemFont_Shadow_Huge1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 20)
		SystemFont_Shadow_Huge2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24)
		SystemFont_Shadow_Huge2_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 24, "OUTLINE")
		SystemFont_Shadow_Huge3:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 25)
		SystemFont_Shadow_Huge4:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 27)
		SystemFont_Shadow_Huge4_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 27, "OUTLINE")
		SystemFont_Shadow_Large2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 18)
		SystemFont_Shadow_Large:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		SystemFont_Shadow_Large_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16, "OUTLINE")
		SystemFont_Shadow_Med1:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		SystemFont_Shadow_Med1_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12, "OUTLINE")
		SystemFont_Shadow_Med2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		SystemFont_Shadow_Med2_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326, "OUTLINE")
		SystemFont_Shadow_Med3:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326)
		SystemFont_Shadow_Med3_Outline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 13.999999046326, "OUTLINE")
		SystemFont_Shadow_Outline_Huge3:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 25, "OUTLINE")
		SystemFont_Shadow_Small2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		SystemFont_Shadow_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		SystemFont_Small2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 11.000000953674)
		SystemFont_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
		SystemFont_WTF2:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 36)
		SystemFont_World:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 100256.7578125)
		SystemFont_World_ThickOutline:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 100256.7578125, "OUTLINE", "THICKOUTLINE")
		System_IME:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 16)
		Tooltip_Med:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 12)
		Tooltip_Small:SetFont("Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf", 10)
	]]
	end
end)