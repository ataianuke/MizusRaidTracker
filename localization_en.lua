-- ********************************************************
-- **        Mizus Raid Tracker - enGB/enUS Local        **
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
-- MRT_L.Bossyells["Impossible..."] = "Iron Council";  -- Hardmode - Steelbreaker last  // also yelled by Lich King - damn
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
-- ExportFrame
MRT_L.Core["Export_Frame_Title"] = "Data export"


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