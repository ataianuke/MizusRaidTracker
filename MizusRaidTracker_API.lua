-- ********************************************************
-- **              Mizus RaidTracker - API               **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010)
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


--- API for handling item costs of newly looted items. The function will only be called, when an item was tracked with the automatic tracking system.
-- It won't be called, if the user has added an item manually. Only one function can be registered at any given time.
-- @name MRT_RegisterItemCostHandler(functionToCall, suppressAskCostDialog, addonName)
-- @param functionToCall The function, which shall be called, when a new items has been looted and tracked
-- @param suppressAskCostDialog Boolean - If set to true, it will disable the popup dialog.
-- @param addonName The name of addon which registers one of its functions here. Will be used to inform the user.
-- @return boolean - indicates if the registration of the function was successful
-- @usage -- The function, which should be called, will receive and shall return the following variables
-- cost, looter, itemNote, deleteItem = functionToCall(itemInfoTable)
-- -- param itemInfoTable: A stripped down variant of the loot information from the MRT_RaidLog table
--                         Will include the key 'ItemLink', 'ItemString', 'ItemId', 'ItemName', 'ItemColor', 'ItemCount', 'Looter', 'DKPValue'
-- -- return cost: number - the cost for this item
-- -- return looter: string - the looter for this item, either a name, or 'bank' or 'disenchanted'
-- -- return itemNote: string - an item note for this item
-- -- return deleteItem: boolean - if set to true, the item will not be saved but deleted
-- @usage -- A simple example, which sets the cost to 42 and leaves a loot note
-- function MRT_ItemCostHandlerExample(itemInfo)
--     return 42, itemInfo.Looter, "Example ItemNote", false;
-- end
--
-- local registrationSuccess = MRT_RegisterItemCostHandler(MRT_ItemCostHandlerExample, false, "MRT TestSuite");
-- if registrationSuccess then
--     MRT_Print("ItemCostHandler registration was a success!");
-- end
function MRT_RegisterItemCostHandler(functionToCall, suppressAskCostDialog, addonName)
    return MRT_RegisterItemCostHandlerCore(functionToCall, suppressAskCostDialog, addonName);
end


--- Unregister a previously registered item cost handler
-- @name MRT_UnregisterItemCostHandler(registeredFunction)
-- @param registeredFunction The function, which shall be unregistered
-- @return boolean - indicates if the unregistration of the function was successful
-- @usage unregistrationSuccess = MRT_UnregisterItemCostHandler(registeredFunction);
function MRT_UnregisterItemCostHandler(registeredFunction)
    return MRT_UnregisterItemCostHandlerCore(registeredFunction);
end


--- API for notifying external functions about changes in the loot table. Multiple functions can be registered.
-- @name MRT_RegisterLootNotify(functionToCall)
-- @param functionToCall The function, which shall be called, when the loot table changed
-- @return boolean - indicates if the registration of the function was successful
-- @usage -- The function, which should be called, will receive the following variables:
-- functionToCall(itemInfoTable, source, raidNumber, itemNumber)
-- -- itemInfoTable: A copy of the corresponding loot information from the MRT_RaidLog table
-- --                see http://wow.curseforge.com/addons/mizusraidtracker/pages/api/variables-and-tables/ for more information
-- -- source: Indicates, what user action was the cause for calling the function. There are currently four values defined:
-- --         1 = Item was tracked automatically and the user entered his/her data into the loot popup (function will be called, after data from the loot popup has been processed)
-- --         2 = Item was tracked automatically, without any user interaction. This may happen, if the loot popup was turned off by the user or if an other addon handles the item costs.
-- --         3 = Item was added manually via the main UI
-- --         4 = Item was modified manually via the main UI
-- -- raidNumber: The raidNumber, for which this item is saved.
-- -- itemNumber: The itemNumber of this item in its specific raid.
-- @usage -- A simple information function:
-- function MRT_LootNotify(itemInfoTable, source, raidNum, itemNum)
--     MRT_Print("LootNotify! Item is "..itemInfoTable["ItemLink"].." - Source is "..tostring(source).." - raidNum/itemnum: "..tostring(raidNum).."/"..tostring(itemNum));
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
-- @name MRT_UnregisterLootNotify(registeredFunction)
-- @param functionCalled The function, which shall be unregistered
-- @return boolean - indicates if the unregistration of the function was successful
-- @usage unregistrationSuccess = MRT_UnregisterLootNotify(registeredFunction);
function MRT_UnregisterLootNotify(registeredFunction)
    local unregisterStatusCore = MRT_UnregisterLootNotifyCore(registeredFunction);
    local unregisterStatusGUI = MRT_UnregisterLootNotifyGUI(registeredFunction);
    return (unregisterStatusCore or unregisterStatusGUI);
end



--[[
-- examples:
function MRT_LootNotify(itemInfoTable, source, raidNum, itemNum)
    MRT_Print("LootNotify! Item is "..itemInfoTable["ItemLink"].." - Source is "..tostring(source).." - raidNum/itemnum: "..tostring(raidNum).."/"..tostring(itemNum));
    MRT_Print("Unregistering function now!");
    MRT_UnregisterLootNotify(MRT_LootNotify);
end
local registrationSuccess = MRT_RegisterLootNotify(MRT_LootNotify);
if registrationSuccess then
    MRT_Print("LootNotify registration was a success!");
end


function MRT_ItemCostHandlerExample(itemInfo)
    return 42, itemInfo.Looter, "Example ItemNote", false;
end
local registrationSuccess = MRT_RegisterItemCostHandler(MRT_ItemCostHandlerExample, false, "MRT TestSuite");
if registrationSuccess then
    MRT_Print("ItemCostHandler registration was a success!");
end
]]--
