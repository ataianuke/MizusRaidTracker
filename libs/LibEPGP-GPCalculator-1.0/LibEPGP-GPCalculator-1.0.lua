-- ****************************************************
--              LibEPGP-GPCalculator-1.0
-- ****************************************************
-- A library for calculating GP values of items.
-- 
-- This library is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010-2011)
--
-- Licensed under the MIT-License (see LICENSE.txt)
--

assert(LibStub, "LibEPGP_GPCalculator-1.0 requires LibStub")
assert(LibStub:GetLibrary("LibBabble-Inventory-3.0", true), "LibEPGP-GPCalculator-1.0 requires LibBabble-Inventory-3.0")

local libGP = LibStub:NewLibrary("LibEPGP-GPCalculator-1.0", 1)

if not libGP then 
    return -- No upgrade needed
end

do
    -- set up a copy of LBI for handling the different item types
    local LBI = LibStub("LibBabble-Inventory-3.0")
    local LBIR = LBI:GetReverseLookupTable()
    
    local _, _, _, uiVersion = GetBuildInfo()
    local epgpCoefficient = 0

    -- The coefficient seems to have changed in Cataclysm to 0.06974 - this isn't in the official web documentation but in the EPGP-Addon-Code
    if (uiVersion < 40000) then
        epgpCoefficient = 0.483
    else
        epgpCoefficient = 0.06974
    end

    -- List of various ItemIDs of token and their corresponding item level:
    -- List of tokens, which can be traded for a helm
    local TOKEN_HEAD = {
        [29759] = 120,              -- T4-Head Hunter/Mage/Warlock
        [29760] = 120,              -- T4-Head Paladin/Rouge/Shaman
        [29761] = 120,              -- T4-Head Druid/Priest/Warrior
        [30242] = 133,              -- T5-Head Paladin/Rouge/Shaman
        [30243] = 133,              -- T5-Head Druid/Priest/Warrior
        [30244] = 133,              -- T5-Head Hunter/Mage/Warlock
        [31095] = 146,              -- T6-Head Hunter/Shaman/Warrior
        [31096] = 146,              -- T6-Head Druid/Mage/Rouge
        [31097] = 146,              -- T6-Head Paladin/Priest/Warlock
        [40616] = 200,              -- T7/10-Head Paladin/Priest/Warlock
        [40617] = 200,              -- T7/10-Head Hunter/Shaman/Warrior
        [40618] = 200,              -- T7/10-Head Death Knight/Druid/Mage/Rouge
        [40631] = 213,              -- T7/25-Head Paladin/Priest/Warlock
        [40632] = 213,              -- T7/25-Head Hunter/Shaman/Warrior
        [40633] = 213,              -- T7/25-Head Death Knight/Druid/Mage/Rouge
        [45638] = 226,              -- T8/25-Head Paladin/Priest/Warlock
        [45639] = 226,              -- T8/25-Head Hunter/Shaman/Warrior
        [45640] = 226,              -- T8/25-Head Death Knight/Druid/Mage/Rouge
        [45647] = 219,              -- T8/10-Head Paladin/Priest/Warlock
        [45648] = 219,              -- T8/10-Head Hunter/Shaman/Warrior
        [45649] = 219,              -- T8/10-Head Death Knight/Druid/Mage/Rouge
        [63683] = 359,              -- T11-Head Paladin/Priest/Warlock
        [63684] = 359,              -- T11-Head Hunter/Shaman/Warrior
        [63682] = 359,              -- T11-Head Death Knight/Druid/Mage/Rouge
        [65000] = 372,              -- T11-Heroic-Head Hunter/Shaman/Warrior
        [65001] = 372,              -- T11-Heroic-Head Paladin/Priest/Warlock
        [65002] = 372,              -- T11-Heroic-Head Death Knight/Druid/Mage/Rouge
    }

    -- List of tokens, which can be traded for a set of shoulder pads
    local TOKEN_SHOULDERS = {
        [29762] = 120,              -- T4-Shoulder pads Hunter/Mage/Warlock
        [29763] = 120,              -- T4-Shoulder pads Paladin/Rouge/Shaman
        [29764] = 120,              -- T4-Shoulder pads Druid/Priest/Warrior
        [30248] = 133,              -- T5-Shoulder pads Paladin/Rouge/Shaman
        [30249] = 133,              -- T5-Shoulder pads Druid/Priest/Warrior
        [30250] = 133,              -- T5-Shoulder pads Hunter/Mage/Warlock
        [31101] = 146,              -- T6-Shoulder pads Paladin/Priest/Warlock
        [31102] = 146,              -- T6-Shoulder pads Druid/Mage/Rouge
        [31103] = 146,              -- T6-Shoulder pads Hunter/Shaman/Warrior
        [40622] = 200,              -- T7/10-Shoulder pads Paladin/Priest/Warlock
        [40623] = 200,              -- T7/10-Shoulder pads Hunter/Shaman/Warrior
        [40624] = 200,              -- T7/10-Shoulder pads Death Knight/Druid/Mage/Rouge
        [40637] = 213,              -- T7/25-Shoulder pads Paladin/Priest/Warlock
        [40638] = 213,              -- T7/25-Shoulder pads Hunter/Shaman/Warrior
        [40639] = 213,              -- T7/25-Shoulder pads Death Knight/Druid/Mage/Rouge
        [45656] = 226,              -- T8/25-Shoulder pads Paladin/Priest/Warlock
        [45657] = 226,              -- T8/25-Shoulder pads Hunter/Shaman/Warrior
        [45658] = 226,              -- T8/25-Shoulder pads Death Knight/Druid/Mage/Rouge
        [45659] = 219,              -- T8/10-Shoulder pads Paladin/Priest/Warlock
        [45660] = 219,              -- T8/10-Shoulder pads Hunter/Shaman/Warrior
        [45661] = 219,              -- T8/10-Shoulder pads Death Knight/Druid/Mage/Rouge
        [64314] = 359,              -- T11-Shoulder pads Death Knight/Druid/Mage/Rouge
        [64315] = 359,              -- T11-Shoulder pads Paladin/Priest/Warlock
        [64316] = 359,              -- T11-Shoulder pads Hunter/Shaman/Warrior
        [65087] = 372,              -- T11-Heroic-Shoulder pads Hunter/Shaman/Warrior
        [65088] = 372,              -- T11-Heroic-Shoulder pads Paladin/Priest/Warlock
        [65089] = 372,              -- T11-Heroic-Shoulder pads Death Knight/Druid/Mage/Rouge
    }

    -- List of tokens, which can be traded for a chest piece
    local TOKEN_CHEST = {
        [29753] = 120,              -- T4-Chest Druid/Priest/Warrior
        [29754] = 120,              -- T4-Chest Paladin/Rouge/Shaman
        [29755] = 120,              -- T4-Chest Hunter/Mage/Warlock
        [30236] = 133,              -- T5-Chest Paladin/Rouge/Shaman
        [30237] = 133,              -- T5-Chest Druid/Priest/Warrior
        [30238] = 133,              -- T5-Chest Hunter/Mage/Warlock
        [31089] = 146,              -- T6-Chest Paladin/Priest/Warlock
        [31090] = 146,              -- T6-Chest Druid/Mage/Rouge
        [31091] = 146,              -- T6-Chest Hunter/Shaman/Warrior
        [40610] = 200,              -- T7/10-Chest Paladin/Priest/Warlock
        [40611] = 200,              -- T7/10-Chest Hunter/Shaman/Warrior
        [40612] = 200,              -- T7/10-Chest Death Knight/Druid/Mage/Rouge
        [40625] = 213,              -- T7/25-Chest Paladin/Priest/Warlock
        [40626] = 213,              -- T7/25-Chest Hunter/Shaman/Warrior
        [40627] = 213,              -- T7/25-Chest Death Knight/Druid/Mage/Rouge
        [45632] = 226,              -- T8/25-Chest Paladin/Priest/Warlock
        [45633] = 226,              -- T8/25-Chest Hunter/Shaman/Warrior
        [45634] = 226,              -- T8/25-Chest Death Knight/Druid/Mage/Rouge
        [45635] = 219,              -- T8/10-Chest Paladin/Priest/Warlock
        [45636] = 219,              -- T8/10-Chest Hunter/Shaman/Warrior
        [45637] = 219,              -- T8/10-Chest Death Knight/Druid/Mage/Rouge
        [67423] = 372,              -- T11-Heroic-Chest Paladin/Priest/Warlock
        [67424] = 372,              -- T11-Heroic-Chest Hunter/Shaman/Warrior
        [67425] = 372,              -- T11-Heroic-Chest Death Knight/Druid/Mage/Rouge
    }

    -- List of tokens, which can be traded for a set of bracers
    local TOKEN_WRISTS = {
        [34848] = 154,              -- T6-Bracers Paladin/Priest/Warlock
        [34851] = 154,              -- T6-Bracers Hunter/Shaman/Warrior
        [34852] = 154,              -- T6-Bracers Rouge/Mage/Druid
    }

    -- List of tokens, which can be traded for a set of gloves
    local TOKEN_HANDS = {
        [29756] = 120,              -- T4-Gloves Hunter/Mage/Warlock
        [29757] = 120,              -- T4-Gloves Druid/Priest/Warrior
        [29758] = 120,              -- T4-Gloves Paladin/Rouge/Shaman
        [30239] = 133,              -- T5-Gloves Paladin/Rouge/Shaman
        [30240] = 133,              -- T5-Gloves Druid/Priest/Warrior
        [30241] = 133,              -- T5-Gloves Hunter/Mage/Warlock
        [31092] = 146,              -- T6-Gloves Paladin/Priest/Warlock
        [31093] = 146,              -- T6-Gloves Druid/Mage/Rouge
        [31094] = 146,              -- T6-Gloves Hunter/Shaman/Warrior
        [40613] = 200,              -- T7/10-Gloves Paladin/Priest/Warlock
        [40614] = 200,              -- T7/10-Gloves Hunter/Shaman/Warrior
        [40615] = 200,              -- T7/10-Gloves Death Knight/Druid/Mage/Rouge
        [40628] = 213,              -- T7/25-Gloves Paladin/Priest/Warlock
        [40629] = 213,              -- T7/25-Gloves Hunter/Shaman/Warrior
        [40630] = 213,              -- T7/25-Gloves Death Knight/Druid/Mage/Rouge
        [45641] = 226,              -- T8/25-Gloves Paladin/Priest/Warlock
        [45642] = 226,              -- T8/25-Gloves Hunter/Shaman/Warrior
        [45643] = 226,              -- T8/25-Gloves Death Knight/Druid/Mage/Rouge
        [45644] = 219,              -- T8/10-Gloves Paladin/Priest/Warlock
        [45645] = 219,              -- T8/10-Gloves Hunter/Shaman/Warrior
        [45646] = 219,              -- T8/10-Gloves Death Knight/Druid/Mage/Rouge
        [67429] = 372,              -- T11-Heroic-Gloves Paladin/Priest/Warlock
        [67430] = 372,              -- T11-Heroic-Gloves Hunter/Shaman/Warrior
        [67431] = 372,              -- T11-Heroic-Gloves Death Knight/Druid/Mage/Rouge
    }

    -- List of tokens, which can be traded for a waist piece
    local TOKEN_WAIST = {
        [34853] = 154,              -- T6-Belt Paladin/Priest/Warlock
        [34854] = 154,              -- T6-Belt Hunter/Shaman/Warrior
        [34855] = 154,              -- T6-Belt Rouge/Mage/Druid
    }

    -- List of tokens, which can be traded for a leg piece
    local TOKEN_LEGS = {
        [29765] = 120,              -- T4-Leggings Hunter/Mage/Warlock
        [29766] = 120,              -- T4-Leggings Paladin/Rouge/Shaman
        [29767] = 120,              -- T4-Leggings Druid/Priest/Warrior
        [30245] = 133,              -- T5-Leggings Paladin/Rouge/Shaman
        [30246] = 133,              -- T5-Leggings Druid/Priest/Warrior
        [30247] = 133,              -- T5-Leggings Hunter/Mage/Warlock
        [31098] = 146,              -- T6-Leggings Paladin/Priest/Warlock
        [31099] = 146,              -- T6-Leggings Druid/Mage/Rouge
        [31100] = 146,              -- T6-Leggings Hunter/Shaman/Warrior
        [40619] = 200,              -- T7/10-Leggings Paladin/Priest/Warlock
        [40620] = 200,              -- T7/10-Leggings Hunter/Shaman/Warrior
        [40621] = 200,              -- T7/10-Leggings Death Knight/Druid/Mage/Rouge
        [40634] = 213,              -- T7/25-Leggings Paladin/Priest/Warlock
        [40635] = 213,              -- T7/25-Leggings Hunter/Shaman/Warrior
        [40636] = 213,              -- T7/25-Leggings Death Knight/Druid/Mage/Rouge
        [45653] = 226,              -- T8/25-Leggings Paladin/Priest/Warlock
        [45654] = 226,              -- T8/25-Leggings Hunter/Shaman/Warrior
        [45655] = 226,              -- T8/25-Leggings Death Knight/Druid/Mage/Rouge
        [45647] = 219,              -- T8/10-Leggings Paladin/Priest/Warlock
        [45648] = 219,              -- T8/10-Leggings Hunter/Shaman/Warrior
        [45649] = 219,              -- T8/10-Leggings Death Knight/Druid/Mage/Rouge
        [67426] = 372,              -- T11-Heroic-Leggings Death Knight/Druid/Mage/Rouge
        [67427] = 372,              -- T11-Heroic-Leggings Hunter/Shaman/Warrior
        [67428] = 372,              -- T11-Heroic-Leggings Paladin/Priest/Warlock
    }

    -- List of tokens, which can be traded for a pair of shoes
    local TOKEN_FEET = {
        [34856] = 154,              -- T6-Shoes Paladin/Priest/Warlock
        [34857] = 154,              -- T6-Shoes Hunter/Shaman/Warrior
        [34858] = 154,              -- T6-Shoes Rouge/Mage/Druid
    }

    -- List of tokens, which can be traded for a head, shoulder, chest, hands or legs slot item
    local TOKEN_5PART = {
        [47242] = 245,              -- T9/25-Token universal (Trophy of the Crusade)
        [47557] = 258,              -- T9-Heroic-Token Paladin/Priest/Warlock
        [47558] = 258,              -- T9-Heroic-Token Hunter/Shaman/Warrior
        [47559] = 258,              -- T9-Heroic-Token Death Knight/Druid/Mage/Rouge
        [52025] = 264,              -- T10-Token Death Knight/Druid/Mage/Rouge
        [52026] = 264,              -- T10-Token Hunter/Shaman/Warrior
        [52027] = 264,              -- T10-Token Paladin/Priest/Warlock
        [52028] = 277,              -- T10-Heroic-Token Death Knight/Druid/Mage/Rouge
        [52029] = 277,              -- T10-Heroic-Token Hunter/Shaman/Warrior
        [52030] = 277,              -- T10-Heroic-Token Paladin/Priest/Warlock
        [66998] = 372,              -- T11-Heroic-Token universal (Essence of the Forlorn)
    }


    --- Calculate and return a simple list of possible GP values. If there is more than one possible GP value, the function will also return a
    -- human readable string, for presenting the different values to a user and a special list, to represent which value apply under which conditions.
    -- @param item Either an ItemID or ItemString or ItemLink. Item need to be cached in client.
    -- @param class Optional - Specify the class, which will receive the item. Fully capitalized english class name with no spaces (use second return parameter of WoW-API-Function 'UnitClass')
    -- @param spec Optional - Specify the general specialization, which will receive the item. (Either "TANK", "DD" or "HEALER")
    -- @param slot Optional - Specify the slot, for which this item will be used. For possible values, see itemEquipLoc (http://www.wowpedia.org/ItemEquipLoc)
    -- @usage local GPValues, GPValueText, GPListType, GPList = LibEPGP_GPCalculator:GetItemGP(item, class, spec, slot)
    -- GPValues is a list with possible GP values for the given parameters. If no value could be calculated, it will return { 0 }. The maximum length of the list is 2.
    -- GPValueText is a human readable string, which you can present to the user for doing a GP value choice. If there is only a unique possible GP value for the given parameters, then this variable will be nil.
    -- GPListType is a string, specifing the type of the return list with GP values. If there are multiple possible GP values, this will be either "SHIELD", "1HWEAPON", "2HWEAPON", "RANGED" or "TOKEN". Otherwise nil.
    -- GPList is a list representing the different possible GP values in a machine processable form. There are five different list types. If the GP value for the given parameters is unique, this will be nil.
    -- @usage Example 1: A cloth chest item for a priest - only one possible GP value - ItemString and class are given
    -- LibEPGP-GPCalculator:GetItemGP("item:50717:0:0:0:0:0:0:0:0", "PRIEST") == { 778 }, nil, nil, nil
    -- @usage Example 2: A 1H weapon for a warrior - two possible values, depending on if used for tanking, or if placed in MH or OH - ItemID and class are given
    -- LibEPGP-GPCalculator.GetItemGP(50412, "WARRIOR") => { 825, 275 }, "Either 275 GP (for Hunter or Tank or if used as Offhand) or 825 GP (for anything else)", "1HWEAPON", { ["OTHER"] = 825, ["OFFHAND"] = 275, ["TANK"] = 275, ["HUNTER"] = 275 }
    -- @usage Example 3: A T10-Token - two possible GP values, depending on the slot - ItemID is given
    -- LibEPGP-GPCalculator.GetItemGP(52030) => { 778, 583 }, "Either 778 GP (for Head, Chest or Legs) or 583 GP (for Shoulders or Hands)", "TOKEN", { ["HEAD"] = 778, ["CHEST"] = 778, ["LEGS"] = 778, ["SHOULDERS"] = 583, ["HANDS"] = 583, }
    -- @usage Example 4: A bag - no possible values - ItemId is given
    -- LibEPGP-GPCalculator.GetItemGP(38082) => { 0 }, nil, nil, nil
    function libGP:GetItemGP(item, class, spec, slot)
        --[[
        The basic GP formular is: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
        The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
        The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who will use the item
        --]]
        -- Gather item information
        local _, itemLink, itemRarity, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(item)
        -- Check if a valid item was supplied
        if not itemLink then
            error(("Argument #1 to LibEPGP_GPCalculator:GetValues was invalid or not a cached item. It must be a cached ItemID, ItemString or ItemLink. Got: %s"):format(item) , 2)
        end
        -- Get ItemID
        local itemID = string.match(itemLink, "|Hitem:(%d+)")
        -- Armor: With the exception of shields, the GP values for armor items are unique
        if LBIR[itemType] == "Armor" then
            -- Slots Wrist, Neck, Back, Finger, Offhand-Items and Relics have a fixed modifier of 0.5
            if itemEquipLoc == "INVTYPE_WRIST" or itemEquipLoc == "INVTYPE_NECK" or itemEquipLoc == "INVTYPE_CLOAK" or itemEquipLoc == "INVTYPE_FINGER" or itemEquipLoc == "INVTYPE_HOLDABLE" or itemEquipLoc == "INVTYPE_RELIC" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
            -- Slots Shoulder, Hands, Waist, Feet and Trinkets have a fixed modifier of 0.75
            if itemEquipLoc == "INVTYPE_SHOULDER" or itemEquipLoc == "INVTYPE_HAND" or itemEquipLoc == "INVTYPE_WAIST" or itemEquipLoc == "INVTYPE_FEET" or itemEquipLoc == "INVTYPE_TRINKET" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.75) }
            end
            -- Slots Head, Chest, Legs have a fixed modifier of 1
            if itemEquipLoc == "INVTYPE_HEAD" or itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" or itemEquipLoc == "INVTYPE_LEGS" then
                return { libGP:GetGP(itemLevel, itemRarity, 1) }
            end
            -- If a shield is used for tanking, it has a modifier of 1.5 - else 0.5
            -- Additional idea: all caster shields of a quality of rare (or better) seem to have +Int on them. This could avoid the return of multiple values
            --            also: shield with +Str are tank shields
            if itemEquipLoc == "INVTYPE_SHIELD" then
                -- 0.5, if class is shaman (non-tank), or spec is either HEAL or DD
                if class == "SHAMAN" or spec == "DD" or spec == "HEAL" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- 1.5, if class is warrior (Shield is only used for tanking then) or spec is TANK
                elseif class == "WARRIOR" or spec == "TANK" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 0.5), libGP:GetGP(itemLevel, itemRarity, 1.5) }
                    local GPValueText = ("Either %d GP (for Tanks) or %d GP (for other specs)"):format(GPValues[2], GPValues[1])
                    local GPListType = "SHIELD"
                    local GPList = { ["OTHER"] = GPValues[1], ["TANK"] = GPValues[2] }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
        end
        -- Weapons: They are a bit more complicated
        if LBIR[itemType] == "Weapon" then
            -- a 1H main-hand weapon is always mod 1.5, except for hunter and tanks (0.5 then)
            -- If no spec is given, then return mod 1.5 for all non tanking classes.
            -- INVTYPE_WEAPONMAINHAND can't be an offhand.
            if itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
                if class == "HUNTER" or spec == "TANK" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                elseif class == "MAGE" or class == "PRIEST" or class == "ROGUE" or class == "SHAMAN" or class == "WARLOCK" or spec ~= nil then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter or Tank) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "1HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["TANK"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- a 1H off-hand weapon is always mod 0.5
            if itemEquipLoc == "INVTYPE_WEAPONOFFHAND" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
            -- 1H weapon is 1.5, except for hunters and tanks - or if used as offhand (0.5 then)
            -- Additional idea: There are classes, who can't equip off hand weapons. Should return the 1.5 mod value then.
            if itemEquipLoc == "INVTYPE_WEAPON" then
                if class == "HUNTER" or spec == "TANK" or slot == "INVTYPE_WEAPONOFFHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                elseif class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or slot == "INVTYPE_WEAPONMAINHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter or Tank or if used as Offhand) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "1HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["TANK"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- 2H weapon is 2, except for warrior OH (1) or hunter (1)
            -- Possible extension: If the weapon has Int on it, it is not for a warrior or hunter -> mod 2!
            if itemEquipLoc == "INVTYPE_2HWEAPON" then
                -- 1, if used for Offhand or class is hunter
                if class == "HUNTER" or slot == "INVTYPE_WEAPONOFFHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1) }
                -- 2, if class is not Warrior and not hunter and not nil
                elseif class ~= nil and class ~= "WARRIOR" and class ~= "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 2) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 2), libGP:GetGP(itemLevel, itemRarity, 1) }
                    local GPValueText = ("Either %d GP (for Hunter or is used as Offhand) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "2HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- Bows are mod 0.5, except for hunters (1.5 then)
            if itemEquipLoc == "INVTYPE_RANGED" then
                -- 1.5, if used by hunter
                if class == "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- 0.5, if not used by hunter
                elseif class ~= nil then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter) or %d GP (for any other class)"):format(GPValues[2], GPValues[1])
                    local GPListType = "RANGED"
                    local GPList = { ["OTHER"] = GPValues[1], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- INVTYPE_RANGEDRIGHT covers wands, crossbows and guns. Wands are always 0.5. Crossbows and guns are under the same rules as bows.
            if itemEquipLoc == "INVTYPE_RANGEDRIGHT" then
                -- 1.5, if used by hunter
                if class == "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- 0.5, if other class or item is a wand
                elseif class ~= nil or LBIR[itemSubType] == "Wands" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter) or %d GP (for any other class)"):format(GPValues[2], GPValues[1])
                    local GPListType = "RANGED"
                    local GPList = { ["OTHER"] = GPValues[1], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- Thrown weapons are ranged weapons, which have a mod of 0.5 except for hunters. 
            -- However, in WoW it does not make sense for a Hunter to carry thrown weapons, so this case can be ignored. 
            -- ... I think. At least I hope... Why do I have this strange feeling that there is at least one Hunter out there that will prove me wrong some day?
            if itemEquipLoc == "INVTYPE_THROWN" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
        end
        -- Misc: Tier Tokens are under this category. Depending on the type of the token, it may be able to redeem different slots 
        if LBIR[itemType] == "Miscellaneous" then
            if TOKEN_HEAD[itemID] or TOKEN_CHEST[itemID] or TOKEN_LEGS[itemID] then
                itemLevel = TOKEN_HEAD[itemID] or TOKEN_CHEST[itemID] or TOKEN_LEGS[itemID]
                return { libGP:GetGP(itemLevel, itemRarity, 1) }
            end
            if TOKEN_SHOULDERS[itemID] or TOKEN_HANDS[itemID] or TOKEN_WAIST[itemID] or TOKEN_FEET[itemID] then
                itemLevel = TOKEN_SHOULDERS[itemID] or TOKEN_HANDS[itemID] or TOKEN_WAIST[itemID] or TOKEN_FEET[itemID]
                return { libGP:GetGP(itemLevel, itemRarity, 0.75) }
            end
            if TOKEN_WRISTS[itemID] then
                itemLevel = TOKEN_WRISTS[itemID]
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
            if TOKEN_5PART[itemID] then
                itemLevel = TOKEN_5PART[itemID]
                if slot == "INVTYPE_HEAD" or slot == "INVTYPE_CHEST" or slot == "INVTYPE_ROBE" or slot == "INVTYPE_LEGS" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1) }
                elseif slot == "INVTYPE_SHOULDER" or slot == "INVTYPE_HAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.75) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1), libGP:GetGP(itemLevel, itemRarity, 0.75) }
                    local GPValueText = ("Either %d GP (for Head, Chest or Legs) or %d GP (for Shoulders or Hands)"):format(GPValues[1], GPValues[2])
                    local GPListType = "TOKEN"
                    local GPList = { ["HEAD"] = GPValues[1], ["CHEST"] = GPValues[1], ["LEGS"] = GPValues[1], ["SHOULDERS"] = GPValues[2], ["HANDS"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
        end
        -- If the item was not recognized, return { 0 }
        return { 0 }
    end

    --- Calculates the GP for an item with known itemLevel, rarity and slot mod.
    -- @param itemLevel The itemLevel of an item
    -- @param rarity The rarity of an item. Possible values are: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
    -- @param slotMod The slot modifier according to the EPGP-System.
    -- @return a number, representing the GP value for the given variables
    function libGP:GetGP(itemLevel, rarity, slotMod)
        --[[
        The basic GP formular was: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
        The coefficient seems to have changed in Cataclysm to 0.06974 - this isn't in the official web documentation but in the EPGP-Addon-Code
        The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
        The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who will use the item
        --]]
        -- sanity check inputs here
        -- calculate the GP value
        return floor( epgpCoefficient * 2 ^ ( itemLevel/26 + (rarity - 4) ) * slotMod )
    end
end
