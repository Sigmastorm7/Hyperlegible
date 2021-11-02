local addon, db = ...

---------------------------------
-- Database building utilities --
    -- The 'core' fonts/font families are handled differently by the GetFont() method
    -- when passed as a font instance or a global reference using their name string
    local function FlagHandler(p, h, f)
        return p, h, f
    end

    -- Recursively get every inherited Font Object and return a table containing their names
    local function GetInheritance(f, t)
        local p = f:GetFontObject()
        local n

        if p ~= nil then n = p:GetName() end

        if p ~= nil and n ~= nil then
            t = t or {}
            table.insert(t, n)
            return GetInheritance(p, t)
        else
            -- FontFamilyDB[f:GetName()] = true
            return t or false
        end
    end

    local function RestorePreserved()
        for _, f in ipairs(db.preserve) do
        	local font = db.data[f]
        	print(font.path, font.height, font.flags)
        	_G[f]:SetFont(font.path, font.height, font.flags)
        end
    end

    local function round(number, decimals)
        return tonumber((("%%.%df"):format(decimals)):format(number))
    end

    local function UpdateDB()
        ------------------------------------------------
        -- 	NOTE: font references acquired using the
        --	GetFontObject()	method MUST be assigned to
        --	a variable before using with methods
        ------------------------------------------------

        -- Refresh the db in case of updates to game or addons

        -- local getFonts = {}
        -- getFonts = GetFonts()

        -- local f = {}
        -- local p, h, fl
        -- for _, n in ipairs(getFonts) do
        
            -- UpdateFonts[i] = f

            -- if string.sub(font, 1, 5) ~= "table" then
            --     table.insert(self.fontTable, font)
            -- end

            -- DON'T BREAK THIS PART PLEASE --
            -- do -- TEMPORARILY DISABLING MOST OF THIS FUNCTION FOR EFFICIENCY 
                -- f.font = _G[n]
                -- db.export[n] = {}
                -- db.export[n] = GetInheritance(f.font) -- .inheritance = GetInheritance(f.font)
                -- f.get = {_G[n]:GetFont()}
                -- db.export[n].path =  f.get[1]
                -- db.export[n].height =  f.get[2]
                -- db.export[n].flags =  f.get[3]
                -- db.export[n].info = GetFontInfo(n)
            -- end
            -- DON'T BREAK THIS PART PLEASE --
            -- table.insert(fonts, n)
        -- end
    end
---------------------------------

-----------------------------------
-- Atkinson Hyperlegible license --
    db.license = 'ATKINSON HYPERLEGIBLE FONT LICENSE\n\nCopyright © 2020, Braille Institute of America, Inc., |cFF0000EE|HurlIndex:25|h|https://www.brailleinstitute.org/freefont|h|r with Reserved Typeface Name Atkinson Hyperlegible Fonf.\n\nGENERAL\n\nCopyright Holder allows the Font to be used, studied, modified and redistributed freely as long as it is not sold by itself. The Font, including any derivative works, may be bundled, embedded, redistributed and/or sold with any software or other work provided that the Reserved Typeface Name is not used on, in or by any derivative work. The Font and derivatives, however, cannot be released under any other type of license. The requirement for the Font to remain under this license does not apply to any document created using the Font or any of its derivatives.\n\nDEFINITIONS\n\n"Author" refers to any designer, engineer, programmer, technical writer or other person who contributed to the Font Software.\n\n“Copyright Holder” refers to Braille Institute of America, Inc.\n\n“Font” refers to the Atkinson Hyperlegible Font developed by Copyright Holder.\n\n"Font Software" refers to the set of files released by Copyright Holder under this license. This may include source files, build scripts and documentation.\n\n"Modified Version" refers to any derivative made by adding to, deleting, or substituting -- in part or in whole -- any of the components of the Original Version, by changing formats or by porting the Font Software to a new environmenf.\n\n"Original Version" refers to the collection of the Font Software components as distributed by Copyright Holder.\n\n"Reserved Typeface Name" refers to the name Atkinson Hyperlegible Fonf.\n\nPERMISSION & CONDITIONS\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of the Font Software, to use, study, copy, merge, embed, modify, redistribute, and sell modified and unmodified copies of the Font Software, subject to the following conditions:\n\n1) Neither the Font Software nor any of its individual components, in Original Version or Modified Version, may be sold by itself.\n\n2) The Original Version or Modified Version of the Font Software may be bundled, redistributed and/or sold with any other software, provided that each copy contains the above copyright notice and this license. These can be included either as stand-alone text files, human-readable headers or in the appropriate machine-readable metadata fields within text or binary files as long as those fields can be easily viewed by the user.\n\n3) No Modified Version of the Font Software may use the Reserved Typeface Name unless explicit written permission is granted by Copyright Holder. This restriction only applies to the primary font name as presented to the users.\n\n4) The name of Copyright Holder or the Author(s) of the Font Software shall not be used to promote, endorse or advertise any Modified Version or any related software or other product, except:\n    (a) to acknowledge the contribution(s) of Copyright Holder and the Author(s); or\n    (b) with the prior written permission of Copyright Holder.\n\n5) The Font Software, modified or unmodified, in part or in whole, must be distributed entirely under this license, and must not be distributed under any other license.\n\nTERMINATION\n\nThis license shall immediately terminate and become null and void if any of the above conditions are not met.\n\nDISCLAIMER\n\nTHE FONT SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF COPYRIGHT, PATENT, TRADEMARK OR OTHER RIGHF. IN NO EVENT SHALL COPYRIGHT HOLDER BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, INCLUDING ANY GENERAL, SPECIAL, INDIRECT, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF THE USE OF OR INABILITY TO USE THE FONT SOFTWARE OR FROM OTHER DEALINGS IN THE FONT SOFTWARE.'
-----------------------------------

-------------
-- Locales --
    db.locale = {
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
-------------

----------------------------------
-- Font paths, data & relations --
    db.paths = {
        ["regular"] = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Regular-102.ttf",
        ["bold"] = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Bold-102.ttf",
        ["italic"] = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-Italic-102.ttf",
        ["bolditalic"] = "Interface\\AddOns\\Hyperlegible\\fonts\\Atkinson-Hyperlegible-BoldItalic-102.ttf",
    }

    db.data = {
        ["AchievementCriteriaFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                    "AchievementDescriptionFont",
                    "SystemFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["AchievementDateFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "AchievementFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["AchievementDescriptionFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["AchievementFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["AchievementPointsFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["AchievementPointsFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ArtifactAppearanceSetHighlightFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = {
                "Fancy24Font",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ArtifactAppearanceSetNormalFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = {
                "Fancy24Font",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["BossEmoteNormalHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge3",
            },
            ["height"] = 25,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ChatBubbleFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ChatFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Shadow_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ChatFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Shadow_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CombatLogFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CombatTextFont"] = { -- troublesome font
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_World",
            },
            ["height"] = 125,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CombatTextFontOutline"] = { -- troublesome font
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_World_ThickOutline",
            },
            ["height"] = 125,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorCCFont"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_OutlineThick_WTF",
            },
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorDampeningFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "CommentatorTeamScoreFont",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = 0,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9019588232040405,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorFontMedium"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large2",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorTeamNameFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = 0,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9019588232040405,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorTeamScoreFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = 0,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9019588232040405,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorVictoryFanfare"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "Game120Font",
            },
            ["height"] = 120,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = 0,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9019588232040405,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CommentatorVictoryFanfareTeam"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "Game72Font",
            },
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = 0,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9019588232040405,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ConsoleFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Shadow_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ConsoleFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Shadow_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["CoreAbilityFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["DestinyFontHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["DestinyFontLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["DestinyFontMed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["DialogButtonHighlightText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "DialogButtonNormalText",
                "SystemFont_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["DialogButtonNormalText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ErrorFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy12Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy14Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy16Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy18Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy20Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy22Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy24Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy27Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy30Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy32Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Fancy48Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.TTF",
            ["inheritance"] = false,
            ["height"] = 48.00000381469727,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FocusFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FriendsFont_11"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FriendsFont_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FriendsFont_Normal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FriendsFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["FriendsFont_UserText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game10Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game11Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game11Font_Shadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game11Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game120Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 120,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game12Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game12Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game13Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game13FontShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game13Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game15Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game15Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game16Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game17Font_Shadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 17,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game18Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game20Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game24Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game27Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game30Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game32Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game32Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game36Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game36Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game40Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 40,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game40Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 40,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game42Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 42,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game46Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 46,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game46Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 46,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game48Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 48.00000381469727,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game48FontShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 48.00000381469727,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game52Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 51.99999618530273,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game58Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 58,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game60Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 60,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game69Font_Shadow2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 69,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game72Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Game72Font_Shadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = false,
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFont72Highlight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "GameFont72Normal",
                "Game72Font",
            },
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFont72HighlightShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "GameFont72NormalShadow",
                "Game72Font_Shadow",
            },
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFont72Normal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "Game72Font",
            },
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFont72NormalShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.ttf",
            ["inheritance"] = {
                "Game72Font_Shadow",
            },
            ["height"] = 72,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontBlack"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontBlackMedium"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med3",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontBlackSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontBlackSmall2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Small2",
            },
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontBlackTiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny",
            },
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontBlackTiny2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny2",
            },
            ["height"] = 8,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontDarkGraySmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.3490188419818878,
                    ["g"] = 0.3490188419818878,
                    ["r"] = 0.3490188419818878,
                },
            },
        },
        ["GameFontDisable"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalHuge",
                "SystemFont_Shadow_Huge1",
            },
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontDisable",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableMed2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalMed2",
                "SystemFont_Shadow_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableMed3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med3",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableOutline22"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalOutline22",
                "SystemFont22_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableSmall2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Small2",
            },
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableSmallLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontDisableSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableTiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny",
            },
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontDisableTiny2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny2",
            },
            ["height"] = 8,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontGreen"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["GameFontGreenLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["GameFontGreenSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["GameFontHighlight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightCenter"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightExtraSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightExtraSmallLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightExtraSmall",
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightExtraSmallLeftTop"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightExtraSmallLeft",
                "GameFontHighlightExtraSmall",
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalHuge",
                "SystemFont_Shadow_Huge1",
            },
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightHuge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Huge2",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightLarge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge2",
                "SystemFont_Shadow_Large2",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightMed2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalMed2",
                "SystemFont_Shadow_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightMedium"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med3",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightOutline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalOutline",
                "SystemFont_Shadow_Med1_Outline",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightOutline22"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalOutline22",
                "SystemFont22_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightRight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightShadowHuge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge2",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightShadowOutline22"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont22_Shadow_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmall2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Small2",
            },
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmallLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmallLeftTop"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmallLeft",
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmallOutline"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontHighlightSmallRight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalCenter"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalGraySmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontNormalHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge1",
            },
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHuge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Huge2",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHuge3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge3",
            },
            ["height"] = 25,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHuge3Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Outline_Huge3",
            },
            ["height"] = 25,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHuge4"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge4",
            },
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHuge4Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge4_Outline",
            },
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalHugeBlack"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Huge1",
            },
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontNormalHugeOutline"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge1",
            },
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLarge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large2",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLargeLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLargeLeftTop"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLargeLeft",
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLargeOutline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Large_Outline",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLeftBottom"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLeftGreen"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0,
                },
            },
        },
        ["GameFontNormalLeftGrey"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["GameFontNormalLeftLightGreen"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.2509798407554627,
                    ["g"] = 0.7490179538726807,
                    ["r"] = 0.2509798407554627,
                },
            },
        },
        ["GameFontNormalLeftOrange"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.2509798407554627,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalLeftRed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0.9019588232040405,
                },
            },
        },
        ["GameFontNormalLeftYellow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalMed1"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalMed2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalMed2Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med2_Outline",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalMed3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med3",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalMed3Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med3_Outline",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalOutline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med1_Outline",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalOutline22"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont22_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.7803904414176941,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalRight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalShadowHuge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Huge2",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalShadowOutline22"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont22_Shadow_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalSmall2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Small2",
            },
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalSmallBattleNetBlueLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.7725473046302795,
                    ["r"] = 0.5098028182983398,
                },
            },
        },
        ["GameFontNormalSmallLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalTiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny",
            },
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalTiny2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny2",
            },
            ["height"] = 8,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalWTF2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_WTF2",
            },
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormalWTF2Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Outline_WTF2",
            },
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontNormal_NoShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontRed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontRedLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontRedSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontBlack",
                "SystemFont_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontWhiteSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontBlackSmall",
                "SystemFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontWhiteTiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny",
            },
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFontWhiteTiny2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Tiny2",
            },
            ["height"] = 8,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameFont_Gigantic"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameNormalNumberFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "NumberFont_GameNormal",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameTooltipHeader"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameTooltipHeaderText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameTooltipHeader",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameTooltipText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "Tooltip_Med",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["GameTooltipTextSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "Tooltip_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["IMEHighlight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "System_IME",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["IMENormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "System_IME",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["InvoiceFont_Med"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["InvoiceFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["InvoiceTextFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "InvoiceFont_Med",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.05882339924573898,
                    ["g"] = 0.1215683594346046,
                    ["r"] = 0.1803917586803436,
                },
            },
        },
        ["InvoiceTextFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "InvoiceFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.05882339924573898,
                    ["g"] = 0.1215683594346046,
                    ["r"] = 0.1803917586803436,
                },
            },
        },
        ["ItemTextFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Large",
            },
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.05882339924573898,
                    ["g"] = 0.1215683594346046,
                    ["r"] = 0.1803917586803436,
                },
            },
        },
        ["MailFont_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["MailTextFontNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "MailFont_Large",
            },
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.05882339924573898,
                    ["g"] = 0.1215683594346046,
                    ["r"] = 0.1803917586803436,
                },
            },
        },
        ["MissionCombatTextFontOutline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Outline_WTF2",
            },
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["MovieSubtitleFont"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalShadowOutline22",
                "SystemFont22_Shadow_Outline",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.7803904414176941,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NewSubSpellFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SubSpellFont",
                "SpellFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5411753058433533,
                    ["g"] = 0.7019592523574829,
                    ["r"] = 0.8196060657501221,
                },
            },
        },
        ["Number11Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number11FontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number11Font",
            },
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number12Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number12Font_o1"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number13Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number13FontGray"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number13Font",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["Number13FontRed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number13Font",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number13FontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number13Font",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number13FontYellow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number13Font",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number14FontGray"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Normal_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["Number14FontGreen"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Normal_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["Number14FontRed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Normal_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number14FontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Normal_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number15Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number15FontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number15Font",
            },
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number16Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number18Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Number18FontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "Number18Font",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormal"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalGray"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5999986529350281,
                    ["g"] = 0.5999986529350281,
                    ["r"] = 0.5999986529350281,
                },
            },
        },
        ["NumberFontNormalHuge"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\skurri.ttf",
            ["inheritance"] = {
                "NumberFont_Outline_Huge",
            },
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalLarge"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalLargeRight"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalLarge",
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalLargeRightGray"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalLargeRight",
                "NumberFontNormalLarge",
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5999986529350281,
                    ["g"] = 0.5999986529350281,
                    ["r"] = 0.5999986529350281,
                },
            },
        },
        ["NumberFontNormalLargeRightRed"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalLargeRight",
                "NumberFontNormalLarge",
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalLargeRightYellow"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalLargeRight",
                "NumberFontNormalLarge",
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalLargeYellow"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalLarge",
                "NumberFont_Outline_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalRight"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalRightGray"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalRight",
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5999986529350281,
                    ["g"] = 0.5999986529350281,
                    ["r"] = 0.5999986529350281,
                },
            },
        },
        ["NumberFontNormalRightGreen"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalRight",
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["NumberFontNormalRightRed"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalRight",
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalRightYellow"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalRight",
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalSmall"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_OutlineThick_Mono_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontNormalSmallGray"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormalSmall",
                "NumberFont_OutlineThick_Mono_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5999986529350281,
                    ["g"] = 0.5999986529350281,
                    ["r"] = 0.5999986529350281,
                },
            },
        },
        ["NumberFontNormalYellow"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFontNormal",
                "NumberFont_Outline_Med",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontSmallBattleNetBlueLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.7725473046302795,
                    ["r"] = 0.5098028182983398,
                },
            },
        },
        ["NumberFontSmallWhiteLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFontSmallYellowLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "NumberFont_Small",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_GameNormal"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Normal_Med"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_OutlineThick_Mono_Small"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE, MONOCHROME",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Outline_Huge"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\skurri.ttf",
            ["inheritance"] = false,
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Outline_Large"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Outline_Med"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Shadow_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -0.0006094765849411488,
                    ["x"] = 0.0006094765849411488,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Shadow_Med"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Shadow_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Shadow_Tiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["NumberFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ObjectiveFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.7999982237815857,
                    ["g"] = 0.7999982237815857,
                    ["r"] = 0.7999982237815857,
                },
            },
        },
        ["OptionsFontHighlight"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlight",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["OptionsFontHighlightSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontHighlightSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["OptionsFontLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLarge",
                "SystemFont_Shadow_Large",
            },
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["OptionsFontLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["OptionsFontSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["OptionsFontSmallLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "OptionsFontSmall",
                "GameFontNormalSmall",
                "SystemFont_Shadow_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["PVPInfoTextFont"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_OutlineThick_Huge2",
            },
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["PriceFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["PriceFontGray"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "PriceFont",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["PriceFontGreen"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "PriceFont",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.1019605621695519,
                },
            },
        },
        ["PriceFontRed"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "PriceFont",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["PriceFontWhite"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "PriceFont",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["PriceFontYellow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\ARIALN.TTF",
            ["inheritance"] = {
                "PriceFont",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestDifficulty_Difficult"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestDifficulty_Header"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.7019592523574829,
                    ["g"] = 0.7019592523574829,
                    ["r"] = 0.7019592523574829,
                },
            },
        },
        ["QuestDifficulty_Impossible"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.1019605621695519,
                    ["g"] = 0.1019605621695519,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestDifficulty_Standard"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.2509798407554627,
                    ["g"] = 0.7490179538726807,
                    ["r"] = 0.2509798407554627,
                },
            },
        },
        ["QuestDifficulty_Trivial"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.5019596815109253,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.5019596815109253,
                },
            },
        },
        ["QuestDifficulty_VeryDifficult"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontNormalLeft",
                "GameFontNormal",
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.2509798407554627,
                    ["g"] = 0.5019596815109253,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["QuestFontHighlightHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFontNormalHuge",
                "QuestFont_Huge",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFontLeft"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "QuestFont",
                "SystemFont_Med2",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["QuestFontNormalHuge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Huge",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFontNormalLarge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Large",
            },
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFontNormalSmall"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontBlack",
                "SystemFont_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.1803917586803436,
                    ["r"] = 0.3019601106643677,
                },
            },
        },
        ["QuestFont_30"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_39"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 39,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Enormous"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Huge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Outline_Huge"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Shadow_Enormous"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Enormous",
            },
            ["height"] = 30,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0.05098028108477593,
                        ["g"] = 0.3490188419818878,
                        ["r"] = 0.4901950061321259,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Shadow_Huge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Huge",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0.05098028108477593,
                        ["g"] = 0.3490188419818878,
                        ["r"] = 0.4901950061321259,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Shadow_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0.05098028108477593,
                        ["g"] = 0.3490188419818878,
                        ["r"] = 0.4901950061321259,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Shadow_Super_Huge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Super_Huge",
            },
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0.05098028108477593,
                        ["g"] = 0.3490188419818878,
                        ["r"] = 0.4901950061321259,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Super_Huge"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestFont_Super_Huge_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["QuestMapRewardsFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "GameFontBlackSmall",
                "SystemFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.6705867648124695,
                    ["g"] = 0.7882335782051086,
                    ["r"] = 0.9019588232040405,
                },
            },
        },
        ["QuestTitleFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Shadow_Huge",
                "QuestFont_Huge",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0.05098028108477593,
                        ["g"] = 0.3490188419818878,
                        ["r"] = 0.4901950061321259,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0,
                    ["r"] = 0,
                },
            },
        },
        ["QuestTitleFontBlackShadow"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = {
                "QuestFont_Shadow_Huge",
                "QuestFont_Huge",
            },
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ReputationDetailFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        --[[ this font is kind of weird so we'll ignore it
            ["ScrollingMessageFrame"] = {
                ["flags"] = "",
            ["inheritance"] = false,
            ["height"] = 0,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
            },
        ]]
        ["SpellFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SplashHeaderFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\MORPHEUS.ttf",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.8196060657501221,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SubSpellFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SpellFont_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0,
                    ["g"] = 0.1999995559453964,
                    ["r"] = 0.3490188419818878,
                },
            },
        },
        ["SubZoneTextFont"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_OutlineThick_Huge4",
            },
            ["height"] = 26,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["System15Font"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 15,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont22_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont22_Shadow_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -2,
                    ["x"] = 2,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Huge1"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Huge1_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Huge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Huge4"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_InverseShadow_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.7490179538726807,
                        ["b"] = 0.3999991118907929,
                        ["g"] = 0.3999991118907929,
                        ["r"] = 0.3999991118907929,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_LargeNamePlate"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_LargeNamePlateFixed"] = { -- troublesome font
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Med1"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Med2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Med3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_NamePlate"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_NamePlateCastBar"] = { -- troublesome font
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 125,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_NamePlateFixed"] = { -- troublesome font
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_OutlineThick_Huge2"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 22,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_OutlineThick_Huge4"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 26,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_OutlineThick_WTF"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Outline_Small"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Outline_WTF2"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge1"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 20,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge2_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 24,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 25,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge4"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Huge4_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 27,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Large"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Large2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 18,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Large_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med1"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med1_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med2_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med3"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Med3_Outline"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Outline_Huge3"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 25,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Shadow_Small2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Small2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 11,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Tiny"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 9,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_Tiny2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 8,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_WTF2"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 36,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_World"] = { -- troublesome font
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 125,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["SystemFont_World_ThickOutline"] = { -- troublesome font
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 125,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["System_IME"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 16,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["TextStatusBarText"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Outline_Small",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["TextStatusBarTextLarge"] = {
            ["flags"] = "OUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Outline",
            },
            ["height"] = 13,
            ["info"] = {
                ["outline"] = "OUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Tooltip_Med"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["Tooltip_Small"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = false,
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["VehicleMenuBarStatusBarText"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_Shadow_Med1",
            },
            ["height"] = 12,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["WhiteNormalNumberFont"] = {
            ["flags"] = "",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "NumberFont_GameNormal",
            },
            ["height"] = 10,
            ["info"] = {
                ["outline"] = "",
                ["shadow"] = {
                    ["y"] = -1,
                    ["x"] = 1,
                    ["color"] = {
                        ["a"] = 0.9999977946281433,
                        ["b"] = 0,
                        ["g"] = 0,
                        ["r"] = 0,
                    },
                },
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.9999977946281433,
                    ["g"] = 0.9999977946281433,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["WorldMapTextFont"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_OutlineThick_WTF",
            },
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.7607826590538025,
                    ["g"] = 0.9294097423553467,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
        ["ZoneTextFont"] = {
            ["flags"] = "OUTLINE, THICKOUTLINE",
            ["path"] = "Fonts\\FRIZQT__.TTF",
            ["inheritance"] = {
                "SystemFont_OutlineThick_WTF",
            },
            ["height"] = 32,
            ["info"] = {
                ["outline"] = "OUTLINE, THICKOUTLINE",
                ["color"] = {
                    ["a"] = 0.9999977946281433,
                    ["b"] = 0.7607826590538025,
                    ["g"] = 0.9294097423553467,
                    ["r"] = 0.9999977946281433,
                },
            },
        },
    }

    db.parent = {
        ["Game20Font"] = false,
        ["Game27Font"] = false,
        ["SystemFont_Tiny2"] = {
            "GameFontNormalTiny2",
            "GameFontBlackTiny2",
            "GameFontDisableTiny2",
            "GameFontWhiteTiny2",
        },
        ["Fancy12Font"] = false,
        ["SystemFont22_Shadow_Outline"] = {
            "GameFontHighlightShadowOutline22",
            "MovieSubtitleFont",
            "GameFontNormalShadowOutline22",
        },
        ["SystemFont_Shadow_Huge4_Outline"] = {
            "GameFontNormalHuge4Outline",
        },
        ["NumberFont_Small"] = {
            "NumberFontSmallBattleNetBlueLeft",
            "NumberFontSmallWhiteLeft",
            "NumberFontSmallYellowLeft",
        },
        ["SystemFont_Small2"] = {
            "GameFontDisableSmall2",
            "GameFontHighlightSmall2",
            "GameFontBlackSmall2",
        },
        ["Game52Font_Shadow2"] = false,
        ["SystemFont_World_ThickOutline"] = {
            "CombatTextFontOutline",
        },
        ["SystemFont_NamePlateFixed"] = false,
        ["SystemFont_NamePlate"] = false,
        ["SystemFont_Tiny"] = {
            "GameFontDisableTiny",
            "GameFontNormalTiny",
            "GameFontBlackTiny",
            "GameFontWhiteTiny",
        },
        ["NumberFont_Outline_Med"] = {
            "NumberFontNormalRightRed",
            "NumberFontNormalRightYellow",
            "NumberFontNormal",
            "NumberFontNormalRight",
            "NumberFontNormalRightGreen",
            "NumberFontNormalYellow",
            "NumberFontNormalGray",
            "NumberFontNormalRightGray",
        },
        ["NumberFont_Normal_Med"] = {
            "Number14FontWhite",
            "Number14FontGray",
            "Number14FontRed",
            "Number14FontGreen",
        },
        ["SystemFont_Shadow_Med3"] = {
            "GameFontHighlightMedium",
            "GameFontDisableMed3",
            "GameFontNormalMed3",
        },
        ["GameTooltipHeader"] = {
            "GameTooltipHeaderText",
        },
        ["Game13Font"] = false,
        ["Game120Font"] = {
            "CommentatorVictoryFanfare",
        },
        ["Fancy32Font"] = false,
        ["Game48FontShadow"] = false,
        ["Game48Font"] = false,
        ["Game11Font_Shadow"] = false,
        ["Game11Font_o1"] = false,
        ["Game40Font"] = false,
        ["Game12Font_o1"] = false,
        ["SystemFont_Shadow_Huge4"] = {
            "GameFontNormalHuge4",
        },
        ["SystemFont_Shadow_Huge1"] = {
            "GameFontNormalHuge",
            "GameFontDisableHuge",
            "GameFontNormalHugeOutline",
            "GameFontHighlightHuge",
        },
        ["SystemFont_OutlineThick_Huge4"] = {
            "SubZoneTextFont",
        },
        ["Game16Font"] = false,
        ["Fancy20Font"] = false,
        ["SystemFont_Shadow_Med2_Outline"] = {
            "GameFontNormalMed2Outline",
        },
        ["ReputationDetailFont"] = false,
        ["SystemFont_Shadow_Huge2"] = {
            "GameFontHighlightShadowHuge2",
            "GameFontNormalShadowHuge2",
        },
        ["NumberFont_Shadow_Large"] = false,
        ["Fancy48Font"] = false,
        ["Fancy22Font"] = false,
        ["SystemFont_OutlineThick_WTF"] = {
            "CommentatorCCFont",
            "WorldMapTextFont",
            "ZoneTextFont",
        },
        ["SystemFont_Shadow_Med3_Outline"] = {
            "GameFontNormalMed3Outline",
        },
        ["SystemFont_Med1"] = {
            "GameFontNormal_NoShadow",
            "GameFontBlack",
            "CommentatorFontSmall",
            "GameFontWhite",
            "QuestFontNormalSmall",
        },
        ["SystemFont_Outline"] = {
            "TextStatusBarTextLarge",
        },
        ["AchievementFont_Small"] = {
            "AchievementDateFont",
        },
        ["Tooltip_Small"] = {
            "GameTooltipTextSmall",
        },
        ["System_IME"] = {
            "IMEHighlight",
            "IMENormal",
        },
        ["Number12Font_o1"] = false,
        ["Number16Font"] = false,
        ["NumberFont_OutlineThick_Mono_Small"] = {
            "NumberFontNormalSmallGray",
            "NumberFontNormalSmall",
        },
        ["Fancy30Font"] = false,
        ["QuestFont_Shadow_Small"] = false,
        ["FriendsFont_Normal"] = false,
        ["SystemFont_LargeNamePlateFixed"] = false,
        ["SystemFont_Shadow_Large"] = {
            "GameFontHighlightLarge",
            "GameFontNormalLargeLeft",
            "GameFontNormalLargeLeftTop",
            "GameFontRedLarge",
            "ErrorFont",
            "AchievementPointsFont",
            "GameFontDisableLarge",
            "CommentatorTeamScoreFont",
            "GameFontNormalLarge",
            "OptionsFontLarge",
            "GameFontGreenLarge",
            "CommentatorDampeningFont",
        },
        ["FriendsFont_UserText"] = false,
        ["SystemFont_Shadow_Med1"] = {
            "GameFontNormalLeftGreen",
            "GameFontGreen",
            "ObjectiveFont",
            "QuestDifficulty_Trivial",
            "QuestDifficulty_Impossible",
            "VehicleMenuBarStatusBarText",
            "GameFontNormalLeftGrey",
            "GameFontHighlightRight",
            "GameFontNormalLeftRed",
            "GameFontNormal",
            "QuestDifficulty_Difficult",
            "GameFontHighlightCenter",
            "GameFontDisable",
            "GameFontRed",
            "GameFontNormalLeftBottom",
            "GameFontNormalLeftOrange",
            "QuestDifficulty_VeryDifficult",
            "CombatLogFont",
            "GameFontNormalLeftLightGreen",
            "GameFontNormalLeft",
            "GameFontNormalRight",
            "QuestDifficulty_Header",
            "GameFontHighlightLeft",
            "GameFontHighlight",
            "GameFontNormalLeftYellow",
            "GameFontNormalCenter",
            "OptionsFontHighlight",
            "OptionsFontLeft",
            "QuestDifficulty_Standard",
            "AchievementPointsFontSmall",
            "GameFontDisableLeft",
        },
        ["Game60Font"] = false,
        ["Game11Font"] = false,
        ["NumberFont_Outline_Large"] = {
            "NumberFontNormalLargeRight",
            "NumberFontNormalLargeRightYellow",
            "NumberFontNormalLarge",
            "NumberFontNormalLargeRightRed",
            "NumberFontNormalLargeRightGray",
            "NumberFontNormalLargeYellow",
        },
        ["Game15Font"] = false,
        ["Number18Font"] = {
            "Number18FontWhite",
        },
        ["Tooltip_Med"] = {
            "GameTooltipText",
        },
        ["SystemFont_Med3"] = {
            "GameFontBlackMedium",
        },
        ["QuestFont_39"] = false,
        ["Fancy27Font"] = false,
        ["SystemFont_Huge1"] = {
            "GameFontNormalHugeBlack",
        },
        ["SystemFont_World"] = {
            "CombatTextFont",
        },
        ["Fancy24Font"] = {
            "ArtifactAppearanceSetNormalFont",
            "ArtifactAppearanceSetHighlightFont",
        },
        ["SystemFont_Huge1_Outline"] = false,
        ["NumberFont_Shadow_Med"] = {
            "ConsoleFontNormal",
            "ChatFontNormal",
        },
        ["SystemFont_Shadow_Large2"] = {
            "GameFontHighlightLarge2",
            "CommentatorFontMedium",
            "GameFontNormalLarge2",
        },
        ["Game72Font"] = {
            "CommentatorVictoryFanfareTeam",
            "GameFont72Normal",
            "GameFont72Highlight",
        },
        ["InvoiceFont_Small"] = {
            "InvoiceTextFontSmall",
        },
        ["SystemFont_Shadow_Large_Outline"] = {
            "GameFontNormalLargeOutline",
        },
        ["Game30Font"] = false,
        ["Game17Font_Shadow"] = false,
        ["Number15Font"] = {
            "Number15FontWhite",
        },
        ["Game42Font"] = false,
        ["QuestFont_30"] = false,
        ["Number13Font"] = {
            "Number13FontGray",
            "Number13FontRed",
            "Number13FontWhite",
            "Number13FontYellow",
        },
        ["Game12Font"] = false,
        ["Game10Font_o1"] = false,
        ["Game13Font_o1"] = false,
        ["Game15Font_o1"] = false,
        ["SystemFont_NamePlateCastBar"] = false,
        ["SystemFont_Shadow_Small2"] = {
            "GameFontNormalSmall2",
        },
        ["InvoiceFont_Med"] = {
            "InvoiceTextFontNormal",
        },
        ["FriendsFont_Small"] = false,
        ["QuestFont_Huge"] = {
            "QuestFontHighlightHuge",
            "QuestFontNormalHuge",
            "QuestFont_Shadow_Huge",
            "QuestTitleFontBlackShadow",
            "QuestTitleFont",
        },
        ["SystemFont_Huge4"] = false,
        ["Game36Font_Shadow2"] = false,
        ["Fancy14Font"] = false,
        ["NumberFont_Shadow_Tiny"] = false,
        ["Game69Font_Shadow2"] = false,
        ["SystemFont_Shadow_Small"] = {
            "GameFontDisableSmallLeft",
            "GameFontHighlightSmallOutline",
            "GameFontHighlightSmallLeftTop",
            "GameFontHighlightSmallLeft",
            "GameFontHighlightExtraSmallLeft",
            "OptionsFontSmall",
            "GameFontNormalGraySmall",
            "GameFontHighlightExtraSmallLeftTop",
            "GameFontHighlightSmall",
            "GameFontNormalSmallLeft",
            "GameFontDarkGraySmall",
            "GameFontRedSmall",
            "GameFontNormalSmallBattleNetBlueLeft",
            "GameFontHighlightSmallRight",
            "GameFontHighlightExtraSmall",
            "GameFontDisableSmall",
            "OptionsFontHighlightSmall",
            "OptionsFontSmallLeft",
            "GameFontGreenSmall",
            "GameFontNormalSmall",
        },
        ["SystemFont_Outline_Small"] = {
            "TextStatusBarText",
        },
        ["SpellFont_Small"] = {
            "NewSubSpellFont",
            "SubSpellFont",
        },
        ["ChatBubbleFont"] = false,
        ["DestinyFontLarge"] = false,
        ["Game40Font_Shadow2"] = false,
        ["SystemFont_LargeNamePlate"] = false,
        ["NumberFont_Outline_Huge"] = {
            "NumberFontNormalHuge",
        },
        ["SystemFont_InverseShadow_Small"] = false,
        ["FriendsFont_Large"] = false,
        ["QuestFont_Outline_Huge"] = false,
        ["QuestFont_Super_Huge"] = {
            "QuestFont_Shadow_Super_Huge",
        },
        ["DestinyFontMed"] = false,
        ["SystemFont_Shadow_Med2"] = {
            "GameFontNormalMed2",
            "FocusFontSmall",
            "GameFontDisableMed2",
            "GameFontHighlightMed2",
        },
        ["Game24Font"] = false,
        ["NumberFont_Shadow_Small"] = {
            "ConsoleFontSmall",
            "ChatFontSmall",
        },
        ["SystemFont_Outline_WTF2"] = {
            "MissionCombatTextFontOutline",
            "GameFontNormalWTF2Outline",
        },
        ["MailFont_Large"] = {
            "MailTextFontNormal",
        },
        ["Number12Font"] = false,
        ["SystemFont_WTF2"] = {
            "GameFontNormalWTF2",
        },
        ["SystemFont_Shadow_Outline_Huge3"] = {
            "GameFontNormalHuge3Outline",
        },
        ["Game72Font_Shadow"] = {
            "GameFont72NormalShadow",
            "GameFont72HighlightShadow",
        },
        ["FriendsFont_11"] = false,
        ["Game32Font_Shadow2"] = false,
        ["QuestFont_Super_Huge_Outline"] = false,
        ["SystemFont_Shadow_Med1_Outline"] = {
            "GameFontNormalOutline",
            "GameFontHighlightOutline",
        },
        ["GameFont_Gigantic"] = false,
        ["QuestFont_Enormous"] = {
            "QuestFont_Shadow_Enormous",
        },
        ["Game58Font_Shadow2"] = false,
        ["SplashHeaderFont"] = false,
        ["SystemFont22_Outline"] = {
            "GameFontDisableOutline22",
            "GameFontHighlightOutline22",
            "GameFontNormalOutline22",
        },
        ["SystemFont_Shadow_Huge3"] = {
            "BossEmoteNormalHuge",
            "GameFontNormalHuge3",
        },
        ["NumberFont_GameNormal"] = {
            "GameNormalNumberFont",
            "WhiteNormalNumberFont",
        },
        ["ScrollingMessageFrame"] = false,
        ["CoreAbilityFont"] = false,
        ["SystemFont_OutlineThick_Huge2"] = {
            "PVPInfoTextFont",
        },
        ["SystemFont_Med2"] = {
            "GameFontNormalMed1",
            "QuestFont",
            "QuestFontLeft",
        },
        ["System15Font"] = false,
        ["Game46Font"] = false,
        ["SystemFont_Shadow_Huge2_Outline"] = false,
        ["Number11Font"] = {
            "Number11FontWhite",
        },
        ["Game18Font"] = false,
        ["SystemFont_Small"] = {
            "AchievementDescriptionFont",
            "GameFontBlackSmall",
            "GameFontWhiteSmall",
            "QuestMapRewardsFont",
            "AchievementCriteriaFont",
        },
        ["PriceFont"] = {
            "PriceFontYellow",
            "PriceFontGray",
            "PriceFontWhite",
            "PriceFontGreen",
            "PriceFontRed",
        },
        ["SystemFont_Large"] = {
            "DialogButtonNormalText",
            "CommentatorTeamNameFont",
            "DialogButtonHighlightText",
        },
        ["Game32Font"] = false,
        ["DestinyFontHuge"] = false,
        ["Game46Font_Shadow2"] = false,
        ["SystemFont_Huge2"] = {
            "GameFontHighlightHuge2",
            "GameFontNormalHuge2",
        },
        ["Fancy16Font"] = false,
        ["Game13FontShadow"] = false,
        ["QuestFont_Large"] = {
            "QuestFontNormalLarge",
            "ItemTextFontNormal",
        },
        ["Game36Font"] = false,
        ["Fancy18Font"] = false,
    }

    db.child = {
        ["GameFontNormalSmall2"] = {
            "SystemFont_Shadow_Small2",
        },
        ["PriceFontYellow"] = {
            "PriceFont",
        },
        ["GameFontHighlightSmallOutline"] = {
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["QuestFont_Shadow_Enormous"] = {
            "QuestFont_Enormous",
        },
        ["MissionCombatTextFontOutline"] = {
            "SystemFont_Outline_WTF2",
        },
        ["InvoiceTextFontNormal"] = {
            "InvoiceFont_Med",
        },
        ["PriceFontGray"] = {
            "PriceFont",
        },
        ["GameFontHighlightSmallLeftTop"] = {
            "GameFontHighlightSmallLeft",
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontGreen"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["Number13FontGray"] = {
            "Number13Font",
        },
        ["NumberFontNormalRightRed"] = {
            "NumberFontNormalRight",
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["GameFontHighlightSmallLeft"] = {
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontNormalHuge"] = {
            "SystemFont_Shadow_Huge1",
        },
        ["GameFontNormalMed2Outline"] = {
            "SystemFont_Shadow_Med2_Outline",
        },
        ["TextStatusBarTextLarge"] = {
            "SystemFont_Outline",
        },
        ["GameFontHighlightShadowOutline22"] = {
            "SystemFont22_Shadow_Outline",
        },
        ["GameFontHighlightLarge"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["Number13FontRed"] = {
            "Number13Font",
        },
        ["GameTooltipText"] = {
            "Tooltip_Med",
        },
        ["GameFontHighlightShadowHuge2"] = {
            "SystemFont_Shadow_Huge2",
        },
        ["GameFontDisableHuge"] = {
            "GameFontNormalHuge",
            "SystemFont_Shadow_Huge1",
        },
        ["QuestDifficulty_Trivial"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["QuestDifficulty_Impossible"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameTooltipTextSmall"] = {
            "Tooltip_Small",
        },
        ["WorldMapTextFont"] = {
            "SystemFont_OutlineThick_WTF",
        },
        ["NumberFontNormalLargeRight"] = {
            "NumberFontNormalLarge",
            "NumberFont_Outline_Large",
        },
        ["GameFontNormalHuge4"] = {
            "SystemFont_Shadow_Huge4",
        },
        ["GameFontHighlightSmall2"] = {
            "SystemFont_Small2",
        },
        ["AchievementDescriptionFont"] = {
            "SystemFont_Small",
        },
        ["GameFontHighlightMedium"] = {
            "SystemFont_Shadow_Med3",
        },
        ["ZoneTextFont"] = {
            "SystemFont_OutlineThick_WTF",
        },
        ["GameFontHighlightRight"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["ChatFontSmall"] = {
            "NumberFont_Shadow_Small",
        },
        ["GameFontNormalGraySmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontNormalLargeLeftTop"] = {
            "GameFontNormalLargeLeft",
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["GameFontNormalHugeBlack"] = {
            "SystemFont_Huge1",
        },
        ["GameFontDisable"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["CommentatorVictoryFanfareTeam"] = {
            "Game72Font",
        },
        ["GameFontRedLarge"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["IMEHighlight"] = {
            "System_IME",
        },
        ["GameFontDisableOutline22"] = {
            "GameFontNormalOutline22",
            "SystemFont22_Outline",
        },
        ["GameFontNormalLeftBottom"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontHighlightSmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["Number15FontWhite"] = {
            "Number15Font",
        },
        ["GameFontBlack"] = {
            "SystemFont_Med1",
        },
        ["QuestFont_Shadow_Super_Huge"] = {
            "QuestFont_Super_Huge",
        },
        ["GameFontDarkGraySmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFont72NormalShadow"] = {
            "Game72Font_Shadow",
        },
        ["GameFontHighlightHuge2"] = {
            "SystemFont_Huge2",
        },
        ["NumberFontNormalHuge"] = {
            "NumberFont_Outline_Huge",
        },
        ["GameFontRedSmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontNormalHugeOutline"] = {
            "SystemFont_Shadow_Huge1",
        },
        ["GameFontNormalLarge2"] = {
            "SystemFont_Shadow_Large2",
        },
        ["GameFontWhiteTiny"] = {
            "SystemFont_Tiny",
        },
        ["IMENormal"] = {
            "System_IME",
        },
        ["WhiteNormalNumberFont"] = {
            "NumberFont_GameNormal",
        },
        ["GameFontWhite"] = {
            "GameFontBlack",
            "SystemFont_Med1",
        },
        ["GameFontDisableSmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["ConsoleFontNormal"] = {
            "NumberFont_Shadow_Med",
        },
        ["GameFontHighlight"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontNormalWTF2Outline"] = {
            "SystemFont_Outline_WTF2",
        },
        ["GameFont72Highlight"] = {
            "GameFont72Normal",
            "Game72Font",
        },
        ["Number14FontRed"] = {
            "NumberFont_Normal_Med",
        },
        ["OptionsFontLeft"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["ChatFontNormal"] = {
            "NumberFont_Shadow_Med",
        },
        ["GameFontNormalHuge3"] = {
            "SystemFont_Shadow_Huge3",
        },
        ["GameFontNormalHuge2"] = {
            "SystemFont_Huge2",
        },
        ["NumberFontNormalLargeYellow"] = {
            "NumberFontNormalLarge",
            "NumberFont_Outline_Large",
        },
        ["GameFontNormalSmall"] = {
            "SystemFont_Shadow_Small",
        },
        ["ConsoleFontSmall"] = {
            "NumberFont_Shadow_Small",
        },
        ["GameFontNormalMed1"] = {
            "SystemFont_Med2",
        },
        ["NumberFontSmallBattleNetBlueLeft"] = {
            "NumberFont_Small",
        },
        ["GameFontDisableSmallLeft"] = {
            "GameFontDisableSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontNormalHuge4Outline"] = {
            "SystemFont_Shadow_Huge4_Outline",
        },
        ["GameFontNormalMed3Outline"] = {
            "SystemFont_Shadow_Med3_Outline",
        },
        ["NumberFontSmallYellowLeft"] = {
            "NumberFont_Small",
        },
        ["GameFontWhiteTiny2"] = {
            "SystemFont_Tiny2",
        },
        ["QuestFontNormalLarge"] = {
            "QuestFont_Large",
        },
        ["GameFontGreenSmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["AchievementDateFont"] = {
            "AchievementFont_Small",
        },
        ["GameFontDisableTiny"] = {
            "SystemFont_Tiny",
        },
        ["PVPInfoTextFont"] = {
            "SystemFont_OutlineThick_Huge2",
        },
        ["OptionsFontSmall"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["CombatTextFontOutline"] = {
            "SystemFont_World_ThickOutline",
        },
        ["GameFontDisableLeft"] = {
            "GameFontDisable",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["ObjectiveFont"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontHighlightLarge2"] = {
            "GameFontNormalLarge2",
            "SystemFont_Shadow_Large2",
        },
        ["GameFontDisableSmall2"] = {
            "SystemFont_Small2",
        },
        ["GameFontNormalTiny"] = {
            "SystemFont_Tiny",
        },
        ["OptionsFontLarge"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["QuestDifficulty_VeryDifficult"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["CommentatorVictoryFanfare"] = {
            "Game120Font",
        },
        ["QuestTitleFont"] = {
            "QuestFont_Shadow_Huge",
            "QuestFont_Huge",
        },
        ["CommentatorFontSmall"] = {
            "SystemFont_Med1",
        },
        ["CombatTextFont"] = {
            "SystemFont_World",
        },
        ["VehicleMenuBarStatusBarText"] = {
            "SystemFont_Shadow_Med1",
        },
        ["CommentatorCCFont"] = {
            "SystemFont_OutlineThick_WTF",
        },
        ["GameFontNormal_NoShadow"] = {
            "SystemFont_Med1",
        },
        ["GameFontBlackMedium"] = {
            "SystemFont_Med3",
        },
        ["CommentatorDampeningFont"] = {
            "CommentatorTeamScoreFont",
            "SystemFont_Shadow_Large",
        },
        ["GameFontHighlightMed2"] = {
            "GameFontNormalMed2",
            "SystemFont_Shadow_Med2",
        },
        ["GameFontNormalSmallBattleNetBlueLeft"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["ArtifactAppearanceSetHighlightFont"] = {
            "Fancy24Font",
        },
        ["ArtifactAppearanceSetNormalFont"] = {
            "Fancy24Font",
        },
        ["FocusFontSmall"] = {
            "SystemFont_Shadow_Med2",
        },
        ["GameFontNormalMed2"] = {
            "SystemFont_Shadow_Med2",
        },
        ["GameFontBlackSmall"] = {
            "SystemFont_Small",
        },
        ["AchievementPointsFontSmall"] = {
            "SystemFont_Shadow_Med1",
        },
        ["QuestFontLeft"] = {
            "QuestFont",
            "SystemFont_Med2",
        },
        ["AchievementPointsFont"] = {
            "SystemFont_Shadow_Large",
        },
        ["DialogButtonHighlightText"] = {
            "DialogButtonNormalText",
            "SystemFont_Large",
        },
        ["MovieSubtitleFont"] = {
            "GameFontNormalShadowOutline22",
            "SystemFont22_Shadow_Outline",
        },
        ["GameFontNormalLeftRed"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["InvoiceTextFontSmall"] = {
            "InvoiceFont_Small",
        },
        ["Number13FontYellow"] = {
            "Number13Font",
        },
        ["GameNormalNumberFont"] = {
            "NumberFont_GameNormal",
        },
        ["GameFontNormal"] = {
            "SystemFont_Shadow_Med1",
        },
        ["TextStatusBarText"] = {
            "SystemFont_Outline_Small",
        },
        ["QuestFontNormalSmall"] = {
            "GameFontBlack",
            "SystemFont_Med1",
        },
        ["GameFontNormalShadowOutline22"] = {
            "SystemFont22_Shadow_Outline",
        },
        ["QuestDifficulty_Difficult"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["NumberFontNormalLargeRightGray"] = {
            "NumberFontNormalLargeRight",
            "NumberFontNormalLarge",
            "NumberFont_Outline_Large",
        },
        ["GameFontNormalLargeOutline"] = {
            "SystemFont_Shadow_Large_Outline",
        },
        ["NumberFontNormalLargeRightYellow"] = {
            "NumberFontNormalLargeRight",
            "NumberFontNormalLarge",
            "NumberFont_Outline_Large",
        },
        ["DialogButtonNormalText"] = {
            "SystemFont_Large",
        },
        ["NewSubSpellFont"] = {
            "SubSpellFont",
            "SpellFont_Small",
        },
        ["SubSpellFont"] = {
            "SpellFont_Small",
        },
        ["MailTextFontNormal"] = {
            "MailFont_Large",
        },
        ["GameFontNormalMed3"] = {
            "SystemFont_Shadow_Med3",
        },
        ["GameFontHighlightExtraSmallLeftTop"] = {
            "GameFontHighlightExtraSmallLeft",
            "GameFontHighlightExtraSmall",
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["QuestDifficulty_Header"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["QuestDifficulty_Standard"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["OptionsFontHighlight"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["ErrorFont"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["QuestFont"] = {
            "SystemFont_Med2",
        },
        ["GameFontNormalOutline"] = {
            "SystemFont_Shadow_Med1_Outline",
        },
        ["CommentatorFontMedium"] = {
            "SystemFont_Shadow_Large2",
        },
        ["NumberFontNormalRight"] = {
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["GameFontGreenLarge"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["CommentatorTeamNameFont"] = {
            "SystemFont_Large",
        },
        ["GameFontDisableLarge"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["GameFontDisableMed2"] = {
            "GameFontNormalMed2",
            "SystemFont_Shadow_Med2",
        },
        ["Number14FontGray"] = {
            "NumberFont_Normal_Med",
        },
        ["Number14FontWhite"] = {
            "NumberFont_Normal_Med",
        },
        ["NumberFontNormal"] = {
            "NumberFont_Outline_Med",
        },
        ["GameFontNormalSmallLeft"] = {
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["PriceFontGreen"] = {
            "PriceFont",
        },
        ["GameFontBlackTiny2"] = {
            "SystemFont_Tiny2",
        },
        ["CombatLogFont"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["Number13FontWhite"] = {
            "Number13Font",
        },
        ["Number11FontWhite"] = {
            "Number11Font",
        },
        ["CommentatorTeamScoreFont"] = {
            "SystemFont_Shadow_Large",
        },
        ["NumberFontSmallWhiteLeft"] = {
            "NumberFont_Small",
        },
        ["SubZoneTextFont"] = {
            "SystemFont_OutlineThick_Huge4",
        },
        ["NumberFontNormalLargeRightRed"] = {
            "NumberFontNormalLargeRight",
            "NumberFontNormalLarge",
            "NumberFont_Outline_Large",
        },
        ["NumberFontNormalLarge"] = {
            "NumberFont_Outline_Large",
        },
        ["NumberFontNormalGray"] = {
            "NumberFont_Outline_Med",
        },
        ["NumberFontNormalSmallGray"] = {
            "NumberFontNormalSmall",
            "NumberFont_OutlineThick_Mono_Small",
        },
        ["NumberFontNormalSmall"] = {
            "NumberFont_OutlineThick_Mono_Small",
        },
        ["NumberFontNormalYellow"] = {
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["NumberFontNormalRightGray"] = {
            "NumberFontNormalRight",
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["NumberFontNormalRightYellow"] = {
            "NumberFontNormalRight",
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["QuestFontHighlightHuge"] = {
            "QuestFontNormalHuge",
            "QuestFont_Huge",
        },
        ["BossEmoteNormalHuge"] = {
            "SystemFont_Shadow_Huge3",
        },
        ["Number18FontWhite"] = {
            "Number18Font",
        },
        ["GameFontNormalLeftLightGreen"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontNormalLeft"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontNormalLargeLeft"] = {
            "GameFontNormalLarge",
            "SystemFont_Shadow_Large",
        },
        ["GameFontBlackTiny"] = {
            "SystemFont_Tiny",
        },
        ["GameFontNormalShadowHuge2"] = {
            "SystemFont_Shadow_Huge2",
        },
        ["NumberFontNormalRightGreen"] = {
            "NumberFontNormalRight",
            "NumberFontNormal",
            "NumberFont_Outline_Med",
        },
        ["GameFontDisableTiny2"] = {
            "SystemFont_Tiny2",
        },
        ["PriceFontWhite"] = {
            "PriceFont",
        },
        ["GameFontHighlightExtraSmallLeft"] = {
            "GameFontHighlightExtraSmall",
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontHighlightExtraSmall"] = {
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontHighlightSmallRight"] = {
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontWhiteSmall"] = {
            "GameFontBlackSmall",
            "SystemFont_Small",
        },
        ["GameFontNormalRight"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontNormalLarge"] = {
            "SystemFont_Shadow_Large",
        },
        ["GameFontNormalOutline22"] = {
            "SystemFont22_Outline",
        },
        ["GameFontNormalLeftGrey"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["QuestMapRewardsFont"] = {
            "GameFontBlackSmall",
            "SystemFont_Small",
        },
        ["GameFontNormalLeftGreen"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontDisableMed3"] = {
            "SystemFont_Shadow_Med3",
        },
        ["GameFontHighlightLeft"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["OptionsFontHighlightSmall"] = {
            "GameFontHighlightSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["AchievementCriteriaFont"] = {
            "AchievementDescriptionFont",
            "SystemFont_Small",
        },
        ["GameFontHighlightHuge"] = {
            "GameFontNormalHuge",
            "SystemFont_Shadow_Huge1",
        },
        ["GameFont72HighlightShadow"] = {
            "GameFont72NormalShadow",
            "Game72Font_Shadow",
        },
        ["GameFontNormalLeftYellow"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontHighlightOutline22"] = {
            "GameFontNormalOutline22",
            "SystemFont22_Outline",
        },
        ["GameTooltipHeaderText"] = {
            "GameTooltipHeader",
        },
        ["GameFont72Normal"] = {
            "Game72Font",
        },
        ["GameFontNormalWTF2"] = {
            "SystemFont_WTF2",
        },
        
        ["GameFontNormalCenter"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontNormalHuge3Outline"] = {
            "SystemFont_Shadow_Outline_Huge3",
        },
        ["GameFontHighlightOutline"] = {
            "GameFontNormalOutline",
            "SystemFont_Shadow_Med1_Outline",
        },
        ["GameFontNormalLeftOrange"] = {
            "GameFontNormalLeft",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["OptionsFontSmallLeft"] = {
            "OptionsFontSmall",
            "GameFontNormalSmall",
            "SystemFont_Shadow_Small",
        },
        ["GameFontBlackSmall2"] = {
            "SystemFont_Small2",
        },
        ["ItemTextFontNormal"] = {
            "QuestFont_Large",
        },
        ["GameFontNormalTiny2"] = {
            "SystemFont_Tiny2",
        },
        ["Number14FontGreen"] = {
            "NumberFont_Normal_Med",
        },
        ["PriceFontRed"] = {
            "PriceFont",
        },
        ["QuestFont_Shadow_Huge"] = {
            "QuestFont_Huge",
        },
        ["QuestFontNormalHuge"] = {
            "QuestFont_Huge",
        },
        ["QuestTitleFontBlackShadow"] = {
            "QuestFont_Shadow_Huge",
            "QuestFont_Huge",
        },
        ["GameFontRed"] = {
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
        ["GameFontHighlightCenter"] = {
            "GameFontHighlight",
            "GameFontNormal",
            "SystemFont_Shadow_Med1",
        },
    }

    db.preserve = {
        ["NumberFontNormalSmallGray"] = true,
    }

    db.fonts = {
        "AchievementCriteriaFont",
        "AchievementDateFont",
        "AchievementDescriptionFont",
        "AchievementFont_Small",
        "AchievementPointsFont",
        "AchievementPointsFontSmall",
        "ArtifactAppearanceSetHighlightFont",
        "ArtifactAppearanceSetNormalFont",
        "BossEmoteNormalHuge",
        "ChatBubbleFont",
        "ChatFontNormal",
        "ChatFontSmall",
        "CombatLogFont",
        "CombatTextFont",
        "CombatTextFontOutline",
        "CommentatorCCFont",
        "CommentatorDampeningFont",
        "CommentatorFontMedium",
        "CommentatorFontSmall",
        "CommentatorTeamNameFont",
        "CommentatorTeamScoreFont",
        "CommentatorVictoryFanfare",
        "CommentatorVictoryFanfareTeam",
        "ConsoleFontNormal",
        "ConsoleFontSmall",
        "CoreAbilityFont",
        "DestinyFontHuge",
        "DestinyFontLarge",
        "DestinyFontMed",
        "DialogButtonHighlightText",
        "DialogButtonNormalText",
        "ErrorFont",
        "Fancy12Font",
        "Fancy14Font",
        "Fancy16Font",
        "Fancy18Font",
        "Fancy20Font",
        "Fancy22Font",
        "Fancy24Font",
        "Fancy27Font",
        "Fancy30Font",
        "Fancy32Font",
        "Fancy48Font",
        "FocusFontSmall",
        "FriendsFont_11",
        "FriendsFont_Large",
        "FriendsFont_Normal",
        "FriendsFont_Small",
        "FriendsFont_UserText",
        "Game10Font_o1",
        "Game11Font",
        "Game11Font_Shadow",
        "Game11Font_o1",
        "Game120Font",
        "Game12Font",
        "Game12Font_o1",
        "Game13Font",
        "Game13FontShadow",
        "Game13Font_o1",
        "Game15Font",
        "Game15Font_o1",
        "Game16Font",
        "Game17Font_Shadow",
        "Game18Font",
        "Game20Font",
        "Game24Font",
        "Game27Font",
        "Game30Font",
        "Game32Font",
        "Game32Font_Shadow2",
        "Game36Font",
        "Game36Font_Shadow2",
        "Game40Font",
        "Game40Font_Shadow2",
        "Game42Font",
        "Game46Font",
        "Game46Font_Shadow2",
        "Game48Font",
        "Game48FontShadow",
        "Game52Font_Shadow2",
        "Game58Font_Shadow2",
        "Game60Font",
        "Game69Font_Shadow2",
        "Game72Font",
        "Game72Font_Shadow",
        "GameFont72Highlight",
        "GameFont72HighlightShadow",
        "GameFont72Normal",
        "GameFont72NormalShadow",
        "GameFontBlack",
        "GameFontBlackMedium",
        "GameFontBlackSmall",
        "GameFontBlackSmall2",
        "GameFontBlackTiny",
        "GameFontBlackTiny2",
        "GameFontDarkGraySmall",
        "GameFontDisable",
        "GameFontDisableHuge",
        "GameFontDisableLarge",
        "GameFontDisableLeft",
        "GameFontDisableMed2",
        "GameFontDisableMed3",
        "GameFontDisableOutline22",
        "GameFontDisableSmall",
        "GameFontDisableSmall2",
        "GameFontDisableSmallLeft",
        "GameFontDisableTiny",
        "GameFontDisableTiny2",
        "GameFontGreen",
        "GameFontGreenLarge",
        "GameFontGreenSmall",
        "GameFontHighlight",
        "GameFontHighlightCenter",
        "GameFontHighlightExtraSmall",
        "GameFontHighlightExtraSmallLeft",
        "GameFontHighlightExtraSmallLeftTop",
        "GameFontHighlightHuge",
        "GameFontHighlightHuge2",
        "GameFontHighlightLarge",
        "GameFontHighlightLarge2",
        "GameFontHighlightLeft",
        "GameFontHighlightMed2",
        "GameFontHighlightMedium",
        "GameFontHighlightOutline",
        "GameFontHighlightOutline22",
        "GameFontHighlightRight",
        "GameFontHighlightShadowHuge2",
        "GameFontHighlightShadowOutline22",
        "GameFontHighlightSmall",
        "GameFontHighlightSmall2",
        "GameFontHighlightSmallLeft",
        "GameFontHighlightSmallLeftTop",
        "GameFontHighlightSmallOutline",
        "GameFontHighlightSmallRight",
        "GameFontNormal",
        "GameFontNormalCenter",
        "GameFontNormalGraySmall",
        "GameFontNormalHuge",
        "GameFontNormalHuge2",
        "GameFontNormalHuge3",
        "GameFontNormalHuge3Outline",
        "GameFontNormalHuge4",
        "GameFontNormalHuge4Outline",
        "GameFontNormalHugeBlack",
        "GameFontNormalHugeOutline",
        "GameFontNormalLarge",
        "GameFontNormalLarge2",
        "GameFontNormalLargeLeft",
        "GameFontNormalLargeLeftTop",
        "GameFontNormalLargeOutline",
        "GameFontNormalLeft",
        "GameFontNormalLeftBottom",
        "GameFontNormalLeftGreen",
        "GameFontNormalLeftGrey",
        "GameFontNormalLeftLightGreen",
        "GameFontNormalLeftOrange",
        "GameFontNormalLeftRed",
        "GameFontNormalLeftYellow",
        "GameFontNormalMed1",
        "GameFontNormalMed2",
        "GameFontNormalMed2Outline",
        "GameFontNormalMed3",
        "GameFontNormalMed3Outline",
        "GameFontNormalOutline",
        "GameFontNormalOutline22",
        "GameFontNormalRight",
        "GameFontNormalShadowHuge2",
        "GameFontNormalShadowOutline22",
        "GameFontNormalSmall",
        "GameFontNormalSmall2",
        "GameFontNormalSmallBattleNetBlueLeft",
        "GameFontNormalSmallLeft",
        "GameFontNormalTiny",
        "GameFontNormalTiny2",
        "GameFontNormalWTF2",
        "GameFontNormalWTF2Outline",
        "GameFontNormal_NoShadow",
        "GameFontRed",
        "GameFontRedLarge",
        "GameFontRedSmall",
        "GameFontWhite",
        "GameFontWhiteSmall",
        "GameFontWhiteTiny",
        "GameFontWhiteTiny2",
        "GameFont_Gigantic",
        "GameNormalNumberFont",
        "GameTooltipHeader",
        "GameTooltipHeaderText",
        "GameTooltipText",
        "GameTooltipTextSmall",
        "IMEHighlight",
        "IMENormal",
        "InvoiceFont_Med",
        "InvoiceFont_Small",
        "InvoiceTextFontNormal",
        "InvoiceTextFontSmall",
        "ItemTextFontNormal",
        "MailFont_Large",
        "MailTextFontNormal",
        "MissionCombatTextFontOutline",
        "MovieSubtitleFont",
        "NewSubSpellFont",
        "Number11Font",
        "Number11FontWhite",
        "Number12Font",
        "Number12Font_o1",
        "Number13Font",
        "Number13FontGray",
        "Number13FontRed",
        "Number13FontWhite",
        "Number13FontYellow",
        "Number14FontGray",
        "Number14FontGreen",
        "Number14FontRed",
        "Number14FontWhite",
        "Number15Font",
        "Number15FontWhite",
        "Number16Font",
        "Number18Font",
        "Number18FontWhite",
        "NumberFontNormal",
        "NumberFontNormalGray",
        "NumberFontNormalHuge",
        "NumberFontNormalLarge",
        "NumberFontNormalLargeRight",
        "NumberFontNormalLargeRightGray",
        "NumberFontNormalLargeRightRed",
        "NumberFontNormalLargeRightYellow",
        "NumberFontNormalLargeYellow",
        "NumberFontNormalRight",
        "NumberFontNormalRightGray",
        "NumberFontNormalRightGreen",
        "NumberFontNormalRightRed",
        "NumberFontNormalRightYellow",
        "NumberFontNormalSmall",
        "NumberFontNormalSmallGray",
        "NumberFontNormalYellow",
        "NumberFontSmallBattleNetBlueLeft",
        "NumberFontSmallWhiteLeft",
        "NumberFontSmallYellowLeft",
        "NumberFont_GameNormal",
        "NumberFont_Normal_Med",
        "NumberFont_OutlineThick_Mono_Small",
        "NumberFont_Outline_Huge",
        "NumberFont_Outline_Large",
        "NumberFont_Outline_Med",
        "NumberFont_Shadow_Large",
        "NumberFont_Shadow_Med",
        "NumberFont_Shadow_Small",
        "NumberFont_Shadow_Tiny",
        "NumberFont_Small",
        "ObjectiveFont",
        "OptionsFontHighlight",
        "OptionsFontHighlightSmall",
        "OptionsFontLarge",
        "OptionsFontLeft",
        "OptionsFontSmall",
        "OptionsFontSmallLeft",
        "PVPInfoTextFont",
        "PriceFont",
        "PriceFontGray",
        "PriceFontGreen",
        "PriceFontRed",
        "PriceFontWhite",
        "PriceFontYellow",
        "QuestDifficulty_Difficult",
        "QuestDifficulty_Header",
        "QuestDifficulty_Impossible",
        "QuestDifficulty_Standard",
        "QuestDifficulty_Trivial",
        "QuestDifficulty_VeryDifficult",
        "QuestFont",
        "QuestFontHighlightHuge",
        "QuestFontLeft",
        "QuestFontNormalHuge",
        "QuestFontNormalLarge",
        "QuestFontNormalSmall",
        "QuestFont_30",
        "QuestFont_39",
        "QuestFont_Enormous",
        "QuestFont_Huge",
        "QuestFont_Large",
        "QuestFont_Outline_Huge",
        "QuestFont_Shadow_Enormous",
        "QuestFont_Shadow_Huge",
        "QuestFont_Shadow_Small",
        "QuestFont_Shadow_Super_Huge",
        "QuestFont_Super_Huge",
        "QuestFont_Super_Huge_Outline",
        "QuestMapRewardsFont",
        "QuestTitleFont",
        "QuestTitleFontBlackShadow",
        "ReputationDetailFont",
        -- "ScrollingMessageFrame",
        "SpellFont_Small",
        "SplashHeaderFont",
        "SubSpellFont",
        "SubZoneTextFont",
        "System15Font",
        "SystemFont22_Outline",
        "SystemFont22_Shadow_Outline",
        "SystemFont_Huge1",
        "SystemFont_Huge1_Outline",
        "SystemFont_Huge2",
        "SystemFont_Huge4",
        "SystemFont_InverseShadow_Small",
        "SystemFont_Large",
        "SystemFont_LargeNamePlate",
        "SystemFont_LargeNamePlateFixed",
        "SystemFont_Med1",
        "SystemFont_Med2",
        "SystemFont_Med3",
        "SystemFont_NamePlate",
        "SystemFont_NamePlateCastBar",
        "SystemFont_NamePlateFixed",
        "SystemFont_Outline",
        "SystemFont_OutlineThick_Huge2",
        "SystemFont_OutlineThick_Huge4",
        "SystemFont_OutlineThick_WTF",
        "SystemFont_Outline_Small",
        "SystemFont_Outline_WTF2",
        "SystemFont_Shadow_Huge1",
        "SystemFont_Shadow_Huge2",
        "SystemFont_Shadow_Huge2_Outline",
        "SystemFont_Shadow_Huge3",
        "SystemFont_Shadow_Huge4",
        "SystemFont_Shadow_Huge4_Outline",
        "SystemFont_Shadow_Large",
        "SystemFont_Shadow_Large2",
        "SystemFont_Shadow_Large_Outline",
        "SystemFont_Shadow_Med1",
        "SystemFont_Shadow_Med1_Outline",
        "SystemFont_Shadow_Med2",
        "SystemFont_Shadow_Med2_Outline",
        "SystemFont_Shadow_Med3",
        "SystemFont_Shadow_Med3_Outline",
        "SystemFont_Shadow_Outline_Huge3",
        "SystemFont_Shadow_Small",
        "SystemFont_Shadow_Small2",
        "SystemFont_Small",
        "SystemFont_Small2",
        "SystemFont_Tiny",
        "SystemFont_Tiny2",
        "SystemFont_WTF2",
        "SystemFont_World",
        "SystemFont_World_ThickOutline",
        "System_IME",
        "TextStatusBarText",
        "TextStatusBarTextLarge",
        "Tooltip_Med",
        "Tooltip_Small",
        "VehicleMenuBarStatusBarText",
        "WhiteNormalNumberFont",
        "WorldMapTextFont",
        "ZoneTextFont",
    }

    db.families = { "fancy", "game", "number", "quest", "system", "misc" }
    db.traits = { "outline", "thickoutline", "monochrome", "shadow" }
    db.heights = { "tiny", "small", "medium", "large", "huge" }
    db.heightNums = {
    	["tiny"] = {0, 8},
    	["small"] = {9, 12},
    	["medium"] = {13, 16},
    	["large"] = {17, 20},
    	["huge"] = {21, 9999999}
    }

    db.filters = { db.families, db.traits, db.heights }
----------------------------------

HyperDB = {}
HyperDB.paths = db.paths
HyperDB.data = db.data
HyperDB.parent = db.parent
HyperDB.child = db.child
HyperDB.preserve = db.preserve
HyperDB.fonts = db.fonts