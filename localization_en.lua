-- ********************************************************
-- **        Mizus Raid Tracker - enGB/enUS Local        **
-- **            <ENTER URL HERE>            **
-- ********************************************************
--

-----------------------------
--  Create Tablestructure  --
-----------------------------
MRT_L = { ["RaidZones"] = {}, ["Bossyells"] = {}, ["Options"] = {}};


-----------------
--  RaidZones  --
-----------------
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
};


-----------------
--  Bossyells  --
-----------------
-- Trial of the Crusader
MRT_L.Bossyells["The Scourge cannot be stopped..."] = "Val'kyr Twins";
MRT_L.Bossyells["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions";
    
-- Icecrown Citadel
MRT_L.Bossyells["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Gunship Battle"; -- Muradin
MRT_L.Bossyells["Damage control! Put those fires out! You haven't seen the last of the horde!"] = "Gunship Battle"; -- Saurfang
MRT_L.Bossyells["My queen, they... come."] = "Blood Prince Council"; -- Prince Keleseth
MRT_L.Bossyells["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker"; -- Dreamwalker


---------------------------
--  Optionspanels local  --
---------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Tracks raids, loot and attendance";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Enabled";
MRT_L.Options["MP_Debug"] = "Debugmessages";

-- TrackingPanel - Title
MRT_L.Options["TP_Title"] = "Tracking";

-- AttendancePanel - Title
MRT_L.Options["AP_Title"] = "Attendance";

