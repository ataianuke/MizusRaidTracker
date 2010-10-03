-- ********************************************************
-- **              Mizus RaidTracker - Core              **
-- **           <http://nanaki.affenfelsen.de>           **
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
MRT_NumOfCurrentRaid = nil;
MRT_NumOfLastBoss = nil;
MRT_Options = {};
MRT_RaidLog = {};
MRT_PlayerDB = {};

local MRT_Defaults = {
    ["Options"] = {
        ["General_MasterEnable"] = true,                                            -- AddonEnable: true / nil
        ["General_OptionsVersion"] = 2,                                             -- OptionsVersion - Counter, which increases after a new option has been added
        ["General_DebugEnabled"] = nil,                                             --
        ["General_SlashCmdHandler"] = "mrt",                                        --
        ["Attendance_GuildAttendanceCheckEnabled"] = nil,                           -- 
        ["Attendance_GuildAttendanceCheckNoAuto"] = true,                           --
        ["Attendance_GuildAttendanceCheckDuration"] = 3,                            -- in minutes - 0..5
        ["Attendance_GroupRestriction"] = nil,                                      -- if true, track only first 2/5 groups in 10/25 player raids
        ["Attendance_TrackOffline"] = true,                                         -- if true, track offline players
        ["Tracking_Log10MenRaids"] = nil,                                           -- Track 10 player raids: true / nil
        ["Tracking_LogAVRaids"] = nil,                                              -- Track Archavons Vault: true / nil
        ["Tracking_AskForDKPValue"] = true,                                         -- 
        ["Tracking_MinItemQualityToLog"] = 4,                                       -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_MinItemQualityToGetDKPValue"] = 4,                               -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_CreateNewRaidOnNewZone"] = true,
        ["Tracking_UseServerTime"] = nil,
        ["Export_ExportFormat"] = 1,                                                -- 1: CTRT compatible, 2: plain text, 3: BBCode
        ["Export_CTRT_AddPoorItem"] = true,                                         -- Add a poor item as loot to each boss - Fixes encounter detection for CTRT-Import for EQDKP: true / nil
        ["Export_CTRT_IgnorePerBossAttendance"] = nil,                              -- This will create an export where each raid member has 100% attendance: true / nil
        ["Export_DateTimeFormat"] = "%m/%d/%Y",                                     -- lua date syntax - http://www.lua.org/pil/22.1.html
        ["Export_Currency"] = "DKP",
    },
};


--------------
--  Locals  --
--------------
local deformat = LibStub("LibDeformat-3.0");
local tinsert = tinsert;
local pairs = pairs;
local ipairs = ipairs;

local MRT_TimerFrame = CreateFrame("Frame");                -- Timer for Guild-Attendance-Checks
local MRT_LoginTimer = CreateFrame("Frame");                -- Timer for Login (Wait 10 secs after Login - then check Raisstatus)
local MRT_RaidRosterScanTimer = CreateFrame("Frame");       -- Timer for regular scanning for the raid roster (there is no event for disconnecting players)

local MRT_GuildRoster = {};
local MRT_GuildRosterInitialUpdateDone = nil;
local MRT_GuildRosterUpdating = nil;
local MRT_AskCostQueue = {};
local MRT_AskCostQueueRunning = nil;


----------------------
--  RegisterEvents  --
----------------------
function MRT_MainFrame_OnLoad(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("CHAT_MSG_LOOT");
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    frame:RegisterEvent("CHAT_MSG_WHISPER");
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    frame:RegisterEvent("PLAYER_ENTERING_WORLD");
    frame:RegisterEvent("RAID_INSTANCE_WELCOME");
    frame:RegisterEvent("RAID_ROSTER_UPDATE");
end


-------------------------
--  Handler functions  --
-------------------------
-- Event handler
function MRT_OnEvent(frame, event, ...)
    if (event == "ADDON_LOADED") then
        frame:UnregisterEvent("ADDON_LOADED");
        MRT_UpdateSavedOptions();
        MRT_Options_ParseValues();
        MRT_GUI_ParseValues();
        MRT_Core_Frames_ParseLocal();
        SLASH_MIZUSRAIDTRACKER1 = "/"..MRT_Options["General_SlashCmdHandler"];
        SlashCmdList["MIZUSRAIDTRACKER"] = function(msg) MRT_SlashCmdHandler(msg); end
        MRT_Debug("Addon loaded.");
    
    elseif (event == "CHAT_MSG_LOOT") then 
        if (MRT_NumOfCurrentRaid) then
            MRT_AutoAddLoot(...);
        end
    
    elseif (event == "CHAT_MSG_MONSTER_YELL") then
        local monsteryell, sourceName = ...;
        if (MRT_L.Bossyells[monsteryell]) then
            MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
            if (MRT_NumOfCurrentRaid) then
                MRT_AddBosskill(MRT_L.Bossyells[monsteryell]);
            end
        end
    
    elseif (event == "CHAT_MSG_WHISPER") then
        if (MRT_TimerFrame.GARunning) then
            local msg, source = ...;
            MRT_GuildAttendanceWhisper(msg, source);
        end
    
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then 
        MRT_CombatLogHandler(...);
    
    elseif (event == "GUILD_ROSTER_UPDATE") then 
        MRT_GuildRosterUpdate(frame, event, ...);
        
    elseif (event == "PLAYER_ENTERING_WORLD") then
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
        MRT_LoginTimer.loginTime = time();
        -- Delay data gathering a bit to make sure, that data is avaiable after login
        -- aka: Dalaran latency fix
        MRT_LoginTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.loginTime) > 5) then
                self:SetScript("OnUpdate", nil);
                MRT_CheckRaidStatusAfterLogin();
                MRT_GuildRosterUpdate(frame, nil, true)
                MRT_GuildRosterInitialUpdateDone = true;
                MRT_VersionUpdate();
            end
        end);
    
    elseif (event == "RAID_INSTANCE_WELCOME") then
        if (not MRT_Options["General_MasterEnable"]) then return end;
        -- Use GetInstanceInfo() for informations about the zone! / Track bossdifficulty at bosskill (important for ICC)
        local instanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
        if (MRT_L.Raidzones[instanceInfoName]) then
            -- check if recognized raidzone is a pvpraid (-> Archavons Vault) and if tracking is enabled
            if (MRT_PvPRaids[MRT_L.Raidzones[instanceInfoName]] and not MRT_Options["Tracking_LogAVRaids"]) then 
                if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
                return;
            end
            MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty);
        end
    
    elseif (event == "RAID_ROSTER_UPDATE") then
        MRT_Debug("RAID_ROSTER_UPDATE fired!");
        MRT_RaidRosterUpdate(frame);
    
    end
end

-- Combatlog handler
function MRT_CombatLogHandler(...)
    local _, combatEvent, _, _, _, destGUID, destName = ...;
    if (not MRT_NumOfCurrentRaid) then return; end
    if (combatEvent == "UNIT_DIED") then
        local NPCID = MRT_GetNPCID(destGUID);
        if (MRT_BossIDList[NPCID]) then
            MRT_AddBosskill(destName);
        end
    end
end

-- Slashcommand handler
function MRT_SlashCmdHandler(msg)
    msg = string.lower(msg);
    if (msg == 'options' or msg == 'o') then
        InterfaceOptionsFrame_OpenToCategory("Mizus RaidTracker");
    elseif (msg == 'dkpcheck') then
        MRT_StartGuildAttendanceCheck("_attendancecheck_");
    elseif (msg == '') then
        MRT_GUI_Toggle();
    elseif (msg == 'dkpframe') then
        if (MRT_GetDKPValueFrame:IsShown()) then
            MRT_GetDKPValueFrame:Hide();
        else
            MRT_GetDKPValueFrame:Show();
        end
    elseif (msg == 'snapshot') then
        MRT_TakeSnapshot();
    else
        -- FIXME: print commands
    end
end


----------------------
--  Apply Defaults  --
----------------------
-- Check variables - if missing, load defaults
function MRT_UpdateSavedOptions()
    if not MRT_Options["General_OptionsVersion"] then
        MRT_Debug("Setting Options to default values...");
        for key, value in pairs(MRT_Defaults["Options"]) do
            if (MRT_Options[key] == nil) then
                MRT_Options[key] = value;
            end
        end
    end
    if MRT_Options["General_OptionsVersion"] == 1 then
        MRT_Options["Tracking_CreateNewRaidOnNewZone"] = true;
        MRT_Options["General_OptionsVersion"] = 2;
    end
end


------------------------------------------------
--  Make configuration changes if neccessary  --
------------------------------------------------
function MRT_VersionUpdate()
    -- DB changes from v.nil to v.1: Move extended player information in extra database
    if (MRT_Options["DB_Version"] == nil) then
        if (#MRT_RaidLog > 0) then
            local currentrealm = GetRealmName();
            for i, raidInfoTable in ipairs(MRT_RaidLog) do
                local realm;
                if (raidInfoTable["Realm"]) then
                    realm = raidInfoTable["Realm"];
                else
                    realm = currentrealm;
                    raidInfoTable["Realm"] = realm;
                end
                if (MRT_PlayerDB[realm] == nil) then
                    MRT_PlayerDB[realm] = {};
                end
                for j, playerInfo in pairs(raidInfoTable["Players"]) do
                    local name = playerInfo["Name"];
                    if (MRT_PlayerDB[realm][name] == nil) then 
                        MRT_PlayerDB[realm][name] = {};
                        MRT_PlayerDB[realm][name]["Name"] = name;
                    end
                    if (playerInfo["Race"]) then
                        MRT_PlayerDB[realm][name]["Race"] = playerInfo["Race"];
                        playerInfo["Race"] = nil;
                    end
                    if (playerInfo["RaceL"]) then
                        MRT_PlayerDB[realm][name]["Race"] = playerInfo["RaceL"];
                        playerInfo["RaceL"] = nil;
                    end
                    if (playerInfo["Class"]) then
                        MRT_PlayerDB[realm][name]["Class"] = playerInfo["Class"];
                        playerInfo["Class"] = nil;
                    end
                    if (playerInfo["ClassL"]) then
                        MRT_PlayerDB[realm][name]["ClassL"] = playerInfo["ClassL"];
                        playerInfo["ClassL"] = nil;
                    end
                    if (playerInfo["Level"]) then
                        MRT_PlayerDB[realm][name]["Level"] = playerInfo["Level"];
                        playerInfo["Level"] = nil;
                    end
                    if (playerInfo["Sex"]) then
                        MRT_PlayerDB[realm][name]["Sex"] = playerInfo["Sex"];
                        playerInfo["Sex"] = nil;
                    end
                end
            end
        end
        MRT_Options["DB_Version"] = 1;
    end
    -- DB changes from v.1 to v.2: Add missing StopTime to each raid entry
    if (MRT_Options["DB_Version"] == 1) then
        if (#MRT_RaidLog > 0) then
            for i, raidInfoTable in ipairs(MRT_RaidLog) do
                local latestTimestamp = 1;
                for j, playerInfo in pairs(raidInfoTable["Players"]) do
                    if (playerInfo["Leave"] > latestTimestamp) then
                        latestTimestamp = playerInfo["Leave"];
                    end
                end
                raidInfoTable["StopTime"] = latestTimestamp;
            end
        end
        MRT_Options["DB_Version"] = 2;
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
    --  IV) If RaidZone changed and CreateNewRaidOnNewZone on
    --  V) If RaidZone changed and CreateNewRaidOnNewZone on (check for raid size)
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
    -- Case: There is an active raid and a zone change and MRT_Options["Tracking_CreateNewRaidOnNewZone"] is enabled:
    elseif (MRT_Options["Tracking_CreateNewRaidOnNewZone"]) then
        MRT_Debug("Active raid in different zone found...");
        if (instanceInfoDifficulty == 2 or instanceInfoDifficulty == 4) then MRT_CreateNewRaid(instanceInfoName, 25);
        elseif (MRT_Options["Tracking_Log10MenRaids"]) then MRT_CreateNewRaid(instanceInfoName, 10);
        else MRT_EndActiveRaid();
        end
    -- Case: There is an active raid and a zone change and MRT_Options["Tracking_CreateNewRaidOnNewZone"] is disabled:
    else
        -- Case: Active Raid is a 10 player raid -> 10 player raids tracking enabled
        if (MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"] == 10) then
            -- Case: Zonechange and same raid size
            if (instanceInfoDifficulty == 1 or instanceInfoDifficulty == 3) then
                MRT_Debug("Raid zone changed. Raid size didn't change. CreateNewRaidOnNewZone is disabled. Won't create new raid.");
                return;
            else
                MRT_Debug("Raid zone and raid size changed. Starting new raid.");
                MRT_CreateNewRaid(instanceInfoName, 25);
            end
        -- Case: Active Raid is a 25 player raid
        else
            if (instanceInfoDifficulty == 2 or instanceInfoDifficulty == 4) then 
                MRT_Debug("Raid zone changed. Raid size didn't change. CreateNewRaidOnNewZone is disabled. Won't create new raid.");
                return;
            -- Case: different size as active raid
            elseif (MRT_Options["Tracking_Log10MenRaids"]) then
                MRT_Debug("Raid zone and raid size changed. Starting new raid.");
                MRT_CreateNewRaid(instanceInfoName, 10);
            else
                MRT_Debug("Raidsize changed to 10, but 10 player tracking disabled - ending active raid...")
                MRT_EndActiveRaid();
            end
        end
    end
end

function MRT_CreateNewRaid(zoneName, raidSize)
    if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
    local numRaidMembers = GetNumRaidMembers();
    local realm = GetRealmName();
    if (numRaidMembers == 0) then return end
    MRT_Debug("Creating new raid... - RaidZone is "..zoneName.." and RaidSize is "..tostring(raidSize));
    local currentTime = MRT_GetCurrentTime();
    local MRT_RaidInfo = {["Players"] = {}, ["Bosskills"] = {}, ["Loot"] = {}, ["RaidZone"] = zoneName, ["RaidSize"] = raidSize, ["Realm"] = GetRealmName(), ["StartTime"] = currentTime};
    MRT_Debug(tostring(numRaidMembers).." raidmembers found. Processing RaidRoster...");
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        local UnitID = "raid"..tostring(i);
        local playerRaceL, playerRace = UnitRace(UnitID);
        local playerSex = UnitSex(UnitID);
        local playerInfo = {
            ["Name"] = playerName,
            ["Join"] = currentTime,
            ["Leave"] = nil,
        }
        local playerDBEntry = {
            ["Name"] = playerName,
            ["Race"] = playerRace,
            ["RaceL"] = playerRaceL,
            ["Class"] = playerClass,
            ["ClassL"] = playerClassL,
            ["Level"] = playerLvl,
            ["Sex"] = playerSex,
        };
        if ((playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= 2 and raidSize == 10) or (playerSubGroup <= 5 and raidSize == 25))) then
            tinsert(MRT_RaidInfo["Players"], playerInfo);
        end
        if (MRT_PlayerDB[realm] == nil) then
            MRT_PlayerDB[realm] = {};
        end
        MRT_PlayerDB[realm][playerName] = playerDBEntry;
    end
    tinsert(MRT_RaidLog, MRT_RaidInfo);
    MRT_NumOfCurrentRaid = #MRT_RaidLog;
    -- set up timer for regular raid roster scanning
    MRT_RaidRosterScanTimer.lastCheck = time()
    MRT_RaidRosterScanTimer:SetScript("OnUpdate", function (self)
        if ((time() - self.lastCheck) > 5) then
            self.lastCheck = time();
            MRT_RaidRosterUpdate();
        end
    end);
end

function MRT_RaidRosterUpdate(frame)
    if (not MRT_NumOfCurrentRaid) then return; end
    if (GetNumRaidMembers() == 0) then 
        MRT_EndActiveRaid();
        return;
    end
    local numRaidMembers = GetNumRaidMembers();
    local realm = GetRealmName();
    local raidSize = MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"];
    local activePlayerList = {};
    MRT_Debug("RaidRosterUpdate: Processing RaidRoster");
    --MRT_Debug(tostring(numRaidMembers).." raidmembers found.");
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        if (playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= 2 and raidSize == 10) or (playerSubGroup <= 5 and raidSize == 25)) then
            tinsert(activePlayerList, playerName);
        end
        local playerInRaid = nil;
        for key, val in pairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
            if (val["Name"] == playerName) then
                if(val["Leave"] == nil) then playerInRaid = true; end
            end
        end
        if ((playerInRaid == nil) and (playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= 2 and raidSize == 10) or (playerSubGroup <= 5 and raidSize == 25))) then
            MRT_Debug("New player found: "..playerName);
            local UnitID = "raid"..tostring(i);
            local playerRaceL, playerRace = UnitRace(UnitID);
            local playerSex = UnitSex(UnitID);
            local playerInfo = {
                ["Name"] = playerName,
                ["Join"] = MRT_GetCurrentTime(),
                ["Leave"] = nil,
            };
            tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"], playerInfo);
        end
        -- PlayerDB is being renewed when creating a new raid, so only update unknown players here
        if (not MRT_PlayerDB[realm][playerName]) then
            local UnitID = "raid"..tostring(i);
            local playerRaceL, playerRace = UnitRace(UnitID);
            local playerSex = UnitSex(UnitID);
            local playerDBEntry = {
                ["Name"] = playerName,
                ["Race"] = playerRace,
                ["RaceL"] = playerRaceL,
                ["Class"] = playerClass,
                ["ClassL"] = playerClassL,
                ["Level"] = playerLvl,
                ["Sex"] = playerSex,
            };
            MRT_PlayerDB[realm][playerName] = playerDBEntry;
        end
    end
    -- MRT_Debug("RaidRosterUpdate: Checking for leaving players...");
    for key, val in pairs (MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
        local matchFound = nil;
        for index, activePlayer in ipairs (activePlayerList) do
            if (val["Name"] == activePlayer) then 
                matchFound = true; 
            end
        end
        if (not matchFound) then
            if (not MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"]) then
                MRT_Debug("Leaving player found: "..val["Name"]);
                MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"] = MRT_GetCurrentTime();
            end
        end
    end
end

-- @param man_diff: used by GUI when a bosskill was added manually
--                  valid values: "H", "N", nil
function MRT_AddBosskill(bossname, man_diff)
    if (not MRT_NumOfCurrentRaid) then return; end
    MRT_Debug("Adding bosskill to RaidLog[] - tracked boss: "..bossname);
    local _, _, instanceDifficulty, _, _, dynDiff, isDyn = GetInstanceInfo();
    if (man_diff) then
        if (MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"] == 10) then
            instanceDifficulty = 1;
        else
            instanceDifficulty = 2;
        end;
        if (man_diff == "H") then
            instanceDifficulty = instanceDifficulty + 2;
        end;
    else
        if (isDyn) then instanceDifficulty = instanceDifficulty + (2 * dynDiff); end;
    end;
    local trackedPlayers = {};
    local numRaidMembers = GetNumRaidMembers();
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, _, _, _, _, playerOnline = GetRaidRosterInfo(i);
        -- check group number and group related tracking options
        if (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= 2 and (instanceDifficulty == 1 or instanceDifficulty == 3)) or (playerSubGroup <= 5 and (instanceDifficulty == 2 or instanceDifficulty == 4))) then
            -- check online status and online status related tracking options
            if (MRT_Options["Attendance_TrackOffline"] or playerOnline == 1) then
                tinsert(trackedPlayers, playerName);
            end
        end
    end
    local MRT_BossKillInfo = {
        ["Players"] = trackedPlayers,
        ["Name"] = bossname,
        ["Date"] = MRT_GetCurrentTime(),
        ["Difficulty"] = instanceDifficulty,
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"], MRT_BossKillInfo);
    MRT_NumOfLastBoss = #MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"];
    if (bossname ~= MRT_L.Core["GuildAttendanceBossEntry"] and MRT_Options["Attendance_GuildAttendanceCheckEnabled"]) then
        if (MRT_Options["Attendance_GuildAttendanceCheckNoAuto"]) then
            StaticPopupDialogs["MRT_GA_MSGBOX"] = {
                text = string.format("MRT: "..MRT_L.Core["GuildAttendanceMsgBox"], bossname),
                button1 = MRT_L.Core["MB_Yes"],
                button2 = MRT_L.Core["MB_No"],
                OnAccept = function() MRT_StartGuildAttendanceCheck(bossname); end,
                timeout = 0,
                whileDead = true,
                hideOnEscape = false,
            }
            local msgbox = StaticPopup_Show("MRT_GA_MSGBOX");
            msgbox.bossname = bossname;
        else
            MRT_StartGuildAttendanceCheck(bossname);
        end
    end
end

function MRT_EndActiveRaid()
    if (not MRT_NumOfCurrentRaid) then return; end
    MRT_Debug("Ending active raid...");
    -- disable RaidRosterScanTimer
    MRT_RaidRosterScanTimer:SetScript("OnUpdate", nil);
    -- update DB
    local currentTime = MRT_GetCurrentTime();
    for key, value in pairs (MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
        if (not MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"]) then
            MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"][key]["Leave"] = currentTime;
        end
    end
    MRT_RaidLog[MRT_NumOfCurrentRaid]["StopTime"] = currentTime;
    MRT_NumOfCurrentRaid = nil;
    MRT_NumOfLastBoss = nil;
end

function MRT_CheckRaidStatusAfterLogin()
    if (GetNumRaidMembers() == 0) then
        MRT_EndActiveRaid();
        return;
    end
    if (MRT_NumOfCurrentRaid) then
        -- set up timer for regular raid roster scanning
        MRT_RaidRosterScanTimer.lastCheck = time()
        MRT_RaidRosterScanTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.lastCheck) > 5) then
                self.lastCheck = time();
                MRT_RaidRosterUpdate();
            end
        end);
    end
end

function MRT_TakeSnapshot()
    if (MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.Core["TakeSnapshot_CurrentRaidError"]);
        return false; 
    end
    if (GetNumRaidMembers() == 0) then
        MRT_Print(MRT_L.Core["TakeSnapshot_NotInRaidError"]);
        return false; 
    end
    MRT_CreateNewRaid("Snapshot", 0);
    MRT_EndActiveRaid();
    MRT_Print(MRT_L.Core["TakeSnapshot_Done"]);
    return true;
end


-------------------------------
--  loot tracking functions  --
-------------------------------
-- track loot based on chatmessage recognized by event CHAT_MSG_LOOT
function MRT_AutoAddLoot(chatmsg)
    -- MRT_Debug("Lootevent recieved. Processing...");
    -- patterns LOOT_ITEM / LOOT_ITEM_SELF are also valid for LOOT_ITEM_MULTIPLE / LOOT_ITEM_SELF_MULTIPLE - but not the other way around - try these first
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
    -- Quick&Dirty for Trashdrops befor first bosskill
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
        ["Time"] = MRT_GetCurrentTime(),
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"], MRT_LootInfo);
    if (not MRT_Options["Tracking_AskForDKPValue"]) then return; end
    if (MRT_Options["Tracking_MinItemQualityToGetDKPValue"] > MRT_ItemColorValues[itemColor]) then return; end
    MRT_DKPFrame_AddToItemCostQueue(MRT_NumOfCurrentRaid, #MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"]);
end


---------------------------
--  loot cost functions  --
---------------------------
-- basic idea: add looted items to a little queue and ask cost for each item in the queue 
--             this should avoid missing dialogs for fast looted items
-- note: standard dkpvalue is already 0 (unless EPGP-system-support enabled)
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
    --MRT_GetDKPValueFrame_Text:SetText(string.format(MRT_L.Core["DKP_Frame_Text"], MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["ItemLink"], MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"]));
    MRT_GetDKPValueFrame_TextFirstLine:SetText(MRT_L.Core["DKP_Frame_EnterCostFor"]);
    MRT_GetDKPValueFrame_TextSecondLine:SetText(MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["ItemLink"]);
    MRT_GetDKPValueFrame_TextThirdLine:SetText(string.format(MRT_L.Core.DKP_Frame_LootetBy, MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"]));
    MRT_GetDKPValueFrame_TTArea:SetWidth(MRT_GetDKPValueFrame_TextSecondLine:GetWidth());
    MRT_GetDKPValueFrame_EB:SetText("");
    MRT_GetDKPValueFrame_EB2:SetText("");
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
    local lootNote = MRT_GetDKPValueFrame_EB2:GetText();
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["DKPValue"] = dkpValue;
    if (lootNote ~= nil and lootNote ~= "" and lootNote ~= " ") then
        MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Note"] = lootNote;
    end
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

-- Case Bank: Set DKP-Value = 0, set Looter = bank
function MRT_DKPFrame_Bank()
    local lootNote = MRT_GetDKPValueFrame_EB2:GetText();
    MRT_Debug("DKPFrame: Bank pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"] = "bank";
    if (lootNote ~= nil and lootNote ~= "" and lootNote ~= " ") then
        MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Note"] = lootNote;
    end
    MRT_DKPFrame_PostAskQueue();
end

-- Case Disenchanted: Set DKP-Value = 0, set Looter = disenchanted
function MRT_DKPFrame_Disenchanted()
    local lootNote = MRT_GetDKPValueFrame_EB2:GetText();
    MRT_Debug("DKPFrame: Disenchanted pressed");
    MRT_GetDKPValueFrame:Hide();
    MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Looter"] = "disenchanted";
    if (lootNote ~= nil and lootNote ~= "" and lootNote ~= " ") then
        MRT_RaidLog[MRT_AskCostQueue[1]["RaidNum"]]["Loot"][MRT_AskCostQueue[1]["ItemNum"]]["Note"] = lootNote;
    end
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
    MRT_GuildRosterUpdating = true;
    MRT_Debug("Processing GuildRoster...");
    if (frame:IsEventRegistered("GUILD_ROSTER_UPDATE")) then
        frame:UnregisterEvent("GUILD_ROSTER_UPDATE");
    end
    local guildRosterOfflineFilter = GetGuildRosterShowOffline();
    local guildRosterSelection = GetGuildRosterSelection();
    SetGuildRosterShowOffline(true);
    local numGuildMembers = GetNumGuildMembers();
    local guildRoster = {};
    for i = 1, numGuildMembers do
        local charName = GetGuildRosterInfo(i);
        if (charName) then
            guildRoster[string.lower(charName)] = charName;
        end
    end
    MRT_GuildRoster = guildRoster;
    SetGuildRosterShowOffline(guildRosterOfflineFilter);
    SetGuildRosterSelection(guildRosterSelection);
    MRT_GuildRosterUpdating = nil;
    frame:RegisterEvent("GUILD_ROSTER_UPDATE");
end

-- start guild attendance announcement
function MRT_StartGuildAttendanceCheck(bosskilled)
    if (not MRT_NumOfCurrentRaid) then return end;
    if (MRT_TimerFrame.GARunning) then return end;
    MRT_TimerFrame.GARunning = true;
    MRT_TimerFrame.GAStart = time();
    MRT_TimerFrame.GALastMsg = time();
    MRT_TimerFrame.GADuration = MRT_Options["Attendance_GuildAttendanceCheckDuration"];
    local bosskilltext = nil;
    if (bosskilled == "_attendancecheck_") then
        MRT_AddBosskill(MRT_L.Core["GuildAttendanceBossEntry"]);
        bosskilltext = "MRT: "..MRT_L.Core["GuildAttendanceAnnounceText"];
    else
        bosskilltext = "MRT: "..string.format(MRT_L.Core["GuildAttendanceBossDownText"], bosskilled).." "..MRT_L.Core["GuildAttendanceAnnounceText"];
    end
    SendChatMessage("********************", "GUILD");
    SendChatMessage(bosskilltext, "GUILD");
    SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceRemainingTimeText"], MRT_TimerFrame.GADuration), "GUILD");
    SendChatMessage("********************", "GUILD");
    MRT_TimerFrame.GABossKillText = bosskilltext;
    MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
    MRT_TimerFrame:SetScript("OnUpdate", function() MRT_GuildAttendanceCheckUpdate(); end);
end

function MRT_GuildAttendanceCheckUpdate()
    if (MRT_TimerFrame.GARunning) then
        -- is last message one minute ago?
        if ((time() - MRT_TimerFrame.GALastMsg) >= 60) then
            MRT_TimerFrame.GALastMsg = time();
            -- is GACheck duration up?
            if (MRT_TimerFrame.GADuration == 0) then
                SendChatMessage("MRT: "..MRT_L.Core["GuildAttendanceTimeUpText"], "GUILD");
                MRT_TimerFrame.GARunning = nil;
            else
                SendChatMessage("********************", "GUILD");
                SendChatMessage(MRT_TimerFrame.GABossKillText, "GUILD");
                SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceRemainingTimeText"], MRT_TimerFrame.GADuration), "GUILD");
                SendChatMessage("********************", "GUILD");
                MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
            end
        end
    end
    if (not MRT_TimerFrame.GARunning) then
        MRT_TimerFrame:SetScript("OnUpdate", nil);
    end
end

function MRT_GuildAttendanceWhisper(msg, source)
    if ((MRT_NumOfCurrentRaid ~= nil) and (MRT_GuildRoster[string.lower(msg)] ~= nil)) then
        local player = MRT_GuildRoster[string.lower(msg)];
        local player_exist = nil;
--        for key, val in pairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
--            if (val["Name"] == player) then
--                if (not val["Leave"]) then player_exist = true; end
--            end
--        end
        if (MRT_NumOfLastBoss) then
            for i, v in ipairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"][MRT_NumOfLastBoss]["Players"]) do
                if (v == player) then player_exist = true; end;
            end
            if (player_exist == nil) then tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"][MRT_NumOfLastBoss]["Players"], player); end;
        end
        if (player_exist) then
            SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceReplyFail"], player), "WHISPER", nil, source);
        else
            SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceReply"], player), "WHISPER", nil, source);
        end
    end
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
    DEFAULT_CHAT_FRAME:AddMessage("MRT: "..text, 1, 1, 0);
end

-- Parse static local strings
function MRT_Core_Frames_ParseLocal()
    MRT_GetDKPValueFrame_Title:SetText("MRT - "..MRT_L.Core["DKP_Frame_Title"]);
    MRT_GetDKPValueFrame_CostString:SetText(MRT_L.Core["DKP_Frame_Cost"]);
    MRT_GetDKPValueFrame_NoteString:SetText(MRT_L.Core["DKP_Frame_Note"]);
    MRT_GetDKPValueFrame_OKButton:SetText(MRT_L.Core["DKP_Frame_OK_Button"]);
    MRT_GetDKPValueFrame_CancelButton:SetText(MRT_L.Core["DKP_Frame_Cancel_Button"]);
    MRT_GetDKPValueFrame_DeleteButton:SetText(MRT_L.Core["DKP_Frame_Delete_Button"]);
    MRT_GetDKPValueFrame_BankButton:SetText(MRT_L.Core["DKP_Frame_Bank_Button"]);
    MRT_GetDKPValueFrame_DisenchantedButton:SetText(MRT_L.Core["DKP_Frame_Disenchanted_Button"]);
    MRT_ExportFrame_Title:SetText("MRT - "..MRT_L.Core["Export_Frame_Title"]);
    MRT_ExportFrame_ExplanationText:SetText(MRT_L.Core["Export_Explanation"]);
    MRT_ExportFrame_OKButton:SetText(MRT_L.Core["Export_Button"]);
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

function MRT_GetCurrentTime()
    if MRT_Options["Tracking_UseServerTime"] then
        local _, month, day, year = CalendarGetDate();
        local hour, minute = GetGameTime();
        return time( { year = year, month = month, day = day, hour = hour, min = minute, } );
    else
        return time();
    end
end

function MRT_MakeEQDKP_Time(timestamp)
    return date("%c", timestamp)
end


------------------------------
--  export frame functions  --
------------------------------
function MRT_ExportFrame_Show(export)
    MRT_ExportFrame_EB:SetText(export)
    MRT_ExportFrame_EB:SetCursorPosition(MRT_ExportFrame_EB:GetNumLetters());
    MRT_ExportFrame_EB:HighlightText();
    MRT_ExportFrame:Show();
end

function MRT_ExportFrame_Hide()
    MRT_ExportFrame:Hide();
end


------------------------
--  export functions  --
------------------------
-- MRT_CreateRaidExport:
-- - this function should work like a hub for all exports
-- - if additional export functions are added, implement an option to the option panel
--   to choose the export format
-- - this function shall then call the correct export function
-- arg usage: (int, nil, nil) = export complete raid
--            (int, int, nil) = export one boss
--            (int, nil, <H, N>) = export all hard-/normalmode events
--            (int, int, <H, N>) = -> will be treated as (int, int, nil)
function MRT_CreateRaidExport(raidID, bossID, difficulty)
    -- basic "catch bad args" routines
    -- check if bad raidID
    if (MRT_RaidLog[raidID] == nil) then return end;
    -- check if bad bossID
    if (bossID ~= nil) then
        if (MRT_RaidLog[raidID]["Bosskills"][bossID] == nil) then return end;
        difficulty = nil;
    end
    -- check if bad difficulty-setting
    if ((difficulty ~= nil) and (difficulty ~= "H") and (difficulty ~= "N")) then return end;
    -- Choose the correct export function here
    local dkpstring;
    if (MRT_Options["Export_ExportFormat"] == 1) then
        dkpstring = MRT_CreateCtrtAttendeeDkpString(raidID, bossID, difficulty);
    elseif (MRT_Options["Export_ExportFormat"] == 2) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, nil);
    elseif (MRT_Options["Export_ExportFormat"] == 3) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, 1);
    end
    -- Show the data export
    MRT_ExportFrame_Show(dkpstring);
end

-- create CTRT-compatible DKP-String for the EQDKP CTRT-Import-Plugin / Uses boss attendee data for creating join/leave-timestamps
function MRT_CreateCtrtAttendeeDkpString(raidID, bossID, difficulty)
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    local raidStop = MRT_RaidLog[raidID]["StopTime"];
    local realm = MRT_RaidLog[raidID]["Realm"];
    -- start creating xml-data!
    local index = 1;
    local xml = "<RaidInfo>";
    xml = xml.."<key>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StartTime"]).."</key>";
    xml = xml.."<realm>"..MRT_RaidLog[raidID]["Realm"].."</realm>";
    xml = xml.."<start>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StartTime"]).."</start>";
    xml = xml.."<end>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["StopTime"]).."</end>";
    xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    xml = xml.."<PlayerInfos>";
    index = 1;
    for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
        local name = val["Name"];
        xml = xml.."<key"..index..">";
        xml = xml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                xml = xml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                xml = xml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                xml = xml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                xml = xml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        xml = xml.."</key"..index..">";
        index = index + 1;
    end
    xml = xml.."</PlayerInfos>";
    -- check data - goal: create as few join/leave pairs as possible
    -- idea: 
        -- 1. parse join/leave times and create table with these time (joinLeaveTable["PlayerName"][#]["Join"], joinLeaveTable["PlayerName"][#]["Leave"]
        -- 2. parse boss events, iterate for each attendee through these timestamps. If a matching pair is found, then work is done. If not, create an extra set of join and leave data for the bosskill timestamp
        -- Note: For avoiding handling issues, use extra strings vor bosskill-data and join/leave data. Concatenate later.
        -- if ["Export_CTRT_IgnorePerBossAttendance"] is set, create a join/left entry which spans the complete raid timespan
    local joinXml = "";
    local leaveXml = "";
    local joinLeaveTable = {};
    index = 1;
    joinXml = joinXml.."<Join>";
    leaveXml = leaveXml.."<Leave>";
    for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
        if (not MRT_Options["Export_CTRT_IgnorePerBossAttendance"] or (MRT_Options["Export_CTRT_IgnorePerBossAttendance"] and not joinLeaveTable[val["Name"]])) then
            local name = val["Name"];
            joinXml = joinXml.."<key"..index..">";
            joinXml = joinXml.."<player>"..name.."</player>";
            if (MRT_PlayerDB[realm][name]) then
                if (MRT_PlayerDB[realm][name]["Race"]) then
                    joinXml = joinXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
                end
                if (MRT_PlayerDB[realm][name]["Sex"]) then
                    joinXml = joinXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
                end
                if (MRT_PlayerDB[realm][name]["Class"]) then
                    joinXml = joinXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
                end
                if (MRT_PlayerDB[realm][name]["Level"]) then
                    joinXml = joinXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
                end
            end
            if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
                joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(raidStart).."</time>";
            else
                joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(val["Join"]).."</time>";
            end
            joinXml = joinXml.."</key"..index..">";
            leaveXml = leaveXml.."<key"..index..">";
            leaveXml = leaveXml.."<player>"..name.."</player>";
            if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
                leaveXml = leaveXml.."<time>"..MRT_MakeEQDKP_Time(raidStop).."</time>";
            else
                leaveXml = leaveXml.."<time>"..MRT_MakeEQDKP_Time(val["Leave"]).."</time>";
            end
            leaveXml = leaveXml.."</key"..index..">";
            index = index + 1;
            local joinLeaveData = {};
            if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
                joinLeaveData = { ["Join"] = raidStart, ["Leave"] = raidStop, }
            else
                joinLeaveData = { ["Join"] = val["Join"], ["Leave"] = val["Leave"], }
            end
            if (not joinLeaveTable[name]) then
                joinLeaveTable[name] = {};
            end
            tinsert(joinLeaveTable[name], joinLeaveData);
        end
    end
    -- if ["Export_CTRT_IgnorePerBossAttendance"] is set, check boss attendees for unknown players and add them to join/leave-data before processing bosskill-data
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for idx2, name in ipairs(MRT_RaidLog[raidID]["Bosskills"][idx]["Players"]) do
                if (not joinLeaveTable[name]) then
                    joinXml = joinXml.."<key"..index..">";
                    joinXml = joinXml.."<player>"..name.."</player>";
                    if (MRT_PlayerDB[realm][name]) then
                        if (MRT_PlayerDB[realm][name]["Race"]) then
                            joinXml = joinXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
                        end
                        if (MRT_PlayerDB[realm][name]["Sex"]) then
                            joinXml = joinXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
                        end
                        if (MRT_PlayerDB[realm][name]["Class"]) then
                            joinXml = joinXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
                        end
                        if (MRT_PlayerDB[realm][name]["Level"]) then
                            joinXml = joinXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
                        end
                    end
                    joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(raidStart).."</time>";
                    joinXml = joinXml.."</key"..index..">";
                    leaveXml = leaveXml.."<key"..index..">";
                    leaveXml = leaveXml.."<player>"..name.."</player>";
                    leaveXml = leaveXml.."<time>"..MRT_MakeEQDKP_Time(raidStop).."</time>";
                    leaveXml = leaveXml.."</key"..index..">";
                    index = index + 1;
                    local joinLeaveData = { ["Join"] = raidStart, ["Leave"] = raidStop, }
                    joinLeaveTable[name] = {};
                    tinsert(joinLeaveTable[name], joinLeaveData);
                end
            end
        end
    end
    -- Create bosskill list
    -- local helper vars
    local bosskillXml = "";
    local bossListToAddPoorItems = {};
    -- local function for creating a boss string
    local function createBossKillString(raidID, bossID)
        local bossKillTime = MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"];
        local bossKillString = "";
        bossKillString = bossKillString.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        bossKillString = bossKillString.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        bossKillString = bossKillString.."<time>"..MRT_MakeEQDKP_Time(bossKillTime).."</time>";
        bossKillString = bossKillString.."<attendees>";
        if (not MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
            for idx, name in ipairs(MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"]) do
                bossKillString = bossKillString.."<key"..idx.."><name>"..name.."</name></key"..idx..">";
                -- check, if player is a raidattendee at this point
                local raidattendee = false;
                if (joinLeaveTable[name]) then
                    for idx2, val2 in ipairs(joinLeaveTable[name]) do
                        if ((val2.Join < bossKillTime) and (bossKillTime < val2.Leave)) then
                            raidattendee = true;
                        end
                    end
                end
                -- if not raidattendee, create an extra join/leave-date
                if not raidattendee then
                    joinXml = joinXml.."<key"..index..">";
                    joinXml = joinXml.."<player>"..name.."</player>";
                    if (MRT_PlayerDB[realm][name]) then
                        if (MRT_PlayerDB[realm][name]["Race"]) then
                            joinXml = joinXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
                        end
                        if (MRT_PlayerDB[realm][name]["Sex"]) then
                            joinXml = joinXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
                        end
                        if (MRT_PlayerDB[realm][name]["Class"]) then
                            joinXml = joinXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
                        end
                        if (MRT_PlayerDB[realm][name]["Level"]) then
                            joinXml = joinXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
                        end
                    end
                    joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(bossKillTime - 10).."</time>";
                    joinXml = joinXml.."</key"..index..">";
                    leaveXml = leaveXml.."<key"..index..">";
                    leaveXml = leaveXml.."<player>"..name.."</player>";
                    leaveXml = leaveXml.."<time>"..MRT_MakeEQDKP_Time(bossKillTime + 10).."</time>";
                    leaveXml = leaveXml.."</key"..index..">";
                    index = index + 1;
                end
            end
        else
            local attendeeIndex = 1;
            for name, val in pairs(joinLeaveTable) do
                bossKillString = bossKillString.."<key"..attendeeIndex.."><name>"..name.."</name></key"..attendeeIndex..">";
                attendeeIndex = attendeeIndex + 1;
            end
        end
        bossKillString = bossKillString.."</attendees>";
        local addBossData = {
            name = MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"],
            difficulty = MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"],
            datetime = MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"]),
        };
        tinsert(bossListToAddPoorItems, addBossData);
        return bossKillString;
    end
    -- create boss string for export
    if (MRT_RaidLog[raidID]["Bosskills"]) then
        if ((bossID == nil) and (difficulty == nil)) then
            bosskillXml = bosskillXml.."<BossKills>";
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                bosskillXml = bosskillXml.."<key"..idx..">";
                bosskillXml = bosskillXml..createBossKillString(raidID, idx);
                bosskillXml = bosskillXml.."</key"..idx..">";
            end
            bosskillXml = bosskillXml.."</BossKills>";
        elseif (bossID) then
            bosskillXml = bosskillXml.."<BossKills><key1>";
            bosskillXml = bosskillXml..createBossKillString(raidID, bossID);
            bosskillXml = bosskillXml.."</key1></BossKills>";
        else
            -- difficulties on functionside are "H" and "N"
            local no_boss = true;
            local bossindex = 1;
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                if ((val["Difficulty"] < 3) and difficulty == "N") or ((val["Difficulty"] > 2) and difficulty == "H") then
                    if (no_boss) then
                        bosskillXml = bosskillXml.."<BossKills>";
                        no_boss = false;
                    end
                    bosskillXml = bosskillXml.."<key"..bossindex..">";
                    bosskillXml = bosskillXml..createBossKillString(raidID, idx);
                    bosskillXml = bosskillXml.."</key"..bossindex..">";
                    bossindex = bossindex + 1;
                end
            end
            if (no_boss == false) then
                bosskillXml = bosskillXml.."</BossKills>";
            end
        end
    end
    bosskillXml = bosskillXml.."<note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].."]]></note>";
    -- Concatenate data here!
    xml = xml..bosskillXml;
    xml = xml..joinXml.."</Join>";
    xml = xml..leaveXml.."</Leave>";
    -- Proceed as normal.
    xml = xml.."<Loot>";
    index = 1;
    for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if ((bossID == nil and difficulty == nil) or (val["BossNumber"] == bossID) or (MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Difficulty"] < 3 and difficulty == "N") or (MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Difficulty"] > 2 and difficulty == "H")) then
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
            xml = xml.."<Note><![CDATA[";
            if val["Note"] then
                xml = xml..val["Note"];
            end;
            xml = xml.." - Zone: "..MRT_RaidLog[raidID]["RaidZone"].." - Boss: "..MRT_RaidLog[raidID]["Bosskills"][val["BossNumber"]]["Name"].." - "..val["DKPValue"].." DKP]]>";
            xml = xml.."</Note>";
            xml = xml.."</key"..index..">";
            index = index + 1;
        end
    end
    -- EQDKP-CTRT-Import-Fix: If option is set, add one poor item to each boss
    if (MRT_Options["Export_CTRT_AddPoorItem"]) then
        for idx, val in ipairs(bossListToAddPoorItems) do
            xml = xml.."<key"..index..">";
            xml = xml.."<ItemName>Destroyed Magic Item</ItemName>";
            xml = xml.."<ItemID>35788:0:0:0:0:0:0:0:80</ItemID>";
            xml = xml.."<Color>ff9d9d9d</Color>";
            xml = xml.."<Count>1</Count>";
            xml = xml.."<Player>disenchanted</Player>";
            xml = xml.."<Costs>0</Costs>";
            xml = xml.."<Time>"..val["datetime"].."</Time>";
            xml = xml.."<Difficulty>"..val["difficulty"].."</Difficulty>";
            xml = xml.."<Boss>"..val["name"].."</Boss>";
            xml = xml.."<Note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].." - Boss: "..val["name"].." - 0 DKP]]></Note>";
            xml = xml.."</key"..index..">";
            index = index + 1;
        end
    end
    xml = xml.."</Loot>";
    xml = xml.."</RaidInfo>";
    return xml;
end

-- Planned format options:
-- @param addFormat: nil = plainText, 1 = BBCode, 2 = MediaWiki(NYI)
function MRT_CreateTextExport(raidID, bossID, difficulty, addFormat)
    -- Generate generic getBossData-Function:
    local function getBossData(raidID, bossID)
        -- Set up vars, create sorted playerList
        local bossData = "";
        local isFirstItem = true;
        local playerList = MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"];
        table.sort(playerList);
        -- Create data
        -- Begin boss headline formatting
        if (addFormat == 1) then
            bossData = bossData.."[b]";
        elseif (addFormat == 2) then
        end
        -- Boss headline
        bossData = bossData..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].." - ";
        if (MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"] < 3) then
            bossData = bossData..MRT_L.Core["Export_Normal"];
        else
            bossData = bossData..MRT_L.Core["Export_Heroic"];
        end
        -- End boss headline formatting
        if (addFormat == 1) then
            bossData = bossData.."[/b]";
        elseif (addFormat == 2) then
        end
        -- End of boss headline
        bossData = bossData.."\n";
        bossData = bossData..MRT_L.Core["Export_Attendees"].."("..tostring(#playerList).."):\n";
        bossData = bossData..table.concat(playerList, ", ");
        bossData = bossData.."\n\n";
        for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
            if (val["BossNumber"] == bossID) then
                if (isFirstItem) then bossData = bossData..MRT_L.Core["Export_Loot"]..":\n"; isFirstItem = false; end
                bossData = bossData.."- "..val["ItemName"].." - "..val["DKPValue"].." "..MRT_Options["Export_Currency"].." - "..val["Looter"]
                if val["Note"] then bossData = bossData.." ("..val["Note"]..")"; end
                bossData = bossData.."\n";
            end
        end
        bossData = bossData.."\n\n";
        return bossData;
    end
    -- Start creating export data
    local export = "";
    -- Begin headline formatting
    if (addFormat == 1) then
        export = export.."[u][b]";
    elseif (addFormat == 2) then
    end
    -- Begin headline text
    export = export..date(MRT_Options["Export_DateTimeFormat"], MRT_RaidLog[raidID]["StartTime"]);
    export = export.." - "..MRT_RaidLog[raidID]["RaidZone"].." ("..MRT_RaidLog[raidID]["RaidSize"]..")";
    -- End headline formatting
    if (addFormat == 1) then
        export = export.."[/b][/u]";
    elseif (addFormat == 2) then
    end
    -- End of headline
    export = export.."\n\n";
    -- If boss events are present, create a list of boss events
    local bossDataExist = nil;
    if (MRT_RaidLog[raidID]["Bosskills"] and #MRT_RaidLog[raidID]["Bosskills"] > 0) then
        if ((bossID == nil) and (difficulty == nil)) then
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                export = export..getBossData(raidID, idx);
            end
            bossDataExist = true;
        elseif (bossID) then
            export = export..getBossData(raidID, bossID);
            bossDataExist = true;
        else
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                if ((val["Difficulty"] < 3) and difficulty == "N") or ((val["Difficulty"] > 2) and difficulty == "H") then
                    export = export..getBossData(raidID, idx);
                    bossDataExist = true;
                end
            end
        end
    end
    -- If no boss events are present, create a list of raid atendees
    if (not bossDataExist) then
        -- Create list, remove duplicates, sort list, add list to export data 
        -- Very dirty hack for sorting out duplicates, i know....
        local keyPlayerList = {};
        local numPlayerList = {};
        for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
            keyPlayerList[val["Name"]] = val["Name"];
        end
        for key, val in pairs(keyPlayerList) do
            tinsert(numPlayerList, val);
        end
        table.sort(numPlayerList);
        -- Add export data
        export = export..MRT_L.Core["Export_Attendees"].."("..tostring(#numPlayerList).."):\n";
        export = export..table.concat(numPlayerList, ", ");
    end  
    return export;
end