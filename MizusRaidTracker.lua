-- *********************************************************
-- **              Mizus Raid Tracker - Core              **
-- **            <ENTER URL HERE>            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall
--
-- The localizations are written by:
--    * enGB/enUS: Mizukichan
--    * deDE: Mizukichan
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--


-------------------------------
--  Globals/Default Options  --
-------------------------------
MRT_ADDON_TITLE = GetAddOnMetadata("MizusRaidTracker", "Title");
MRT_ADDON_VERSION = GetAddOnMetadata("MizusRaidTracker", "Version");
MRT_Options = {};
MRT_RaidLog = {};

local MRT_Defaults = {
    ["Options"] = {
        ["General_MasterEnable"] = true,                                            -- AddonEnable: true/false
        ["General_Version"] = GetAddOnMetadata("MizusRaidTracker", "Version"),      -- 
        ["General_DebugEnabled"] = true,                                            --
        ["Attendance_GuildAttendanceCheckEnabled"] = true,                          -- 
        ["Attendance_GuildAttendanceCheckDuration"] = 3,                            -- in minutes - 0..5
        ["Tracking_AutoCreateRaid"] = true,                                         --
        ["Tracking_Log10MenRaids"] = true,                                          --
        ["Tracking_AskForDKPValue"] = true,                                         -- 
        ["Tracking_MinItemQualityToLog"] = 3,                                       -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_MinItemQualityToGetDKPValue"] = 4,                               -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_OnlyTrackInRaidDungeons"] = true,                                -- Currently not used
        ["Tracking_UseDefaultItemIgnoreList"] = true,                               -- Currently not used
    },
};

--------------
--  Locals  --
--------------
local MRT_GuildRoster = {};
local MRT_GuildRosterInitialUpdateDone = nil;
local MRT_GuildRosterUpdating = nil;
local MRT_NumOfCurrentRaid = nil;


-------------------
--  Initilazing  --
-------------------
function MRT_MainFrame_OnLoad(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    frame:RegisterEvent("CHAT_MSG_LOOT");
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    frame:RegisterEvent("GUILD_ROSTER_UPDATE");
    frame:RegisterEvent("RAID_INSTANCE_WELCOME");
    frame:RegisterEvent("RAID_ROSTER_UPDATE");
    frame:RegisterEvent("VARIABLES_LOADED");
end


-------------------------
--  Handler functions  --
-------------------------
-- Eventhandler
function MRT_OnEvent(frame, event, ...)
    if (event == "ADDON_LOADED") then
        frame:UnregisterEvent("ADDON_LOADED");
        MRT_Options_ParseValues();
        GuildRoster();
        MRT_Debug("Addon loaded.");
    end
    
    if (event == "CHAT_MSG_MONSTER_YELL") then
        local monsteryell, sourceName = ...;
        if (MRT_L.Bossyells[monsteryell]) then
            MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
        end
    end
    
    if (event == "COMBAT_LOG_EVENT_UNFILTERED") then MRT_CombatLogHandler(...); end
    
    if (event == "GUILD_ROSTER_UPDATE") then MRT_GuildRosterUpdate(frame, event, ...); end
    
    if (event == "RAID_INSTANCE_WELCOME") then
        -- Use GetInstanceInfo() for informations about the zone! / Track bossdifficulty at bosskill (important for ICC)
        local instanceName, resetTimer = ...;
        local instanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
        MRT_Debug("RAID_INSTANCE_WELCOME recieved. Instancename is "..instanceName.." and the resettimer is "..tostring(resetTimer));
        MRT_Debug("GetInstanceInfo() returns '"..instanceInfoName.."' as name, '"..instanceInfoType.."' as type and '"..MRT_InstanceDifficultyTable[instanceInfoDifficulty].."' as difficulty");
        -- End of debugcode
        -- Create a new raidentry if MRT_L.Raidzones match and MRT enabled and: 
        --  I) If no active raid and 10 player tracking enabled
        --  if 10 player tracking disabled, check for 25 player
        --  II) If changed from 10 men to 25 men
        --  III) If changed from 25 men to 10 men (if 10men enabled - else close raid)
        --  IV) If RaidZone changed
        if (MRT_L.Raidzones[instanceInfoName] and MRT_Options["General_MasterEnable"]) then
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
    end
    
    if (event == "RAID_ROSTER_UPDATE") then
        MRT_RaidRosterUpdate();
    end
    
    if (event == "VARIABLES_LOADED") then MRT_UpdateSavedOptions(); end
end

-- Combatloghandler
function MRT_CombatLogHandler(...)
    local _, combatEvent, _, _, _, destGUID, destName = ...;
    if (combatEvent == "UNIT_DIED") then
        local NPCID = MRT_GetNPCID(destGUID);
        if (MRT_BossIDList[NPCID]) then
            MRT_Debug("NPC from Bosslist died. - NPCName was "..destName.." and NPCID was "..NPCID);
        end
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


function MRT_Debug(text)
    if (MRT_Options["General_DebugEnabled"]) then
        DEFAULT_CHAT_FRAME:AddMessage("MRT v."..MRT_ADDON_VERSION.." Debug: "..text, 1, 0.5, 0);
    end
end


--------------------------
--  Tracking functions  --
--------------------------
function MRT_CreateNewRaid(zoneName, raidSize)
    if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
    MRT_Debug("Creating new raid... - RaidZone is "..zoneName.." and RaidSize is "..tostring(raidSize));
    local MRT_RaidInfo = {["Players"] = {}, ["RaidZone"] = zoneName, ["RaidSize"] = raidSize, ["StartTime"] = time()};
    local numRaidMembers = GetNumRaidMembers();
    MRT_Debug(tostring(numRaidMembers).." raidmembers found. Processing RaidRoster...");
    for i = 1, numRaidMembers do
        local UnitID = "raid"..tostring(i);
        local playerName, _, _, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
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
    table.insert(MRT_RaidLog, MRT_RaidInfo);
    MRT_NumOfCurrentRaid = #MRT_RaidLog;
end


function MRT_RaidRosterUpdate()
    if (not MRT_NumOfCurrentRaid) then return; end
    if (not UnitInRaid("player")) then MRT_EndActiveRaid(); end
end


function MRT_EndActiveRaid()
    if (not MRT_NumOfCurrentRaid) then return; end
    MRT_Debug("Ending active raid...");
    MRT_NumOfCurrentRaid = nil;
end


----------------------------
--  Attendance functions  --
----------------------------
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
--  Helper functions  --
------------------------
-- GetNPCID - returns the NPCID or nil, if GUID was no NPC
function MRT_GetNPCID(GUID)
    local first3 = tonumber("0x"..strsub(GUID, 3, 5));
    local unitType = bit.band(first3, 0x007);
    if (unitType == 0x003) then
        return tonumber("0x"..strsub(GUID, 9, 12));
    else
        return nil;
    end
end

