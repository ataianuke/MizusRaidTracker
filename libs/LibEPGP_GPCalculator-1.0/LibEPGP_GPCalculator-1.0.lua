-- ****************************************************
--              LibEPGP_GPCalculator-1.0
-- ****************************************************
-- A library for calculating GP values of items.
-- 
-- This library is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010-2011)
--
-- Licensed under the MIT-License (see LICENSE.txt)
--

assert(LibStub, "LibEPGP_GPCalculator-1.0 requires LibStub")
assert(LibStub:GetLibrary("LibBabble-Inventory-3.0", true), "LibEPGP_GPCalculator-1.0 requires LibBabble-Inventory-3.0")

local lib = LibStub:NewLibrary("LibEPGP_GPCalculator-1.0", 1)

if not lib then 
    return -- No upgrade needed
end

-- set up a copy of LBI for handling the different item types
local LBI = LibStub("LibBabble-Inventory-3.0")
local LBIR = LBI:GetReverseLookupTable()

-- List of various ItemIDs:
-- List of tokens, which can be traded for a helm
local TOKEN_HEAD = {
}

-- List of tokens, which can be traded for a set of shoulder pads
local TOKEN_SHOULDER = {
}

-- List of tokens, which can be traded for a chest piece
local TOKEN_CHEST = {
}

-- List of tokens, which can be traded for a set of gloves
local TOKEN_HANDS = {
}

-- List of tokens, which can be traded for a leg piece
local TOKEN_LEGS = {
}

-- List of tokens, which can be traded for a head, shoulder, chest, hands or legs slot item
local TOKEN_5PART = {
}

-- List of tokens, which can be traded for a head, shoulder, chest, wrist, waist, hands, legs or feet slot item
local TOKEN_8PART = {
}

-- @usage Example 1: A cloth chest item for a priest - only one possible GP value - ItemString and class are given
-- LibEPGP_GPCalculator.GetGPTuple("item:50717:0:0:0:0:0:0:0:0", "PRIEST") => 778, nil, nil, nil, nil, nil, nil, nil, nil
-- @usage Example 2: A T10-Token - two possible GP values, depending on the slot - ItemId is given
-- LibEPGP_GPCalculator.GetGPTuple(52030) => 778, 583, nil, {"INVTYPE_HEAD", "INVTYPE_CHEST", "INVTYPE_LEGS"}, {"INVTYPE_SHOULDER", "INVTYPE_HAND"}, nil, nil, nil, nil
-- @usage Example 3: A 1H weapon for a warrior - two possible values, depending on if used for tanking, or if placed in MH or OH - ItemID and class are given
-- LibEPGP_GPCalculator.GetGPTuple(50412, "WARRIOR") => 825, 275, 275, {"INVTYPE_WEAPONMAINHAND"}, {"INVTYPE_WEAPONMAINHAND"}, {"INVTYPE_WEAPONOFFHAND"}, {"NONTANK"}, {"TANK"}, {"NONTANK"}
-- @usage Example 4: A 1H weapon - two possible values, depending on class and slot - ItemLink is given
-- LibEPGP_GPCalculator.GetGPTuple("|cffa335ee|Hitem:50412:0:0:0:0:0:0:0:0|h[Bloodvenom Blade]|h|r") => 825, 275, 275, {"INVTYPE_WEAPONMAINHAND"}, {"INVTYPE_WEAPONMAINHAND"}, {"INVTYPE_WEAPONOFFHAND"}, {"NONTANK", "PRIEST", "ROUGE", "WARLOCK", "SHAMAN", "MAGE"}, {"TANK", "HUNTER"}, {"NONTANK", "PRIEST", "ROUGE", "WARLOCK", "SHAMAN", "MAGE", "HUNTER"}
-- @usage Example 5: A bag - no possible values - ItemId is given
-- LibEPGP_GPCalculator.GetGPTuple(38082) => 0, nil, nil, nil, nil, nil, nil, nil, nil
-- @usage It is recommended to use as much parameter as possible to shorten the return values


--- Calculate and return a simple list of possible GP values. If there is more than one possible GP value, the function will also return a
-- human readable string, for presenting the different values to a user and a special list, to represent which value apply under which conditions.
-- @param item Either an ItemID or ItemString or ItemLink. Item need to be cached in client.
-- @param class Optional - Specify the class, which should receive the item. Fully capitalized english class name with no spaces (use second return parameter of WoW-API-Function 'UnitClass')
-- @param spec Optional - Specify the spec, which should receive the item. Class specialization (Either "TANK", "DD" or "HEALER")
-- @param slot Optional - Specify the slot, for which this item should be used. For possible values, see itemEquipLoc (http://www.wowpedia.org/ItemEquipLoc)
-- @usage local GPValues, GPValueText, GPListType, GPList = LibEPGP_GPCalculator:GetItemGP(item, class, spec, slot)
-- FIXME! (Explanationtext for the return values)
-- @usage Example 1: A cloth chest item for a priest - only one possible GP value - ItemString and class are given
-- LibEPGP_GPCalculator:GetItemGP("item:50717:0:0:0:0:0:0:0:0", "PRIEST") == { 778 }
function lib:GetItemGP(item, class, spec, slot)
    --[[
    The basic GP formular is: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
    The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
    The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who should use the item
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
            return { lib:GetGP(itemLevel, itemRarity, 0.5) }
        end
        -- Slots Shoulder, Hands, Waist, Feet and Trinkets have a fixed modifier of 0.75
        if itemEquipLoc == "INVTYPE_SHOULDER" or itemEquipLoc == "INVTYPE_HAND" or itemEquipLoc == "INVTYPE_WAIST" or itemEquipLoc == "INVTYPE_FEET" or itemEquipLoc == "INVTYPE_TRINKET" then
            return { lib:GetGP(itemLevel, itemRarity, 0.75) }
        end
        -- Slots Head, Chest, Legs have a fixed modifier of 1
        if itemEquipLoc == "INVTYPE_HEAD" or itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" or itemEquipLoc == "INVTYPE_LEGS" then
            return { lib:GetGP(itemLevel, itemRarity, 1) }
        end
        -- If a shield is used for tanking, it has a modifier of 1.5 - else 0.5
        -- Additional idea: all caster shields of a quality of rare (or better) seem to have +Int on them. This could avoid the return of multiple values
        --            also: shield with +Str are tank shields
        if itemEquipLoc == "INVTYPE_SHIELD" then
            -- 0.5, if class is shaman (non-tank), or spec is either HEAL or DD
            if class == "SHAMAN" or spec == "DD" or spec == "HEAL" then
                return { lib:GetGP(itemLevel, itemRarity, 0.5) }
            -- 1.5, if class is warrior or spec is TANK
            elseif class == "WARRIOR" or spec == "TANK" then
                return { lib:GetGP(itemLevel, itemRarity, 1.5) }
            -- if nothing matches, return both values
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 0.5), lib:GetGP(itemLevel, itemRarity, 1.5) }
                local GPValueText = ("Either %d GP (for Tanks) or %d GP (for other specs)"):format(GPValues[2], GPValues[1])
                local GPListType = "SHIELD"
                local GPList = { ["OTHER"] = GPValues[1], ["TANK"] = GPValues[2] }
                return GPValues, GPValueText, GPListType, GPList
            end
        end
    end
    if LBIR[itemType] == "Weapon" then
        -- a 1H main-hand weapon is always mod 1.5, except for hunter and tanks (0.5 then)
        -- Possible extension: If the weapon has Int on it, it is not for a tank or hunter -> mod 2!
        if itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
            if class == "HUNTER" or spec == "TANK" then
                return { lib:GetGP(itemLevel, itemRarity, 0.5) }
            elseif class ~= nil or spec ~= nil then
                return { lib:GetGP(itemLevel, itemRarity, 1.5) }
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 1.5), lib:GetGP(itemLevel, itemRarity, 0.5) }
                local GPValueText = ("Either %d GP (for Hunter or Tank) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                local GPListType = "1HWEAPON"
                local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["TANK"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                return GPValues, GPValueText, GPListType, GPList
            end
        end
        -- a 1H off-hand weapon is always mod 0.5
        if itemEquipLoc == "INVTYPE_WEAPONOFFHAND" then
            return { lib:GetGP(itemLevel, itemRarity, 0.5) }
        end
        -- 1H weapon is 1.5, except for hunters and tanks - or if used as offhand (0.5 then)
        if itemEquipLoc == "INVTYPE_WEAPON" then
            if class == "HUNTER" or spec == "TANK" or slot == "INVTYPE_WEAPONOFFHAND" then
                return { lib:GetGP(itemLevel, itemRarity, 0.5) }
            elseif class ~= nil or spec ~= nil then
                return { lib:GetGP(itemLevel, itemRarity, 1.5) }
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 1.5), lib:GetGP(itemLevel, itemRarity, 0.5) }
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
                return { lib:GetGP(itemLevel, itemRarity, 1) }
            -- 2, if class is not Warrior and not hunter and not nil
            elseif class ~= nil and class ~= "WARRIOR" and class ~= "HUNTER" then
                return { lib:GetGP(itemLevel, itemRarity, 2) }
            -- if nothing matches, return both values
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 2), lib:GetGP(itemLevel, itemRarity, 1) }
                local GPValueText = ("Either %d GP (for Hunter or Offhand) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                local GPListType = "2HWEAPON"
                local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                return GPValues, GPValueText, GPListType, GPList
            end
        end
        -- Bows are mod 0.5, except for hunters (1.5 then)
        if itemEquipLoc == "INVTYPE_RANGED" then
            -- 1.5, if used by hunter
            if class == "HUNTER" then
                return { lib:GetGP(itemLevel, itemRarity, 1.5) }
            -- 0.5, if not used by hunter
            elseif class ~= nil then
                return { lib:GetGP(itemLevel, itemRarity, 0.5) }
            -- if nothing matches, return both values
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 1.5), lib:GetGP(itemLevel, itemRarity, 0.5) }
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
                return { lib:GetGP(itemLevel, itemRarity, 1.5) }
            -- 0.5, if other class or item is a wand
            elseif class ~= nil or LBIR[itemSubType] == "Wands" then
                return { lib:GetGP(itemLevel, itemRarity, 0.5) }
            -- if nothing matches, return both values
            else
                local GPValues = { lib:GetGP(itemLevel, itemRarity, 1.5), lib:GetGP(itemLevel, itemRarity, 0.5) }
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
            return { lib:GetGP(itemLevel, itemRarity, 0.5) }
        end
    end
    -- If the item was not recognized, return 0
    return 0
end

--- Calculates the GP for an item with known itemLevel, rarity and slot mod.
-- @param itemLevel The itemLevel of an item
-- @param rarity The rarity of an item. Possible values are: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
-- @param slotMod The slot modifier according to the EPGP-System.
-- @return a number, representing the GP value for the given variables
function lib:GetGP(itemLevel, rarity, slotMod)
    --[[
    The basic GP formular is: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
    The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
    The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who should use the item
    --]]
    -- sanity check inputs here
    -- calculate the GP value
    return floor( 0.483 * 2 ^ ( itemLevel/26 + (rarity - 4) ) * slotMod )
end
