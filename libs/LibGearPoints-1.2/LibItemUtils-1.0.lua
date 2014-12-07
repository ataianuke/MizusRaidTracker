-- This library provides an interface to query if an item can be
-- use by a certain class. The API is as follows:
--
-- CanClassUse(class, itemType): class is one of **** and itemType a localized itemType (http://www.wowwiki.com/ItemType).
--

--[[
Copyright (c) 2006, 2007, Alkis Evlogimenos
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

	* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
	* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
	* Neither the name of Alkis Evlogimenos nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]

-- Modifications by Mizukichan: Removed LibDebug dependencies

local MAJOR_VERSION = "LibItemUtils-1.0"
local MINOR_VERSION = tonumber(("$Revision: $"):match("%d+")) or 0

local lib, oldMinor = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

-- Inventory types are localized on each client. For this we need
-- LibBabble-Inventory to unlocalize the strings.
local LBIR = LibStub("LibBabble-Inventory-3.0"):GetReverseLookupTable()
local deformat = LibStub("LibDeformat-3.0")

-- Make a frame for our repeating calls to GetItemInfo.
lib.frame = lib.frame or CreateFrame("Frame", MAJOR_VERSION .. "_Frame")
local frame = lib.frame
frame:Hide()
frame:SetScript('OnUpdate', nil)
frame:UnregisterAllEvents()

-- Use the GameTooltip or create a new one and initialize it
-- Used to extract Class limitations for an item, upgraded ilvl,
-- and binding type.
lib.tooltip = lib.tooltip or CreateFrame("GameTooltip",
                                         MAJOR_VERSION .. "_Tooltip",
                                         frame, "GameTooltipTemplate")
local tooltip = lib.tooltip
local bindingFrame = getglobal(tooltip:GetName().."TextLeft2")
local restrictedClassFrameNameFormat = tooltip:GetName().."TextLeft%d"
tooltip:Hide();

-------------
-- OTHER
-------------

--- Convert an itemlink to itemID
--  @param itemlink of which you want the itemID from
--  @returns number or nils
function lib:ItemlinkToID(itemlink)
  if not itemlink then return nil end
  local itemID = strmatch(itemlink, 'item:(%d+)')
  if not itemID then return end
  return tonumber(itemID)
end

--- Returns the bonus IDs for an item
--  @param item to get the bonus IDs from
--  @returns a table of bonus IDs; empty table if none; nil if not an item.
function lib:BonusIDs(item)
  local _, itemLink, _, _, _, _, _, _, _ = GetItemInfo(item)
  if not itemLink then return end

  local itemString = string.match(itemLink, "item[%-?%d:]+")
  if not itemString then return nil end
  
  local bonuses = {}
    local tbl = { strsplit(":", itemString) }
    for key, value in pairs(tbl) do
       if key >= 14 then
          table.insert(bonuses, tonumber(value))
        end
    end

   return bonuses
end

-------------
-- ITEM USAGE
-------------

--[[

All item types we care about:

    Cloth = true,
    Leather = true,
    Mail = true,
    Plate = true,
    Shields = true,

    Bows = true,
    Crossbows = true,
    Daggers = true,
    ["Fist Weapons"] = true,
    Guns = true,
    ["One-Handed Axes"] = true,
    ["One-Handed Maces"] = true,
    ["One-Handed Swords"] = true,
    Polearms = true,
    Staves = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Maces"] = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
    Wands = true,
--]]

local disallowed = {
  DEATHKNIGHT = {
    Shields = true,

    Bows = true,
    Crossbows = true,
    Daggers = true,
    ["Fist Weapons"] = true,
    Guns = true,
    Polearms = true,
    Staves = true,

    Idols = true,
    Librams = true,
    Thrown = true,
    Totems = true,
    Wands = true,
  },
  DRUID = {
    Mail = true,
    Plate = true,
    Shields = true,

    Bows = true,
    Crossbows = true,
    Guns = true,
    ["One-Handed Axes"] = true,
    ["One-Handed Swords"] = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Swords"] = true,

    Librams = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
    Wands = true,
  },
  HUNTER = {
    Plate = true,
    Shields = true,

    ["One-Handed Maces"] = true,
    ["Two-Handed Maces"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Totems = true,
    Wands = true,
  },
  MAGE = {
    Leather = true,
    Mail = true,
    Plate = true,
    Shields = true,

    Bows = true,
    Crossbows = true,
    ["Fist Weapons"] = true,
    Guns = true,
    ["One-Handed Axes"] = true,
    ["One-Handed Maces"] = true,
    Polearms = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Maces"] = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
  },
  PALADIN = {
    Bows = true,
    Crossbows = true,
    ["Fist Weapons"] = true,
    Guns = true,
    Staves = true,

    Idols = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
    Wands = true,
  },
  PRIEST = {
    Leather = true,
    Mail = true,
    Plate = true,
    Shields = true,

    Bows = true,
    Crossbows = true,
    ["Fist Weapons"] = true,
    Guns = true,
    ["One-Handed Axes"] = true,
    ["One-Handed Swords"] = true,
    Polearms = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Maces"] = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
  },
  ROGUE = {
    Mail = true,
    Plate = true,
    Shields = true,

    Polearms = true,
    Staves = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Maces"] = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Totems = true,
    Wands = true,
  },
  SHAMAN = {
    Plate = true,

    Bows = true,
    Crossbows = true,
    Guns = true,
    ["One-Handed Swords"] = true,
    Polearms = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Thrown = true,
    Wands = true,
  },
  WARLOCK = {
    Leather = true,
    Mail = true,
    Plate = true,
    Shields = true,

    Bows = true,
    Crossbows = true,
    ["Fist Weapons"] = true,
    Guns = true,
    ["One-Handed Axes"] = true,
    ["One-Handed Maces"] = true,
    Polearms = true,
    ["Two-Handed Axes"] = true,
    ["Two-Handed Maces"] = true,
    ["Two-Handed Swords"] = true,

    Idols = true,
    Librams = true,
    Sigils = true,
    Thrown = true,
    Totems = true,
  },
  WARRIOR = {
    Idols = true,
    Librams = true,
    Sigils = true,
    Totems = true,
    Wands = true,
  },
}

function lib:ClassCanUse(class, item)
  local subType = select(7, GetItemInfo(item))
  if not subType then
    return true
  end

  -- Check if this is a restricted class token.
  -- TODO(alkis): Possibly cache this check if performance is an issue.
  local link = select(2, GetItemInfo(item))
  tooltip:SetOwner(UIParent, "ANCHOR_NONE")
  tooltip:SetHyperlink(link)
  -- lets see if we can find a 'Classes: Mage, Druid' string on the itemtooltip
  -- Only scanning line 2 is not enough, we need to scan all the lines
  for lineID = 1, tooltip:NumLines(), 1 do
    local line = _G[restrictedClassFrameNameFormat:format(lineID)]
    if line then
      local text = line:GetText()
      if text then
        local classList = deformat(text, ITEM_CLASSES_ALLOWED)
        if classList then
          tooltip:Hide()
          for _, restrictedClass in pairs({strsplit(',', classList)}) do
            restrictedClass = strtrim(strupper(restrictedClass))
            restrictedClass = strupper(LOCALIZED_CLASS_NAMES_FEMALE[restrictedClass] or LOCALIZED_CLASS_NAMES_MALE[restrictedClass])
            if class == restrictedClass then
              return true
            end
          end
          return false
        end
      end
    end
  end
  tooltip:Hide()

  -- Check if players can equip this item.
  subType = LBIR[subType]
  if disallowed[class][subType] then
    return false
  end

  return true
end

-- Not currently used; pending changes to upgrade system, this may not
-- be necessary in the future.  We'll see in 6.0.
function lib:GetItemIlevel(item, fallback)
  tooltip:SetOwner(UIParent, "ANCHOR_NONE")
  tooltip:SetHyperlink(item)
  -- lets see if we can find a 'Classes: Mage, Druid' string on the itemtooltip
  -- Only scanning line 2 is not enough, we need to scan all the lines
  for lineID = 1, tooltip:NumLines(), 1 do
    local line = _G[restrictedClassFrameNameFormat:format(lineID)]
    if line then
      local text = line:GetText()
      if text then
	local item_level_pattern = ITEM_LEVEL:gsub("%%d", "(%%d+)")
	local ilvl = tonumber(text:match(item_level_pattern))
	if ilvl then
	  return ilvl
	end
      end
    end
  end

  return fallback
end

function lib:ClassCannotUse(class, item)
  return not self:ClassCanUse(class, item)
end

local function NewTableOrClear(t)
  if not t then return {} end
  wipe(t)
  return t
end

function lib:ClassesThatCanUse(item, t)
  t = NewTableOrClear(t)
  for class, _ in pairs(RAID_CLASS_COLORS) do
    if self:ClassCanUse(class, item) then
      table.insert(t, class)
    end
  end
  return t
end

function lib:ClassesThatCannotUse(item, t)
  t = NewTableOrClear(t)
  for class, _ in pairs(RAID_CLASS_COLORS) do
    if self:ClassCannotUse(class, item) then
      table.insert(t, class)
    end
  end
  return t
end

-----------------
-- ITEMS FOR SLOT
-----------------

local slot_table = {
  INVTYPE_HEAD = {"HeadSlot", nil},
  INVTYPE_NECK = {"NeckSlot", nil},
  INVTYPE_SHOULDER = {"ShoulderSlot", nil},
  INVTYPE_CLOAK = {"BackSlot", nil},
  INVTYPE_CHEST = {"ChestSlot", nil},
  INVTYPE_WRIST	= {"WristSlot", nil},
  INVTYPE_HAND = {"HandsSlot", nil},
  INVTYPE_WAIST = {"WaistSlot", nil},
  INVTYPE_LEGS = {"LegsSlot", nil},
  INVTYPE_FEET = {"FeetSlot", nil},
  INVTYPE_SHIELD = {"SecondaryHandSlot", nil},
  INVTYPE_ROBE = {"ChestSlot", nil},
  INVTYPE_2HWEAPON = {"MainHandSlot", "SecondaryHandSlot"},
  INVTYPE_WEAPONMAINHAND = {"MainHandSlot", nil},
  INVTYPE_WEAPONOFFHAND	= {"SecondaryHandSlot", "MainHandSlot"},
  INVTYPE_WEAPON = {"MainHandSlot","SecondaryHandSlot"},
  INVTYPE_THROWN = {"RangedSlot", nil},
  INVTYPE_RANGED = {"RangedSlot", nil},
  INVTYPE_RANGEDRIGHT = {"RangedSlot", nil},
  INVTYPE_FINGER = {"Finger0Slot", "Finger1Slot"},
  INVTYPE_HOLDABLE = {"SecondaryHandSlot", "MainHandSlot"},
  INVTYPE_TRINKET = {"Trinket0Slot", "Trinket1Slot"},
  -- Hack for Tier 9 25M heroic tokens.
  -- TODO(alkis): Fix this to return more than 2 slots because these tokens
  -- can go in any of 5 slots.
  INVTYPE_CUSTOM_MULTISLOT_TIER = {"HeadSlot", "ChestSlot"}
}

function lib:ItemsForSlot(invtype, unit)
  local t = slot_table[invtype]
  if not t then return end

  local first, second = unpack(t)
  -- Translate to slot ids
  first = first and GetInventorySlotInfo(first)
  second = second and GetInventorySlotInfo(second)
  -- Translate to item links
  first = first and GetInventoryItemLink(unit or "player", first)
  second = second and GetInventoryItemLink(unit or "player", second)

  return first, second
end

----------------
-- ITEM BINDINGS
----------------

-- binding is one of: ITEM_BIND_ON_PICKUP, ITEM_BIND_ON_EQUIP,
-- ITEM_BIND_ON_USE, ITEM_BIND_TO_ACCOUNT
function lib:IsBinding(binding, item)
  local link = select(2, GetItemInfo(item))
  tooltip:SetOwner(UIParent, "ANCHOR_NONE")
  tooltip:SetHyperlink(link)

  if tooltip:NumLines() > 1 then
    local text = bindingFrame:GetText()
    if text then
      return text == binding
    end
  end
  tooltip:Hide()
end

function lib:IsBoP(item)
  return lib:IsBinding(ITEM_BIND_ON_PICKUP, item)
end

function lib:IsBoE(item)
  return lib:IsBinding(ITEM_BIND_ON_EQUIP, item)
end

--------------
-- ITEMCACHING
--------------

-- Reuse or create a table to store the lookup queue in
lib.itemQueue = lib.itemQueue or {}
local itemQueue = lib.itemQueue

--- Try to lookup the items on the itemQueue
--
--  This will lookup all the items on the itemQueue, and if found it
--  will call the callbacks and remove them. If they are not found it
--  will retry once per second for a max of 30 seconds after the last
--  callback was called, and after that it will give up.
local timeout = 0
local ticker = 0
local function LookupItems(frame, elapsed)
  timeout = timeout + elapsed
  ticker = ticker + elapsed
  if timeout > 30 then
    -- Debug("Giving up, clearing itemQueue")
    for item, _ in pairs(itemQueue) do
      -- Debug("\t%s", item)
    end
    wipe(itemQueue)
    ticker = 0
    frame:Hide()
    return
  end

  if ticker > 1 then
    ticker = 0
    -- Go through all the items and check if they have data in the
    -- client cache. If the do call the saved functions and args.
    -- Debug("Checking for new items in the cache")
    for itemLink, itemData in pairs(itemQueue) do
      if GetItemInfo(itemLink) then
        -- If we found an item, reset the timeout.
        timeout = 0
        itemQueue[itemLink] = nil
        for callback, args in pairs(itemData) do
          pcall(callback, unpack(args))
        end
      else
        -- Otherwise set the hyperlink on a tooltip to make the cache
        -- fetch it.
        tooltip:SetHyperlink(itemLink)
        tooltip:Show()
        tooltip:Hide()
      end
    end
  end

  -- If we have no more items in the itemQueue to lookup, reset the
  -- timeout and hide the frame.
  if not next(itemQueue) then
    timeout = 0
    ticker = 0
    frame:Hide()
  end
end
frame:SetScript("OnUpdate", LookupItems)

--- Try to cache an item and call the callback function when the item
--- is available
--
--  @param itemLink any itemLink in Hitem:1234 form
--  @param callback function pointer to the callback function that
--  should be called when the item is available
--  @param ... a list of variables you would like to pass to the
--  callback function.
--  @return boolean true if the item has been registered successfully
function lib:CacheItem(itemLink, callback, ...)
  -- Reset the timeout for the itemQueue
  timeout = 0

  if type(itemLink) == 'number' then
    itemLink = format('item:%d', itemLink)
  end

  if type(callback) ~= "function" then
    error("Usage: CacheItem(itemLink, callback, [...]): 'callback' - function.", 2)
  end

  if not itemLink or not strmatch(itemLink, 'item:(%d+)') then
    error("Usage: CacheItem(itemLink, callback, [...]): 'itemLink' - not a valid itemLink (item:12345).", 2)
  end

  itemQueue[itemLink] = itemQueue[itemLink] or {}
  itemQueue[itemLink][callback] = {...}

  -- show the frame to start looking up items
  frame:Show()

  return true
end

