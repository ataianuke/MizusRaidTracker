-- ********************************************************
-- **           Mizus RaidTracker - itIT Local           **
-- **              <http://cosmocanyon.de>               **
-- ********************************************************
--
-- This localization is written by:
--  <NOBODY>
--
-- Note: 
--  MRT requires a correct localization of bossyells for working
--

-- Check for addon table
if (not MizusRaidTracker) then return; end
local _L = MizusRaidTracker._L

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "itIT" then return end


-----------------
--  Bossyells  --
-----------------
-- Yells/Ulduar
	--[[Translation missing --]]
	_L.yells[529]["Algalon"] = "I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"
	--[[Translation missing --]]
	_L.yells[529]["Freya"] = "His hold on me dissipates. I can see clearly once more. Thank you, heroes."
	--[[Translation missing --]]
	_L.yells[529]["Hodir"] = "I... I am released from his grasp... at last."
	--[[Translation missing --]]
	_L.yells[529]["Mimiron"] = "It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."
	--[[Translation missing --]]
	_L.yells[529]["Thorim"] = "Stay your arms! I yield!"

-- Yells/Trials_of_the_Crusader
	--[[Translation missing --]]
	_L.yells[543]["Faction Champions"] = "A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."

-- Yells/Icecrown_Citadel
	--[[Translation missing --]]
	_L.yells[604]["Dreamwalker"] = "I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"
	--[[Translation missing --]]
	_L.yells[604]["Icecrown Gunship Battle Alliance"] = "Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"
	--[[Translation missing --]]
	_L.yells[604]["Icecrown Gunship Battle Horde"] = "The Alliance falter. Onward to the Lich King!"

-- Yells/Ruby_Sanctum
	--[[Translation missing --]]
	_L.yells[609]["Halion"] = "Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"

-- Yells/Throne_of_the_Four_Winds
	--[[Translation missing --]]
	_L.yells[773]["Conclave Of Wind"] = "The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!"

-- Yells/Firelands
	--[[Translation missing --]]
	_L.yells[800]["Ragnaros"] = "Too soon! ... You have come too soon..."

-- Yells/Terrace_of_Endless_Spring
	--[[Translation missing --]]
	_L.yells[886]["Lei Shi"] = "I... ah... oh! Did I...? Was I...? It was... so... cloudy."
	--[[Translation missing --]]
	_L.yells[886]["Tsulong"] = "I thank you, strangers. I have been freed."

-- Yells/Siege_of_Orgrimmar
	--[[Translation missing --]]
	_L.yells[953]["Immerseus"] = "Ah, you have done it!  The waters are pure once more."
	--[[Translation missing --]]
	_L.yells[953]["Spoils of Pandaria"] = "System resetting. Don't turn the power off, or the whole thing will probably explode."

-- Yells/Hellfire_Citadel
	--[[Translation missing --]]
	_L.yells[1026]["Hellfire Assault"] = "If you want something done right, you have to do it yourself..."



---------------------------------
--  Core frames local strings  --
---------------------------------
-- MRT_L/Core
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Bank_Button"] = "Bank"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Cancel_Button"] = "Cancel"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Cost"] = "Cost"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Delete_Button"] = "Delete"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Disenchanted"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_EnterCostFor"] = "Enter cost for"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_LootetBy"] = "looted by |cFFFFFFFF%s|r."
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Note"] = "Note"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_OK_Button"] = "Ok"
	--[[Translation missing --]]
	MRT_L.Core["DKP_Frame_Title"] = "Enter cost"
	--[[Translation missing --]]
	MRT_L.Core["Export_AttendanceNote"] = [=[In the Raid-Log-Import-Settings, please set the option
"Time in seconds, the loot belongs to the boss before."
to or below 180 seconds to avoid attendance issues.]=]
	--[[Translation missing --]]
	MRT_L.Core["Export_Attendees"] = "Attendees"
	--[[Translation missing --]]
	MRT_L.Core["Export_Button"] = "Close"
	--[[Translation missing --]]
	MRT_L.Core["Export_Explanation"] = [=[Press Ctrl+C to copy the data to the clipboard.
Press Ctrl+V to import data in your webbrowser.]=]
	--[[Translation missing --]]
	MRT_L.Core["Export_Frame_Title"] = "Data export"
	--[[Translation missing --]]
	MRT_L.Core["Export_Heroic"] = "Heroic"
	--[[Translation missing --]]
	MRT_L.Core["Export_Loot"] = "Loot"
	--[[Translation missing --]]
	MRT_L.Core["Export_Normal"] = "Normal"
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceAddNotice"] = "%s added %s to the boss attendee list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceAnnounceText"] = "Whisper me your mains name to be added to the DKP list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceAnnounceText2"] = "Whisper me with '%s' to be added to the DKP list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceBossDownText"] = "%s down!"
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceBossEntry"] = "Attendance check"
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceFailNotice"] = "%s failed to add %s to the boss attendee list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Make attendance check now?"
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutes remaining."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceReply"] = "Added %s to DKP list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceReplyFail"] = "%s is already in DKP list."
	--[[Translation missing --]]
	MRT_L.Core["GuildAttendanceTimeUpText"] = "If you haven't whispered me by now, you're too late."
	--[[Translation missing --]]
	MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Left-click to toggle the raidlog browser"
	--[[Translation missing --]]
	MRT_L.Core["LDB Right-click to open the options menu"] = "Right-click to open the options menu"
	--[[Translation missing --]]
	MRT_L.Core["MB_Cancel"] = "Cancel"
	--[[Translation missing --]]
	MRT_L.Core["MB_No"] = "No"
	--[[Translation missing --]]
	MRT_L.Core["MB_Ok"] = "Ok"
	--[[Translation missing --]]
	MRT_L.Core["MB_Yes"] = "Yes"
	--[[Translation missing --]]
	MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Error: Active raid in progress. No snapshot taken."
	--[[Translation missing --]]
	MRT_L.Core["TakeSnapshot_Done"] = "Snapshot taken."
	--[[Translation missing --]]
	MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Error: You are not in a raid. No snapshot taken."
	--[[Translation missing --]]
	MRT_L.Core["Trash Mob"] = "Trash Mob"



-----------------------------------
--  Option panels local strings  --
-----------------------------------
-- MRT_L/Options
	--[[Translation missing --]]
	MRT_L.Options["AP_GroupRestriction"] = "Track only first 2/4/5/6 groups"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendance"] = "Enable guild attendance check"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "Custom guild attendance text:"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceDuration"] = "Duration of taking attendance"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Ask for confirmation"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceTrigger"] = "Trigger"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "Use custom guild attendance text"
	--[[Translation missing --]]
	MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "Use trigger instead of character name"
	--[[Translation missing --]]
	MRT_L.Options["AP_Minutes"] = "minutes"
	--[[Translation missing --]]
	MRT_L.Options["AP_Title"] = "Attendance"
	--[[Translation missing --]]
	MRT_L.Options["AP_TitleText"] = "MRT - Attendance options"
	--[[Translation missing --]]
	MRT_L.Options["AP_TrackOfflinePlayers"] = "Track offline players"
	--[[Translation missing --]]
	MRT_L.Options["EP_AllXMLExportsTitle"] = "All XML export formats"
	--[[Translation missing --]]
	MRT_L.Options["EP_BBCode"] = "BBCode formatted Text"
	--[[Translation missing --]]
	MRT_L.Options["EP_BBCode_wowhead"] = "BBCode formatted Text with wowhead links"
	--[[Translation missing --]]
	MRT_L.Options["EP_ChooseExport_Title"] = "Export format"
	--[[Translation missing --]]
	MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Enable boss encounter detection fix for the
EQdkp(-Plus) CT_RaidTrackerImport 1.16.x]=]
	--[[Translation missing --]]
	MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (CT RaidTracker compatible)"
	--[[Translation missing --]]
	MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "Ignore per boss attendance"
	--[[Translation missing --]]
	MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[Enable attendance fix for the 
EQdkp-Plus Raid-Log-Import 0.5.6.x]=]
	--[[Translation missing --]]
	MRT_L.Options["EP_CTRTTitleText"] = "CTRT compatible export settings"
	--[[Translation missing --]]
	MRT_L.Options["EP_Currency"] = "Currency"
	--[[Translation missing --]]
	MRT_L.Options["EP_DKPBoard"] = "DKPBoard"
	--[[Translation missing --]]
	MRT_L.Options["EP_EnglishExport"] = "Export zone names and boss names in english"
	--[[Translation missing --]]
	MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
	--[[Translation missing --]]
	MRT_L.Options["EP_EQDKPTitleText"] = "EQdkp-Plus XML settings"
	--[[Translation missing --]]
	MRT_L.Options["EP_HTML"] = "CSS based HTML with wowhead links"
	--[[Translation missing --]]
	MRT_L.Options["EP_JSON"] = "JSON"
	--[[Translation missing --]]
	MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
	--[[Translation missing --]]
	MRT_L.Options["EP_Onslaught_LootList"] = "Onslaught Loot List"
	--[[Translation missing --]]
	MRT_L.Options["EP_Plain_Text"] = "Plain Text"
	--[[Translation missing --]]
	MRT_L.Options["EP_SetDateTimeFormat"] = "Set format of date and time"
	--[[Translation missing --]]
	MRT_L.Options["EP_TextExportTitleText"] = "Text export settings"
	--[[Translation missing --]]
	MRT_L.Options["EP_Title"] = "Export"
	--[[Translation missing --]]
	MRT_L.Options["EP_TitleText"] = "MRT - Export options"
	--[[Translation missing --]]
	MRT_L.Options["ITP_AutoFocus_Always"] = "Always"
	--[[Translation missing --]]
	MRT_L.Options["ITP_AutoFocus_Never"] = "Never"
	--[[Translation missing --]]
	MRT_L.Options["ITP_AutoFocus_NoCombat"] = "When not in combat"
	--[[Translation missing --]]
	MRT_L.Options["ITP_AutoFocus_Title"] = "AutoFocus on loot cost dialog"
	--[[Translation missing --]]
	MRT_L.Options["ITP_IgnoreEnchantingMats"] = "Ignore enchanting materials"
	--[[Translation missing --]]
	MRT_L.Options["ITP_IgnoreGems"] = "Ignore gems"
	--[[Translation missing --]]
	MRT_L.Options["ITP_Title"] = "Item tracking"
	--[[Translation missing --]]
	MRT_L.Options["ITP_TitleText"] = "MRT - Item tracking options"
	--[[Translation missing --]]
	MRT_L.Options["ITP_UseEPGP_GP_Values"] = "Use EPGP GP values"
	--[[Translation missing --]]
	MRT_L.Options["MP_AutoPrunning"] = "Automatically delete raids older than"
	--[[Translation missing --]]
	MRT_L.Options["MP_Days"] = "days"
	--[[Translation missing --]]
	MRT_L.Options["MP_Debug"] = "Enable debug messages"
	--[[Translation missing --]]
	MRT_L.Options["MP_Description"] = "Tracks raids, loot and attendance"
	--[[Translation missing --]]
	MRT_L.Options["MP_Enabled"] = "Enable automatic tracking"
	--[[Translation missing --]]
	MRT_L.Options["MP_MinimapIcon"] = "Show minimap icon"
	--[[Translation missing --]]
	MRT_L.Options["MP_ResetGuiPos"] = "Reset GUI position"
	--[[Translation missing --]]
	MRT_L.Options["MP_SlashCmd"] = "Slash command"
	--[[Translation missing --]]
	MRT_L.Options["TP_AskForDKPValue"] = "Ask for item cost"
	--[[Translation missing --]]
	MRT_L.Options["TP_AskForDKPValuePersonal"] = "... if loot mode is personal loot"
	--[[Translation missing --]]
	MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Create new raid on new zone"
	--[[Translation missing --]]
	MRT_L.Options["TP_Log10MenRaids"] = "Track 10 player raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogAVRaids"] = "Track PVP raids (VoA, BH)"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogBCRaids"] = "Track Burning Crusade raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogCataclysmRaids"] = "Track Cataclysm raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogClassicRaids"] = "Track classic raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogLFRRaids"] = "Track LFR raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogLootModePersonal"] = "Track loot mode 'Personal'"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogMoPRaids"] = "Track Pandaria raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWarlordsRaids"] = "Track Warlords of Draenor raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWhileGroup"] = "Track raids while being in a group"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWhileSolo"] = "Track raids while being solo"
	--[[Translation missing --]]
	MRT_L.Options["TP_LogWotLKRaids"] = "Track WotLK raids"
	--[[Translation missing --]]
	MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Min item quality to ask cost for"
	--[[Translation missing --]]
	MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Min item quality to log"
	--[[Translation missing --]]
	MRT_L.Options["TP_OnlyTrackItemsAbove"] = "Only track items equal or above Itemlevel"
	--[[Translation missing --]]
	MRT_L.Options["TP_OnlyTrackItemsBelow"] = "or equal or below Itemlevel"
	--[[Translation missing --]]
	MRT_L.Options["TP_Title"] = "Raid tracking"
	--[[Translation missing --]]
	MRT_L.Options["TP_TitleText"] = "MRT - Raid tracking options"
	--[[Translation missing --]]
	MRT_L.Options["TP_UseServerTime"] = "Use server time"
	--[[Translation missing --]]
	MRT_L.Options["TT_AP_GA_CustomText"] = [=[Available variables:
<<BOSS>> - Name of the boss event
<<TIME>> - Remaining time of the guild attendance check
<<TRIGGER>> - The custom trigger command]=]
	--[[Translation missing --]]
	MRT_L.Options["TT_EP_AddPoorItem"] = [=[This option changes the loot export a bit to fix the boss encounter detection 
of the CT_RaidTrackerImport. Use this, if you have boss events 
in your raid without loot associated to it. (e.g. attendance checks).]=]
	--[[Translation missing --]]
	MRT_L.Options["TT_EP_DateTimeTT"] = [=[ %d - day of the month [01-31] 
 %m - month [01-12] 
 %y - two-digit year [00-99] 
 %Y - full year 

 %H - hour, using a 24-hour clock [00-23] 
 %I - hour, using a 12-hour clock [01-12] 
 %M - minute [00-59] 
 %S - second [00-59] 
 %p - either 'am' or 'pm']=]
	--[[Translation missing --]]
	MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[This option changes the export of timestamps a bit to pass 
the 50% attendance threshold of the Raid-Log-Importer. 
Only use this option, if your DKP system is based on per boss attendance.]=]
	--[[Translation missing --]]
	MRT_L.Options["TT_MP_SlashCmd"] = [=[Command without leading slash.
A relog after changing this value is recommended.]=]



-------------------
--  GUI strings  --
-------------------
-- MRT_L/GUI
	--[[Translation missing --]]
	MRT_L.GUI["Active raid found. End current one first."] = "Error: Active raid found. Please end the active raid before starting a new one."
	--[[Translation missing --]]
	MRT_L.GUI["Add boss attendee"] = "Add boss attendee"
	--[[Translation missing --]]
	MRT_L.GUI["Add bosskill"] = "Add bosskill"
	--[[Translation missing --]]
	MRT_L.GUI["Add loot data"] = "Add loot data"
	--[[Translation missing --]]
	MRT_L.GUI["Add raid attendee"] = "Add raid attendee"
	--[[Translation missing --]]
	MRT_L.GUI["Bossname"] = "Bossname"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Add"] = "Add"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Delete"] = "Delete"
	--[[Translation missing --]]
	MRT_L.GUI["Button_EndCurrentRaid"] = "End current raid"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Export"] = "Export"
	--[[Translation missing --]]
	MRT_L.GUI["Button_ExportHeroic"] = "Export H"
	--[[Translation missing --]]
	MRT_L.GUI["Button_ExportNormal"] = "Export N"
	--[[Translation missing --]]
	MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "Make guild attendance check"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Modify"] = "Modify"
	--[[Translation missing --]]
	MRT_L.GUI["Button_Rename"] = "Rename"
	--[[Translation missing --]]
	MRT_L.GUI["Button_ResumeLastRaid"] = "Resume last raid"
	--[[Translation missing --]]
	MRT_L.GUI["Button_StartNewRaid"] = "Start new raid"
	--[[Translation missing --]]
	MRT_L.GUI["Button_TakeSnapshot"] = "Take Snapshot"
	--[[Translation missing --]]
	MRT_L.GUI["Can not delete current raid"] = "Error: Can't delete current raid."
	--[[Translation missing --]]
	MRT_L.GUI["Cell_Hard"] = "Hard"
	--[[Translation missing --]]
	MRT_L.GUI["Cell_LFR"] = "LFR"
	--[[Translation missing --]]
	MRT_L.GUI["Cell_Normal"] = "Normal"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Cost"] = "Cost"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Date"] = "Date"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Difficulty"] = "Mode"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Join"] = "Join"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Leave"] = "Leave"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Looter"] = "Looter"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Name"] = "Name"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Num"] = "#"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Size"] = "Size"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Time"] = "Time"
	--[[Translation missing --]]
	MRT_L.GUI["Col_Zone"] = "Zone"
	--[[Translation missing --]]
	MRT_L.GUI["Confirm boss attendee entry deletion"] = "Do you want to delete %s from the boss attendees list?"
	--[[Translation missing --]]
	MRT_L.GUI["Confirm boss entry deletion"] = "Do you want to delete entry %d - %s - from the bosskill list?"
	--[[Translation missing --]]
	MRT_L.GUI["Confirm loot entry deletion"] = "Do you want to delete item %s from the loot list?"
	--[[Translation missing --]]
	MRT_L.GUI["Confirm raid attendee entry deletion"] = "Do you want to delete %s from the raid attendees list?"
	--[[Translation missing --]]
	MRT_L.GUI["Confirm raid entry deletion"] = "Do you want to delete raid number %d?"
	--[[Translation missing --]]
	MRT_L.GUI["Difficulty N or H"] = "Difficulty ('N' or 'H')"
	--[[Translation missing --]]
	MRT_L.GUI["End tracking of current raid before exporting it"] = "Error: Can't export active raid."
	--[[Translation missing --]]
	MRT_L.GUI["Entered join time is not before leave time"] = "Error: Entered join time is not before leave time."
	--[[Translation missing --]]
	MRT_L.GUI["Entered time is not between start and end of raid"] = "Error: Entered time is not between start and end of raid."
	--[[Translation missing --]]
	MRT_L.GUI["Header_Title"] = "MRT - Raidlog"
	--[[Translation missing --]]
	MRT_L.GUI["Item cost invalid"] = "Error: Item cost is not a number."
	--[[Translation missing --]]
	MRT_L.GUI["Itemlink"] = "Itemlink or ItemID or Itemname"
	--[[Translation missing --]]
	MRT_L.GUI["Looter"] = "Looter"
	--[[Translation missing --]]
	MRT_L.GUI["Modify loot data"] = "Modify loot data"
	--[[Translation missing --]]
	MRT_L.GUI["No active raid in progress. Please enter time."] = "Error: No active raid in progress. Please enter time."
	--[[Translation missing --]]
	MRT_L.GUI["No active raid."] = "Error: No active raid."
	--[[Translation missing --]]
	MRT_L.GUI["No boss attendee selected"] = "Error: No boss attendee selected."
	--[[Translation missing --]]
	MRT_L.GUI["No boss name entered"] = "Error: No boss name entered."
	--[[Translation missing --]]
	MRT_L.GUI["No boss selected"] = "Error: No boss selected."
	--[[Translation missing --]]
	MRT_L.GUI["No itemLink found"] = "Error: Itemlink is not valid."
	--[[Translation missing --]]
	MRT_L.GUI["No loot selected"] = "Error: No item selected."
	--[[Translation missing --]]
	MRT_L.GUI["No name entered"] = "Error: No name entered."
	--[[Translation missing --]]
	MRT_L.GUI["No raid attendee selected"] = "Error: No raid attendee selected."
	--[[Translation missing --]]
	MRT_L.GUI["No raid selected"] = "Error: No raid selected."
	--[[Translation missing --]]
	MRT_L.GUI["No valid difficulty entered"] = "Error: No valid difficulty entered."
	--[[Translation missing --]]
	MRT_L.GUI["No valid raid size"] = "Error: No valid raid size entered."
	--[[Translation missing --]]
	MRT_L.GUI["No valid time entered"] = "Error: No valid time entered."
	--[[Translation missing --]]
	MRT_L.GUI["Note"] = "Note"
	--[[Translation missing --]]
	MRT_L.GUI["Player not in raid."] = "Error: You are not in a raid."
	--[[Translation missing --]]
	MRT_L.GUI["Raid size"] = "Raid size"
	--[[Translation missing --]]
	MRT_L.GUI["Rename boss"] = "Rename boss"
	--[[Translation missing --]]
	MRT_L.GUI["Resuming last raid failed"] = "Error: Failed to resume last raid"
	--[[Translation missing --]]
	MRT_L.GUI["Resuming last raid successful"] = "Last raid successfully resumed."
	--[[Translation missing --]]
	MRT_L.GUI["Tables_BossAttendeesTitle"] = "Boss attendees"
	--[[Translation missing --]]
	MRT_L.GUI["Tables_BossLootTitle"] = "Boss loot"
	--[[Translation missing --]]
	MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Raid attendees"
	--[[Translation missing --]]
	MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Raid bosskills"
	--[[Translation missing --]]
	MRT_L.GUI["Tables_RaidLogTitle"] = "Raid list"
	--[[Translation missing --]]
	MRT_L.GUI["Tables_RaidLootTitle"] = "Raid loot"
	--[[Translation missing --]]
	MRT_L.GUI["Time"] = "Time"
	--[[Translation missing --]]
	MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[Format HH:MM 

If left blank, MRT will use 
the raid start time.]=]
	--[[Translation missing --]]
	MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[Format HH:MM 

If left blank, MRT will use 
the raid end time or current time.]=]
	--[[Translation missing --]]
	MRT_L.GUI["TT_BA_Add"] = "Add an attendee to the boss attendee list."
	--[[Translation missing --]]
	MRT_L.GUI["TT_BA_Delete"] = "Delete selected boss attendee."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Add"] = "Add a boss encounter."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Format HH:MM 

Leave blank, if you want to add a boss 
as the most recent of the current raid.]=]
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Delete"] = "Delete selected boss encounter."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Export"] = "Export selected boss encounter."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Boss_Rename"] = "Renames selected boss encounter."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Loot_Add"] = "Add an item to the loot list."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Loot_Delete"] = "Delete selected item."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Loot_Modify"] = "Modify data of selected item."
	--[[Translation missing --]]
	MRT_L.GUI["TT_RA_Add"] = "Add an attendee to the raid attendee list."
	--[[Translation missing --]]
	MRT_L.GUI["TT_RA_Delete"] = "Delete selected raid attendee."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Raid_Delete"] = "Delete selected raid."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Raid_Export"] = "Export selected raid."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Raid_ExportH"] = "Export all heroic mode encounters of selected raid."
	--[[Translation missing --]]
	MRT_L.GUI["TT_Raid_ExportN"] = "Export all normal mode encounters of selected raid."
	--[[Translation missing --]]
	MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "If left blank, MRT will use 25 as the default value."
	--[[Translation missing --]]
	MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "If left blank, MRT will use your current zone."
	--[[Translation missing --]]
	MRT_L.GUI["TT_TakeSnapshot"] = [=[Make a snapshot of the current raidgroup. 
Doesn't work, if raidtracking is in progress. 
In that case, add a boss event.]=]
	--[[Translation missing --]]
	MRT_L.GUI["Value"] = "Value"
	--[[Translation missing --]]
	MRT_L.GUI["Zone name"] = "Zone name"


