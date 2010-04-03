-- ********************************************************
-- **        Mizus Raid Tracker - enGB/enUS Local        **
-- **            <ENTER URL HERE>            **
-- ********************************************************
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

-----------------------------
--  Create Tablestructure  --
-----------------------------
MRT_L = { ["RaidZones"] = {}, ["Bossyells"] = {}, ["Core"] = {}, ["Options"] = {}};


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
MRT_L.Bossyells["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker";


---------------------------------
--  Core frames local strings  --
---------------------------------
-- Enter DKP cost frame
MRT_L.Core["DKP_Frame_Title"] = "Enter cost";
MRT_L.Core["DKP_Frame_Text"] = "Enter cost for %s\nlooted by |cFFFFFFFF%s|r.";
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok";
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Cancel";
MRT_L.Core["DKP_Frame_Delete_Button"] = "Delete";
MRT_L.Core["DKP_Frame_Bank_Button"] = "Bank";
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Disenchanted";


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
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "MinItemQualityToLog";
MRT_L.Options["TP_MinItemQualityToLog_Values"] = {
    [1] = "Poor",
    [2] = "Common",
    [3] = "Uncommon",
    [4] = "Rare",
    [5] = "Epic",
    [6] = "Legendary",
    [7] = "Artifact", 
}

-- AttendancePanel - Title
MRT_L.Options["AP_Title"] = "Attendance";
MRT_L.Options["AP_TitleText"] = "MRT - Attendance options";

