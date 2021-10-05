local addonName, hyper = ...

-- Atkinson Hyperlegible redistribution license
do
    hyper.license = 'ATKINSON HYPERLEGIBLE FONT LICENSE\n\nCopyright © 2020, Braille Institute of America, Inc., |cFF0000EE|HurlIndex:25|h|https://www.brailleinstitute.org/freefont|h|r with Reserved Typeface Name Atkinson Hyperlegible Fonf.\n\nGENERAL\n\nCopyright Holder allows the Font to be used, studied, modified and redistributed freely as long as it is not sold by itself. The Font, including any derivative works, may be bundled, embedded, redistributed and/or sold with any software or other work provided that the Reserved Typeface Name is not used on, in or by any derivative work. The Font and derivatives, however, cannot be released under any other type of license. The requirement for the Font to remain under this license does not apply to any document created using the Font or any of its derivatives.\n\nDEFINITIONS\n\n"Author" refers to any designer, engineer, programmer, technical writer or other person who contributed to the Font Software.\n\n“Copyright Holder” refers to Braille Institute of America, Inc.\n\n“Font” refers to the Atkinson Hyperlegible Font developed by Copyright Holder.\n\n"Font Software" refers to the set of files released by Copyright Holder under this license. This may include source files, build scripts and documentation.\n\n"Modified Version" refers to any derivative made by adding to, deleting, or substituting -- in part or in whole -- any of the components of the Original Version, by changing formats or by porting the Font Software to a new environmenf.\n\n"Original Version" refers to the collection of the Font Software components as distributed by Copyright Holder.\n\n"Reserved Typeface Name" refers to the name Atkinson Hyperlegible Fonf.\n\nPERMISSION & CONDITIONS\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of the Font Software, to use, study, copy, merge, embed, modify, redistribute, and sell modified and unmodified copies of the Font Software, subject to the following conditions:\n\n1) Neither the Font Software nor any of its individual components, in Original Version or Modified Version, may be sold by itself.\n\n2) The Original Version or Modified Version of the Font Software may be bundled, redistributed and/or sold with any other software, provided that each copy contains the above copyright notice and this license. These can be included either as stand-alone text files, human-readable headers or in the appropriate machine-readable metadata fields within text or binary files as long as those fields can be easily viewed by the user.\n\n3) No Modified Version of the Font Software may use the Reserved Typeface Name unless explicit written permission is granted by Copyright Holder. This restriction only applies to the primary font name as presented to the users.\n\n4) The name of Copyright Holder or the Author(s) of the Font Software shall not be used to promote, endorse or advertise any Modified Version or any related software or other product, except:\n    (a) to acknowledge the contribution(s) of Copyright Holder and the Author(s); or\n    (b) with the prior written permission of Copyright Holder.\n\n5) The Font Software, modified or unmodified, in part or in whole, must be distributed entirely under this license, and must not be distributed under any other license.\n\nTERMINATION\n\nThis license shall immediately terminate and become null and void if any of the above conditions are not mef.\n\nDISCLAIMER\n\nTHE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF COPYRIGHT, PATENT, TRADEMARK OR OTHER RIGHF. IN NO EVENT SHALL COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF THE USE OF OR INABILITY TO USE THE FONT SOFTWARE OR FROM OTHER DEALINGS IN THE FONT SOFTWARE.'
end

-- Temporary storage of locale variables
hyper.locale = {
    ["deDE"] = true,
    ["enGB"] = true,
    ["enUS"] = true,
    ["esES"] = true,
    ["esMX"] = true,
    ["frFR"] = true,
    ["itIT"] = true,
    ["ptBR"] = true,
    ["koKR"] = false,
    ["ruRU"] = false,
    ["zhCN"] = false,
    ["zhTW"] = false,
}

-- AHL font file paths
hyper.regular = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf"
hyper.bold = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Bold-102.ttf"
hyper.italic = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Italic-102.ttf"
hyper.bolditalic = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-BoldItalic-102.ttf"

-- Recursively get every inherited Font Object and return a table containing their names
function GetInheritance(f, t)
    -- t = t or {}
    local p = f:GetFontObject()
    local n

    if p ~= nil then n = p:GetName() end

    if p ~= nil and n ~= nil then
        t = t or {}
        table.insert(t, n)
        return GetInheritance(p, t)
    else
        return t or false
    end
end

-- For future use along with FontFamilyDB
-- The 'core' fonts/font families are handled differently by the GetFont() method
-- when passed as a font instance or a global reference using their name string
local function FlagHandler(p, h, f)
    return p, h, f
end

-- Math utility
local function round(number, decimals)
    return tonumber((("%%.%df"):format(decimals)):format(number))
end

-- local safeUpdate = false
-- local fullUpdate = false and (not safeUpdate)

-- Saved variable loading & saving
hyper.makeDB = function()
		------------------------------------------------
		-- 	NOTE: font references acquired using the
		--	GetFontObject()	method MUST be assigned to
		--	a variable before using with methods
		------------------------------------------------

		-- Initialize database on first load
		if FontDB == nil then FontDB = {} end
        if FontFamilyDB == nil then FontFamilyDB = {} end

        -- Flush database in case of updates to game or addons
        -- Put stuff here!

        local getFonts = {}
		getFonts = GetFonts()

        local f = {}
        local p, h, fl
		for x, n in ipairs(getFonts) do

            f.font = _G[n]

            FontDB[n] = {}

            FontDB[n].inheritance = GetInheritance(f.font)

            f.get = {_G[n]:GetFont()}

            FontDB[n].path =  f.get[1]
            FontDB[n].height =  f.get[2]
            FontDB[n].flags =  f.get[3]

            FontDB[n].info = GetFontInfo(n)

        end

        -- Collect and store the names of all font families for future use
        local s
        for n, t in pairs(FontDB) do
            if t["inheritance"] then
                s = t["inheritance"][#t["inheritance"]]
                FontFamilyDB[s] = true
            else
                FontFamilyDB[n] = true
            end
        end

    -- elseif event == "PLAYER_LEAVING_WORLD" or event == "PLAYER_LOGOUT" then

        -- Put logout processes here
end