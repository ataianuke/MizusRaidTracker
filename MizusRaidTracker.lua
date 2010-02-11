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
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--


-------------------------------
--  Globals/Default Options  --
-------------------------------
MRT_ADDON_TITLE = GetAddOnMetadata("MizusRaidTracker", "Title");
MRT_ADDON_VERSION = GetAddOnMetadata("MizusRaidTracker", "Version");

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



---------------------------------
--  General (local) functions  --
---------------------------------
-- Called by Frame after Creation
function MRT_OnLoad()
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_LOOT");
	this:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	this:RegisterEvent("GUILD_ROSTER_UPDATE");
end

-- Eventhandler
function MRT_OnEvent(event, ...)
end

