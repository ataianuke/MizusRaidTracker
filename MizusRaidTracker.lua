-- ********************************************************
-- **              Mizus RaidTracker - Core              **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mîzukichan @ EU-Antonidas (2010-2014)
--
-- Contributors:
--    * Kevin (HTML-Export) (2010)
--    * Knoxa (various MoP fixes) (2013)
--    * Kravval (various MoP fixes, enhancements to boss kill detection) (2013)
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


-- Check for addon table
if (not MizusRaidTracker) then MizusRaidTracker = {}; end
local mrt = MizusRaidTracker
local _L = MizusRaidTracker._L

-------------------------------
--  Globals/Default Options  --
-------------------------------
MRT_ADDON_TITLE = GetAddOnMetadata("MizusRaidTracker", "Title");
MRT_ADDON_VERSION = GetAddOnMetadata("MizusRaidTracker", "Version");
--@debug@
MRT_ADDON_VERSION = "v0.60.3-alpha"
--@end-debug@
MRT_NumOfCurrentRaid = nil;
MRT_NumOfLastBoss = nil;
MRT_Options = {};
MRT_RaidLog = {};
MRT_PlayerDB = {};

MRT_ArrayBossID = {};
MRT_ArrayBosslast = nil;

local MRT_Defaults = {
    ["Options"] = {
        ["DB_Version"] = 2,
        ["General_MasterEnable"] = true,                                            -- AddonEnable: true / nil
        ["General_OptionsVersion"] = 13,                                            -- OptionsVersion - Counter, which increases after a new option has been added - if new option is added, then increase counter and add to update options function
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
        ["Attendance_GuildAttendanceUseCustomText"] = false,
        ["Attendance_GuildAttendanceCustomText"] = MRT_GA_TEXT_CHARNAME_BOSS,
        ["Attendance_GroupRestriction"] = false,                                    -- if true, track only first 2/5 groups in 10/25 player raids
        ["Attendance_TrackOffline"] = true,                                         -- if true, track offline players
        ["Tracking_Log10MenRaids"] = true,                                          -- Track 10 player raids: true / nil (pre WoD-Raids)
        ["Tracking_Log25MenRaids"] = true,                                          -- Track 25 player raids: true / nil (pre WoD-Raids)
        ["Tracking_LogLFRRaids"] = true,                                            -- Track LFR raids: true / nil (any)
        ["Tracking_LogNormalRaids"] = true,                                         -- Track Normal raids (WoD+)
        ["Tracking_LogHeroicRaids"] = true,                                         -- Track Heroic raids (WoD+)
        ["Tracking_LogMythicRaids"] = true,                                         -- Track Mythic raids (WoD+)
        ["Tracking_LogAVRaids"] = false,                                            -- Track PvP raids: true / nil
        ["Tracking_LogWotLKRaids"] = false,                                         -- Track WotLK raid: true / nil
        ["Tracking_LogCataclysmRaids"] = false,                                     -- Track Catacylsm raid: true / nil
        ["Tracking_LogMoPRaids"] = true,                                            -- Track MoP raid: true / nil
        ["Tracking_LogLootModePersonal"] = true,
        ["Tracking_AskForDKPValue"] = true,                                         -- 
        ["Tracking_MinItemQualityToLog"] = 4,                                       -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_MinItemQualityToGetDKPValue"] = 4,                               -- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
        ["Tracking_AskCostAutoFocus"] = 2,                                          -- 1: always AutoFocus, 2: when not in combat, 3: never
        ["Tracking_CreateNewRaidOnNewZone"] = true,
        ["Tracking_OnlyTrackItemsAboveILvl"] = 0,
        ["Tracking_UseServerTime"] = false,
        ["ItemTracking_IgnoreEnchantingMats"] = true,
        ["ItemTracking_IgnoreGems"] = true,
        ["ItemTracking_UseEPGPValues"] = false,
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
MRT_DELAY_FIRST_RAID_ENTRY_FOR_RLI_BOSSATTENDANCE_FIX_DATA = 60;

local deformat = LibStub("LibDeformat-3.0");
local LDB = LibStub("LibDataBroker-1.1");
local LDBIcon = LibStub("LibDBIcon-1.0");
local LDialog = LibStub("LibDialog-1.0");
local LBB = LibStub("LibBabble-Boss-3.0");
local LBBL = LBB:GetUnstrictLookupTable();
local LBI = LibStub("LibBabble-Inventory-3.0");
local LBIR = LBI:GetReverseLookupTable();
local EPGPCalc = LibStub("LibEPGP-GPCalculator-1.0");
local ScrollingTable = LibStub("ScrollingTable");
local tinsert = tinsert;
local pairs = pairs;
local ipairs = ipairs;

local MRT_TimerFrame = CreateFrame("Frame");                -- Timer for Guild-Attendance-Checks
local MRT_LoginTimer = CreateFrame("Frame");                -- Timer for Login (Wait 10 secs after Login - then check Raidstatus)
local MRT_RaidRosterScanTimer = CreateFrame("Frame");       -- Timer for regular scanning for the raid roster (there is no event for disconnecting players)
local MRT_RIWTimer = CreateFrame("Frame"); 

local MRT_GuildRoster = {};
local MRT_GuildRosterInitialUpdateDone = nil;
local MRT_GuildRosterUpdating = nil;
local MRT_AskCostQueue = {};
local MRT_AskCostQueueRunning = nil;

local MRT_UnknownRelogStatus = true;

local _, _, _, uiVersion = GetBuildInfo();

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

-- Table for boss yells
for k, v in pairs(_L.yells) do
    MRT_L.Bossyells[k] = {}
    for k2, v2 in pairs(v) do
        if (k2 == "Icecrown Gunship Battle Alliance") or (k2 == "Icecrown Gunship Battle Horde") then k2 = "Icecrown Gunship Battle"; end
        MRT_L.Bossyells[k][v2] = k2
    end
end

----------------------
--  RegisterEvents  --
----------------------
function MRT_MainFrame_OnLoad(frame)
    frame:RegisterEvent("ADDON_LOADED");
    frame:RegisterEvent("CHAT_MSG_LOOT");
    frame:RegisterEvent("CHAT_MSG_WHISPER");
    frame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
    frame:RegisterEvent("ENCOUNTER_END");
    if (uiVersion < 50001) then
        frame:RegisterEvent("GROUP_ROSTER_UPDATE");
    end
    frame:RegisterEvent("PARTY_CONVERTED_TO_RAID");
    frame:RegisterEvent("PARTY_INVITE_REQUEST");
    frame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
    frame:RegisterEvent("PLAYER_ENTERING_WORLD");
    frame:RegisterEvent("PLAYER_REGEN_DISABLED");
    frame:RegisterEvent("RAID_INSTANCE_WELCOME");
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
    
    if (uiVersion >= 50001) then
        frame:RegisterEvent("RAID_ROSTER_UPDATE");
    end
end


-------------------------
--  Handler functions  --
-------------------------
-- Event handler
function MRT_OnEvent(frame, event, ...)
    if (event == "ADDON_LOADED") then
        local addonName = ...;
        if (addonName == "MizusRaidTracker") then
            MRT_Debug("Initializing MRT...");
            frame:UnregisterEvent("ADDON_LOADED");
            MRT_Initialize(frame);
        end
    
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
        if (not MRT_Options["General_MasterEnable"]) then return end;
        if (not MRT_NumOfCurrentRaid) then return; end
        local monsteryell, sourceName = ...;
        local areaID = GetCurrentMapAreaID();
        if (not areaID) then return; end
        if (MRT_L.Bossyells[areaID] and MRT_L.Bossyells[areaID][monsteryell]) then
            MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
            local bossName = LBBL[MRT_L.Bossyells[areaID][monsteryell]] or MRT_L.Bossyells[areaID][monsteryell];
            local NPCID = MRT_ReverseBossIDList[MRT_L.Bossyells[areaID][monsteryell]];
            MRT_AddBosskill(bossName, nil, NPCID);
        end
    
    elseif (event == "COMBAT_LOG_EVENT_UNFILTERED") then 
        if (not MRT_Options["General_MasterEnable"]) then return end;
        MRT_CombatLogHandler(...);
        
    elseif (event == "ENCOUNTER_END") then
        local encounterID, name, difficulty, size, success = ...
        MRT_Debug("ENCOUNTER_END fired! encounterID="..encounterID..", name="..name..", difficulty="..difficulty..", size="..size..", success="..success)
    
    elseif (event == "GUILD_ROSTER_UPDATE") then 
        MRT_GuildRosterUpdate(frame, event, ...);
        
    elseif (event == "PARTY_CONVERTED_TO_RAID") then
        MRT_Debug("PARTY_CONVERTED_TO_RAID fired!");
        if (MRT_UnknownRelogStatus) then
            MRT_UnknownRelogStatus = false;
            MRT_EndActiveRaid();            
        end
        
    elseif (event == "PARTY_INVITE_REQUEST") then
        MRT_Debug("PARTY_INVITE_REQUEST fired!");
        if (MRT_UnknownRelogStatus) then
            MRT_UnknownRelogStatus = false;
            MRT_EndActiveRaid();            
        end
        
    elseif (event == "PLAYER_ENTERING_WORLD") then
        frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
        MRT_LoginTimer.loginTime = time();
        -- Delay data gathering a bit to make sure, that data is available after login
        -- aka: ugly Dalaran latency fix - this is the part, which needs rework
        MRT_LoginTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.loginTime) > 5) then
                if (not MRT_GuildRosterInitialUpdateDone) then
                    MRT_GuildRosterUpdate(frame, nil, true);
                end
                MRT_GuildRosterInitialUpdateDone = true;
            end
            if ((time() - self.loginTime) > 15) then
                MRT_Debug("Relog Timer: 15 seconds threshold reached...");
                self:SetScript("OnUpdate", nil);
                if (MRT_UnknownRelogStatus) then MRT_CheckRaidStatusAfterLogin(); end
                MRT_UnknownRelogStatus = false;
            end
        end);
        
    elseif (event == "PARTY_LOOT_METHOD_CHANGED") then
        MRT_Debug("Event PARTY_LOOT_METHOD_CHANGED fired.");
        if (not MRT_Options["General_MasterEnable"]) then 
            MRT_Debug("MRT seems to be disabled. Ignoring Event.");
            return; 
        end;
        MRT_CheckZoneAndSizeStatus();
    
    elseif (event == "ZONE_CHANGED_NEW_AREA") then
        MRT_Debug("Event ZONE_CHANGED_NEW_AREA fired.");
        if (not MRT_Options["General_MasterEnable"]) then 
            MRT_Debug("MRT seems to be disabled. Ignoring Event.");
            return; 
        end;
        -- The WoW-Client randomly returns wrong zone information directly after a zone change for a relatively long period of time.
        -- Use the DBM approach: wait 10 seconds after RIW-Event and then check instanceInfo stuff. Hopefully this fixes the problem....
        -- A generic function to schedule functions would be nice! <- FIXME!
        MRT_Debug("Setting up instance check timer - raid status will be checked in 10 seconds.");
        MRT_RIWTimer.riwTime = time();
        MRT_RIWTimer:SetScript("OnUpdate", function (self)
            if ((time() - self.riwTime) > 10) then
                self:SetScript("OnUpdate", nil);
                MRT_CheckZoneAndSizeStatus();
            end
        end);
    
    elseif(event == "PLAYER_REGEN_DISABLED") then 
        wipe(MRT_ArrayBossID)
        --MRT_Debug("Tabelle gelöscht");
    
    elseif (event == "GROUP_ROSTER_UPDATE" or event == "RAID_ROSTER_UPDATE") then
        MRT_Debug("GROUP_ROSTER_UPDATE or RAID_ROSTER_UPDATE fired!");
        if (MRT_UnknownRelogStatus) then
            MRT_UnknownRelogStatus = false;
            MRT_CheckRaidStatusAfterLogin();
        end
        MRT_RaidRosterUpdate(frame);
    
    end
end

function MRT_PrintGR()
    local concatTable = "";
    for key, val in pairs(MRT_GuildRoster) do
        concatTable = concatTable..val..", ";
    end
    MRT_Debug(concatTable);
end

-- Combatlog handler
function MRT_CombatLogHandler(...)
    local _, combatEvent, _, _, _, _, _, destGUID, destName, _, _, spellID = ...;
    if (not MRT_NumOfCurrentRaid) then return; end
    if (combatEvent == "UNIT_DIED") then
        local englishBossName;
        local localBossName = destName;
        local NPCID = MRT_GetNPCID(destGUID);
        --MRT_Debug("localBossName: "..localBossName.." - NPCID: "..NPCID);
        if (MRT_BossIDList[NPCID]) then
            MRT_Debug("Valid NPCID found... - Match on "..MRT_BossIDList[NPCID]);
            localBossName = LBBL[MRT_BossIDList[NPCID]] or MRT_BossIDList[NPCID];
            if(MRT_ArrayBossIDList[MRT_BossIDList[NPCID]]) then
                local count = 0;
                local bosses = getn(MRT_ArrayBossIDList[MRT_BossIDList[NPCID]]);
                MRT_ArrayBossID[NPCID] = NPCID;
                MRT_Debug("Tabelle erweitert um "..NPCID);
                for key, val in pairs(MRT_ArrayBossID) do
                    if(tContains(MRT_ArrayBossIDList[MRT_BossIDList[NPCID]], val)) then
                        count = count +1;
                    end
                end
                if (bosses == count) then
                    if (MRT_ArrayBosslast ~= localBossName) then
                        MRT_AddBosskill(localBossName, nil, NPCID);
                    end
                end
            else 
                MRT_AddBosskill(localBossName, nil, NPCID);
            end
        end
    end
    if (combatEvent == "SPELL_CAST_SUCCESS") then
        -- MRT_Debug("SPELL_CAST_SUCCESS event found - SpellID is " .. spellID);
    end
    if (combatEvent == "SPELL_CAST_SUCCESS" and MRT_BossSpellIDTriggerList[spellID]) then
        MRT_Debug("Matching SpellID in trigger list found - Processing...");
        -- Get NPCID provided by the constants file
        local NPCID = MRT_BossSpellIDTriggerList[spellID][2]
        -- Get localized boss name, if available - else use english one supplied in the constants file
        local localBossName = LBBL[MRT_BossSpellIDTriggerList[spellID][1]] or MRT_BossSpellIDTriggerList[spellID][1];
        MRT_AddBosskill(localBossName, nil, NPCID);
    end
end

-- Slashcommand handler
function MRT_SlashCmdHandler(msg)
    msg_lower = string.lower(msg);
    if (msg_lower == 'options' or msg_lower == 'o') then
        InterfaceOptionsFrame_OpenToCategory("Mizus RaidTracker");
        return;
    elseif (msg_lower == 'dkpcheck') then
        MRT_AddBosskill(MRT_L.Core["GuildAttendanceBossEntry"]);
        MRT_StartGuildAttendanceCheck("_attendancecheck_");
        return;
    elseif (msg_lower == 'deleteall now') then
        MRT_DeleteRaidLog();
        return;
    elseif (msg_lower == 'snapshot') then
        MRT_TakeSnapshot();
        return;
    elseif (msg_lower == '') then
        MRT_GUI_Toggle();
        return;
    elseif (msg_lower == 'dkpframe') then
        if (MRT_GetDKPValueFrame:IsShown()) then
            MRT_GetDKPValueFrame:Hide();
        else
            MRT_GetDKPValueFrame:Show();
        end
        return;
    elseif (string.match(msg, 'additem')) then
        local itemLink, looter, cost = string.match(msg, 'additem%s+(|c.+|r)%s+(%a+)%s+(%d*)');
        if (not itemLink) then 
            itemLink, looter = string.match(msg, 'additem%s+(|c.+|r)%s+(%a+)');
            cost = 0;
        end
        if (itemLink) then
            MRT_ManualAddLoot(itemLink, looter, cost);
            return;
        end
    end
    local slashCmd = '/'..MRT_Options.General_SlashCmdHandler;
    MRT_Print("Slash commands:");
    MRT_Print("'"..slashCmd.."' opens the raid log broser.");
    MRT_Print("'"..slashCmd.." options' opens the options menu.");
    MRT_Print("'"..slashCmd.." dkpcheck' creates a new boss entry and starts an attendance check.");
    MRT_Print("'"..slashCmd.." additem <ItemLink> <Looter> [<Costs>]' adds an item to the last boss kill.");
    MRT_Print("Example: "..slashCmd.." additem \124cffffffff\124Hitem:6948:0:0:0:0:0:0:0:0\124h[Hearthstone]\124h\124r Mizukichan 10");
    MRT_Print("'"..slashCmd.." snapshot' creates a snapshot of the current raid composition.");
    MRT_Print("'"..slashCmd.." deleteall now' deletes the complete raid log. USE WITH CAUTION!");
end

-- Chat handler
local MRT_ChatHandler = {};
function MRT_ChatHandler:CHAT_MSG_WHISPER_Filter(event, msg, from, ...)
    if (not MRT_TimerFrame.GARunning) then return false; end
    if ( MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"] and (MRT_Options["Attendance_GuildAttendanceCheckTrigger"] == msg) ) then
        MRT_Debug("Message filtered... - Msg was '"..msg.."' from '"..from.."'");
        return true;
    elseif (not MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
        local player = MRT_GuildRoster[string.lower(msg)];
        if (not player) then return false; end
        MRT_Debug("Message filtered... - Msg was '"..msg.."' from '"..from.."'");
        return true;
    end
    return false;
end

function MRT_ChatHandler:CHAT_MSG_WHISPER_INFORM_FILTER(event, msg, from, ...)
    if (not MRT_TimerFrame.GARunning) then return false; end
    if (msg == MRT_ChatHandler.MsgToBlock) then
        MRT_Debug("Message filtered... - Msg was '"..msg.."' from '"..from.."'");
        return true;
    end
    return false;
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", MRT_ChatHandler.CHAT_MSG_WHISPER_Filter);
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", MRT_ChatHandler.CHAT_MSG_WHISPER_INFORM_FILTER);


------------------
--  Initialize  --
------------------
function MRT_Initialize(frame)
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
    if (MRT_Options["General_SlashCmdHandler"] and MRT_Options["General_SlashCmdHandler"] ~= "") then
        SLASH_MIZUSRAIDTRACKER1 = "/"..MRT_Options["General_SlashCmdHandler"];
        SlashCmdList["MIZUSRAIDTRACKER"] = function(msg) MRT_SlashCmdHandler(msg); end
    end
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
    -- check for open raids
    if (not MRT_NumOfCurrentRaid) then
        MRT_UnknownRelogStatus = false;
    end
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
    if MRT_Options["General_OptionsVersion"] == 8 then
        if (MRT_Options["Export_ExportFormat"] > 3) then
            MRT_Options["Export_ExportFormat"] = MRT_Options["Export_ExportFormat"] + 1;
        end
        MRT_Options["General_OptionsVersion"] = 9;
    end
    if MRT_Options["General_OptionsVersion"] == 9 then
        MRT_Options["Attendance_GuildAttendanceUseCustomText"] = false;
        MRT_Options["Attendance_GuildAttendanceCustomText"] = MRT_GA_TEXT_CHARNAME_BOSS;
        MRT_Options["General_OptionsVersion"] = 10;
    end
    if MRT_Options["General_OptionsVersion"] == 10 then
        MRT_Options["ItemTracking_IgnoreEnchantingMats"] = true;
        MRT_Options["ItemTracking_IgnoreGems"] = true;
        MRT_Options["General_OptionsVersion"] = 11;
    end 
    if MRT_Options["General_OptionsVersion"] == 11 then
        MRT_Options["Tracking_LogWotLKRaids"] = false;
        MRT_Options["General_OptionsVersion"] = 12;
    end
    if MRT_Options["General_OptionsVersion"] == 12 then
        MRT_Options["ItemTracking_UseEPGPValues"] = false;
        MRT_Options["General_OptionsVersion"] = 13;
    end
    if MRT_Options["General_OptionsVersion"] == 13 then
        MRT_Options["Tracking_LogLFRRaids"] = true;
        MRT_Options["General_OptionsVersion"] = 14;
    end
    if MRT_Options["General_OptionsVersion"] == 14 then
        MRT_Options["Tracking_LogCataclysmRaids"] = false;     
        MRT_Options["Tracking_LogMoPRaids"] = true;            
        MRT_Options["Tracking_LogLootModePersonal"] = true;
        MRT_Options["General_OptionsVersion"] = 15;
    end
    if MRT_Options["General_OptionsVersion"] == 15 then
        MRT_Options["Tracking_Log25MenRaids"] = true;
        MRT_Options["Tracking_LogNormalRaids"] = true;
        MRT_Options["Tracking_LogHeroicRaids"] = true;
        MRT_Options["Tracking_LogMythicRaids"] = true;
        MRT_Options["General_OptionsVersion"] = 16;
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
    -- DB changes from v.2 to v.3: 
    -- * Update from 3.4 difficulty IDs to 6.0 difficulty IDs
    -- * Add raid difficulty IDs to raid entries
    -- * Fix LFR (ID 17) entries
    if (MRT_Options["DB_Version"] == 2) then
        if (#MRT_RaidLog > 0) then
            for i, raidInfoTable in ipairs(MRT_RaidLog) do
                if (raidInfoTable["RaidSize"] == 10) then
                    raidInfoTable["DiffID"] = 3;
                elseif (raidInfoTable["RaidSize"] == 25) then
                    raidInfoTable["DiffID"] = 4;
                end
                for j, bossInfo in ipairs(raidInfoTable["Bosskills"]) do
                    if (not bossInfo["Difficulty"]) then
                        raidInfoTable["DiffID"] = 17;
                        bossInfo["Difficulty"] = 17;
                    elseif (bossInfo["Difficulty"] == 1) then
                        bossInfo["Difficulty"] = 3;
                    elseif (bossInfo["Difficulty"] == 2) then
                        bossInfo["Difficulty"] = 4;
                    elseif (bossInfo["Difficulty"] == 3) then
                        bossInfo["Difficulty"] = 5;
                    elseif (bossInfo["Difficulty"] == 4) then
                        bossInfo["Difficulty"] = 6;
                    end
                end
            end
        end
        MRT_Options["DB_Version"] = 3;
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
            -- if MRT_NumOfCurrentRaid not nil, then reduce it by the number of deleted raids
            if (MRT_NumOfCurrentRaid) then
                MRT_NumOfCurrentRaid = MRT_NumOfCurrentRaid - lastRaidOverPrunningTreshhold
                if (MRT_NumOfCurrentRaid < 1) then MRT_NumOfCurrentRaid = nil; end
            end
            -- delete raid entries, that are too old
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
            -- realm-check is neccessary, because there may be PlayerDB-entries for realms, whose corresponding raids are deleted
            if (not usedPlayerList[realm] or not usedPlayerList[realm][player]) then
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
    if (not MRT_IsInRaid()) then
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
    local _, instanceInfoType, diffID, diffDesc, maxPlayers, _, _, iniMapID, iniGroupSize = MRT_GetInstanceInfo();
    if (not diffID) then return; end
    local areaID = GetCurrentMapAreaID();
    if (not areaID) then return; end
    local localInstanceInfoName = GetMapNameByID(areaID);
    if (not localInstanceInfoName) then return; end
    MRT_Debug("MRT_CheckZoneAndSizeStatus called - data: Name="..localInstanceInfoName.." / ID=" ..areaID.." / Type="..instanceInfoType.." / InfoDiff="..diffDesc.." / GetInstanceDiff="..diffID);
    -- For legacy 10 N/H and 25 N/H raids, difficulty is tracked at boss killtime, as those difficulties have a shared ID
    -- Thus, handle diffID 5 as 3 and 6 as 2
    if (diffID == 5) then diffID = 3; end
    if (diffID == 6) then diffID = 4; end
    if (MRT_RaidZones[areaID]) then
        -- Check if the current raidZone is a zone which should be tracked
        if (MRT_PvPRaids[areaID] and not MRT_Options["Tracking_LogAVRaids"]) then 
            MRT_Debug("This instance is a PvP-Raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (MRT_LegacyRaidZonesCataclysm[areaID] and not MRT_Options["Tracking_LogCataclysmRaids"]) then
            MRT_Debug("This instance is a Cataclysm-Raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (MRT_LegacyRaidZonesWotLK[areaID] and not MRT_Options["Tracking_LogWotLKRaids"]) then
            MRT_Debug("This instance is a WotLK-Raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (MRT_LegacyRaidZonesBC[areaID] and not MRT_Options["Tracking_LogBCRaids"]) then
            MRT_Debug("This instance is a BC-Raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        -- Check if the current loot mode should be tracked
        if (select(1, GetLootMethod()) == "personalloot" and not MRT_Options["Tracking_LogLootModePersonal"]) then
            MRT_Debug("Loot method is personal loot and tracking of this loot method is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        -- Check if current raid size should be tracked
        if (diffID == 3 and not MRT_Options["Tracking_Log10MenRaids"]) then
            MRT_Debug("This instance is a 10 player legacy raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (diffID == 4 and not MRT_Options["Tracking_Log25MenRaids"]) then
            MRT_Debug("This instance is a 25 player legacy raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if ((diffID == 7 or diffID == 17) and not MRT_Options["Tracking_LogLFRRaids"]) then
            MRT_Debug("This instance is a LFR-Raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (diffID == 14 and not MRT_Options["Tracking_LogNormalRaids"]) then
            MRT_Debug("This instance is a WoD or later normal mode raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (diffID == 15 and not MRT_Options["Tracking_LogHeroicRaids"]) then
            MRT_Debug("This instance is a WoD or later heroic mode raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        if (diffID == 16 and not MRT_Options["Tracking_LogMythicRaids"]) then
            MRT_Debug("This instance is a WoD or later mythic mode raid and tracking of those is disabled.");
            if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
            return;
        end
        -- At this point, we should have something that should be tracked.
        -- If there is no active raid, just start one
        if (not MRT_NumOfCurrentRaid) then
            MRT_Debug("Start tracking a new instance - Name="..localInstanceInfoName.." / maxPlayers="..maxPlayers.." / diffID="..diffID);
            MRT_CreateNewRaid(localInstanceInfoName, maxPlayers, diffID);
            return;
        end
        -- There is an active raid, check if diffID changed, if yes, start a new raid
        if (MRT_RaidLog[MRT_NumOfCurrentRaid]["DiffID"] ~= diffID) then
            MRT_Debug("Start tracking a new instance - Name="..localInstanceInfoName.." / maxPlayers="..maxPlayers.." / diffID="..diffID);
            MRT_CreateNewRaid(localInstanceInfoName, maxPlayers, diffID);
            return;
        end
        -- diffID not changed. If instance changed, check if auto create on new instance is on.
        if ((MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidZone"] ~= localInstanceInfoName) and MRT_Options["Tracking_CreateNewRaidOnNewZone"]) then
            MRT_Debug("Start tracking a new instance - Name="..localInstanceInfoName.." / maxPlayers="..maxPlayers.." / diffID="..diffID);
            MRT_CreateNewRaid(localInstanceInfoName, maxPlayers, diffID);
            return;
        end
    else
        MRT_Debug("This instance is not on the tracking list.");
    end
end

function MRT_CreateNewRaid(zoneName, raidSize, diffID)
    assert(zoneName, "Invalid argument: zoneName is nil.")
    assert(raidSize, "Invalid argument: raidSize is nil.")
    assert(diffID, "Invalid argument: diffID is nil.")
    if (MRT_NumOfCurrentRaid) then MRT_EndActiveRaid(); end
    local numRaidMembers = MRT_GetNumRaidMembers();
    local realm = GetRealmName();
    if (numRaidMembers == 0) then return; end
    MRT_Debug("Creating new raid... - RaidZone is "..zoneName..", RaidSize is "..tostring(raidSize).. " and diffID is "..tostring(diffID));
    local currentTime = MRT_GetCurrentTime();
    local MRT_RaidInfo = {["Players"] = {}, ["Bosskills"] = {}, ["Loot"] = {}, ["DiffID"] = diffID, ["RaidZone"] = zoneName, ["RaidSize"] = raidSize, ["Realm"] = GetRealmName(), ["StartTime"] = currentTime};
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
        };
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
        if ((playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= (raidSize / 5)))) then
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

function MRT_ResumeLastRaid()
    -- if there is a running raid, then there is nothing to resume
    if (MRT_NumOfCurrentRaid) then return false; end
    -- if the player is not in a raid, then there is no reason to resume
    local numRaidMembers = MRT_GetNumRaidMembers();
    if (numRaidMembers == 0) then return false; end
    -- sanity checks: Is there a last raid? Was the last raid on the same realm as this raid?
    local numOfLastRaid = #MRT_RaidLog;
    if (not numOfLastRaid or numOfLastRaid == 0) then return false; end
    local realm = GetRealmName();
    if (MRT_RaidLog[numOfLastRaid]["Realm"] ~= realm) then return false; end
    -- scan RaidRoster and create a list with current valid attendees (valid in the sense should be tracked according to the current setting (check subgroup and onlinestatus))
    -- also, update PlayerDB
    local currentAttendeesList = {};
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
        if (MRT_PlayerDB[realm] == nil) then
            MRT_PlayerDB[realm] = {};
        end
        MRT_PlayerDB[realm][playerName] = playerDBEntry;
        -- is this a valid attendee?
        if ((playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= (raidSize / 5)))) then
            currentAttendeesList[playerName] = true;
        end
    end
    -- next step: check raid roster of last raid - if there is an entry of an valid raid member with leaveTime == end of last raid, then just resume this entry (-> set leave-time to nil)
    local endOfLastRaid = MRT_RaidLog[numOfLastRaid]["StopTime"];
    for i, attendeeDataSet in ipairs(MRT_RaidLog[numOfLastRaid]["Players"]) do
        if (attendeeDataSet.Leave and attendeeDataSet.Leave == endOfLastRaid and currentAttendeesList[attendeeDataSet.Name]) then
            attendeeDataSet.Leave = nil;
            currentAttendeesList[attendeeDataSet.Name] = nil;
        end
    end
    -- at this point, currentAttendeesList should only contain players, which were not in the last raid when tracking of the last raid ended. Add new raid attendee entries for these players
    local now = MRT_GetCurrentTime();
    for playerName, val in pairs(currentAttendeesList) do
        local playerInfo = {
            ["Name"] = playerName,
            ["Join"] = now,
            ["Leave"] = nil,
        };
        tinsert(MRT_RaidLog[numOfLastRaid]["Players"], playerInfo);
    end
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
    -- update status variables
    MRT_NumOfCurrentRaid = numOfLastRaid;
    if (#MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"] > 0) then
        MRT_NumOfLastBoss = #MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"];
    end
    -- done - last raid is resumed and tracking is enabled
    return true;
end

function MRT_RaidRosterUpdate(frame)
    if (not MRT_NumOfCurrentRaid) then return; end
    if (not MRT_IsInRaid()) then 
        MRT_EndActiveRaid();
        return;
    end
    local numRaidMembers = MRT_GetNumRaidMembers();
    local realm = GetRealmName();
    local raidSize = MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"];
    local activePlayerList = {};
    --MRT_Debug("RaidRosterUpdate: Processing RaidRoster");
    --MRT_Debug(tostring(numRaidMembers).." raidmembers found.");
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, playerLvl, playerClassL, playerClass, _, playerOnline = GetRaidRosterInfo(i);
        -- seems like there is a slight possibility, that playerName is not available - so check it
        if playerName then
            if (playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= (raidSize / 5))) then
                tinsert(activePlayerList, playerName);
            end
            local playerInRaid = nil;
            for key, val in pairs(MRT_RaidLog[MRT_NumOfCurrentRaid]["Players"]) do
                if (val["Name"] == playerName) then
                    if(val["Leave"] == nil) then playerInRaid = true; end
                end
            end
            if ((playerInRaid == nil) and (playerOnline or MRT_Options["Attendance_TrackOffline"]) and (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= (raidSize / 5)))) then
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
    local maxPlayers = MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"];
    local _, _, diffID = MRT_GetInstanceInfo();
    if (man_diff) then
        diffID = MRT_RaidLog[MRT_NumOfCurrentRaid]["DiffID"];
        if (man_diff == "H" and (diffID == 3 or diffID == 4)) then
            diffID = diffID + 2;
        end
    end
    local trackedPlayers = {};
    local numRaidMembers = MRT_GetNumRaidMembers();
    for i = 1, numRaidMembers do
        local playerName, _, playerSubGroup, _, _, _, _, playerOnline = GetRaidRosterInfo(i);
        -- check group number and group related tracking options
        if (not MRT_Options["Attendance_GroupRestriction"] or (playerSubGroup <= (maxPlayers / 5))) then
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
        ["Difficulty"] = diffID,
        ["BossId"] = bossID,
    }
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"], MRT_BossKillInfo);
    MRT_NumOfLastBoss = #MRT_RaidLog[MRT_NumOfCurrentRaid]["Bosskills"];
    if (bossname ~= MRT_L.Core["GuildAttendanceBossEntry"] and MRT_Options["Attendance_GuildAttendanceCheckEnabled"]) then
        if (MRT_Options["Attendance_GuildAttendanceCheckNoAuto"]) then
            StaticPopupDialogs["MRT_GA_MSGBOX"] = {
                preferredIndex = 3,
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
    MRT_ArrayBosslast = bossname;
    wipe(MRT_ArrayBossID);
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
    if (not MRT_IsInRaid()) then
        MRT_Print(MRT_L.Core["TakeSnapshot_NotInRaidError"]);
        return false; 
    end
    MRT_CreateNewRaid("Snapshot", 40, 0);
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
    local itemName, _, itemId, itemString, itemRarity, itemColor, itemLevel, _, itemType, itemSubType, _, _, _, _ = MRT_GetDetailedItemInformation(itemLink);
    if (not itemName == nil) then MRT_Debug("Panic! Item information lookup failed horribly. Source: MRT_AutoAddLoot()"); return; end
    -- check options, if this item should be tracked
    if (MRT_Options["Tracking_MinItemQualityToLog"] > itemRarity) then MRT_Debug("Item not tracked - quality is too low."); return; end
    if (MRT_Options["Tracking_OnlyTrackItemsAboveILvl"] > itemLevel) then MRT_Debug("Item not tracked - iLvl is too low."); return; end
    if (MRT_Options["ItemTracking_IgnoreGems"] and LBIR[itemType] == "Gem") then MRT_Debug("Item not tracked - it is a gem and the corresponding ignore option is on."); return; end
    if (MRT_Options["ItemTracking_IgnoreEnchantingMats"] and LBIR[itemType] == "Trade Goods" and LBIR[itemSubType] == "Enchanting") then MRT_Debug("Item not tracked - it is a enchanting material and the corresponding ignore option is on."); return; end
    if (MRT_IgnoredItemIDList[itemId]) then MRT_Debug("Item not tracked - ItemID is listed on the ignore list"); return; end
    local dkpValue = 0;
    local lootAction = nil;
    local itemNote = nil;
    local supressCostDialog = nil;
    local GPValues, GPValueText, GPListType, GPList = nil, nil, nil, nil;
    -- if EPGP GP system is enabled, get GP values
    if (MRT_Options["ItemTracking_UseEPGPValues"]) then
        local realm = GetRealmName();
        local lootClass = MRT_PlayerDB[realm][playerName]["Class"];
        GPValues, GPValueText, GPListType, GPList = EPGPCalc:GetItemGP(itemLink, lootClass);
        dkpValue = GPValues[1];
        itemNote = GPValueText;
    end
    -- if an external function handles item data, notify it
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
        local retOK, dkpValue_tmp, playerName_tmp, itemNote_tmp, lootAction_tmp, supressCostDialog_tmp = pcall(MRT_ExternalItemCostHandler.func, notifierInfo);
        if (retOK) then
            dkpValue = dkpValue_tmp;
            playerName = playerName_tmp;
            itemNote = itemNote_tmp;
            lootAction = lootAction_tmp;
            supressCostDialog = supressCostDialog_tmp;
        end
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
        MRT_AddBosskill(MRT_L.Core["Trash Mob"], "N");
    end
    -- if code reach this point, we should have valid item information, an active raid and at least one bosskill entry - make a table!
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
    };
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
                pcall(val, itemInfo, MRT_NOTIFYSOURCE_ADD_SILENT, MRT_NumOfCurrentRaid, itemNum);
            end
        end
        return; 
    end
    if (MRT_Options["Tracking_MinItemQualityToGetDKPValue"] > MRT_ItemColorValues[itemColor]) then return; end
    MRT_DKPFrame_AddToItemCostQueue(MRT_NumOfCurrentRaid, #MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"]);
end

function MRT_ManualAddLoot(itemLink, looter, cost)
    if (not MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L["GUI"]["No active raid"]);
        return; 
    end
    if (not MRT_NumOfLastBoss) then MRT_AddBosskill(MRT_L.Core["Trash Mob"]); end
    local itemName, _, itemId, itemString, itemRarity, itemColor, itemLevel, _, itemType, itemSubType, _, _, _, _ = MRT_GetDetailedItemInformation(itemLink);
    if (not itemName) then 
        MRT_Debug("MRT_ManualAddLoot(): Failed horribly when trying to get item informations.");
        return; 
    end
    local lootInfo = {
        ["ItemLink"] = itemLink,
        ["ItemString"] = itemString,
        ["ItemId"] = itemId,
        ["ItemName"] = itemName,
        ["ItemColor"] = itemColor,
        ["ItemCount"] = 1,
        ["Looter"] = looter,
        ["DKPValue"] = cost,
        ["BossNumber"] = MRT_NumOfLastBoss,
        ["Time"] = MRT_GetCurrentTime(),
    };
    tinsert(MRT_RaidLog[MRT_NumOfCurrentRaid]["Loot"], lootInfo);
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
            pcall(val, itemInfo, MRT_NOTIFYSOURCE_ADD_GUI, MRT_NumOfCurrentRaid, itemNum);
        end
    end
    return;
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
        MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"] = 0;
    elseif (button == "Bank") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = "bank";
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"] = lootNote;
        MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"] = 0;
    elseif (button == "Disenchanted") then
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Looter"] = "disenchanted";
        MRT_RaidLog[raidNum]["Loot"][itemNum]["Note"] = lootNote;
        MRT_RaidLog[raidNum]["Loot"][itemNum]["DKPValue"] = 0;
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
            pcall(val, itemInfo, MRT_NOTIFYSOURCE_ADD_POPUP, raidNum, itemNum);
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
    -- Put decider here: Which textblock should be used for the attendance check?
    local unformattedAnnouncement = nil;
    local bossName = bosskilled;
    if (bosskilled == "_attendancecheck_") then 
        bossName = MRT_L.Core["GuildAttendanceBossEntry"];        
    end
    if (MRT_Options["Attendance_GuildAttendanceUseCustomText"]) then
        unformattedAnnouncement = MRT_Options["Attendance_GuildAttendanceCustomText"];
    else
        if (bosskilled == "_attendancecheck_") then
            if (MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
                unformattedAnnouncement = MRT_GA_TEXT_TRIGGER_NOBOSS;
            else
                unformattedAnnouncement = MRT_GA_TEXT_CHARNAME_NOBOSS;
            end
        else
            if (MRT_Options["Attendance_GuildAttendanceCheckUseTrigger"]) then
                unformattedAnnouncement = MRT_GA_TEXT_TRIGGER_BOSS;
            else
                unformattedAnnouncement = MRT_GA_TEXT_CHARNAME_BOSS;
            end
        end
    end
    -- send announcement text
    MRT_GuildAttendanceSendAnnouncement(unformattedAnnouncement, bossName, MRT_TimerFrame.GADuration);
    -- start GA timer frame
    MRT_TimerFrame.GAText = unformattedAnnouncement;
    MRT_TimerFrame.GABoss = bossName;
    MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
    MRT_TimerFrame:SetScript("OnUpdate", function() MRT_GuildAttendanceCheckUpdate(); end);
end

function MRT_GuildAttendanceCheckUpdate()
    if (MRT_TimerFrame.GARunning) then
        -- is last message one minute ago?
        if ((time() - MRT_TimerFrame.GALastMsg) >= 60) then
            MRT_TimerFrame.GALastMsg = time();
            -- is GACheck duration up?
            if (MRT_TimerFrame.GADuration <= 0) then
                local timerUpText = "MRT: "..MRT_L.Core["GuildAttendanceTimeUpText"];
                MRT_GuildAttendanceSendAnnouncement(timerUpText, nil, nil);
                MRT_TimerFrame.GARunning = nil;
            else
                MRT_GuildAttendanceSendAnnouncement(MRT_TimerFrame.GAText, MRT_TimerFrame.GABoss, MRT_TimerFrame.GADuration);
                MRT_TimerFrame.GADuration = MRT_TimerFrame.GADuration - 1;
            end
        end
    end
    if (not MRT_TimerFrame.GARunning) then
        MRT_TimerFrame:SetScript("OnUpdate", nil);
    end
end

function MRT_GuildAttendanceSendAnnouncement(unformattedText, boss, timer)
    -- format text
    local announcement = unformattedText;
    if (boss) then 
        announcement = string.gsub(announcement, "<<BOSS>>", boss); 
    end
    if (timer) then 
        announcement = string.gsub(announcement, "<<TIME>>", timer); 
    end
    if (MRT_Options["Attendance_GuildAttendanceCheckTrigger"]) then 
        announcement = string.gsub(announcement, "<<TRIGGER>>", MRT_Options["Attendance_GuildAttendanceCheckTrigger"]); 
    end
    -- split announcement text block into multiple lines
    local textlineList = { string.split("\n", announcement) };
    -- send announcement
    local targetChannel = "GUILD";
    --[===[@debug@
    if (MRT_Options["General_DebugEnabled"]) then targetChannel = "RAID"; end
    --@end-debug@]===]
    for index, textline in ipairs(textlineList) do
        SendChatMessage(textline, targetChannel);
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
    if (uiVersion < 60000) then
        local first3 = tonumber("0x"..strsub(GUID, 3, 5));
        local unitType = bit.band(first3, 0x007);
        if ((unitType == 0x003) or (unitType == 0x005)) then
            return tonumber("0x"..strsub(GUID, 6, 10));
        else
            return nil;
        end
    else
        -- Player-GUID: Player-[server ID]-[player UID]
        -- other GUID: [Unit type]-0-[server ID]-[instance ID]-[zone UID]-[ID]-[Spawn UID]
        local unitType, _, _, _, _, ID = strsplit("-", GUID);
        if (unitType == "Creature") or (unitType == "Vehicle") then
            return tonumber(ID);
        else
            return nil;
        end
    end
end

-- @param itemIdentifer: Either itemLink or itemID and under special circumstances itemName
-- @usage local itemName, itemLink, itemId, itemString, itemRarity, itemColor, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = MRT_GetDetailedItemInformation(itemIdentifier)
-- If itemIdentifier is not valid, the return value will be nil
-- otherwise, it will be a long tuple of item information
-- this function should be compatible with 3.x and 4.0.x clients
function MRT_GetDetailedItemInformation(itemIdentifier)
    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemIdentifier);
    if (not itemLink) then return nil; end
    local _, itemString, _ = deformat(itemLink, "|c%s|H%s|h%s|h|r");
    local itemId, _ = deformat(itemString, "item:%d:%s");
    local itemColor = MRT_ItemColors[itemRarity + 1];
    return itemName, itemLink, itemId, itemString, itemRarity, itemColor, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice;
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

-- Adding generic function for counting raid members in order to deal with WoW MoP changes
function MRT_GetNumRaidMembers()
    if (IsInRaid()) then
        return GetNumGroupMembers();
    else
        return 0;
    end
end

-- Adding generic function in order to deal with WoW MoP changes (to ensure backwards compatibility)
function MRT_IsInRaid()
    return IsInRaid();
end

function MRT_GetInstanceDifficulty()
    local _, _, iniDiff = GetInstanceInfo();
    -- handle non instanced territories as 40 player raids
    if (iniDiff == 0) then iniDiff = 9; end
    return iniDiff
end

function MRT_GetInstanceInfo()
    local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
    -- handle non instanced territories as 40 player raids
    if (difficultyID == 0) then 
        difficultyID = 9;
        maxPlayers = 40;
    end
    return name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize
end