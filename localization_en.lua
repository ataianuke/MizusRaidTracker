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
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",

    -- Ulduar
    ["You rush headlong into the maw of madness!"] = "Iron Council",  -- Normalmode - Stormcaller Brundir last
    ["What have you gained from my defeat? You are no less doomed, mortals!"] = "Iron Council",  -- Semi-Hardmode - Runemaster Molgeim last
    ["Impossible..."] = MRT_IsInstanceUlduar("Iron Council"),  -- Hardmode - Steelbreaker last  // also yelled by Lich King -> instance check necessary
    ["I... I am released from his grasp... at last."] = "Hodir",
    ["Stay your arms! I yield!"] = "Thorim",
    ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Freya",
    ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Mimiron",
    ["I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore."] = "Algalon",

    -- Trial of the Crusader
    ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions",
    ["The Scourge cannot be stopped..."] = "Val'kyr Twins",
        
    -- Icecrown Citadel
    ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Gunship Battle", -- Muradin
    ["The Alliance falter. Onward to the Lich King!"] = "Gunship Battle", -- Saurfang
    ["My queen, they... come."] = "Blood Prince Council", -- Prince Keleseth
    ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker", -- Dreamwalker

    -- Ruby Sanctum
    ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "Halion", -- Halion
}


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core = {
    DKP_Frame_Bank_Button = "Bank",
    DKP_Frame_Cancel_Button = "Cancel",
    DKP_Frame_Delete_Button = "Delete",
    DKP_Frame_Disenchanted_Button = "Disenchanted",
    DKP_Frame_OK_Button = "Ok",
    DKP_Frame_EnterCostFor = "Enter cost for",
    DKP_Frame_LootetBy = "looted by |cFFFFFFFF%s|r.",
    DKP_Frame_Title = "Enter cost",
    DKP_Frame_Cost = "Cost",
    DKP_Frame_Note = "Note",
    Export_Attendees = "Attendees",
    Export_Button = "Close",
    Export_Explanation = "Press Ctrl+C to copy the data to the clipboard.\nPress Ctrl+V to import data in your webbrowser.",
    Export_Frame_Title = "Data export",
    Export_Heroic = "Heroic",
    Export_Loot = "Loot",
    Export_Normal = "Normal",
    GuildAttendanceAnnounceText = "Whisper me your mains name to be added to the DKP list.",
    GuildAttendanceBossDownText = "%s down!",
    GuildAttendanceBossEntry = "Attendance check",
    GuildAttendanceMsgBox = "%s down. Make attendance check now?",
    GuildAttendanceRemainingTimeText = "%d minutes remaining.",
    GuildAttendanceReply = "Added %s to DKP list.",
    GuildAttendanceReplyFail = "%s is already in DKP list.",
    GuildAttendanceTimeUpText = "If you haven't whispered me by now, you're too late.",
    MB_Cancel = "Cancel",
    MB_No = "No",
    MB_Ok = "Ok",
    MB_Yes = "Yes",
    TakeSnapshot_CurrentRaidError = "Error: Active raid in progress. No snapshot taken.",
    TakeSnapshot_Done = "Snapshot taken.",
    TakeSnapshot_NotInRaidError = "Error: You are not in a raid. No snapshot taken.",
}


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options = {
	AP_GroupRestriction = "Track only first 2/5 groups",
	AP_GuildAttendance = "Enable guild attendance check",
    AP_GuildAttendanceNoAuto = "Ask for confirmation",
	AP_GuildAttendanceDuration = "Duration of taking attendance",
	AP_Minutes = "minutes",
	AP_Title = "Attendance",
	AP_TitleText = "MRT - Attendance options",
	AP_TrackOfflinePlayers = "Track offline players",
	EP_BBCode = "BBCode formatted Text",
	EP_ChooseExport_Title = "Export format",
	EP_CTRT_AddPoorItem = "Add a poor item as loot to each boss \n(Bugfix for the EQDKP-CTRT-Import encounter detection)",
	EP_CTRT_compatible = "CT RaidTracker compatible",
    EP_CTRT_IgnorePerBossAttendance = "Ignore per boss attendance",
	EP_CTRTTitleText = "CTRT compatible export settings",
    EP_Currency = "Currency",
	EP_Plain_Text = "Plain Text",
	EP_SetDateTimeFormat = "Set format of date and time",
	EP_TextExportTitleText = "Text export settings",
	EP_Title = "Export",
	EP_TitleText = "MRT - Export options",
	MP_Debug = "Enable debug messages",
	MP_Description = "Tracks raids, loot and attendance",
	MP_Enabled = "Enable MRT",
    MP_SlashCmd = "Slash command",
	TP_AskForDKPValue = "Ask for item cost",
    TP_CreateNewRaidOnNewZone = "Create new raid on new zone",
	TP_Log10MenRaids = "Track 10 player raids",
	TP_LogAVRaids = "Track Archavons Vault",
	TP_MinItemQualityToGetCost_Desc = "Min item quality to ask cost for",
	TP_MinItemQualityToLog_Desc = "Min item quality to log",
	TP_Title = "Tracking",
	TP_TitleText = "MRT - Tracking options",
    TP_UseServerTime = "Use server time",
	TT_EP_DateTimeTT = " %d - day of the month [01-31] \n %m - month [01-12] \n %y - two-digit year [00-99] \n %Y - full year \n\n %H - hour, using a 24-hour clock [00-23] \n %I - hour, using a 12-hour clock [01-12] \n %M - minute [00-59] \n %S - second [00-59] \n %p - either 'am' or 'pm'",
    TT_MP_SlashCmd = "Command without leading slash.\nA relog after changing this value is recommended.",
}


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI = {
	["Add boss attendee"] = "Add boss attendee",
	["Add bosskill"] = "Add bosskill",
	["Add loot data"] = "Add loot data",
	["Add raid attendees as boss attendees"] = "Do you want to add tracked raid attendees as boss attendees?",
	Bossname = "Bossname",
	Button_Add = "Add",
	Button_Delete = "Delete",
	Button_Export = "Export",
	Button_ExportHeroic = "Export H",
	Button_ExportNormal = "Export N",
	Button_Modify = "Modify",
	Button_TakeSnapshot = "Take Snapshot",
	["Can not delete current raid"] = "Error: Can't delete current raid.",
	Cell_Hard = "Hard",
	Cell_Normal = "Normal",
	Col_Cost = "Cost",
	Col_Date = "Date",
	Col_Difficulty = "Mode",
	Col_Join = "Join",
	Col_Leave = "Leave",
	Col_Looter = "Looter",
	Col_Name = "Name",
	Col_Num = "#",
	Col_Size = "Size",
	Col_Time = "Time",
	Col_Zone = "Zone",
	["Confirm boss attendee entry deletion"] = "Do you want to delete %s from the boss attendees list?",
	["Confirm boss entry deletion"] = "Do you want to delete entry %d - %s - from the bosskill list?",
	["Confirm loot entry deletion"] = "Do you want to delete item %s from the loot list?",
	["Confirm raid attendee entry deletion"] = "Do you want to delete %s from the raid attendees list?",
	["Confirm raid entry deletion"] = "Do you want to delete raid number %d?",
	["Difficulty N or H"] = "Difficulty ('N' or 'H')",
    ["End tracking of current raid before exporting it"] = "Error: Can't export active raid.",
	["Entered time is not between start and end of raid"] = "Error: Entered time is not between start and end of raid.",
	Header_Title = "MRT - Raidlog",
	["Item cost invalid"] = "Error: Item cost is not a number.",
	Itemlink = "Itemlink",
	Looter = "Looter",
	["Modify loot data"] = "Modify loot data",
	["No active raid"] = "Error: No active raid in progress. Please enter time.",
	["No boss attendee selected"] = "Error: No boss attendee selected.",
	["No boss name entered"] = "Error: No boss name entered.",
	["No boss selected"] = "Error: No boss selected.",
	["No itemLink found"] = "Error: Itemlink is not valid.",
	["No loot selected"] = "Error: No item selected.",
	["No raid attendee selected"] = "Error: No raid attendee selected.",
	["No raid selected"] = "Error: No raid selected.",
	["No valid difficulty entered"] = "Error: No valid difficulty entered.",
	["No valid time entered"] = "Error: No valid time entered.",
    Note = "Note",
	Tables_BossAttendeesTitle = "Boss attendees",
	Tables_BossLootTitle = "Boss loot",
	Tables_RaidAttendeesTitle = "Raid attendees",
	Tables_RaidBosskillsTitle = "Raid bosskills",
	Tables_RaidLogTitle = "Raid list",
	Tables_RaidLootTitle = "Raid loot",
	Time = "Time",
	TT_BA_Add = "Add an attendee to the boss attendee list.",
	TT_BA_Delete = "Delete selected boss attendee.",
	TT_Boss_Add = "Add a boss encounter.",
	TT_Boss_Add_TimeEB = "Format HH:MM \n\nLeave blank, if you want to add a boss \nas the most recent of the current raid.",
	TT_Boss_Delete = "Delete selected boss encounter.",
	TT_Boss_Export = "Export selected boss encounter.",
	TT_Loot_Add = "Add an item to the loot list.",
	TT_Loot_Delete = "Delete selected item.",
	TT_Loot_Modify = "Modify data of selected item.",
	TT_RA_Add = "Add an attendee to the raid attendee list.",
	TT_RA_Delete = "Delete selected raid attendee.",
	TT_Raid_Delete = "Delete selected raid.",
	TT_Raid_Export = "Export selected raid.",
	TT_Raid_ExportH = "Export all heroic mode encounters of selected raid.",
	TT_Raid_ExportN = "Export all normal mode encounters of selected raid.",
	TT_TakeSnapshot = "Make a snapshot of the current raidgroup. \nDoesn't work, if raidtracking is in progress. \nIn that case, add a boss event.",
	Value = "Value",
}


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
