-- ********************************************************
-- **              Mizus RaidTracker - Core              **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010)
--
-- Contributors:
--    * Kevin (HTML-Export) (2010)
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
        ["DB_Version"] = 2,
        ["General_MasterEnable"] = true,                                            -- AddonEnable: true / nil
        ["General_OptionsVersion"] = 8,                                             -- OptionsVersion - Counter, which increases after a new option has been added - if new option is added, then increase counter and add to update options function
        ["General_DebugEnabled"] = false,                                           --
        ["General_SlashCmdHandler"] = "mrt",                                        --
        ["General_PrunnRaidLog"] = false,                                           -- Prunning - shall old be deleted after a certain amount of time
        ["General_PrunningTime"] = 90,                                              -- Prunning time, after log shall be deleted (days)
        ["General_ShowMinimapIcon"] = false,                                        --
        ["Attendance_GuildAttendanceCheckEnabled"] = false,                         -- 
        ["Attendance_GuildAttendanceCheckNoAuto"] = true,                           --
        ["Attendance_GuildAttendanceCheckUseTrigger"] = false,
        ["Attendance_GuildAttendanceCheckTrigger"] = "!triggerexample",
        ["Attendance_GuildAttendanceCheckDuration"] = 3,                            -- in minutes - 0..5
        ["Attendance_GroupRestriction"] = false,                                    -- if true, track only first 2/5 groups in 10/25 player raids
        ["Attendance_TrackOffline"] = true,                                         -- if true, track offline players
        ["Tracking_Log10MenRaids"] = false,                                         -- Track 10 player raids: true / nil
        ["Tracking_LogAVRaids"] = false,                                            -- Track Archavons Vault: true / nil
        ["Tracking_AskForDKPValue"] = true,                                         -- 
        ["Tracking_MinItemQualityToLog"] = 4,                                       -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_MinItemQualityToGetDKPValue"] = 4,                               -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_AskCostAutoFocus"] = 2,                                          -- 1: always AutoFocus, 2: when not in combat, 3: never
        ["Tracking_CreateNewRaidOnNewZone"] = true,
        ["Tracking_OnlyTrackItemsAboveILvl"] = 0,
        ["Tracking_UseServerTime"] = false,
        ["Export_ExportFormat"] = 2,                                                -- 1: CTRT compatible, 2: EQdkp-Plus XML, 3: MLdkp 1.5,  4: plain text, 5: BBCode, 6: BBCode with wowhead, 7: CSS based HTML
        ["Export_ExportEnglish"] = false,                                           -- If activated, zone and boss names will be exported in english
        ["Export_CTRT_AddPoorItem"] = false,                                        -- Add a poor item as loot to each boss - Fixes encounter detection for CTRT-Import for EQDKP: true / nil
        ["Export_CTRT_IgnorePerBossAttendance"] = false,                            -- This will create an export where each raid member has 100% attendance: true / nil
        ["Export_CTRT_RLIPerBossAttendanceFix"] = false,
        ["Export_EQDKP_RLIPerBossAttendanceFix"] = false,
        ["Export_DateTimeFormat"] = "%m/%d/%Y",                                     -- lua date syntax - http://www.lua.org/pil/22.1.html
        ["Export_Currency"] = "DKP",
        ["MiniMap_SV"] = {                                                          -- Saved Variables for LibDBIcon
            hide = true,
        },
    },
};


--------------
--  Locals  --
--------------
local deformat = LibStub("LibDeformat-3.0");
local LDB = LibStub("LibDataBroker-1.1");
local LDBIcon = LibStub("LibDBIcon-1.0");
local LBZ = LibStub("LibBabble-Zone-3.0");
local LBZR = LBZ:GetReverseLookupTable();
local LBB = LibStub("LibBabble-Boss-3.0");
local LBBL = LBB:GetUnstrictLookupTable();
local ScrollingTable = LibStub("ScrollingTable");
local tinsert = tinsert;
local pairs = pairs;
local ipairs = ipairs;

local MRT_TimerFrame = CreateFrame("Frame");                -- Timer for Guild-Attendance-Checks
local MRT_LoginTimer = CreateFrame("Frame");                -- Timer for Login (Wait 10 secs after Login - then check Raisstatus)
local MRT_RaidRosterScanTimer = CreateFrame("Frame");       -- Timer for regular scanning for the raid roster (there is no event for disconnecting players)
local MRT_RIWTimer = CreateFrame("Frame"); 

local MRT_GuildRoster = {};
local MRT_GuildRosterInitialUpdateDone = nil;
local MRT_GuildRosterUpdating = nil;
local MRT_AskCostQueue = {};
local MRT_AskCostQueueRunning = nil;

-- Vars for API
local MRT_ExternalItemCostHandler = {
    func = nil,
    suppressDialog = nil,
    addonName = nil,
};
local MRT_ExternalLootNotifier = {};

-- Table definition for the drop down menu for the DKPFrame
local MRT_DKPFrame_DropDownTableColDef = {
    {["name"] = "", ["width"] = 100},
};


----------------------
--  RegisterEvents  --
----------------------
function MRT_MainFrame_OnLoad(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("CHAT_MSG_LOOT");
    frame:RegisterEvent("CHAT_MSG_WHISPER");
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    frame:RegisterEvent("PARTY_INVITE_REQUEST");
    frame:RegisterEvent("PARTY_MEMBERS_CHANGED");
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
        MRT_Initialize();
    
    elseif (event == "CHAT_MSG_LOOT") then 
        if (MRT_NumOfCurrentRaid) then
            MRT_AutoAddLoot(...);
        end
        
    elseif (event == "CHAT_MSG_WHISPER") then
        if (not MRT_TimerFrame.GARunning) then return false; end
        local msg, from = ...;
        if ( MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"] and (MRT_Options["Attendance_GuildAttendanceCheckTrigger"] == msg) ) then
            MRT_GuildAttendanceWhisper(from, from);
        elseif (not MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
            local player = MRT_GuildRoster[string.lower(msg)];
            if (not player) then return; end
            MRT_GuildAttendanceWhisper(player, from);
        end
    
    elseif (event == "CHAT_MSG_MONSTER_YELL") then
        if (not MRT_NumOfCurrentRaid) then return; end
        local monsteryell, sourceName = ...;
        local localInstance = GetInstanceInfo();
        if (not localInstance) then return; end
        local instance = LBZR[localInstance];
        if (not instance) then return; end
        if (MRT_L.Bossyells[instance] and MRT_L.Bossyells[instance][monsteryell]) then
            MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
            local bossName = LBBL[MRT_L.Bossyells[instance][monsteryell]] or MRT_L.Bossyells[instance][monsteryell];
            local NPCID = MRT_ReverseBossIDList[MRT_L.Bossyells[instance][monsteryell]];
            MRT_AddBosskill(bossName, nil, NPCID);
        end
    
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then 
        MRT_CombatLogHandler(...);
    
    elseif (event == "GUILD_ROSTER_UPDATE") then 
        MRT_GuildRosterUpdate(frame, event, ...);
        
    elseif (event == "PARTY_INVITE_REQUEST") then
        MRT_Debug("PARTY_INVITE_REQUEST fired!");
        
    elseif (event == "PARTY_MEMBERS_CHANGED") then
        MRT_Debug("PARTY_MEMBERS_CHANGED");
        
    elseif (event == "PLAYER_ENTERING_WORLD") then
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
        MRT_LoginTimer.loginTime = time();
        -- Delay data gathering a bit to make sure, that data is available after login
        -- aka: ugly Dalaran latency fix
        MRT_LoginTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.loginTime) > 5) then
                self:SetScript("OnUpdate", nil);
                MRT_CheckRaidStatusAfterLogin();
                MRT_GuildRosterUpdate(frame, nil, true)
                MRT_GuildRosterInitialUpdateDone = true;
            end
        end);
    
    elseif (event == "RAID_INSTANCE_WELCOME") then
        if (not MRT_Options["General_MasterEnable"]) then return end;
        -- I've recieved reports, stating that 25 player raids were tracked as 10 player raids - I have no idea why, but this here is the only place, where this issue could occure
        -- Wasn't able to reproduce this issue, so I think, I'll change it blindly...
        -- Use the DBM approach: wait 3 seconds after RIW-Event and then check instanceInfo stuff. Hopefully this fixes the problem....
        -- Can reuse the login-timer here - at least i hope, that noone hits a RIW 5 seconds after login...
        -- second though: even if - it shouldn't matter
        -- A generic function to schedule function would be nice! <- FIXME!
        MRT_RIWTimer.riwTime = time()
        MRT_RIWTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.riwTime) > 3) then
                self:SetScript("OnUpdate", nil);
                MRT_CheckZoneAndSizeStatus();
            end
        end);
    
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
        local englishBossName;
        local localBossName = destName;
        local NPCID = MRT_GetNPCID(destGUID);
        --MRT_Debug("localBossName: "..localBossName.." - NPCID: "..NPCID);
        if (MRT_BossIDList[NPCID]) then
            --MRT_Debug("Valid NPCID found... - Match on "..MRT_BossIDList[NPCID]);
            if (MRT_BossRenameList[NPCID]) then
                --MRT_Debug("Rename entry for NPCID found...");
                englishBossName = MRT_BossRenameList[NPCID];
                localBossName = LBBL[englishBossName] or englishBossName;
                --MRT_Debug("New local bossname is "..localBossName);
            end
            MRT_AddBosskill(localBossName, nil, NPCID);
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
    elseif (msg == 'deleteall now') then
        MRT_DeleteRaidLog();
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

-- Chat handler
local MRT_ChatHandler = {};
function MRT_ChatHandler:CHAT_MSG_WHISPER_Filter(self, event, msg, from, ...)
    if (not MRT_TimerFrame.GARunning) then return false; end
    if ( MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"] and (MRT_Options["Attendance_GuildAttendanceCheckTrigger"] == msg) ) then
        return true;
    elseif (not MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
        local player = MRT_GuildRoster[string.lower(msg)];
        if (not player) then return false; end
        return true;
    end
    return false;
end

function MRT_ChatHandler:CHAT_MSG_WHISPER_INFORM_FILTER(self, event, msg, from, ...)
    if (not MRT_TimerFrame.GARunning) then return false; end
    if (msg == MRT_ChatHandler.MsgToBlock) then
        return true;
    end
    return false;
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", MRT_ChatHandler.CHAT_MSG_WHISPER_Filter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", MRT_ChatHandler.CHAT_MSG_WHISPER_INFORM_FILTER);


------------------
--  Initialize  --
------------------
function MRT_Initialize()
    -- Update settings and DB
    MRT_UpdateSavedOptions();
    MRT_VersionUpdate();
    -- Maintenance
    MRT_PeriodicMaintenance();
    -- Parse localization
    MRT_Options_ParseValues();
    MRT_GUI_ParseValues();
    MRT_Core_Frames_ParseLocal();
    -- set up slash command
    SLASH_MIZUSRAIDTRACKER1 = "/"..MRT_Options["General_SlashCmdHandler"];
    SlashCmdList["MIZUSRAIDTRACKER"] = function(msg) MRT_SlashCmdHandler(msg); end
    -- set up LDB data source
    MRT_LDB_DS = LDB:NewDataObject("Mizus RaidTracker", {
        icon = "Interface\\AddOns\\MizusRaidTracker\\icons\\icon_disabled",
        label = MRT_ADDON_TITLE,
        text = "MRT",
        type = "data source",
        OnClick = function(self, button)
            if (button == "LeftButton") then
                MRT_GUI_Toggle();
            elseif (button == "RightButton") then
                InterfaceOptionsFrame_OpenToCategory("Mizus RaidTracker");
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine(MRT_ADDON_TITLE);
            tooltip:AddLine(" ");
            tooltip:AddLine(MRT_L.Core["LDB Left-click to toggle the raidlog browser"]);
            tooltip:AddLine(MRT_L.Core["LDB Right-click to open the options menu"]);
        end,
    });
    -- set up minimap icon
    LDBIcon:Register("Mizus RaidTracker", MRT_LDB_DS, MRT_Options["MiniMap_SV"]);
    -- set up drop down menu for the DKPFrame
    MRT_DKPFrame_DropDownTable = ScrollingTable:CreateST(MRT_DKPFrame_DropDownTableColDef, 9, nil, nil, MRT_GetDKPValueFrame);
    MRT_DKPFrame_DropDownTable.head:SetHeight(1);
    MRT_DKPFrame_DropDownTable.frame:SetFrameLevel(3);
    MRT_DKPFrame_DropDownTable.frame:Hide();
    MRT_DKPFrame_DropDownTable:EnableSelection(false);
    MRT_DKPFrame_DropDownTable:RegisterEvents({
        ["OnClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)
            if (not realrow) then return true; end
            local playerName = MRT_DKPFrame_DropDownTable:GetCell(realrow, column);
            if (playerName) then
                MRT_GetDKPValueFrame.Looter = playerName;
                MRT_GetDKPValueFrame_TextThirdLine:SetText(string.format(MRT_L.Core.DKP_Frame_LootetBy, playerName));
                MRT_GetDKPValueFrame_DropDownList_Toggle();
            end
            return true;
        end
    });
    MRT_DKPFrame_DropDownTable.head:SetHeight(1);
    -- update version number in saved vars
    MRT_Options["General_Version"] = MRT_ADDON_VERSION;
    MRT_Options["General_ClientLocale"] = GetLocale();
    -- Finish
    MRT_Debug("Addon loaded.");
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
    if MRT_Options["General_OptionsVersion"] == 2 then
        if (MRT_Options["Export_ExportFormat"] > 1) then
            MRT_Options["Export_ExportFormat"] = MRT_Options["Export_ExportFormat"] + 1;
        end
        MRT_Options["General_OptionsVersion"] = 3;
    end
    if MRT_Options["General_OptionsVersion"] == 3 then
        if (MRT_Options["Export_ExportFormat"] > 2) then
            MRT_Options["Export_ExportFormat"] = MRT_Options["Export_ExportFormat"] + 1;
        end
        MRT_Options["General_OptionsVersion"] = 4;
    end
    if MRT_Options["General_OptionsVersion"] == 4 then
        MRT_Options["Tracking_OnlyTrackItemsAboveILvl"] = 0;
        MRT_Options["General_OptionsVersion"] = 5;
    end
    if MRT_Options["General_OptionsVersion"] == 5 then
        MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"] = false;
        MRT_Options["Attendance_GuildAttendanceCheckTrigger"] = "!triggerexample";
        MRT_Options["General_OptionsVersion"] = 6;
    end
    if MRT_Options["General_OptionsVersion"] == 6 then
        MRT_Options["General_PrunnRaidLog"] = false;
        MRT_Options["General_PrunningTime"] = 90;
        MRT_Options["Tracking_AskCostAutoFocus"] = 1;
        MRT_Options["Export_ExportEnglish"] = false;
        MRT_Options["General_OptionsVersion"] = 7;
    end
    if MRT_Options["General_OptionsVersion"] == 7 then
        MRT_Options["General_ShowMinimapIcon"] = false;
        MRT_Options["MiniMap_SV"] = {
            hide = true,
        };
        MRT_Options["General_OptionsVersion"] = 8;
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


----------------------------
--  Periodic maintenance  --
----------------------------
-- delete unused PlayerDB-Entries and prun raidlog
function MRT_PeriodicMaintenance()
    if (#MRT_RaidLog == 0) then return; end
    local startTime = time();
    -- process prunning - smaller raidIndex is older raid
    if (MRT_Options["General_PrunnRaidLog"]) then
        -- prunningTime in seconds
        local prunningTime = MRT_Options["General_PrunningTime"] * 24 * 60 * 60;
        local lastRaidOverPrunningTreshhold = nil;
        for i, raidInfo in ipairs(MRT_RaidLog) do
            if ( (startTime - raidInfo["StartTime"]) > prunningTime and i ~= MRT_NumOfCurrentRaid ) then
                lastRaidOverPrunningTreshhold = i;
            end
        end
        if (lastRaidOverPrunningTreshhold) then
            for i = lastRaidOverPrunningTreshhold, 1, -1 do
                tremove(MRT_RaidLog, i);
            end
        end
    end
    -- process playerDB
    local deletedEntries = 0;
    local usedPlayerList = {};
    for i, raidInfoTable in ipairs(MRT_RaidLog) do
        local name;
        local realm = raidInfoTable["Realm"];
        if (not usedPlayerList[realm]) then usedPlayerList[realm] = {}; end
        for j, playerInfo in pairs(raidInfoTable["Players"]) do
            name = playerInfo.Name;
            usedPlayerList[realm][name] = true;
        end
        for j, bossInfo in ipairs(raidInfoTable["Bosskills"]) do
            for k, playerName in ipairs(bossInfo["Players"]) do
                usedPlayerList[realm][playerName] = true;
            end
        end
    end
    for realm, playerInfoList in pairs(MRT_PlayerDB) do
        for player, playerInfo in pairs(MRT_PlayerDB[realm]) do
            if (not usedPlayerList[realm][player]) then
                MRT_PlayerDB[realm][player] = nil;
                deletedEntries = deletedEntries + 1;
            end
        end
    end
    MRT_Debug("Maintenance finished in "..tostring(time() - startTime).." seconds. Deleted "..tostring(deletedEntries).." player entries.");
end


-----------------
--  API-Stuff  --
-----------------
function MRT_RegisterItemCostHandlerCore(functionToCall, addonName)
    if (functionToCall == nil or addonName == nil) then
        return false;
    end
    if (not MRT_ExternalItemCostHandler.func) then
        MRT_ExternalItemCostHandler.func = functionToCall;
        MRT_ExternalItemCostHandler.addonName = addonName;
        MRT_Print("Note: The addon '"..addonName.."' has registered itself to handle item tracking.");
        return true;
    else
        return false;
    end
end

function MRT_UnregisterItemCostHandlerCore(functionCalled)
    if (functionCalled == nil) then
        return false;
    end
    if (MRT_ExternalItemCostHandler.func == functionCalled) then
        MRT_ExternalItemCostHandler.func = nil;
        MRT_ExternalItemCostHandler.addonName = nil;
        return true;
    else
        return false;
    end
end

function MRT_RegisterLootNotifyCore(functionToCall)
    local isRegistered = nil;
    for i, val in ipairs(MRT_ExternalLootNotifier) do
        if (val == functionToCall) then
            isRegistered = true;
        end
    end
    if (isRegistered) then
        return false;
    else
        tinsert(MRT_ExternalLootNotifier, functionToCall);
        return true;
    end
end

function MRT_UnregisterLootNotifyCore(functionCalled)
    local isRegistered = nil;
    for i, val in ipairs(MRT_ExternalLootNotifier) do
        if (val == functionCalled) then
            isRegistered = i;
        end
    end
    if (isRegistered) then
        tremove(MRT_ExternalLootNotifier, isRegistered);
        return true;
    else
        return false;
    end
end

-------------------------------------
--  basic raid tracking functions  --
-------------------------------------
function MRT_CheckRaidStatusAfterLogin()
    if (GetNumRaidMembers() == 0) then
        MRT_EndActiveRaid();
        MRT_LDB_DS.icon = "Interface\\AddOns\\MizusRaidTracker\\icons\\icon_disabled";
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
        -- update LDB text and icon
        MRT_LDB_DS.icon = "Interface\\AddOns\\MizusRaidTracker\\icons\\icon_enabled";
    end
end

function MRT_CheckZoneAndSizeStatus()
    -- Use GetInstanceInfo() for informations about the zone! / Track bossdifficulty at bosskill (important for ICC)
    local localInstanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
    local instanceInfoDifficulty2 = GetInstanceDifficulty();
    local instanceInfoName = LBZR[localInstanceInfoName];
    -- if no english name available, returen
    if (instanceInfoName == nil) then MRT_Debug("No LBZ-entry for this zone found. Zone is "..localInstanceInfoName); return; end
    MRT_Debug("RIW fired - data: Name="..instanceInfoName.." / Type="..instanceInfoType.." / InfoDiff="..instanceInfoDifficulty.." / GetInstanceDiff="..instanceInfoDifficulty2);
    if (MRT_RaidZones[instanceInfoName]) then
        -- check if recognized raidzone is a pvpraid (-> Archavons Vault) and if tracking is enabled
        if (MRT_PvPRaids[instanceInfoName] and not MRT_Options["Tracking_LogAVRaids"]) then 
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        MRT_CheckTrackingStatus(localInstanceInfoName, instanceInfoDifficulty2);
    end
end

function MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty)
    -- Create a new raidentry if MRT_Raidzones match and MRT enabled and: 
    --  I) If no active raid and 10 player tracking enabled
    --  if 10 player tracking disabled, check for 25 player
    --  II) If changed from 10 men to 25 men
    --  III) If changed from 25 men to 10 men (if 10men enabled - else close raid)
    --  IV) If RaidZone changed and CreateNewRaidOnNewZone on
    --  V) If RaidZone and RaidSize changed and CreateNewRaidOnNewZone off
    MRT_Debug("Match in MRT_Raidzones from GetInstanceInfo() fround.");
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
        local playerGuild = GetGuildInfo(UnitID);
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
            ["Guild"] = playerGuild,
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
    -- update LDB text and icon
    MRT_LDB_DS.icon = "Interface\\AddOns\\MizusRaidTracker\\icons\\icon_enabled";
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
    --MRT_Debug("RaidRosterUpdate: Processing RaidRoster");
    --MRT_Debug(tostring(numRaidMembers).." raidmembers found.");
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        -- seems like there is a slight possibility, that playerName is not available - so check it
        if playerName then
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
                local playerGuild = GetGuildInfo(UnitID);
                local playerDBEntry = {
                    ["Name"] = playerName,
                    ["Race"] = playerRace,
                    ["RaceL"] = playerRaceL,
                    ["Class"] = playerClass,
                    ["ClassL"] = playerClassL,
                    ["Level"] = playerLvl,
                    ["Sex"] = playerSex,
                    ["Guild"] = playerGuild,
                };
                MRT_PlayerDB[realm][playerName] = playerDBEntry;
            end
        end
    end
    -- MRT_Debug("RaidRosterUpdate: Checking for leaving players...");
    for key, val in pairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
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
function MRT_AddBosskill(bossname, man_diff, bossID)
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
        ["BossId"] = bossID,
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
    -- update LDB text and icon
    MRT_LDB_DS.icon = "Interface\\AddOns\\MizusRaidTracker\\icons\\icon_disabled";
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
    local _, _, itemColor, _, itemId, _, _, _, _, _, _, _, _, _, itemName = string.find(itemLink, "|?c?(%x*)|?H?([^:]*):?(%d+):?(%d*):?(%d*):?(%d*):?(%d*):?(%d*):?(%-?%d*):?(%-?%d*):?(%d*):?(%d*)|?h?%[?([^%[%]]*)%]?|?h?|?r?");
    local _, _, itemRarity, itemLevel = GetItemInfo(itemLink);
    -- make the string a number
    itemId = tonumber(itemId);
    -- if major fuckup in first strip:
    -- if (itemString == nil) then MRT_Debug("ItemLink corrupted - no ItemString found."); return; end
    -- if major fuckup in second strip:
    -- if (itemId == nil) then MRT_Debug("ItemLink corrupted - no ItemId found."); return; end
    -- check options, if this item should be tracked
    if (MRT_Options["Tracking_MinItemQualityToLog"] > itemRarity) then MRT_Debug("Item not tracked - quality is too low."); return; end
    if (MRT_Options["Tracking_OnlyTrackItemsAboveILvl"] > itemLevel) then MRT_Debug("Item not tracked - iLvl is too low."); return; end
    if (MRT_IgnoredItemIDList[itemId]) then return; end
    -- if an external function handles item data, notify it
    local dkpValue = 0;
    local lootAction = nil;
    local itemNote = nil;
    local supressCostDialog = nil;
    if (MRT_ExternalItemCostHandler.func) then
        local notifierInfo = {
            ["ItemLink"] = itemLink,
            ["ItemString"] = itemString,
            ["ItemId"] = itemId,
            ["ItemName"] = itemName,
            ["ItemColor"] = itemColor,
            ["ItemCount"] = itemCount,
            ["Looter"] = playerName,
            ["DKPValue"] = dkpValue,
            ["Time"] = MRT_GetCurrentTime(),
        };
        dkpValue, playerName, itemNote, lootAction, supressCostDialog = MRT_ExternalItemCostHandler.func(notifierInfo);
        if (lootAction == MRT_LOOTACTION_BANK) then
            playerName = "bank";
        elseif (lootAction == MRT_LOOTACTION_DISENCHANT) then
            playerName = "disenchanted";
        elseif (lootAction == MRT_LOOTACTION_DELETE) then
            playerName = "_deleted_";
        end
    end
    -- Quick&Dirty for Trashdrops before first bosskill
    if (MRT_NumOfLastBoss == nil) then 
        MRT_AddBosskill(MRT_L.Core["Trash Mob"]);
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
        ["DKPValue"] = dkpValue,
        ["BossNumber"] = MRT_NumOfLastBoss,
        ["Time"] = MRT_GetCurrentTime(),
        ["Note"] = itemNote,
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"], MRT_LootInfo);
    if ((not MRT_Options["Tracking_AskForDKPValue"]) or supressCostDialog) then 
        -- notify registered, external functions
        local itemNum = #MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"];
        if (#MRT_ExternalLootNotifier > 0) then
            local itemInfo = {};
            for key, val in pairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"][itemNum]) do
                itemInfo[key] = val;
            end
            if (itemInfo.Looter == "bank") then
                itemInfo.Action = MRT_LOOTACTION_BANK;
            elseif (itemInfo.Looter == "disenchanted") then
                itemInfo.Action = MRT_LOOTACTION_DISENCHANT;
            elseif (itemInfo.Looter == "_deleted_") then
                itemInfo.Action = MRT_LOOTACTION_DELETE;
            else
                itemInfo.Action = MRT_LOOTACTION_NORMAL;
            end
            for i, val in ipairs(MRT_ExternalLootNotifier) do
                val(itemInfo, MRT_NOTIFYSOURCE_ADD_SILENT, MRT_NumOfCurrentRaid, itemNum);
            end
        end
        return; 
    end
    if (MRT_Options["Tracking_MinItemQualityToGetDKPValue"] > MRT_ItemColorValues[itemColor]) then return; end
    MRT_DKPFrame_AddToItemCostQueue(MRT_NumOfCurrentRaid, #MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"]);
end


---------------------------
--  loot cost functions  --
---------------------------
-- basic idea: add looted items to a little queue and ask cost for each item in the queue 
--             this should avoid missing dialogs for fast looted items
-- note: standard dkpvalue is already 0 (unless EPGP-system-support enabled) (FIXME: EPGP NYI!)
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
    local raidNum = MRT_AskCostQueue[1]["RaidNum"];
    local itemNum = MRT_AskCostQueue[1]["ItemNum"];
    -- gather playerdata and fill drop down menu
    local playerData = {};
    for i, val in ipairs(MRT_RaidLog[raidNum]["Bosskills"][MRT_NumOfLastBoss]["Players"]) do
        playerData[i] = { val };
    end
    table.sort(playerData, function(a, b) return (a[1] < b[1]); end );
    MRT_DKPFrame_DropDownTable:SetData(playerData, true);
    if (#playerData < 8) then
        MRT_DKPFrame_DropDownTable:SetDisplayRows(#playerData, 15);
    else
        MRT_DKPFrame_DropDownTable:SetDisplayRows(8, 15);
    end
    MRT_DKPFrame_DropDownTable.frame:Hide();
    -- set up rest of the frame
    MRT_GetDKPValueFrame_TextFirstLine:SetText(MRT_L.Core["DKP_Frame_EnterCostFor"]);
    MRT_GetDKPValueFrame_TextSecondLine:SetText(MRT_RaidLog[raidNum]["Loot"][itemNum]["ItemLink"]);
    MRT_GetDKPValueFrame_TextThirdLine:SetText(string.format(MRT_L.Core.DKP_Frame_LootetBy, MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"]));
    MRT_GetDKPValueFrame_TTArea:SetWidth(MRT_GetDKPValueFrame_TextSecondLine:GetWidth());
    if (MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"] == 0) then
        MRT_GetDKPValueFrame_EB:SetText("");
    else
        MRT_GetDKPValueFrame_EB:SetText(tostring(MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"]));
    end
    if (MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"]) then
        MRT_GetDKPValueFrame_EB2:SetText(MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"]);
    else
        MRT_GetDKPValueFrame_EB2:SetText("");
    end
    MRT_GetDKPValueFrame.Looter = MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"];
    -- set autoFocus of EditBoxes
    if (MRT_Options["Tracking_AskCostAutoFocus"] == 3 or (MRT_Options["Tracking_AskCostAutoFocus"] == 2 and UnitAffectingCombat("player")) ) then
        MRT_GetDKPValueFrame_EB:SetAutoFocus(false);
    else
        MRT_GetDKPValueFrame_EB:SetAutoFocus(true);
    end
    -- show DKPValue
    MRT_GetDKPValueFrame:Show();
    
end

-- Buttons: OK, Cancel, Delete, Bank, Disenchanted
function MRT_DKPFrame_Handler(button)
    MRT_Debug("DKPFrame: "..button.." pressed.");
    -- if OK was pressed, check input data
    local dkpValue = nil;
    local lootNote = MRT_GetDKPValueFrame_EB2:GetText();
    if (button == "OK") then
        if (MRT_GetDKPValueFrame_EB:GetText() == "") then
            dkpValue = 0;
        else
            dkpValue = tonumber(MRT_GetDKPValueFrame_EB:GetText(), 10);
        end
        if (dkpValue == nil) then return; end
    end
    if (lootNote == "" or lootNote == " ") then
        lootNote = nil;
    end
    -- hide frame
    MRT_GetDKPValueFrame:Hide();
    -- this line is solely for debug purposes 
    -- if (button == "Cancel") then return; end
    -- process item
    local raidNum = MRT_AskCostQueue[1]["RaidNum"];
    local itemNum = MRT_AskCostQueue[1]["ItemNum"];
    local looter = MRT_GetDKPValueFrame.Looter;
    if (button == "OK") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = looter;
        MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"] = dkpValue;
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"] = lootNote;
    elseif (button == "Cancel") then
    elseif (button == "Delete") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = "_deleted_";
    elseif (button == "Bank") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = "bank";
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"] = lootNote;
    elseif (button == "Disenchanted") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = "disenchanted";
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"] = lootNote;
    end
    -- notify registered, external functions
    if (#MRT_ExternalLootNotifier > 0) then
        local itemInfo = {};
        for key, val in pairs(MRT_RaidLog[raidNum]["Loot"][itemNum]) do
            itemInfo[key] = val;
        end
        if (itemInfo.Looter == "bank") then
            itemInfo.Action = MRT_LOOTACTION_BANK;
        elseif (itemInfo.Looter == "disenchanted") then
            itemInfo.Action = MRT_LOOTACTION_DISENCHANT;
        elseif (itemInfo.Looter == "_deleted_") then
            itemInfo.Action = MRT_LOOTACTION_DELETE;
        else
            itemInfo.Action = MRT_LOOTACTION_NORMAL;
        end
        for i, val in ipairs(MRT_ExternalLootNotifier) do
            val(itemInfo, MRT_NOTIFYSOURCE_ADD_POPUP, raidNum, itemNum);
        end
    end
    -- done with handling item - proceed to next one
    table.remove(MRT_AskCostQueue, 1);
    if (#MRT_AskCostQueue == 0) then
        MRT_AskCostQueueRunning = nil;
        -- queue finished, delete itemes which were marked as deleted - FIXME!
    else
        MRT_DKPFrame_AskCost();
    end    
end

function MRT_GetDKPValueFrame_DropDownList_Toggle()
    if (MRT_DKPFrame_DropDownTable.frame:IsShown()) then
        MRT_DKPFrame_DropDownTable.frame:Hide();
    else
        MRT_DKPFrame_DropDownTable.frame:Show();
        MRT_DKPFrame_DropDownTable.frame:SetPoint("TOPRIGHT", MRT_GetDKPValueFrame_DropDownButton, "BOTTOMRIGHT", 0, 0);
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
    local triggertext = nil;
    if (MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
        triggertext = string.format(MRT_L.Core["GuildAttendanceAnnounceText2"], MRT_Options["Attendance_GuildAttendanceCheckTrigger"]);
    else
        triggertext = MRT_L.Core["GuildAttendanceAnnounceText"];
    end
    if (bosskilled == "_attendancecheck_") then
        MRT_AddBosskill(MRT_L.Core["GuildAttendanceBossEntry"]);
        bosskilltext = "MRT: "..triggertext;
    else
        bosskilltext = "MRT: "..string.format(MRT_L.Core["GuildAttendanceBossDownText"], bosskilled).." "..triggertext;
    end
    local targetChannel = "GUILD";
    --@debug@
    if (MRT_Options["General_DebugEnabled"]) then targetChannel = "PARTY"; end
    --@end-debug@
    SendChatMessage("********************", targetChannel);
    SendChatMessage(bosskilltext, targetChannel);
    SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceRemainingTimeText"], MRT_TimerFrame.GADuration), targetChannel);
    SendChatMessage("********************", targetChannel);
    MRT_TimerFrame.GABossKillText = bosskilltext;
    MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
    MRT_TimerFrame:SetScript("OnUpdate", function() MRT_GuildAttendanceCheckUpdate(); end);
end

function MRT_GuildAttendanceCheckUpdate()
    if (MRT_TimerFrame.GARunning) then
        -- is last message one minute ago?
        if ((time() - MRT_TimerFrame.GALastMsg) >= 60) then
            local targetChannel = "GUILD";
            --@debug@
            if (MRT_Options["General_DebugEnabled"]) then targetChannel = "PARTY"; end
            --@end-debug@
            MRT_TimerFrame.GALastMsg = time();
            -- is GACheck duration up?
            if (MRT_TimerFrame.GADuration == 0) then
                SendChatMessage("MRT: "..MRT_L.Core["GuildAttendanceTimeUpText"], targetChannel);
                MRT_TimerFrame.GARunning = nil;
            else
                SendChatMessage("********************", targetChannel);
                SendChatMessage(MRT_TimerFrame.GABossKillText, targetChannel);
                SendChatMessage("MRT: "..string.format(MRT_L.Core["GuildAttendanceRemainingTimeText"], MRT_TimerFrame.GADuration), targetChannel);
                SendChatMessage("********************", targetChannel);
                MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
            end
        end
    end
    if (not MRT_TimerFrame.GARunning) then
        MRT_TimerFrame:SetScript("OnUpdate", nil);
    end
end

function MRT_GuildAttendanceWhisper(player, source)
    if (MRT_NumOfCurrentRaid ~= nil) then
        local sendMsg = nil;
        local player_exist = nil;
        if (MRT_NumOfLastBoss) then
            for i, v in ipairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"][MRT_NumOfLastBoss]["Players"]) do
                if (v == player) then player_exist = true; end;
            end
            if (player_exist == nil) then tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"][MRT_NumOfLastBoss]["Players"], player); end;
        end
        if (player_exist) then
            sendMsg = "MRT: "..string.format(MRT_L.Core.GuildAttendanceReplyFail, player);
            MRT_Print(string.format(MRT_L.Core.GuildAttendanceFailNotice, source, player)); -- this line might just be deleted
        else
            sendMsg = "MRT: "..string.format(MRT_L.Core.GuildAttendanceReply, player);
            MRT_Print(string.format(MRT_L.Core.GuildAttendanceAddNotice, source, player));
        end
        SendChatMessage(sendMsg, "WHISPER", nil, source);
        MRT_ChatHandler.MsgToBlock = sendMsg;
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
    -- pre WoW 4.0.1: GUID, 9, 12 - if there is a demand for a chinese version, this part need to be checked against the client version
    if ((unitType == 0x003) or (unitType == 0x005)) then
        return tonumber("0x"..strsub(GUID, 7, 10));
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
    return date("%m/%d/%y %H:%M:%S", timestamp)
end

function MRT_DeleteRaidLog()
    if (MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["Active raid in progress."]);
        return;
    end
    MRT_RaidLog = {};
    MRT_PlayerDB = {};
    if (MRT_GUIFrame) then
        MRT_GUI_CompleteTableUpdate();
    end
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
    -- 1: CTRT-compatible export
    if (MRT_Options["Export_ExportFormat"] == 1) then
        dkpstring = MRT_CreateCTRTClassicDKPString(raidID, bossID, difficulty);
    -- 2: EQDKP-Plus-XML
    elseif (MRT_Options["Export_ExportFormat"] == 2) then
        dkpstring = MRT_CreateEQDKPPlusXMLString(raidID, bossID, difficulty);
    -- 3: MLDKP 1.5
    elseif (MRT_Options["Export_ExportFormat"] == 3) then
        dkpstring = MRT_CreateMLDKP15ExportString(raidID, bossID, difficulty);
    -- 4: plain text export
    elseif (MRT_Options["Export_ExportFormat"] == 4) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, nil);
    -- 5: BBCode formated export
    elseif (MRT_Options["Export_ExportFormat"] == 5) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, 1);
    -- 6: BBCode formated export with wowhead links
    elseif (MRT_Options["Export_ExportFormat"] == 6) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, 2);
    -- 7: CSS based HTML with wowhead links
    elseif (MRT_Options["Export_ExportFormat"] == 7) then
        dkpstring = MRT_CreateHTMLExport(raidID, bossID, difficulty)
    end
    -- Show the data export
    MRT_ExportFrame_Show(dkpstring);
end

-- complete rewrite of the old function based on the experience of newer functions
function MRT_CreateCTRTClassicDKPString(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- create generic functions for repeated blocks
    local function createBossInfoString(index, bossInfo, attendeeList)
        local bossXml = "<key"..index..">";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[bossInfo.Name] or bossInfo.Name).."</name>";
        else
            bossXml = bossXml.."<name>"..bossInfo.Name.."</name>";
        end
        bossXml = bossXml.."<difficulty>"..bossInfo.Difficulty.."</difficulty>";
        bossXml = bossXml.."<time>"..MRT_MakeEQDKP_Time(bossInfo.Date).."</time>";
        bossXml = bossXml.."<attendees>";
        if attendeeList then
            for i, name in ipairs(attendeeList) do
                bossXml = bossXml.."<key"..i.."><name>"..name.."</name></key"..i..">";
            end
        else
            for i, name in ipairs(bossInfo.Players) do
                bossXml = bossXml.."<key"..i.."><name>"..name.."</name></key"..i..">";
            end
        end
        bossXml = bossXml.."</attendees></key"..index..">";
        return bossXml;
    end
    local function createPlayerInfoString(index, name, realm)
        local playerInfoString = "<key"..index..">";
        playerInfoString = playerInfoString.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerInfoString = playerInfoString.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerInfoString = playerInfoString.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerInfoString = playerInfoString.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                playerInfoString = playerInfoString.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        playerInfoString = playerInfoString.."</key"..index..">";
        return playerInfoString;
    end
    local function createItemInfoString(index, itemInfo)
        local bossInfo = MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber];
        local itemXml = "<key"..index..">";
        itemXml = itemXml.."<ItemName>"..itemInfo.ItemName.."</ItemName>";
        itemXml = itemXml.."<ItemID>"..deformat(itemInfo.ItemString, "item:%s").."</ItemID>";
        itemXml = itemXml.."<Color>"..itemInfo.ItemColor.."</Color>";
        itemXml = itemXml.."<Count>"..itemInfo.ItemCount.."</Count>";
        itemXml = itemXml.."<Player>"..itemInfo.Looter.."</Player>";
        itemXml = itemXml.."<Costs>"..itemInfo.DKPValue.."</Costs>";
        itemXml = itemXml.."<Time>"..MRT_MakeEQDKP_Time(bossInfo.Date + index).."</Time>";
        itemXml = itemXml.."<Difficulty>"..bossInfo.Difficulty.."</Difficulty>";
        itemXml = itemXml.."<Boss>"..bossInfo.Name.."</Boss>";
        itemXml = itemXml.."<Note><![CDATA[";
        if itemInfo.Note then
            itemXml = itemXml..itemInfo.Note;
        end
        itemXml = itemXml.." - Zone: "..MRT_RaidLog[raidID]["RaidZone"].." - Boss: "..bossInfo.Name.." - "..itemInfo.DKPValue.." DKP]]>";
        itemXml = itemXml.."</Note></key"..index..">";
        return itemXml;
    end
    local function createJoinString(index, name, realm, joinTimeStamp)
        local joinXml = "<key"..index..">";
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
        joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(joinTimeStamp).."</time>";
        joinXml = joinXml.."</key"..index..">";
        return joinXml;
    end
    local function createLeaveString(index, name, leaveTimeStamp)
        local leaveString = leaveString.."<key"..index..">";
        leaveString = leaveString.."<player>"..name.."</player>";
        leaveString = leaveString.."<time>"..MRT_MakeEQDKP_Time(leaveTimeStamp).."</time>";
        leaveString = leaveString.."</key"..index..">";
        return leaveString;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    if (bossID) then raidStart = MRT_RaidLog[raidID]["Bosskills"][bossID - 1]["Date"] or MRT_RaidLog[raidID]["StartTime"]; end
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    local index = 1;
    -- starte creating string - header first
    local xml = "<RaidInfo>";
    xml = xml.."<key>"..MRT_MakeEQDKP_Time(raidStart).."</key>";
    xml = xml.."<realm>"..realm.."</realm>";
    xml = xml.."<start>"..MRT_MakeEQDKP_Time(raidStart).."</start>";
    xml = xml.."<end>"..MRT_MakeEQDKP_Time(raidStop).."</end>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<zone>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</zone>";
    else
        xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    -- player infos: gather all players, sort them, create player info once per player
    local playerList = {};
    -- prepare player information and join/leave times
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    elseif (MRT_Options["Export_CTRT_RLIPerBossAttendanceFix"]) then
        -- in the "one raid per boss"-setting, the RLI slices the export in subraids.
        -- each player needs to have 50% attendance in each raid slice to be a valid attendee
        -- attendance fix solution:
        -- export all players, who have attended all bosses, with 100% attendance time.
        -- for all other players, create a set of join/leave-times for each time slice
        -- so, lets start - scan raid attendees first
        local attendanceCount = {};
        local lastBossTimeStamp;
        local joinLeavePair;
        for key, playerInfo in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not attendanceCount[playerInfo.Name]) then
                attendanceCount[playerInfo.Name] = 0;
            end
        end
        -- if we have no bosses, than #BossKills = 0 - convenient.
        -- now count attendance for each boss
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, playerName in ipairs(bossInfo["Players"]) do
                if (not attendanceCount[playerName]) then
                    attendanceCount[playerName] = 1;
                else
                    attendanceCount[playerName] = attendanceCount[playerName] + 1;
                end
            end
        end
        -- and the last step, create join/leave-pairs. if 100% attendance, create one join/leave-pair. if not, make one for each attended boss
        for playerName, bossKillCount in pairs(attendanceCount) do
            if (bossKillCount == #MRT_RaidLog[raidID]["Bosskills"]) then
                playerList[playerName] = { { Join = raidStart, Leave = raidStop, }, };
            else
                lastBossTimeStamp = raidStart;
                for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                    for j, attendeeName in ipairs(bossInfo["Players"]) do
                        if (attendeeName == playerName and raidStart <= lastBossTimeStamp) then
                            joinLeavePair = { Join = lastBossTimeStamp, Leave = (bossInfo.Date + 10), };
                            if (not playerList[playerName]) then playerList[playerName] = {}; end
                            tinsert(playerList[playerName], joinLeavePair);
                        end
                    end
                    lastBossTimeStamp = bossInfo.Date + 20;
                end
                -- if enough time between last bosskill and raid end, add on last join/leave pair
                if (lastBossTimeStamp < raidStop) then
                    joinLeavePair = { Join = lastBossTimeStamp, Leave = raidStop, };
                    if (not playerList[playerName]) then playerList[playerName] = {}; end
                    tinsert(playerList[playerName], joinLeavePair);
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee - if only one boss is exported, watch out for changed raid start
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            if (raidStart <= playerTimes.Join) then
                joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            elseif (raidStart < (playerTimes.Leave or now) ) then
                joinLeavePair = { Join = raidStart, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee and raidStart <= bossInfo.Date) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- player data complete
    -- prepare a list with sorted player names to fill the boss info
    local sortedPlayerList = {};
    for name, joinLeaveTable in pairs(playerList) do
        tinsert(sortedPlayerList, name);
    end
    table.sort(sortedPlayerList);
    -- player list sorted - create playerInfo data
    xml = xml.."<PlayerInfos>";
    for i, name in ipairs(sortedPlayerList) do
        xml = xml..createPlayerInfoString(i, name, realm);
    end
    xml = xml.."</PlayerInfos>";
    -- next: BossKillInfo
    local isFirstBoss = true;
    local exportedBosses = {};
    index = 1;
    if (bossID) then
        xml = xml.."<BossKills>";
        if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
            xml = xml..createBossInfoString(1, MRT_RaidLog[raidID]["Bosskills"][bossID], sortedPlayerList);
        else
            xml = xml..createBossInfoString(1, MRT_RaidLog[raidID]["Bosskills"][bossID], nil);
        end
        isFirstBoss = false;
        tinsert(exportedBosses, bossID);
    else
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if ( (not difficulty) or ((bossInfo["Difficulty"] < 3) and difficulty == "N") or ((bossInfo["Difficulty"] > 2) and difficulty == "H") ) then
                if (isFirstBoss) then 
                    xml = xml.."<BossKills>";
                    isFirstBoss = false;
                end
                if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
                    xml = xml..createBossInfoString(index, bossInfo, sortedPlayerList);
                else
                    xml = xml..createBossInfoString(index, bossInfo, nil);
                end
                index = index + 1;
                tinsert(exportedBosses, i);
            end
        end
    end
    if (not isFirstBoss) then
        xml = xml.."</BossKills>";
    end
    -- extra note entry:
    xml = xml.."<note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].."]]></note>";
    -- next: Join data
    index = 1;
    xml = xml.."<Join>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, joinLeaveEntry in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(index, name, realm, joinLeaveEntry.Join);
            index = index + 1;
        end
    end
    xml = xml.."</Join>";
    -- next: Leave data
    xml = xml.."<Leave>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, joinLeaveEntry in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(index, name, realm, joinLeaveEntry.Leave);
            index = index + 1;
        end
    end
    xml = xml.."</Leave>";
    -- and last: Loot
    index = 1;
    -- prepare a simple lookup-table:
    local exportedBossesLookup = {};
    for i, bossNum in ipairs(exportedBosses) do
        exportedBossesLookup[bossNum] = true;
    end
    xml = xml.."<Loot>";
    for lootId, lootInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (exportedBossesLookup[lootInfo.BossNumber]) then
            xml = xml..createItemInfoString(index, lootInfo);
            index = index + 1;
        end
    end
    -- apply EQdkp CTRT-Import-Plugin-Fix if enabled
    if (MRT_Options["Export_CTRT_AddPoorItem"]) then
        local lootInfo = {
            ["ItemLink"] = "|cff9d9d9d|Hitem:35788:0:0:0:0:0:0:0:0|h[Destroyed Magic Item]|h|r",
            ["ItemString"] = "item:35788:0:0:0:0:0:0:0:0",
            ["ItemId"] = 35788,
            ["ItemName"] = "Destroyed Magic Item",
            ["ItemColor"] = "ff9d9d9d",
            ["ItemCount"] = 1,
            ["Looter"] = "disenchanted",
            ["DKPValue"] = 0,
        };
        for i, bossNum in ipairs(exportedBosses) do
            lootInfo.BossNumber = bossNum;
            lootInfo.Time = MRT_RaidLog[raidID]["Bosskills"][bossNum]["Date"] + index;              -- a little random seed to prevent an item with bosskill time
            xml = xml..createItemInfoString(index, lootInfo);
            index = index + 1;
        end
    end
    xml = xml.."</Loot>";
    -- end
    xml = xml.."</RaidInfo>";
    return xml;
end

-- EQdkp-Plus-XML export format
function MRT_CreateEQDKPPlusXMLString(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- start to create generic functions for repeated blocks
    local function createBossInfoString(raidID, bossID)
        local bossXml = "<bosskill>";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).."</name>";
        else
            bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        end
        bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        bossXml = bossXml.."<time>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"].."</time>";
        bossXml = bossXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        bossXml = bossXml.."</bosskill>";
        return bossXml;
    end
    -- joinLeaveTable is a set of joinLeave Timestamps - example: joinLeaveTable = { {["Join"] = timestamp, ["Leave"] = timestamp}, {["Join"] = timestamp, ["Leave"] = timestamp} }
    local function createPlayerInfoString(name, realm, joinLeaveTable)
        if (#joinLeaveTable == 0) then return ""; end
        local playerXml = "<member>";
        playerXml = playerXml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerXml = playerXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Guild"]) then
                playerXml = playerXml.."<guild>"..MRT_PlayerDB[realm][name]["Guild"].."</guild>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerXml = playerXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerXml = playerXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                playerXml = playerXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        playerXml = playerXml.."<times>";
            for i, val in ipairs(joinLeaveTable) do
                playerXml = playerXml.."<time type='join'>"..val["Join"].."</time>";
                playerXml = playerXml.."<time type='leave'>"..val["Leave"].."</time>";
            end
        playerXml = playerXml.."</times></member>";
        return playerXml;
    end
    local function createItemInfoString(raidID, itemID)
        local itemXml = "<item>";
        itemXml = itemXml.."<name>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemName"].."</name>";
        itemXml = itemXml.."<time>"..MRT_RaidLog[raidID]["Loot"][itemID]["Time"].."</time>";
        itemXml = itemXml.."<member>"..MRT_RaidLog[raidID]["Loot"][itemID]["Looter"].."</member>";
        itemXml = itemXml.."<itemid>"..deformat(MRT_RaidLog[raidID]["Loot"][itemID]["ItemString"], "item:%s").."</itemid>";
        itemXml = itemXml.."<cost>"..MRT_RaidLog[raidID]["Loot"][itemID]["DKPValue"].."</cost>";
        itemXml = itemXml.."</item>";
        return itemXml;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    if (bossID) then raidStart = MRT_RaidLog[raidID]["Bosskills"][bossID - 1]["Date"] or MRT_RaidLog[raidID]["StartTime"]; end
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    -- start creating head
    local xml = "<raidlog><head><export><name>EQdkp Plus XML</name><version>1.0</version></export>";
    xml = xml.."<tracker><name>"..MRT_ADDON_TITLE.."</name><version>"..MRT_ADDON_VERSION.."</version></tracker>";
    xml = xml.."<gameinfo><game>World of Warcraft</game><language>"..GetLocale().."</language><charactername>"..UnitName("Player").."</charactername></gameinfo></head>";
    -- head finished. now the raid data - first the zone information
    xml = xml.."<raiddata><zones><zone>";
    xml = xml.."<enter>"..raidStart.."</enter><leave>"..raidStop.."</leave>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<name>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</name>";
    else
        xml = xml.."<name>"..MRT_RaidLog[raidID]["RaidZone"].."</name>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    xml = xml.."</zone></zones>";
    -- now the bosskills
    xml = xml.."<bosskills>";
    if (not bossID) then
        -- if no bossID is given, export complete raid or all boss of a specific difficulty
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if (not difficulty) then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] < 3) and difficulty == "N") then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createBossInfoString(raidID, i);
            end
        end
    else
        -- export a specific boss
        xml = xml..createBossInfoString(raidID, bossID);
    end
    xml = xml.."</bosskills>";
    -- now the member data
    xml = xml.."<members>";
    local playerList = {};
    -- prepare player information
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    elseif (MRT_Options["Export_EQDKP_RLIPerBossAttendanceFix"]) then
        -- in the "one raid per boss"-setting, the RLI slices the export in subraids.
        -- each player needs to have 50% attendance in each raid slice to be a valid attendee
        -- attendance fix solution:
        -- export all players, who have attended all bosses, with 100% attendance time.
        -- for all other players, create a set of join/leave-times for each time slice
        -- so, lets start - scan raid attendees first
        local attendanceCount = {};
        local lastBossTimeStamp;
        local joinLeavePair;
        for key, playerInfo in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not attendanceCount[playerInfo.Name]) then
                attendanceCount[playerInfo.Name] = 0;
            end
        end
        -- if we have no bosses, than #BossKills = 0 - convenient.
        -- now count attendance for each boss
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, playerName in ipairs(bossInfo["Players"]) do
                if (not attendanceCount[playerName]) then
                    attendanceCount[playerName] = 1;
                else
                    attendanceCount[playerName] = attendanceCount[playerName] + 1;
                end
            end
        end
        -- and the last step, create join/leave-pairs. if 100% attendance, create one join/leave-pair. if not, make one for each attended boss
        for playerName, bossKillCount in pairs(attendanceCount) do
            if (bossKillCount == #MRT_RaidLog[raidID]["Bosskills"]) then
                playerList[playerName] = { { Join = raidStart, Leave = raidStop, }, };
            else
                lastBossTimeStamp = raidStart;
                for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                    for j, attendeeName in ipairs(bossInfo["Players"]) do
                        if (attendeeName == playerName and raidStart <= lastBossTimeStamp) then
                            joinLeavePair = { Join = lastBossTimeStamp, Leave = (bossInfo.Date + 10), };
                            if (not playerList[playerName]) then playerList[playerName] = {}; end
                            tinsert(playerList[playerName], joinLeavePair);
                        end
                    end
                    lastBossTimeStamp = bossInfo.Date + 20;
                end
                -- if enough time between last bosskill and raid end, add on last join/leave pair
                if (lastBossTimeStamp < raidStop) then
                    joinLeavePair = { Join = lastBossTimeStamp, Leave = raidStop, };
                    if (not playerList[playerName]) then playerList[playerName] = {}; end
                    tinsert(playerList[playerName], joinLeavePair);
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            if (raidStart <= playerTimes.Join) then
                joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            elseif (raidStart < (playerTimes.Leave or now) ) then
                joinLeavePair = { Join = raidStart, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                    joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee and raidStart <= bossInfo.Date) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- prepare a list with sorted player names to fill the boss info
    local sortedPlayerList = {};
    for name, joinLeaveTable in pairs(playerList) do
        tinsert(sortedPlayerList, name);
    end
    table.sort(sortedPlayerList);
    -- player data should now be complete - export it:
    for i, name in ipairs(sortedPlayerList) do
        xml = xml..createPlayerInfoString(name, realm, playerList[name]);
    end
    xml = xml.."</members>";
    -- and last, add items
    xml = xml.."<items>";
    for i, itemInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (itemInfo.Looter ~= "_deleted_") then
            if (not bossID and not difficulty) then
                xml = xml..createItemInfoString(raidID, i);
            elseif (bossID and itemInfo["BossNumber"] == bossID) then
                xml = xml..createItemInfoString(raidID, i);
            elseif ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] < 3) and difficulty == "N") or ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createItemInfoString(raidID, i);
            end
        end
    end
    -- finish
    xml = xml.."</items></raiddata></raidlog>";
    return xml;
end

function MRT_CreateMLDKP15ExportString(raidID, bossID, difficulty)
    -- MLDKP1.5 seems to have the instanceID as an optional value - since ID-Stuff changed massivly with the release of Patch 4.0.1, MRT will NOT support exporting of an instanceID in any form
    -- MLDKP1.5 uses numbers for exporting classes and races, so we need a set of tables here. If these tables should be needed somewhere else, then these should be put in the constants file
    local MLDKP_ClassTable = {
        ["WARRIOR"] = 1,
        ["ROGUE"] = 2,
        ["HUNTER"] = 3,
        ["PALADIN"] = 4,
        ["SHAMAN"] = 5,
        ["DRUID"] = 6,
        ["WARLOCK"] = 7,
        ["MAGE"] = 8,
        ["PRIEST"] = 9,
        ["DEATHKNIGHT"] = 10,   -- Wrath of the Lich King
    };
    local MLDKP_RaceTable = {
        ["Gnome"] = 1,
        ["Human"] = 2,
        ["Dwarf"] = 3,
        ["NightElf"] = 4,
        ["Troll"] = 5,
        ["Scourge"] = 6,        -- Unlocalized name for race 'Undead'
        ["Orc"] = 7,
        ["Tauren"] = 8,
        ["Draenei"] = 9,        -- The Burning Crusade
        ["BloodElf"] = 10,      -- The Burning Crusade
        ["Worgen"] = 11,        -- Cataclysm (FIXME: Is this string correct? - if not, the export will fail horribly)
        ["Goblin"] = 12,        -- Cataclysm (FIXME: Is this string correct? - if not, the export will fail horribly)
    };
    local LBBR = LBB:GetReverseLookupTable();
    -- start to create generic functions for repeated blocks
    local function createBossInfoString(raidID, bossID)
        local bossXml = "<bosskill>";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).."</name>";
        else
            bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        end
        bossXml = bossXml.."<time>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"].."</time>";
        bossXml = bossXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        bossXml = bossXml.."</bosskill>";
        return bossXml;
    end
    local function createPlayerInfoString(name, realm)
        local playerXml = "<player>";
        playerXml = playerXml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerXml = playerXml.."<race>"..MLDKP_RaceTable[MRT_PlayerDB[realm][name]["Race"]].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Guild"]) then
                playerXml = playerXml.."<guild>"..MRT_PlayerDB[realm][name]["Guild"].."</guild>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerXml = playerXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerXml = playerXml.."<class>"..MLDKP_ClassTable[MRT_PlayerDB[realm][name]["Class"]].."</class>";
            end
        end
        playerXml = playerXml.."</player>";
        return playerXml;
    end
    local function createItemInfoString(raidID, itemID)
        local bossID = MRT_RaidLog[raidID]["Loot"][itemID]["BossNumber"];
        local lootXml = "<loot>";
        lootXml = lootXml.."<itemname>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemName"].."</itemname>";
        lootXml = lootXml.."<itemid>"..deformat(MRT_RaidLog[raidID]["Loot"][itemID]["ItemString"], "item:%s").."</itemid>";
        lootXml = lootXml.."<count>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemCount"].."</count>";
        lootXml = lootXml.."<player>"..MRT_RaidLog[raidID]["Loot"][itemID]["Looter"].."</player>";
        lootXml = lootXml.."<costs>"..MRT_RaidLog[raidID]["Loot"][itemID]["DKPValue"].."</costs>";
        lootXml = lootXml.."<time>"..MRT_RaidLog[raidID]["Loot"][itemID]["Time"].."</time>";
        lootXml = lootXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        lootXml = lootXml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
        lootXml = lootXml.."<boss>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</boss>";
        if (MRT_RaidLog[raidID]["Loot"][itemID]["Note"]) then
            lootXml = lootXml.."<note><![CDATA["..MRT_RaidLog[raidID]["Loot"][itemID]["Note"].."]]></note>";
        end
        lootXml = lootXml.."</loot>";
        return lootXml;
    end
    local function createJoinString(name, joinTimeStamp)
        local joinXml = "<join>";
        joinXml = joinXml.."<player>"..name.."</player>";
        joinXml = joinXml.."<time>"..joinTimeStamp.."</time>";
        joinXml = joinXml.."</join>";
        return joinXml;
    end
    local function createLeaveString(name, leaveTimeStamp)
        local leaveXml = "<leave>";
        leaveXml = leaveXml.."<player>"..name.."</player>";
        leaveXml = leaveXml.."<time>"..leaveTimeStamp.."</time>";
        leaveXml = leaveXml.."</leave>";
        return leaveXml;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    -- start creating header
    local xml = '<?xml version="1.0"?><!DOCTYPE ML_Raidtracker PUBLIC "-//MLdkp//DTD ML_Raidtracker V 1.5//EN" "http://www.mldkp.net/dtds/1.0/ML_Raidtracker.dtd">';
    xml = xml.."<raidinfo>";
    xml = xml.."<version>1.5</version>";
    xml = xml.."<start>"..raidStart.."</start>";
    xml = xml.."<end>"..raidStop.."</end>";
    xml = xml.."<realm>"..realm.."</realm>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<zone>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</zone>";
    else
        xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    xml = xml.."<exporter>"..UnitName("Player").."</exporter>";
    -- header complete, gather playerInfo
    local playerList = {};
    -- prepare player information
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
            tinsert(playerList[playerTimes.Name], joinLeavePair);
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                    joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- start parsing player data
    xml = xml.."<playerinfos>";
    for name, joinLeaveTable in pairs(playerList) do
        xml = xml..createPlayerInfoString(name, realm);
    end
    xml = xml.."</playerinfos>";
    -- now start creating bossinfo
    local isFirstBosskill = true;
    if (not bossID) then
        -- if no bossID is given, export complete raid or all boss of a specific difficulty
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if (not difficulty) then
                if (isFirstBosskill) then
                    isFirstBosskill = false;
                    xml = xml.."<bosskills>";
                end
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] < 3) and difficulty == "N") or ((bossInfo["Difficulty"] > 2) and difficulty == "H") then
                if (isFirstBosskill) then
                    isFirstBosskill = false;
                    xml = xml.."<bosskills>";
                end
                xml = xml..createBossInfoString(raidID, i);
            end
        end
    else
        -- export a specific boss
        isFirstBosskill = false;
        xml = xml.."<bosskills>";
        xml = xml..createBossInfoString(raidID, bossID);
    end
    if (not isFirstBosskill) then
        xml = xml.."</bosskills>";
    end
    -- next are the join-blocks
    xml = xml.."<joins>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, subTable in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(name, subTable.Join);
        end
    end
    xml = xml.."</joins>";
    -- and now the leave blocks
    xml = xml.."<leaves>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, subTable in ipairs(joinLeaveTable) do
            xml = xml..createLeaveString(name, subTable.Leave);
        end
    end
    xml = xml.."</leaves>";
    -- now the loot list
    xml = xml.."<loots>";
    for i, itemInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (itemInfo.Looter ~= "_deleted_") then
            if (not bossID and not difficulty) then
                xml = xml..createItemInfoString(raidID, i);
            elseif (bossID and itemInfo["BossNumber"] == bossID) then
                xml = xml..createItemInfoString(raidID, i);
            elseif ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] < 3) and difficulty == "N") or ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createItemInfoString(raidID, i);
            end
        end
    end
    xml = xml.."</loots>";
    xml = xml.."</raidinfo>";
    return xml;
end

-- 
function MRT_CreateDKPBoardComExportString(raidID, bossID, difficulty)
end

-- Planned format options:
-- @param addFormat: nil = plainText, 1 = BBCode, 2 = BBCode with wowhead-links, 3 = ?
function MRT_CreateTextExport(raidID, bossID, difficulty, addFormat)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- Generate generic getBossData-Function:
    local function getBossData(raidID, bossID)
        -- Set up vars, create sorted playerList
        local bossData = "";
        local isFirstItem = true;
        local playerList = MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"];
        table.sort(playerList);
        -- Create data
        -- Begin boss headline formatting
        if (addFormat == 1 or addFormat == 2) then
            bossData = bossData.."[b]";
        elseif (addFormat == 3) then
        end
        -- Boss headline
        if (MRT_Options["Export_ExportEnglish"]) then
            bossData = bossData..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).." - ";
        else
            bossData = bossData..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].." - ";
        end
        if (MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"] < 3) then
            bossData = bossData..MRT_L.Core["Export_Normal"];
        else
            bossData = bossData..MRT_L.Core["Export_Heroic"];
        end
        -- End boss headline formatting
        if (addFormat == 1 or addFormat == 2) then
            bossData = bossData.."[/b]";
        elseif (addFormat == 3) then
        end
        -- End of boss headline
        bossData = bossData.."\n";
        bossData = bossData..MRT_L.Core["Export_Attendees"].."("..tostring(#playerList).."):\n";
        bossData = bossData..table.concat(playerList, ", ");
        bossData = bossData.."\n\n";
        for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
            if (val["BossNumber"] == bossID and val["Looter"] ~= "_deleted_") then
                if (isFirstItem) then bossData = bossData..MRT_L.Core["Export_Loot"]..":\n"; isFirstItem = false; end
                bossData = bossData.."- ";
                if (addFormat == 2) then bossData = bossData.."[url=http://www.wowhead.com/?item="..val["ItemId"].."]"; end
                bossData = bossData..val["ItemName"];
                if (addFormat == 2) then bossData = bossData.."[/url]"; end
                bossData = bossData.." - "..val["DKPValue"].." "..MRT_Options["Export_Currency"];
                bossData = bossData.." - "..val["Looter"];
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
    if (addFormat == 1 or addFormat == 2) then
        export = export.."[u][b]";
    elseif (addFormat == 3) then
    end
    -- Begin headline text
    export = export..date(MRT_Options["Export_DateTimeFormat"], MRT_RaidLog[raidID]["StartTime"]);
    export = export.." - ";
    if (MRT_Options["Export_ExportEnglish"]) then
        export = export..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]);
    else
        export = export..MRT_RaidLog[raidID]["RaidZone"];
    end
    export = export.." ("..MRT_RaidLog[raidID]["RaidSize"]..")";
    -- End headline formatting
    if (addFormat == 1 or addFormat == 2) then
        export = export.."[/b][/u]";
    elseif (addFormat == 3) then
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

-- CSS based HTML, including wowhead links (contributed by Kevin)
function MRT_CreateHTMLExport(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- Generate generic getBossData-Function:
    local function getBossData(raidID, bossID)
        -- Set up vars, create sorted playerList
        local bossData = "<div class=\"bossData\">";
        local isFirstItem = true;
        local playerList = MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"];
        table.sort(playerList);
        -- Create data
        -- Begin boss headline formatting
        bossData = bossData.."<div class=\"boss\">";
        -- Boss headline
        bossData = bossData.."<span class=\"name\">";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossData = bossData..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]);
        else
            bossData = bossData..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"];
        end
        bossData = bossData.."</span><span class=\"difficulty\">";
        if (MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"] < 3) then
            bossData = bossData..MRT_L.Core["Export_Normal"];
        else
            bossData = bossData..MRT_L.Core["Export_Heroic"];
        end
        -- End boss headline formatting
        bossData = bossData.."</span></div>";
        -- End of boss headline
        bossData = bossData.."<div class=\"info\">";
        bossData = bossData.."<span class=\"label\">"..MRT_L.Core["Export_Attendees"].." ("..tostring(#playerList)..")</span>";
        bossData = bossData.."<span class=\"attendees\">"..table.concat(playerList, ", ").."</span>";
        bossData = bossData.."</div>";
        bossData = bossData.."<div class=\"loot\">";
        for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
            if (val["BossNumber"] == bossID and val["Looter"] ~= "_deleted_") then
                if (isFirstItem) then bossData = bossData.."<span class=\"label\">"..MRT_L.Core["Export_Loot"].."</span><ul>"; isFirstItem = false; end
                bossData = bossData.."<li>";
                bossData = bossData.."<a class=\"item\" href=\"http://www.wowhead.com/?item="..val["ItemId"].."\">";
                bossData = bossData..val["ItemName"];
                bossData = bossData.."</a>";
                bossData = bossData.."<span class=\"value\">"..val["DKPValue"].." "..MRT_Options["Export_Currency"].."</span>";
                bossData = bossData.."<span class=\"looter\">"..val["Looter"].."</span>";
                if val["Note"] then bossData = bossData.."<span=\"note\">("..val["Note"]..")</span>"; end
                bossData = bossData.."</li>";
            end
        end
        if (isFirstItem) then
            bossData = bossData.."</div></div>";
        else
            bossData = bossData.."</ul></div></div>";
        end
        return bossData;
    end
    -- Start creating export data
    local export = "<div class=\"raidExport\">";
    -- Begin headline formatting
    export = export.."<div class=\"headline\">";
    -- Begin headline text
    export = export.."<span class=\"zone\">";
    if (MRT_Options["Export_ExportEnglish"]) then
        export = export..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]);
    else
        export = export..MRT_RaidLog[raidID]["RaidZone"];
    end
    export = export.." ("..MRT_RaidLog[raidID]["RaidSize"]..")</span>";
    export = export.."<span class=\"start\">"..date(MRT_Options["Export_DateTimeFormat"], MRT_RaidLog[raidID]["StartTime"]).."</span>";
    -- End headline formatting
    export = export.."</div>";
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
        export = export.."<div class=\"info\">";
        export = export.."<span class=\"label\">"..MRT_L.Core["Export_Attendees"].." ("..tostring(#numPlayerList)..")</span>";
        export = export.."<span class=\"attendees\">"..table.concat(numPlayerList, ", ").."</span>";
        export = export.."</div>";
    end
    export = export.."</div>";
    return export;
end
