-- ********************************************************
-- **        Mizus RaidTracker - enGB/enUS Local         **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

-----------------------------
--  Create Tablestructure  --
-----------------------------
MRT_L = { ["RaidZones"] = {}, ["Bossyells"] = {}, ["Core"] = {}, ["Options"] = {}, ["GUI"] = {}, ["ItemValues"] = {} };


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
	["The Eye of Eternity"] = "The Eye of Eternity",
	["The Obsidian Sanctum"] = "The Obsidian Sanctum",
	["Vault of Archavon"] = "Vault of Archavon",
	["Naxxramas"] = "Naxxramas",
	["Ulduar"] = "Ulduar",
	["Trial of the Crusader"] = "Trial of the Crusader",
	["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
	["Onyxia's Lair"] = "Onyxia's Lair",
	["Icecrown Citadel"] = "Icecrown Citadel",
    ["The Ruby Sanctum"] = "The Ruby Sanctum",
};


-----------------
--  Bossyells  --
-----------------
-- Naxxramas
MRT_L.Bossyells["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen";

-- Ulduar
MRT_L.Bossyells["You rush headlong into the maw of madness!"] = "Iron Council";  -- Normalmode - Stormcaller Brundir last
MRT_L.Bossyells["What have you gained from my defeat? You are no less doomed, mortals!"] = "Iron Council";  -- Semi-Hardmode - Runemaster Molgeim last
MRT_L.Bossyells["Impossible..."] = MRT_IsInstanceUlduar("Iron Council");  -- Hardmode - Steelbreaker last  // also yelled by Lich King -> instance check necessary
MRT_L.Bossyells["I... I am released from his grasp... at last."] = "Hodir";
MRT_L.Bossyells["Stay your arms! I yield!"] = "Thorim";
MRT_L.Bossyells["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Freya";
MRT_L.Bossyells["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Mimiron";
MRT_L.Bossyells["I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore."] = "Algalon";

-- Trial of the Crusader
MRT_L.Bossyells["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions";
MRT_L.Bossyells["The Scourge cannot be stopped..."] = "Val'kyr Twins";
    
-- Icecrown Citadel
MRT_L.Bossyells["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Gunship Battle"; -- Muradin
MRT_L.Bossyells["Damage control! Put those fires out! You haven't seen the last of the horde!"] = "Gunship Battle"; -- Saurfang
MRT_L.Bossyells["My queen, they... come."] = "Blood Prince Council"; -- Prince Keleseth
MRT_L.Bossyells["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker"; -- Dreamwalker

-- Ruby Sanctum
MRT_L.Bossyells["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "Halion"; -- Halion


---------------------------------
--  Core frames local strings  --
---------------------------------
-- Enter cost frame
MRT_L.Core["DKP_Frame_Title"] = "Enter cost";
MRT_L.Core["DKP_Frame_Text"] = "Enter cost for %s\nlooted by |cFFFFFFFF%s|r.";
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok";
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Cancel";
MRT_L.Core["DKP_Frame_Delete_Button"] = "Delete";
MRT_L.Core["DKP_Frame_Bank_Button"] = "Bank";
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Disenchanted";
-- guild attendance
MRT_L.Core["GuildAttendanceBossDownText"] = "%s down!";
MRT_L.Core["GuildAttendanceAnnounceText"] = "Whisper me your mains name to be added to the DKP list.";
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutes remaining.";
MRT_L.Core["GuildAttendanceTimeUpText"] = "If you haven't whispered me by now, you're too late.";
MRT_L.Core["GuildAttendanceBossEntry"] = "Attendance check";
MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Make attendance check now?";
MRT_L.Core["GuildAttendanceReply"] = "Added %s to DKP list.";
MRT_L.Core["GuildAttendanceReplyFail"] = "%s is already in DKP list.";
-- MsgBox
MRT_L.Core["MB_Ok"] = "Ok";
MRT_L.Core["MB_Cancel"] = "Cancel";
MRT_L.Core["MB_Yes"] = "Yes";
MRT_L.Core["MB_No"] = "No";
-- ExportFrame
MRT_L.Core["Export_Frame_Title"] = "Data export";
-- Snapshot
MRT_L.Core["TakeSnapshot_Done"] = "Snapshot taken.";
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Error: Active raid in progress. No snapshot taken.";
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Error: You are not in a raid. No snapshot taken.";


-----------------------------------
--  Option panels local strings  --
-----------------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Tracks raids, loot and attendance";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Enable MRT";
MRT_L.Options["MP_Debug"] = "Enable debug messages";

-- TrackingPanel - Title
MRT_L.Options["TP_Title"] = "Tracking";
MRT_L.Options["TP_TitleText"] = "MRT - Tracking options";
-- TrackingPanel - Checkboxes
MRT_L.Options["TP_Log10MenRaids"] = "Track 10 player raids";
MRT_L.Options["TP_LogAVRaids"] = "Track Archavons Vault";
MRT_L.Options["TP_AskForDKPValue"] = "Ask for item cost";
-- TrackingPanel - Slider
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Min item quality to log";
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Min item quality to ask cost for";

-- AttendancePanel - Title
MRT_L.Options["AP_Title"] = "Attendance";
MRT_L.Options["AP_TitleText"] = "MRT - Attendance options";
-- AP - Checkboxes
MRT_L.Options["AP_GuildAttendance"] = "Enable guild attendance check";
MRT_L.Options["AP_GroupRestriction"] = "Track only first 2/5 groups";
MRT_L.Options["AP_TrackOfflinePlayers"] = "Track offline players";
-- AP - Slider
MRT_L.Options["AP_GuildAttendanceDuration"] = "Duration of taking attendance";
MRT_L.Options["AP_Minutes"] = "minutes";

-- ExportPanel - Title
MRT_L.Options["EP_Title"] = "Export";
MRT_L.Options["EP_TitleText"] = "MRT - Export options";
MRT_L.Options["EP_CTRTTitleText"] = "CTRT compatible export settings";
MRT_L.Options["EP_TextExportTitleText"] = "Text export settings";
MRT_L.Options["EP_SetDateTimeFormat"] = "Set format of date and time";
-- EP - DropDownMenu
MRT_L.Options["EP_ChooseExport_Title"] = "Export format";
MRT_L.Options["EP_CTRT_compatible"] = "CT RaidTracker compatible";
MRT_L.Options["EP_Plain_Text"] = "Plain Text";
MRT_L.Options["EP_BBCode"] = "BBCode formated Text";
-- EP - Checkboxes
MRT_L.Options["EP_CTRT_AddPoorItem"] = "Add a poor item as loot to each boss \n(Bugfix for the EQDKP-CTRT-Import encounter detection)";
-- EP - ToolTips
MRT_L.Options["TT_EP_DateTimeTT"] = " %d - day of the month [01-31] \n %m - month [01-12] \n %y - two-digit year [00-99] \n %Y - full year \n\n %H - hour, using a 24-hour clock [00-23] \n %I - hour, using a 12-hour clock [01-12] \n %M - minute [00-59] \n %S - second [00-59] \n %p - either 'am' or 'pm'";


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Header_Title"] = "MRT - Raidlog";
MRT_L.GUI["Tables_RaidLogTitle"] = "Raid list";
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Raid attendees";
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Raid bosskills";
MRT_L.GUI["Tables_BossLootTitle"] = "Boss Loot";
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Boss attendees";
-- table col names
MRT_L.GUI["Col_Num"] = "#";
MRT_L.GUI["Col_Date"] = "Date";
MRT_L.GUI["Col_Zone"] = "Zone";
MRT_L.GUI["Col_Size"] = "Size";
MRT_L.GUI["Col_Name"] = "Name";
MRT_L.GUI["Col_Join"] = "Join";
MRT_L.GUI["Col_Leave"] = "Leave";
MRT_L.GUI["Col_Time"] = "Time";
MRT_L.GUI["Col_Difficulty"] = "Mode";
MRT_L.GUI["Col_Looter"] = "Looter";
MRT_L.GUI["Col_Cost"] = "Cost";
-- table entry local
MRT_L.GUI["Cell_Normal"] = "Normal";
MRT_L.GUI["Cell_Hard"] = "Hard";
-- buttons
MRT_L.GUI["Button_Add"] = "Add";
MRT_L.GUI["Button_Delete"] = "Delete";
MRT_L.GUI["Button_Export"] = "Export";
MRT_L.GUI["Button_ExportNormal"] = "Export N";
MRT_L.GUI["Button_ExportHeroic"] = "Export H";
MRT_L.GUI["Button_Modify"] = "Modify";
MRT_L.GUI["Button_TakeSnapshot"] = "Take Snapshot";
-- button tooltips
MRT_L.GUI["TT_Raid_Delete"] = "Delete selected raid.";
MRT_L.GUI["TT_Raid_Export"] = "Export selected raid.";
MRT_L.GUI["TT_Raid_ExportN"] = "Export all normal mode encounters of selected raid.";
MRT_L.GUI["TT_Raid_ExportH"] = "Export all heroic mode encounters of selected raid.";
MRT_L.GUI["TT_Boss_Add"] = "Add a boss encounter.";
MRT_L.GUI["TT_Boss_Add_TimeEB"] = "Format HH:MM \n\nLeave blank, if you want to add a boss \nas the most recent of the current raid.";
MRT_L.GUI["TT_Boss_Delete"] = "Delete selected boss encounter.";
MRT_L.GUI["TT_Boss_Export"] = "Export selected boss encounter.";
MRT_L.GUI["TT_RA_Add"] = "Add an attendee to the raid attendee list.";
MRT_L.GUI["TT_RA_Delete"] = "Delete selected raid attendee.";
MRT_L.GUI["TT_Loot_Add"] = "Add an item to the loot list.";
MRT_L.GUI["TT_Loot_Modify"] = "Modify data of selected item.";
MRT_L.GUI["TT_Loot_Delete"] = "Delete selected item.";
MRT_L.GUI["TT_BA_Add"] = "Add an attendee to the boss attendee list.";
MRT_L.GUI["TT_BA_Delete"] = "Delete selected boss attendee.";
MRT_L.GUI["TT_TakeSnapshot"] = "Make a snapshot of the current raidgroup. \nDoesn't work, if raidtracking is in progress. \nIn that case, add a boss event."
-- status/error messages
MRT_L.GUI["Can not delete current raid"] = "Error: Can't delete current raid.";
MRT_L.GUI["No boss selected"] = "Error: No boss selected.";
MRT_L.GUI["No boss attendee selected"] = "Error: No boss attendee selected.";
MRT_L.GUI["No raid selected"] = "Error: No raid selected.";
MRT_L.GUI["No raid attendee selected"] = "Error: No raid attendee selected.";
MRT_L.GUI["No loot selected"] = "Error: No item selected.";
MRT_L.GUI["No itemLink found"] = "Error: Itemlink is not valid.";
MRT_L.GUI["No valid time entered"] = "Error: No valid time entered.";
MRT_L.GUI["No active raid"] = "Error: No active raid in progress. Please enter time.";
MRT_L.GUI["No boss name entered"] = "Error: No boss name entered.";
MRT_L.GUI["Item cost invalid"] = "Error: Item cost is not a number.";
MRT_L.GUI["Entered time is not between start and end of raid"] = "Error: Entered time is not between start and end of raid.";
MRT_L.GUI["No valid difficulty entered"] = "Error: No valid difficulty entered.";
-- dialog messages
MRT_L.GUI["Confirm raid entry deletion"] = "Do you want to delete raid number %d?";
MRT_L.GUI["Confirm boss entry deletion"] = "Do you want to delete entry %d - %s - from the bosskill list?";
MRT_L.GUI["Confirm loot entry deletion"] = "Do you want to delete item %s from the loot list?";
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Do you want to delete %s from the raid attendees list?";
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Do you want to delete %s from the boss attendees list?";
MRT_L.GUI["Add raid attendees as boss attendees"] = "Do you want to add tracked raid attendees as boss attendees?";
MRT_L.GUI["Add loot data"] = "Add loot data";
MRT_L.GUI["Add boss attendee"] = "Add boss attendee";
MRT_L.GUI["Add bosskill"] = "Add bosskill";
MRT_L.GUI["Modify loot data"] = "Modify loot data";
MRT_L.GUI["Bossname"] = "Bossname";
MRT_L.GUI["Itemlink"] = "Itemlink";
MRT_L.GUI["Looter"] = "Looter";
MRT_L.GUI["Time"] = "Time";
MRT_L.GUI["Value"] = "Value";
MRT_L.GUI["Difficulty N or H"] = "Difficulty ('N' or 'H')"


------------
--  Misc  --
------------
MRT_L.ItemValues = {
    [1] = "Poor",
    [2] = "Common",
    [3] = "Uncommon",
    [4] = "Rare",
    [5] = "Epic",
    [6] = "Legendary",
    [7] = "Artifact", 
}