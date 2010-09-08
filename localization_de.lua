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
MRT_L.Bossyells["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Die vier Reiter"; -- FIXME!

-- Ulduar
MRT_L.Bossyells["Ihr lauft geradewegs in den Schlund des Wahnsinns!"] = "Versammlung des Eisens";  -- Normalmode - Stormcaller Brundir last
MRT_L.Bossyells["What have you gained from my defeat? You are no less doomed, mortals!"] = "Versammlung des Eisens";  -- Semi-Hardmode - Runemaster Molgeim last FIXME!
MRT_L.Bossyells["Unm\195\182glich..."] = MRT_IsInstanceUlduar("Versammlung des Eisens");  -- Hardmode - Steelbreaker last // also yelled by Lich King -> instance check necessary
MRT_L.Bossyells["Ich... bin von ihm befreit... endlich."] = "Hodir";
MRT_L.Bossyells["Senkt Eure Waffen! Ich ergebe mich!"] = "Thorim";
MRT_L.Bossyells["Seine Macht \195\188ber mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."] = "Freya";
MRT_L.Bossyells["Es scheint, als w\195\164re mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gef\195\164ngnis meine Prim\195\164rdirektive \195\188berschreibt. Alle Systeme nun funktionst\195\188chtig."] = "Mimiron";
MRT_L.Bossyells["I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore."] = "Algalon";  -- FIXME!

-- Trial of the Crusader
MRT_L.Bossyells["Ein tragischer Sieg. Wir wurden schw\195\164cher durch die heutigen Verluste. Wer au\195\159er dem Lichk\195\182nig profitiert von solchen Torheiten? Gro\195\159e Krieger gaben ihr Leben. Und wof\195\188r? Die wahre Bedrohung erwartet uns noch - der Lichk\195\182nig erwartet uns alle im Tod."] = "Fraktionschampions";
MRT_L.Bossyells["Die Gei\195\159el kann nicht aufgehalten werden..."] = "Val'kyr Zwillinge";
    
-- Icecrown Citadel
MRT_L.Bossyells["Sagt nicht, ich h\195\164tte Euch nicht gewarnt, Ihr Schurken! Vorw\195\164rts, Br\195\188der und Schwestern!"] = "Eiskrone Luftschiffkampf"; -- Muradin
MRT_L.Bossyells["Die Allianz wankt. Vorw\195\164rts zum Lichk\195\182nig!"] = "Eiskrone Luftschiffkampf"; -- Saurfang
MRT_L.Bossyells["Meine K\195\182nigin, sie... kommen."] = "Rat des Blutes"; -- Prince Keleseth
MRT_L.Bossyells["ICH BIN GEHEILT! Ysera, erlaubt mir, diese \195\188blen Kreaturen zu beseitigen!"] = "Valithria Traumwandler";

-- Ruby Sanctum
MRT_L.Bossyells["Genie\195\159t euren Sieg, Sterbliche, denn es war euer letzter. Bei der R\195\188ckkehr des Meisters wird diese Welt brennen!"] = "Halion"; -- Halion


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
MRT_L.Core["GuildAttendanceAnnounceText"] = "Flüstert mir den Namen eures Mainchars, um zur DKP-Liste hinzugefügt zu werden.";
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d Minuten verbleibend.";
MRT_L.Core["GuildAttendanceTimeUpText"] = "Wer mich jetzt noch nicht angefl\195\188ster hat, ist zu sp\195\164t!";
MRT_L.Core["GuildAttendanceBossEntry"] = "Teilnehmer-Check";
MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Soll jetzt ein Teilnehmer-Check durchgeführt werden?"
MRT_L.Core["GuildAttendanceReply"] = "%s zur DKP-Liste hinzugef\195\188gt."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s befindet sich bereits in der DKP-Liste.";
-- MsgBox
MRT_L.Core["MB_Ok"] = "Ok";
MRT_L.Core["MB_Cancel"] = "Abbruch";
MRT_L.Core["MB_Yes"] = "Ja";
MRT_L.Core["MB_No"] = "Nein";
-- ExportFrame
MRT_L.Core["Export_Frame_Title"] = "Daten Export";
MRT_L.Core["Export_Explanation"] = "Press Ctrl+C to copy the data to the clipboard.\nPress Ctrl+V to import data in your webbrowser.";
MRT_L.Core["Export_Button"] = "Close";
-- Text Export Local
MRT_L.Core["Export_Attendees"] = "Teilnehmer";
MRT_L.Core["Export_Heroic"] = "Heroic";
MRT_L.Core["Export_Loot"] = "Loot";
MRT_L.Core["Export_Normal"] = "Normal";
-- Snapshot
MRT_L.Core["TakeSnapshot_Done"] = "Snapshot taken.";
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Fehler: Es ist ein aktiver Raid vorhanden. Kein Snapshot möglich.";
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Error: You are not in a raid. No snapshot taken.";


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
MRT_L.Options["TT_EP_DateTimeTT"] = " %d - day of the month [01-31] \n %m - month [01-12] \n %y - two-digit year [00-99] \n %Y - full year \n %H - hour, using a 24-hour clock [00-23] \n %I - hour, using a 12-hour clock [01-12] \n %M - minute [00-59] \n %S - second [00-59] \n %p - either 'am' or 'pm'";


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
MRT_L.GUI["Can not delete current raid"] = "Error: Kann laufenden Raid nicht l\195\182schen.";
MRT_L.GUI["No boss selected"] = "Error: Kein Boss ausgew\195\164hlt.";
MRT_L.GUI["No boss attendee selected"] = "Error: Kein Bossteilnehmer ausgew\195\164hlt.";
MRT_L.GUI["No raid selected"] = "Error: Kein Raid ausgew\195\164hlt.";
MRT_L.GUI["No raid attendee selected"] = "Error: Kein Raidteilnehmer ausgew\195\164hlt.";
MRT_L.GUI["No loot selected"] = "Error: Kein Item ausgew\195\164hlt.";
MRT_L.GUI["No itemLink found"] = "Error: Itemlink ist ung\195\188ltig.";
MRT_L.GUI["No valid time entered"] = "Error: No valid time entered.";
MRT_L.GUI["No active raid"] = "Error: No active raid in progress. Please enter time.";
MRT_L.GUI["No boss name entered"] = "Error: No boss name entered.";
MRT_L.GUI["Item cost invalid"] = "Error: Itempreis ist keine Zahl";
MRT_L.GUI["Entered time is not between start and end of raid"] = "Error: Entered time is not between start and end of raid.";
MRT_L.GUI["No valid difficulty entered"] = "Error: No valid difficulty entered.";
-- dialog messages
MRT_L.GUI["Confirm raid entry deletion"] = "Willst du Raid Nummer %d l\195\182schen?";
MRT_L.GUI["Confirm boss entry deletion"] = "Willst du den Eintrag %d - %s - von der Bosskillliste l\195\182schen?";
MRT_L.GUI["Confirm loot entry deletion"] = "Willst du %s von der Lootliste l\195\182schen?";
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Willst du %s von der Raidteilnehmerliste l\195\182schen?";
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Willst du %s von der Bossteilnehmerliste l\195\182schen?";
MRT_L.GUI["Add raid attendees as boss attendees"] = "Do you want to add tracked raid attendees as boss attendees?";
MRT_L.GUI["Add loot data"] = "Add loot data";
MRT_L.GUI["Add boss attendee"] = "Add boss attendee";
MRT_L.GUI["Add bosskill"] = "Add bosskill";
MRT_L.GUI["Modify loot data"] = "Modify loot data";
MRT_L.GUI["Bossname"] = "Bossname";
MRT_L.GUI["Itemlink"] = "Itemlink";
MRT_L.GUI["Looter"] = "Looter";
MRT_L.GUI["Time"] = "Uhrzeit";
MRT_L.GUI["Value"] = "Wert";
MRT_L.GUI["Difficulty N or H"] = "Difficulty ('N' or 'H')"


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