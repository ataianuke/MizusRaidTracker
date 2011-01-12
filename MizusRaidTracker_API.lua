-- ********************************************************
-- **              Mizus RaidTracker - API               **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010-2011)
--
--    This file is part of Mizus RaidTracker.
--
--    Mizus RaidTracker is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as 
--    published by the Free Software Foundation, either version 3 of the 
--    License, or (at your option) any later version.
--
--    Mizus RaidTracker is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Mizus RaidTracker.  
--    If not, see <http://www.gnu.org/licenses/>.


----------------------------
--  Global API variables  --
----------------------------
-- Item actions
MRT_LOOTACTION_NORMAL = 1;
MRT_LOOTACTION_BANK = 2;
MRT_LOOTACTION_DISENCHANT = 3;
MRT_LOOTACTION_DELETE = 4;

-- Item notify sources
MRT_NOTIFYSOURCE_ADD_POPUP = 1;
MRT_NOTIFYSOURCE_ADD_SILENT = 2;
MRT_NOTIFYSOURCE_ADD_GUI = 3;
MRT_NOTIFYSOURCE_EDIT_GUI = 4;
MRT_NOTIFYSOURCE_DELETE_GUI = 5;


-----------
--  API  --
-----------

--- API for handling item costs of newly looted items. The registered function will only be called, when an item was tracked with the automatic tracking system.
-- It won't be called, if the user has added an item manually. Only one function can be registered at any given time.
-- @name MRT_RegisterItemCostHandler
-- @param functionToCall The function, which shall be called, when a new items has been looted and tracked
-- @param addonName The name of addon which registers one of its functions here. Will be used to inform the user.
-- @return boolean - indicates if the registration of the function was successful
-- @usage -- The function, which should be called, will receive and shall return the following variables
-- cost, looter, itemNote, lootAction, suppressAskCostDialog = functionToCall(itemInfoTable)
-- -- param itemInfoTable: A stripped down variant of the loot information from the MRT_RaidLog table
-- --                      Will include the keys 'ItemLink', 'ItemString', 'ItemId', 'ItemName', 'ItemColor', 'ItemCount', 'Looter', 'DKPValue'
-- --                      see http://wow.curseforge.com/addons/mizusraidtracker/pages/api/variables-and-tables/ for more information
-- -- return cost: number - the cost for this item
-- -- return looter: string - the looter for this item, which should be a player name
-- -- return itemNote: string - an item note for this item
-- -- return lootAction: Indicates, if and what special item action should apply to this item. There are currently four values defined:
-- --                    MRT_LOOTACTION_NORMAL     = item given to looter for personal purpose. (default action if none given)
-- --                    MRT_LOOTACTION_BANK       = item given to looter for bank purpose
-- --                    MRT_LOOTACTION_DISENCHANT = item given to looter for disenchant purpose
-- --                    MRT_LOOTACTION_DELETE     = item will be marked as deleted and be ignored in raid exports
-- -- return suppressAskCostDialog: boolean - If set to true, it will disable the popup dialog.
-- @usage -- A simple example, which sets the cost to 42, leaves a loot note, banks the item and doesn't suppress the pop up dialog
-- function MRT_ItemCostHandlerExample(itemInfo)
--     return 42, itemInfo.Looter, "Example ItemNote", MRT_LOOTACTION_BANK, nil;
-- end
--
-- local registrationSuccess = MRT_RegisterItemCostHandler(MRT_ItemCostHandlerExample, "MRT TestSuite");
-- if registrationSuccess then
--     MRT_Print("ItemCostHandler registration was a success!");
-- end
function MRT_RegisterItemCostHandler(functionToCall, addonName)
    return MRT_RegisterItemCostHandlerCore(functionToCall, addonName);
end


--- Unregister a previously registered item cost handler
-- @name MRT_UnregisterItemCostHandler
-- @param registeredFunction The function, which shall be unregistered
-- @return boolean - indicates if the unregistration of the function was successful
-- @usage unregistrationSuccess = MRT_UnregisterItemCostHandler(registeredFunction);
function MRT_UnregisterItemCostHandler(registeredFunction)
    return MRT_UnregisterItemCostHandlerCore(registeredFunction);
end


--- API for notifying external functions about changes in the loot table. Multiple functions can be registered.
-- @name MRT_RegisterLootNotify
-- @param functionToCall The function, which shall be called, when the loot table changed
-- @return boolean - indicates if the registration of the function was successful
-- @usage -- The function, which should be called, will receive the following variables:
-- functionToCall(itemInfoTable, source, raidNumber, itemNumber, oldItemInfoTable)
-- -- itemInfoTable: A copy of the corresponding loot information from the MRT_RaidLog table
-- --                Additionally a key "Action" with a MRT_LOOTACTION-value
-- --                see http://wow.curseforge.com/addons/mizusraidtracker/pages/api/variables-and-tables/ for more information
-- -- source: Indicates, what user action was the cause for calling the function. There are currently fives values defined:
-- --         MRT_NOTIFYSOURCE_ADD_POPUP  = Item was tracked automatically and the user entered his/her data into the loot popup (function will be called, after data from the loot popup has been processed)
-- --         MRT_NOTIFYSOURCE_ADD_SILENT = Item was tracked automatically, without any user interaction. This may happen, if the loot popup was turned off by the user or if an other addon handles the item costs.
-- --         MRT_NOTIFYSOURCE_ADD_GUI    = Item was added manually via the main UI
-- --         MRT_NOTIFYSOURCE_EDIT_GUI   = Item was modified manually via the main UI
-- --         MRT_NOTIFYSOURCE_DELETE_GUI = Item was deleted manually via the main UI
-- -- raidNumber: The raidNumber, for which this item is saved.
-- -- itemNumber: The itemNumber of this item in its specific raid.
-- -- oldItemInfoTable: If the source was MRT_NOTIFYSOURCE_EDIT_GUI, then this will be a copy of the corresponding loot information from the MRT_RaidLog before it was modified
-- --                   otherwise nil
-- @usage -- A simple information function, which displays item information, when an item was added using the main UI:
-- function MRT_LootNotify(itemInfoTable, source, raidNum, itemNum, oldItemInfoTable)
--     if (source == MRT_NOTIFYSOURCE_ADD_GUI) then 
--         MRT_Print("LootNotify! Item is "..itemInfoTable["ItemLink"].." - Source is "..tostring(source).." - raidNum/itemnum: "..tostring(raidNum).."/"..tostring(itemNum));
--     end
-- end
-- 
-- local registrationSuccess = MRT_RegisterLootNotify(MRT_LootNotify);
-- if (registrationSuccess) then
--     MRT_Print("LootNotify registration was a success!");
-- end
function MRT_RegisterLootNotify(functionToCall)
    local registerStatusCore = MRT_RegisterLootNotifyCore(functionToCall);
    local registerStatusGUI = MRT_RegisterLootNotifyGUI(functionToCall);
    return (registerStatusCore or registerStatusGUI);
end


--- Unregister a previously registered loot notify function
-- @name MRT_UnregisterLootNotify
-- @param registeredFunction The function, which shall be unregistered
-- @return boolean - indicates if the unregistration of the function was successful
-- @usage unregistrationSuccess = MRT_UnregisterLootNotify(registeredFunction);
function MRT_UnregisterLootNotify(registeredFunction)
    local unregisterStatusCore = MRT_UnregisterLootNotifyCore(registeredFunction);
    local unregisterStatusGUI = MRT_UnregisterLootNotifyGUI(registeredFunction);
    return (unregisterStatusCore or unregisterStatusGUI);
end



--[[
-- examples:
function MRT_LootNotify(itemInfoTable, source, raidNum, itemNum, oldItemInfoTable)
    MRT_Print("LootNotify! Item is "..itemInfoTable["ItemLink"].." - Source is "..tostring(source).." - raidNum/itemnum: "..tostring(raidNum).."/"..tostring(itemNum));
    MRT_Print("ItemAction is: "..itemInfoTable.Action);
end
local registrationSuccess = MRT_RegisterLootNotify(MRT_LootNotify);
if registrationSuccess then
    MRT_Print("LootNotify registration was a success!");
end


function MRT_ItemCostHandlerExample(itemInfo)
    return 42, itemInfo.Looter, "Example ItemNote", MRT_LOOTACTION_BANK, nil;
end
local registrationSuccess = MRT_RegisterItemCostHandler(MRT_ItemCostHandlerExample, "MRT TestSuite");
if registrationSuccess then
    MRT_Print("ItemCostHandler registration was a success!");
end
--]]
