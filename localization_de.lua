-- *******************************************************
-- **          Mizus RaidTracker - deDE Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "deDE" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
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
    ["Das Rubinsanktum"] = "The Ruby Sanctum", 
};


-----------------
--  Bossyells  --
-----------------
-- Naxxramas
MRT_L.Bossyells["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen"; -- FIXME!

-- Ulduar
MRT_L.Bossyells["Ihr lauft geradewegs in den Schlund des Wahnsinns!"] = "Iron Council";  -- Normalmode - Stormcaller Brundir last
MRT_L.Bossyells["What have you gained from my defeat? You are no less doomed, mortals!"] = "Iron Council";  -- Semi-Hardmode - Runemaster Molgeim last FIXME!
-- MRT_L.Bossyells["Unm\195\182glich..."] = "Iron Council";  -- Hardmode - Steelbreaker last / also yelled by Lick King... damn
MRT_L.Bossyells["Ich... bin von ihm befreit... endlich."] = "Hodir";
MRT_L.Bossyells["Senkt Eure Waffen! Ich ergebe mich!"] = "Thorim";
MRT_L.Bossyells["Seine Macht \195\188ber mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."] = "Freya";
MRT_L.Bossyells["Es scheint, als w\195\164re mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gef\195\164ngnis meine Prim\195\164rdirektive \195\188berschreibt. Alle Systeme nun funktionst\195\188chtig."] = "Mimiron";
MRT_L.Bossyells["I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore."] = "Algalon";  -- FIXME!

-- Trial of the Crusader
MRT_L.Bossyells["Ein tragischer Sieg. Wir wurden schw\195\164cher durch die heutigen Verluste. Wer au\195\159er dem Lichk\195\182nig profitiert von solchen Torheiten? Gro\195\159e Krieger gaben ihr Leben. Und wof\195\188r? Die wahre Bedrohung erwartet uns noch - der Lichk\195\182nig erwartet uns alle im Tod."] = "Faction Champions";
MRT_L.Bossyells["Die Gei\195\159el kann nicht aufgehalten werden..."] = "Twin Val'kyr";
    
-- Icecrown Citadel
MRT_L.Bossyells["Sagt nicht, ich h\195\164tte Euch nicht gewarnt, Ihr Schurken! Vorw\195\164rts, Br\195\188der und Schwestern!"] = "Icecrown Gunship Battle"; -- Muradin
MRT_L.Bossyells["Die Allianz wankt. Vorw\195\164rts zum Lichk\195\182nig!"] = "Icecrown Gunship Battle"; -- Saurfang
MRT_L.Bossyells["Meine K\195\182nigin, sie... kommen."] = "Blood Prince Council"; -- Prince Keleseth
MRT_L.Bossyells["ICH BIN GEHEILT! Ysera, erlaubt mir, diese \195\188blen Kreaturen zu beseitigen!"] = "Valithria Dreamwalker";

-- Ruby Sanctum
MRT_L.Bossyells["Genie\195\159t euren Sieg, Sterbliche, denn es war euer Letzter! Bei der R\195\188ckkehr des Meisters wird diese Welt brennen..."] = "Halion"; -- Halion


---------------------------------
--  Core frames local strings  --
---------------------------------
-- Enter DKP cost frame
MRT_L.Core["DKP_Frame_Title"] = "Kosten eingeben";
MRT_L.Core["DKP_Frame_Text"] = "Gib die Kosten f\195\188r %s\nerbeutet von |cFFFFFFFF%s|r ein.";
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok";
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Abbruch";
MRT_L.Core["DKP_Frame_Delete_Button"] = "L\195\182schen";
MRT_L.Core["DKP_Frame_Bank_Button"] = "Bank";
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Entzaubert";
-- guild attendance
MRT_L.Core["GuildAttendanceBossDownText"] = "%s down!";
MRT_L.Core["GuildAttendanceAnnounceText"] = "Whisper me your mains name to be added to the DKP list.";
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutes remaining.";
MRT_L.Core["GuildAttendanceTimeUpText"] = "Wer mich jetzt noch nicht angefl\195\188ster hat, ist zu sp\195\164t!";
MRT_L.Core["GuildAttendanceBossEntry"] = "Attendance check";
MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Make attendance check now?"
MRT_L.Core["GuildAttendanceReply"] = "%s zur DKP-Liste hinzugef\195\188gt."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s befindet sich bereits in der DKP-Liste.";
-- MsgBox
MRT_L.Core["MB_Ok"] = "Ok";
MRT_L.Core["MB_Cancel"] = "Abbruch";
MRT_L.Core["MB_Yes"] = "Ja";
MRT_L.Core["MB_No"] = "Nein";
-- ExportFrame
MRT_L.Core["Export_Frame_Title"] = "Daten Export"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Trackt Raids, Loot und Teilnehmer";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Aktiviere MRT";
MRT_L.Options["MP_Debug"] = "Aktiviere Debugnachrichten";

-- TrackingPanel - Title
MRT_L.Options["TP_Title"] = "Raidlog";
MRT_L.Options["TP_TitleText"] = "MRT - Raidlog-Optionen";
-- TrackingPanel - Checkboxes
MRT_L.Options["TP_Log10MenRaids"] = "Logge 10 Spieler Raids";
MRT_L.Options["TP_LogAVRaids"] = "Logge Archavons Kammer";
MRT_L.Options["TP_AskForDKPValue"] = "Frage nach Gegenstandskosten";
-- TrackingPanel - Slider
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Min item quality to log";
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Min item quality to ask cost for";

-- AttendancePanel - Title
MRT_L.Options["AP_Title"] = "Teilnehmerlog";
MRT_L.Options["AP_TitleText"] = "MRT - Teilnehmerlog-Optionen";
-- AP - Checkboxes
MRT_L.Options["AP_GuildAttendance"] = "Aktiviere Gilden-Teilnehmer-Check";
MRT_L.Options["AP_GroupRestriction"] = "Logge nur die ersten 2/5 Gruppen";
MRT_L.Options["AP_TrackOfflinePlayers"] = "Logge Spieler, die offline sind";
-- AP - Slider
MRT_L.Options["AP_GuildAttendanceDuration"] = "Dauer des Teilnehmer-Checks";
MRT_L.Options["AP_Minutes"] = "Minuten";


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Header_Title"] = "MRT - Raidlog";
MRT_L.GUI["Tables_RaidLogTitle"] = "Raidliste";
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Raidteilnehmer";
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Raidbosskills";
MRT_L.GUI["Tables_BossLootTitle"] = "Bossloot";
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Bossteilnehmer";
-- table col names
MRT_L.GUI["Col_Num"] = "#";
MRT_L.GUI["Col_Date"] = "Datum";
MRT_L.GUI["Col_Zone"] = "Zone";
MRT_L.GUI["Col_Size"] = "Gr\195\182\195\159e";
MRT_L.GUI["Col_Name"] = "Name";
MRT_L.GUI["Col_Join"] = "Join";
MRT_L.GUI["Col_Leave"] = "Leave";
MRT_L.GUI["Col_Time"] = "Zeit";
MRT_L.GUI["Col_Difficulty"] = "Modus";
MRT_L.GUI["Col_Looter"] = "Looter";
MRT_L.GUI["Col_Cost"] = "Kosten";
-- table entry local
MRT_L.GUI["Cell_Normal"] = "Normal";
MRT_L.GUI["Cell_Hard"] = "Hard";
-- buttons
MRT_L.GUI["Button_Add"] = "Add";
MRT_L.GUI["Button_Delete"] = "L\195\182schen";
MRT_L.GUI["Button_Export"] = "Export";
MRT_L.GUI["Button_ExportNormal"] = "Export N";
MRT_L.GUI["Button_ExportHeroic"] = "Export H";
MRT_L.GUI["Button_Modify"] = "Modify";
-- status/error messages
MRT_L.GUI["Can not delete current raid"] = "Error: Kann laufenden Raid nicht l\195\182schen.";
MRT_L.GUI["No boss selected"] = "Error: Kein Boss ausgew\195\164hlt.";
MRT_L.GUI["No boss attendee selected"] = "Error: Kein Bossteilnehmer ausgew\195\164hlt.";
MRT_L.GUI["No raid selected"] = "Error: Kein Raid ausgew\195\164hlt.";
MRT_L.GUI["No raid attendee selected"] = "Error: Kein Raidteilnehmer ausgew\195\164hlt.";
MRT_L.GUI["No loot selected"] = "Error: Kein Item ausgew\195\164hlt.";
MRT_L.GUI["No itemLink found"] = "Error: Itemlink ist ung\195\188ltig.";
MRT_L.GUI["Item cost invalid"] = "Error: Itemkosten ist keine Nummer";
-- dialog messages
MRT_L.GUI["Confirm raid entry deletion"] = "Willst du Raid Nummer %d l\195\182schen?";
MRT_L.GUI["Confirm boss entry deletion"] = "Willst du den Eintrag %d - %s - von der Bosskillliste l\195\182schen?";
MRT_L.GUI["Confirm loot entry deletion"] = "Willst du %s von der Lootliste l\195\182schen?";
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Willst du %s von der Raidteilnehmerliste l\195\182schen?";
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Willst du %s von der Bossteilnehmerliste l\195\182schen?";
MRT_L.GUI["Add loot data"] = "Add loot data";
MRT_L.GUI["Add boss attendee"] = "Add boss attendee";
MRT_L.GUI["Modify loot data"] = "Modify loot data";
MRT_L.GUI["Itemlink"] = "Itemlink";
MRT_L.GUI["Looter"] = "Looter";
MRT_L.GUI["Value"] = "Wert";


------------
--  Misc  --
------------
MRT_L.ItemValues = {
    [1] = "Schlecht",
    [2] = "Verbreitet",
    [3] = "Selten",
    [4] = "Rar",
    [5] = "Episch",
    [6] = "Legend\195\164r",
    [7] = "Artefakt", 
}