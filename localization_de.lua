-- *******************************************************
-- **          Mizus Raid Tracker - deDE Local          **
-- **            <ENTER URL HERE>            **
-- *******************************************************
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "deDE" then return end


-----------------
--  RaidZones  --
-----------------
MRT_L.Raidzones = {
    -- Wrath of the Lich King
    ["Das Auge der Ewigkeit"] = "The Eye of Eternity",
    ["Das Obsidiansanktum"] = "The Obsidian Sanctum",
    ["Archavons Kammer"] = "Vault of Archavon",
    ["Naxxramas"] = "Naxxramas",
    ["Ulduar"] = "Ulduar",
    ["Pr\195\188fung des Kreuzfahrers"] = "Trial of the Crusader",
    ["Pr\195\188fung des Obersten Kreuzfahrers"] = "Trial of the Grand Crusader",
    ["Onyxias Hort"] = "Onyxia's Lair",
    ["Eiskronenzitadelle"] = "Icecrown Citadel",   
};


-----------------
--  Bossyells  --
-----------------
-- Trial of the Crusader
MRT_L.Bossyells["Die Gei\195\159el kann nicht aufgehalten werden..."] = "Twin Val'kyr";
MRT_L.Bossyells["Ein tragischer Sieg. Wir wurden schw\195\164cher durch die heutigen Verluste. Wer au\195\159er dem Lichk\195\182nig profitiert von solchen Torheiten? Gro\195\159e Krieger gaben ihr Leben. Und wof\195\188r? Die wahre Bedrohung erwartet uns noch - der Lichk\195\182nig erwartet uns alle im Tod."] = "Faction Champions";
    
-- Icecrown Citadel
MRT_L.Bossyells["Sagt nicht, ich h\195\164tte Euch nicht gewarnt, Ihr Schurken! Vorw\195\164rts, Br\195\188der und Schwestern!"] = "Icecrown Gunship Battle"; -- Muradin
MRT_L.Bossyells["Die Allianz wankt. Vorw\195\164rts zum Lichk\195\182nig!"] = "Icecrown Gunship Battle"; -- Saurfang
MRT_L.Bossyells["Meine K\195\182nigin, sie... kommen."] = "Blood Prince Council"; -- Prince Keleseth
MRT_L.Bossyells["ICH BIN GEHEILT! Ysera, erlaubt mir, diese \195\188blen Kreaturen zu beseitigen!"] = "Valithria Dreamwalker"; -- Dreamwalker


-----------------------------------
--  Local for the Optionspanels  --
-----------------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Trackt Raids, Loot und Teilnehmer";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Aktiviert";
MRT_L.Options["MP_Debug"] = "Debugausgaben";
