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
--	  * deDE: Mizukichan
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
		["General_MasterEnable"] = true,											-- AddonEnable: true/false
		["General_Version"] = GetAddOnMetadata("MizusRaidTracker", "Version"),		-- 
		["General_DebugEnabled"] = true,
		["Attendance_GuildAttendanceCheckEnabled"] = true,							-- 
		["Attendance_GuildAttendanceCheckDuration"] = 3,							-- in minutes - 0..5
		["Tracking_AutoCreateRaid"] = true,
		["Tracking_Log10MenRaids"] = false,
		["Tracking_AskForDKPValue"] = true,											-- 
		["Tracking_MinItemQualityToLog"] = 3,										-- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
		["Tracking_MinItemQualityToGetDKPValue"] = 4,								-- 0:poor, 1:common, 2:uncommon, 3:rare, 4:epic, 5:legendary, 6:artifact
		["Tracking_OnlyTrackInRaidDungeons"] = true,
		["Tracking_UseDefaultItemIgnoreList"] = true,								-- 
	},
};

--------------
--  Locals  --
--------------


-------------------
--  Initilazing  --
-------------------
function MRT_MainFrame_OnLoad(mainFrame)
	mainFrame:RegisterEvent("ADDON_LOADED");
	mainFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	mainFrame:RegisterEvent("CHAT_MSG_LOOT");
	mainFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	mainFrame:RegisterEvent("GUILD_ROSTER_UPDATE");
	mainFrame:RegisterEvent("VARIABLES_LOADED");
end


---------------------------------
--  Handler functions  --
---------------------------------
-- Eventhandler
function MRT_OnEvent(self, event, ...)
	if (event == "ADDON_LOADED") then
		self:UnregisterEvent("ADDON_LOADED");
		MRT_Options_ParseValues();
		MRT_Debug("Addon loaded.");
	end
	if (event == "CHAT_MSG_MONSTER_YELL") then
		local monsteryell, sourceName = ...;
		if (MRT_L.Bossyells[monsteryell]) then
			MRT_Debug("NPC Yell from Bossyelllist detected. Source was "..sourceName);
		end
	end
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		MRT_CombatLogHandler(...)
	end
	if (event == "VARIABLES_LOADED") then
		MRT_UpdateSavedOptions();
	end
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


function MRT_GetNPCID(GUID)
	local first3 = tonumber("0x"..strsub(GUID, 3, 5));
	local unitType = bit.band(first3,0x007);
	if (unitType == 0x003) then
		return tonumber("0x"..strsub(GUID,9,12));
	else
		return nil;
	end
end

