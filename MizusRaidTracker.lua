-- ********************************************************
-- **              Mizus RaidTracker - Core              **
-- **            <ENTER URL HERE>            **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010)
--
-- The localizations are written by:
--    * enGB/enUS: Mizukichan
--    * deDE: Mizukichan
--
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



-------------------------------
--  Globals/Default Options  --
-------------------------------
MRT_ADDON_TITLE = GetAddOnMetadata("MizusRaidTracker", "Title");
MRT_ADDON_VERSION = GetAddOnMetadata("MizusRaidTracker", "Version");
MRT_Options = {};
MRT_RaidLog = {};

SLASH_MIZUSRAIDTRACKER1 = "/mrt";
SlashCmdList["MIZUSRAIDTRACKER"] = function(msg) MRT_SlashCmdHandler(msg); end

local MRT_Defaults = {
    ["Options"] = {
        ["General_MasterEnable"] = true,                                            -- AddonEnable: true / nil
        ["General_Version"] = GetAddOnMetadata("MizusRaidTracker", "Version"),      -- 
        ["General_DebugEnabled"] = nil,                                             --
        ["Attendance_GuildAttendanceCheckEnabled"] = true,                          -- NYI!
        ["Attendance_GuildAttendanceCheckDuration"] = 3,                            -- in minutes - 0..5
        ["Tracking_Log10MenRaids"] = nil,                                           -- in use
        ["Tracking_LogAVRaids"] = nil,                                              -- NYI! Track Archavons Vault
        ["Tracking_AskForDKPValue"] = true,                                         -- 
        ["Tracking_MinItemQualityToLog"] = 4,                                       -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_MinItemQualityToGetDKPValue"] = 4,                               -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
    },
};


--------------
--  Locals  --
--------------
local deformat = LibStub("LibDeformat-3.0");
local tinsert = tinsert;

local MRT_GuildRoster = {};
local MRT_GuildRosterInitialUpdateDone = nil;
local MRT_GuildRosterUpdating = nil;
local MRT_NumOfCurrentRaid = nil;
local MRT_NumOfLastBoss = nil;
local MRT_AskCostQueue = {};
local MRT_AskCostQueueRunning = nil;


-------------------
--  Initilazing  --
-------------------
function MRT_MainFrame_OnLoad(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("CHAT_MSG_LOOT");
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    frame:RegisterEvent("GUILD_ROSTER_UPDATE");
    frame:RegisterEvent("RAID_INSTANCE_WELCOME");
    frame:RegisterEvent("RAID_ROSTER_UPDATE");
    frame:RegisterEvent("VARIABLES_LOADED");
end


-------------------------
--  Handler functions  --
-------------------------
-- Event handler
function MRT_OnEvent(frame, event, ...)
    if (event == "ADDON_LOADED") then
        frame:UnregisterEvent("ADDON_LOADED");
        MRT_Options_ParseValues();
        MRT_GUI_ParseValues();
        MRT_Core_Frames_ParseLocal();
        GuildRoster();
        MRT_Debug("Addon loaded.");
    end
    
    if (event == "CHAT_MSG_LOOT") then 
        if (MRT_NumOfCurrentRaid) then
            MRT_AutoAddLoot(...);
        end
    end
    
    if (event == "CHAT_MSG_MONSTER_YELL") then
        local monsteryell, sourceName = ...;
        if (MRT_L.Bossyells[monsteryell]) then
            MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
            if (MRT_NumOfCurrentRaid) then
                MRT_AddBosskill(MRT_L.Bossyells[monsteryell]);
            end
        end
    end
    
    if (event == "COMBAT_LOG_EVENT_UNFILTERED") then MRT_CombatLogHandler(...); end
    
    if (event == "GUILD_ROSTER_UPDATE") then MRT_GuildRosterUpdate(frame, event, ...); end
    
    if (event == "RAID_INSTANCE_WELCOME") then
        if (not MRT_Options["General_MasterEnable"]) then return end
        -- Use GetInstanceInfo() for informations about the zone! / Track bossdifficulty at bosskill (important for ICC)
        -- local instanceName, resetTimer = ...;
        local instanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
        -- MRT_Debug("RAID_INSTANCE_WELCOME recieved. Instancename is "..instanceName.." and the resettimer is "..tostring(resetTimer));
        -- MRT_Debug("GetInstanceInfo() returns '"..instanceInfoName.."' as name, '"..instanceInfoType.."' as type and '"..MRT_InstanceDifficultyTable[instanceInfoDifficulty].."' as difficulty");
        if (MRT_L.Raidzones[instanceInfoName]) then
            MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty);
        end
    end
    
    if (event == "RAID_ROSTER_UPDATE") then
        MRT_RaidRosterUpdate(frame);
    end
    
    if (event == "VARIABLES_LOADED") then MRT_UpdateSavedOptions(); end
end

-- Combatlog handler
function MRT_CombatLogHandler(...)
    local _, combatEvent, _, _, _, destGUID, destName = ...;
    if (not MRT_NumOfCurrentRaid) then return; end
    if (combatEvent == "UNIT_DIED") then
        local NPCID = MRT_GetNPCID(destGUID);
        -- MRT_Debug("NPC died. - NPCName was "..destName.." and NPCID was "..NPCID);
        if (MRT_BossIDList[NPCID]) then
            MRT_AddBosskill(destName);
        end
    end
end

-- Slashcommand handler
function MRT_SlashCmdHandler(msg)
    if (msg == 'dkpframe') then
        if (MRT_GetDKPValueFrame:IsShown()) then
            MRT_GetDKPValueFrame:Hide();
        else
            MRT_GetDKPValueFrame:Show();
        end
    end
    -- FIXME - shamelessly borrowing the Export-Frame of CTRT for testing
    if (msg == 'extest') then
        URLFrameEditBox:SetText(MRT_CreateCtrtDkpString(27, nil, nil));
        URLFrameEditBox:HighlightText();
        URLFrame:Show();
    end
    if (msg == '') then
        MRT_GUI_Toggle();
    end
end

----------------------
--  Apply Defaults  --
----------------------
-- Check variables - if missing, load defaults
function MRT_UpdateSavedOptions()
    for key, value in pairs(MRT_Defaults["Options"]) do
        if (MRT_Options[key] == nil) then
            MRT_Options[key] = value;
        end
    end
end


-------------------------------------
--  basic raid tracking functions  --
-------------------------------------
function MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty)
    -- Create a new raidentry if MRT_L.Raidzones match and MRT enabled and: 
    --  I) If no active raid and 10 player tracking enabled
    --  if 10 player tracking disabled, check for 25 player
    --  II) If changed from 10 men to 25 men
    --  III) If changed from 25 men to 10 men (if 10men enabled - else close raid)
    --  IV) If RaidZone changed
    MRT_Debug("Match in MRT_L.Raidzones from GetInstanceInfo() fround.");
    -- Case: No active raidtracking:
    if (not MRT_NumOfCurrentRaid) then
        if (MRT_Options["Tracking_Log10MenRaids"] and (instanceInfoDifficulty == 1 or instanceInfoDifficulty == 3)) then 
            MRT_Debug("Start tracking a new 10 player raid...");
            MRT_CreateNewRaid(instanceInfoName, 10);
        elseif (instanceInfoDifficulty == 2 or instanceInfoDifficulty == 4) then
            MRT_Debug("Start tracking a new 25 player raid...");
            MRT_CreateNewRaid(instanceInfoName, 25);
        end
    -- Case: There is an active raid - no zone change
    elseif (MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidZone"] == instanceInfoName) then
        MRT_Debug("Active raid in same zone found...");
        -- Case: Active Raid is a 10 player raid -> 10 player raids tracking enabled
        if (MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"] == 10) then
            -- Case: same size as active raid
            if (instanceInfoDifficulty == 1 or instanceInfoDifficulty == 3) then 
                MRT_Debug("Nothing changed... CurrentRaid == ActiveRaid");
                return;
            -- Case: different size as active raid
            else
                MRT_Debug("Raidsize changed to 25 - creating new raid...");
                MRT_CreateNewRaid(instanceInfoName, 25);
            end
        -- Case: Active Raid is a 25 player raid
        elseif (MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"] == 25) then
            -- Case: same size as active raid
            if (instanceInfoDifficulty == 2 or instanceInfoDifficulty == 4) then 
                MRT_Debug("Nothing changed... CurrentRaid == ActiveRaid");
                return;
            -- Case: different size as active raid
            elseif (MRT_Options["Tracking_Log10MenRaids"]) then 
                MRT_Debug("Raidsize changed to 10 - creating new raid...");
                MRT_CreateNewRaid(instanceInfoName, 10);
            else
                MRT_Debug("Raidsize changed to 10, but 10 player tracking disabled - ending active raid...")
                MRT_EndActiveRaid();
            end
        end
    -- Case: There is an active raid and a zone change
    else
        MRT_Debug("Active raid in different zone found...");
        if (instanceInfoDifficulty == 2 or instanceInfoDifficulty == 4) then MRT_CreateNewRaid(instanceInfoName, 25);
        elseif (MRT_Options["Tracking_Log10MenRaids"]) then MRT_CreateNewRaid(instanceInfoName, 10);
        else MRT_EndActiveRaid();
        end
    end
end

function MRT_CreateNewRaid(zoneName, raidSize)
    if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
    local numRaidMembers = GetNumRaidMembers();
    if (numRaidMembers == 0) then return end
    MRT_Debug("Creating new raid... - RaidZone is "..zoneName.." and RaidSize is "..tostring(raidSize));
    local MRT_RaidInfo = {["Players"] = {}, ["Bosskills"] = {}, ["Loot"] = {}, ["RaidZone"] = zoneName, ["RaidSize"] = raidSize, ["Realm"] = GetRealmName(), ["StartTime"] = time()};
    MRT_Debug(tostring(numRaidMembers).." raidmembers found. Processing RaidRoster...");
    for i = 1, numRaidMembers do
        local playerName, _, _, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        local UnitID = "raid"..tostring(i);
        local playerRaceL, playerRace = UnitRace(UnitID);
        local playerSex = UnitSex(UnitID);
        MRT_RaidInfo["Players"][playerName] = {
            ["Name"] = playerName,
            ["Join"] = time(),
            ["Leave"] = nil,
            ["Race"] = playerRace,
            ["RaceL"] = playerRaceL,
            ["Class"] = playerClass,
            ["ClassL"] = playerClassL,
            ["Level"] = playerLvl,
            ["Sex"] = playerSex,
        }
    end
    tinsert(MRT_RaidLog, MRT_RaidInfo);
    MRT_NumOfCurrentRaid = #MRT_RaidLog;
end

function MRT_RaidRosterUpdate(frame)
    if (not MRT_NumOfCurrentRaid) then return; end
    if (GetNumRaidMembers() == 0) then 
        MRT_EndActiveRaid();
        return;
    end
    local numRaidMembers = GetNumRaidMembers();
    local activePlayerList = {};
    --MRT_Debug("RaidRosterUpdate: Processing RaidRoster");
    --MRT_Debug(tostring(numRaidMembers).." raidmembers found.");
    for i = 1, numRaidMembers do
        local playerName, _, _, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        tinsert(activePlayerList, playerName);
        if (not MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][playerName]) then
            MRT_Debug("New player found: "..playerName);
            local UnitID = "raid"..tostring(i);
            local playerRaceL, playerRace = UnitRace(UnitID);
            local playerSex = UnitSex(UnitID);
            MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][playerName] = {
                ["Name"] = playerName,
                ["Join"] = time(),
                ["Leave"] = nil,
                ["Race"] = playerRace,
                ["RaceL"] = playerRaceL,
                ["Class"] = playerClass,
                ["ClassL"] = playerClassL,
                ["Level"] = playerLvl,
                ["Sex"] = playerSex,
            };
        else
            MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][playerName]["Leave"] = nil;
        end    
    end
    -- MRT_Debug("RaidRosterUpdate: Checking for leaving players...");
    for savedPlayer, values in pairs (MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
        local matchFound = nil;
        for index, activePlayer in ipairs (activePlayerList) do
            if (savedPlayer == activePlayer) then 
                matchFound = true; 
            end
        end
        if (not matchFound) then
            if (not MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][savedPlayer]["Leave"]) then
                MRT_Debug("Leaving player found: "..savedPlayer);
                MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][savedPlayer]["Leave"] = time();
            end
        end
    end
end

function MRT_AddBosskill(bossname)
    if (not MRT_NumOfCurrentRaid) then return; end
    MRT_Debug("Adding bosskill to RaidLog[] - tracked boss: "..bossname);
    local _, _, instanceDifficulty, _, _, dynDiff, isDyn = GetInstanceInfo();
    if (isDyn) then instanceDifficulty = instanceDifficulty + (2 * dynDiff); end;
    local trackedPlayers = {};
    local numRaidMembers = GetNumRaidMembers();
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, _, _, _, _, playerOnline = GetRaidRosterInfo(i);
        tinsert(trackedPlayers, playerName);
    end
    local MRT_BossKillInfo = {
        ["Players"] = trackedPlayers,
        ["Name"] = bossname,
        ["Date"] = time(),
        ["Difficulty"] = instanceDifficulty,
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"], MRT_BossKillInfo);
    MRT_NumOfLastBoss = #MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"];
end

function MRT_EndActiveRaid()
    if (not MRT_NumOfCurrentRaid) then return; end
    MRT_Debug("Ending active raid...");
    for key, value in pairs (MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
        if (not MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"]) then
            MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"] = time();
        end
    end
    MRT_NumOfCurrentRaid = nil;
    MRT_NumOfLastBoss = nil;
end


-------------------------------
--  loot tracking functions  --
-------------------------------
-- track loot based on chatmessage recognized by event CHAT_MSG_LOOT
function MRT_AutoAddLoot(chatmsg)
    -- MRT_Debug("Lootevent recieved. Processing...");
    -- patten LOOT_ITEM / LOOT_ITEM_SELF are also valid for LOOT_ITEM_MULTIPLE / LOOT_ITEM_SELF_MULTIPLE - but not the other way around - try these first
    -- first try: somebody else recieved multiple loot (most parameters)
    local playerName, itemLink, itemCount = deformat(chatmsg, LOOT_ITEM_MULTIPLE);
    -- next try: somebody else recieved single loot
    if (playerName == nil) then
        itemCount = 1;
        playerName, itemLink = deformat(chatmsg, LOOT_ITEM);
    end
    -- if player == nil, then next try: player recieved multiple loot
    if (playerName == nil) then
        playerName = UnitName("player");
        itemLink, itemCount = deformat(chatmsg, LOOT_ITEM_SELF_MULTIPLE);
    end
    -- if itemLink == nil, then last try: player recieved single loot
    if (itemLink == nil) then
        itemCount = 1;
        itemLink = deformat(chatmsg, LOOT_ITEM_SELF);
    end
    -- if itemLink == nil, then there was neither a LOOT_ITEM, nor a LOOT_ITEM_SELF message
    if (itemLink == nil) then 
        -- MRT_Debug("No valid lootevent recieved."); 
        return; 
    end
    -- if code reach this point, we should have a valid looter and a valid itemLink
    MRT_Debug("Item looted - Looter is "..playerName.." and loot is "..itemLink);
    -- example itemLink: |cff9d9d9d|Hitem:7073:0:0:0:0:0:0:0|h[Broken Fang]|h|r
    -- strip the itemlink into its parts / may change to use deformat with easier pattern ("|c%s|H%s|h[%s]|h|r")
    local _, _, itemString = string.find(itemLink, "^|c%x+|H(.+)|h%[.*%]");
    local _, _, itemColor, _, itemId, _, _, _, _, _, _, _, _, itemName = string.find(itemLink, "|?c?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
    -- make the string a number
    itemId = tonumber(itemId);
    -- if major fuckup in first strip:
    -- if (itemString == nil) then MRT_Debug("ItemLink corrupted - no ItemString found."); return; end
    -- if major fuckup in second strip:
    -- if (itemId == nil) then MRT_Debug("ItemLink corrupted - no ItemId found."); return; end
    -- check options, if this item should be tracked
    if (MRT_Options["Tracking_MinItemQualityToLog"] > MRT_ItemColorValues[itemColor]) then MRT_Debug("Item not tracked - quality is too low."); return; end
    if (MRT_IgnoredItemIDList[itemId]) then return; end
    -- Quick&Dirty for Trashdrops
    if (MRT_NumOfLastBoss == nil) then 
        MRT_AddBosskill("_TrashMobLoot_");
    end
    -- if code reach this point, we should have valid item information, an active raid and at least one bosskill entry - make a table!
    -- Note: If a CT-Raidtracker-compatible export need more iteminfo, check GetItemInfo() for more data
    local MRT_LootInfo = {
        ["ItemLink"] = itemLink,
        ["ItemString"] = itemString,
        ["ItemId"] = itemId,
        ["ItemName"] = itemName,
        ["ItemColor"] = itemColor,
        ["ItemCount"] = itemCount,
        ["Looter"] = playerName,
        ["DKPValue"] = 0,
        ["BossNumber"] = MRT_NumOfLastBoss,
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"], MRT_LootInfo);
    if (not MRT_Options["Tracking_AskForDKPValue"]) then return; end
    if (MRT_Options["Tracking_MinItemQualityToGetDKPValue"] > MRT_ItemColorValues[itemColor]) then return; end
    MRT_DKPFrame_AddToItemCostQueue(MRT_NumOfCurrentRaid, #MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"]);
end

-- track loot based on slashcommand (maybe via GUI dialog in future release) 
function MRT_ManuallyAddLoot(playerName, dkpValue, itemLink)
end


---------------------------
--  loot cost functions  --
---------------------------
-- basic idea: add looted items to a little queue and ask cost for each item in the queue 
--             this should avoid missing dialogs for fast looted items
-- note: standard dkpvalue is already 0
function MRT_DKPFrame_AddToItemCostQueue(raidnum, itemnum)
    local MRT_DKPCostQueueItem = {
        ["RaidNum"] = raidnum,
        ["ItemNum"] = itemnum,
    }
    tinsert(MRT_AskCostQueue, MRT_DKPCostQueueItem);
    if (MRT_AskCostQueueRunning) then return; end
    MRT_AskCostQueueRunning = true;
    MRT_DKPFrame_AskCost();
end

-- process first queue entry
function MRT_DKPFrame_AskCost()
    -- if there are no entries in the queue, then return
    if (#MRT_AskCostQueue == 0) then
        MRT_AskCostQueueRunning = nil;
        return; 
    end
    -- else format text and show "Enter Cost" frame
    MRT_GetDKPValueFrame_Text:SetText(string.format(MRT_L.Core["DKP_Frame_Text"], MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["ItemLink"], MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"]));
    MRT_GetDKPValueFrame_EB:SetText("");
    MRT_GetDKPValueFrame:Show();
end

-- Case Ok: Save DKP-Value - Treat no input as zero
function MRT_DKPFrame_Ok()
    MRT_Debug("DKPFrame: OK pressed");
    local dkpValue = nil;
    if (MRT_GetDKPValueFrame_EB:GetText() == "") then
        dkpValue = 0;
    else
        dkpValue = tonumber(MRT_GetDKPValueFrame_EB:GetText(), 10);
    end
    if (dkpValue == nil) then return; end
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["DKPValue"] = dkpValue;
    MRT_DKPFrame_PostAskQueue();
end

-- Case Cancel: Set DKP-Value = 0
function MRT_DKPFrame_Cancel()
    MRT_Debug("DKPFrame: Cancel pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_DKPFrame_PostAskQueue();
end

-- Case Delete: Set DKP-Value = 0, set Looter = _deleted_
function MRT_DKPFrame_Delete()
    MRT_Debug("DKPFrame: Delete pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"] = "_deleted_";
    MRT_DKPFrame_PostAskQueue();
end

-- Case Bank: Set DKP-Value = 0, set Looter = _bank_
function MRT_DKPFrame_Bank()
    MRT_Debug("DKPFrame: Bank pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"] = "_bank_";
    MRT_DKPFrame_PostAskQueue();
end

-- Case Disenchanted: Set DKP-Value = 0, set Looter = _disenchanted_
function MRT_DKPFrame_Disenchanted()
    MRT_Debug("DKPFrame: Disenchanted pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"] = "_disenchanted_";
    MRT_DKPFrame_PostAskQueue();
end

-- delete processed entry - if there are still items in the queue, process the next item
function MRT_DKPFrame_PostAskQueue()
    table.remove(MRT_AskCostQueue, 1);
    if (#MRT_AskCostQueue == 0) then
        MRT_AskCostQueueRunning = nil;
    else
        MRT_DKPFrame_AskCost();
    end    
end


----------------------------
--  attendance functions  --
----------------------------
-- Create a table with names of guild members
function MRT_GuildRosterUpdate(frame, event, ...)
    local GuildRosterChanged = ...;
    if (MRT_GuildRosterInitialUpdateDone and not GuildRosterChanged) then return end;
    if (MRT_GuildRosterUpdating) then return end;
    MRT_GuildRosterInitialUpdateDone = true;
    MRT_GuildRosterUpdating = true;
    MRT_Debug("Processing GuildRoster...");
    if (frame:IsEventRegistered("GUILD_ROSTER_UPDATE")) then
        frame:UnregisterEvent("GUILD_ROSTER_UPDATE");
    end
    local guildRosterOfflineFilter = GetGuildRosterShowOffline();
    local guildRosterSelection = GetGuildRosterSelection();
    SetGuildRosterShowOffline(true);
    local numGuildMembers = GetNumGuildMembers();
    for i = 1, numGuildMembers do
        local charName = GetGuildRosterInfo(i);
        if (charName) then
            MRT_GuildRoster[string.lower(charName)] = charName;
        end
    end
    SetGuildRosterShowOffline(guildRosterOfflineFilter);
    SetGuildRosterSelection(guildRosterSelection);
    MRT_GuildRosterUpdating = nil;
    frame:RegisterEvent("GUILD_ROSTER_UPDATE");
end


------------------------
--  helper functions  --
------------------------
function MRT_Debug(text)
    if (MRT_Options["General_DebugEnabled"]) then
        DEFAULT_CHAT_FRAME:AddMessage("MRT v."..MRT_ADDON_VERSION.." Debug: "..text, 1, 0.5, 0);
    end
end

function MRT_Print(text)
    DEFAULT_CHAT_FRAME:AddMessage("MRT: "..text, 1, 0.5, 0);
end

-- Parse static local strings
function MRT_Core_Frames_ParseLocal()
    MRT_GetDKPValueFrame_Title:SetText("MRT - "..MRT_L.Core["DKP_Frame_Title"]);
    MRT_GetDKPValueFrame_Text:SetText(MRT_L.Core["DKP_Frame_Text"]);
    MRT_GetDKPValueFrame_OKButton:SetText(MRT_L.Core["DKP_Frame_OK_Button"]);
    MRT_GetDKPValueFrame_CancelButton:SetText(MRT_L.Core["DKP_Frame_Cancel_Button"]);
    MRT_GetDKPValueFrame_DeleteButton:SetText(MRT_L.Core["DKP_Frame_Delete_Button"]);
    MRT_GetDKPValueFrame_BankButton:SetText(MRT_L.Core["DKP_Frame_Bank_Button"]);
    MRT_GetDKPValueFrame_DisenchantedButton:SetText(MRT_L.Core["DKP_Frame_Disenchanted_Button"]);
end

-- GetNPCID - returns the NPCID or nil, if GUID was no NPC
function MRT_GetNPCID(GUID)
    local first3 = tonumber("0x"..strsub(GUID, 3, 5));
    local unitType = bit.band(first3, 0x007);
    if ((unitType == 0x003) or (unitType == 0x005)) then
        return tonumber("0x"..strsub(GUID, 9, 12));
    else
        return nil;
    end
end

function MRT_MakeEQDKP_Time(timestamp)
    return date("%c", timestamp)
end


------------------------
--  export functions  --
------------------------
-- create CTRT-like DKP-String for the EQDKP CTRT-Import-Plugin
-- arg usage: (int, nil, nil) = export complete raid
--            (int, int, nil) = export one boss
--            (int, nil, <H, N>) = export all hard-/normalmode events
--            (int, int, <H, N>) = -> will be treated as (int, int, nil)
function MRT_CreateCtrtDkpString(raidID, bossID, difficulty)
    -- basic "catch bad args" routines
    -- check if bad raidID
    if (MRT_RaidLog[raidID] == nil) then return end;
    -- check if bad bossID
    if (bossID ~= nil) then
        if (MRT_RaidLog[raidID]["Bosskills"][bossID] == nil) then return end;
    end
    -- check if bad difficulty-setting
    if ((difficulty ~= nil) and (difficulty ~= "H") and (difficulty ~= "N")) then return end;
    -- start creating xml-data!
    local index = 1;
    local xml = "<RaidInfo>";
    xml = xml.."<key>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StartTime"]).."</key>";
    if (MRT_RaidLog[raidID]["Realm"]) then
        xml = xml.."<realm>"..MRT_RaidLog[raidID]["Realm"].."</realm>";
    end
    xml = xml.."<start>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StartTime"]).."</start>";
    if (MRT_RaidLog[raidID]["StopTime"]) then
        xml = xml.."<end>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StopTime"]).."</end>";
    end
    xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    xml = xml.."<PlayerInfos>";
    index = 1;
    for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
        xml = xml.."<key"..index..">";
        xml = xml.."<name>"..key.."</name>";
        xml = xml.."<race>"..val["Race"].."</race>";
        xml = xml.."<sex>"..val["Sex"].."</sex>";
        xml = xml.."<class>"..val["Class"].."</class>";
        xml = xml.."<level>"..val["Level"].."</level>";
        xml = xml.."</key"..index..">";
        index = index + 1;
    end
    xml = xml.."</PlayerInfos>";
    if (MRT_RaidLog[raidID]["Bosskills"]) then
        if ((bossID == nil) and (difficulty == nil)) then
            xml = xml.."<BossKills>";
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                xml = xml.."<key"..idx..">";
                xml = xml.."<name>"..val["Name"].."</name>";
                xml = xml.."<difficulty>"..val["Difficulty"].."</difficulty>";
                xml = xml.."<time>"..MRT_MakeEQDKP_Time(val["Date"]).."</time>";
                xml = xml.."<attendees>";
                for idx2, val2 in pairs(val["Players"]) do
                    xml = xml.."<key"..idx2.."><name>"..val2.."</name></key"..idx2..">";
                end
                xml = xml.."</attendees>";
                xml = xml.."</key"..idx..">";
            end
            xml = xml.."</BossKills>";
        elseif (bossID) then
            xml = xml.."<BossKills><key1>";
            xml = xml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
            xml = xml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
            xml = xml.."<time>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"]).."</time>";
            xml = xml.."<attendees>";
            for idx, val in pairs(MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"]) do
                xml = xml.."<key"..idx.."><name>"..val.."</name></key"..idx..">";
            end
            xml = xml.."</attendees></key1></BossKills>";
        else
            -- FIXME! Do stuff for export of a specific difficulty
        end
    end
    xml = xml.."<note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].."]]></note>";
    index = 1;
    xml = xml.."<Join>";
    for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
        xml = xml.."<key"..index..">";
        xml = xml.."<player>"..key.."</player>";
        xml = xml.."<race>"..val["Race"].."</race>";
        xml = xml.."<class>"..val["Class"].."</class>";
        xml = xml.."<sex>"..val["Sex"].."</sex>";
        xml = xml.."<level>"..val["Level"].."</level>";
        xml = xml.."<time>"..MRT_MakeEQDKP_Time(val["Join"]).."</time>";
        xml = xml.."</key"..index..">";
        index = index + 1;
    end
    xml = xml.."</Join>";
    xml = xml.."<Leave>";
    index = 1;
    for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
        xml = xml.."<key"..index..">";
        xml = xml.."<player>"..key.."</player>";
        xml = xml.."<time>"..MRT_MakeEQDKP_Time(val["Leave"]).."</time>";
        xml = xml.."</key"..index..">";
        index = index + 1;
    end
    xml = xml.."</Leave>";
    xml = xml.."<Loot>";
    index = 1;
    for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if ((bossID == nil) or (val["BossNumber"] == bossID)) then
            xml = xml.."<key"..index..">";
            xml = xml.."<ItemName>"..val["ItemName"].."</ItemName>";
            local itemIdLong = deformat(val["ItemString"], "item:%s");
            xml = xml.."<ItemID>"..itemIdLong.."</ItemID>";
            xml = xml.."<Color>"..val["ItemColor"].."</Color>";
            xml = xml.."<Count>1</Count>";
            xml = xml.."<Player>"..val["Looter"].."</Player>";
            xml = xml.."<Costs>"..val["DKPValue"].."</Costs>";
            xml = xml.."<Time>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Date"]).."</Time>";
            xml = xml.."<Difficulty>"..MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Difficulty"].."</Difficulty>";
            xml = xml.."<Boss>"..MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Name"].."</Boss>";
            xml = xml.."<Note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].." - Boss: "..MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Name"].." - "..val["DKPValue"].." DKP]]></Note>";
            xml = xml.."</key"..index..">";
            index = index + 1;
        end
    end
    xml = xml.."</Loot>";
    xml = xml.."</RaidInfo>";
    return xml;
end
