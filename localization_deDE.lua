-- *******************************************************
-- **          Mizus RaidTracker - deDE Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- The localizations is written by:
--  Mizukichan
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
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Die vier Reiter", -- FIXME!

    -- Ulduar
    ["Ihr lauft geradewegs in den Schlund des Wahnsinns!"] = "Versammlung des Eisens",  -- Normalmode - Stormcaller Brundir last
    ["What have you gained from my defeat? You are no less doomed, mortals!"] = "Versammlung des Eisens",  -- Semi-Hardmode - Runemaster Molgeim last FIXME!
    ["Unm\195\182glich..."] = function() return MRT_IsInstanceUlduar("Versammlung des Eisens") end,  -- Hardmode - Steelbreaker last // also yelled by Lich King -> instance check necessary
    ["Ich... bin von ihm befreit... endlich."] = "Hodir",
    ["Senkt Eure Waffen! Ich ergebe mich!"] = "Thorim",
    ["Seine Macht \195\188ber mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."] = "Freya",
    ["Es scheint, als w\195\164re mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gef\195\164ngnis meine Prim\195\164rdirektive \195\188berschreibt. Alle Systeme nun funktionst\195\188chtig."] = "Mimiron",
    ["I've rearranged the reply code. Your planet will be spared. I cannot be certain of my own calculations anymore."] = "Algalon",  -- FIXME!

    -- Trial of the Crusader
    ["Ein tragischer Sieg. Wir wurden schw\195\164cher durch die heutigen Verluste. Wer au\195\159er dem Lichk\195\182nig profitiert von solchen Torheiten? Gro\195\159e Krieger gaben ihr Leben. Und wof\195\188r? Die wahre Bedrohung erwartet uns noch - der Lichk\195\182nig erwartet uns alle im Tod."] = "Fraktionschampions",
    ["Die Gei\195\159el kann nicht aufgehalten werden..."] = "Val'kyr Zwillinge",
        
    -- Icecrown Citadel
    ["Sagt nicht, ich h\195\164tte Euch nicht gewarnt, Ihr Schurken! Vorw\195\164rts, Br\195\188der und Schwestern!"] = "Eiskrone Luftschiffkampf", -- Muradin
    ["Die Allianz wankt. Vorw\195\164rts zum Lichk\195\182nig!"] = "Eiskrone Luftschiffkampf", -- Saurfang
    ["Meine K\195\182nigin, sie... kommen."] = "Rat des Blutes", -- Prince Keleseth
    ["ICH BIN GEHEILT! Ysera, erlaubt mir, diese \195\188blen Kreaturen zu beseitigen!"] = "Valithria Traumwandler",

    -- Ruby Sanctum
    ["Genie\195\159t euren Sieg, Sterbliche, denn es war euer letzter. Bei der R\195\188ckkehr des Meisters wird diese Welt brennen!"] = "Halion", -- Halion
}


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core = {
	DKP_Frame_Bank_Button = "Bank",
	DKP_Frame_Cancel_Button = "Abbruch",
	DKP_Frame_Cost = "Kosten",
	DKP_Frame_Delete_Button = "L\195\182schen",
	DKP_Frame_Disenchanted_Button = "Entzaubert",
	DKP_Frame_EnterCostFor = "Gib die Kosten f\195\188r",
	DKP_Frame_LootetBy = "erbeutet von |cFFFFFFFF%s|r ein.",
	DKP_Frame_Note = "Notiz",
	DKP_Frame_OK_Button = "Ok",
	DKP_Frame_Title = "Kosten eingeben",
	Export_Attendees = "Teilnehmer",
	Export_Button = "Schlie\195\159en",
	Export_Explanation = "Dr\195\188cke Strg+C, um die Daten in die Zwischenablage zu kopieren.\nDr\195\188cke Strg+V, um die Daten in den Browser zu importieren.",
	Export_Frame_Title = "Datenexport",
	Export_Heroic = "Heroic",
	Export_Loot = "Loot",
	Export_Normal = "Normal",
	GuildAttendanceAnnounceText = "Fl\195\188stert mir den Namen eures Mainchars, um zur DKP-Liste hinzugef\195\188gt zu werden.",
	GuildAttendanceBossDownText = "%s down!",
	GuildAttendanceBossEntry = "Teilnehmer-Check",
	GuildAttendanceMsgBox = "%s down. Soll jetzt ein Teilnehmer-Check durchgef\195\188hrt werden?",
	GuildAttendanceRemainingTimeText = "%d Minuten verbleibend.",
	GuildAttendanceReply = "%s zur DKP-Liste hinzugef\195\188gt.",
	GuildAttendanceReplyFail = "%s befindet sich bereits in der DKP-Liste.",
	GuildAttendanceTimeUpText = "Wer mich jetzt noch nicht angefl\195\188ster hat, ist zu sp\195\164t!",
	["LDB Left-click to toggle the raidlog browser"] = "Links-Klick um den Raidlog-Browser zu \195\182ffnen.",
	["LDB Right-click to open the options menu"] = "Rechts-Klick um das Optionsmen\195\188 zu \195\182ffnen",
	MB_Cancel = "Abbruch",
	MB_No = "Nein",
	MB_Ok = "Ok",
	MB_Yes = "Ja",
	TakeSnapshot_CurrentRaidError = "Fehler: Es ist ein aktiver Raid vorhanden. Kein Snapshot m\195\182glich.",
	TakeSnapshot_Done = "Snapshot angefertigt.",
	TakeSnapshot_NotInRaidError = "Fehler: Du bist nicht in einem Raid. Kein Snapshot m\195\182glich.",
}


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options = {
	AP_GroupRestriction = "Logge nur die ersten 2/5 Gruppen",
	AP_GuildAttendance = "Aktiviere Gilden-Teilnehmer-Check",
	AP_GuildAttendanceDuration = "Dauer des Teilnehmer-Checks",
	AP_GuildAttendanceNoAuto = "Ask for confirmation", -- Requires localization
	AP_Minutes = "Minuten",
	AP_Title = "Teilnehmer",
	AP_TitleText = "MRT - Teilnehmer-Optionen",
	AP_TrackOfflinePlayers = "Logge Spieler, die offline sind",
	EP_BBCode = "BBCode formatierter Text",
	EP_CTRTTitleText = "CTRT-kompatible Exporteinstellungen",
	EP_CTRT_AddPoorItem = "F\195\188ge ein schlechtes Item als Loot zu jedem Boss hinzu\n(Bugfix f\195\188r die Bosserkennung des EQDKP-CTRT-Import-Plugin)",
	EP_CTRT_IgnorePerBossAttendance = "Ignore per boss attendance", -- Requires localization
	EP_CTRT_compatible = "CT RaidTracker kompatibel",
	EP_ChooseExport_Title = "Exportformat",
	EP_Currency = "W\195\164hrung",
	EP_Plain_Text = "Klartext",
	EP_SetDateTimeFormat = "Format f\195\188r Datum und Zeit",
	EP_TextExportTitleText = "Text-Exporteinstellungen",
	EP_Title = "Export",
	EP_TitleText = "MRT - Export-Optionen",
	MP_Debug = "Aktiviere Debugnachrichten",
	MP_Description = "Trackt Raids, Loot und Teilnehmer",
	MP_Enabled = "Aktiviere MRT",
	MP_SlashCmd = "Slash command", -- Requires localization
	TP_AskForDKPValue = "Frage nach Gegenstandskosten",
	TP_CreateNewRaidOnNewZone = "Erstelle einen neuen Raid nach einem Zonenwechsel.",
	TP_Log10MenRaids = "Logge 10 Spieler Raids",
	TP_LogAVRaids = "Logge Archavons Kammer",
	TP_MinItemQualityToGetCost_Desc = "Min. Itemqualit\195\164t f\195\188r die nach Kosten gefragt wird",
	TP_MinItemQualityToLog_Desc = "Min. Itemqualit\195\164t die getrackt wird",
	TP_Title = "Tracking",
	TP_TitleText = "MRT - Tracking-Optionen",
	TP_UseServerTime = "Nutze die Serverzeit.",
	TT_EP_DateTimeTT = "%d - Tag des Monats [01-31]\n%m - Monat [01-12]\n%y - Jahr (zweistellig) [00-99]\n%Y - volle Jahreszahl\n\n%H - Stunde im 24 Stunden-Format [00-23]\n%I - Stunde im 12 Stunden-Format [01-12]\n%M - Minute [00-59]\n%S - Sekunde [00-59]\n%p - entweder 'am' oder 'pm'",
	TT_MP_SlashCmd = "Command without leading slash.\nA relog after changing this value is recommended.", -- Requires localization
}


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI = {
	["Add boss attendee"] = "Add boss attendee", -- Requires localization
	["Add bosskill"] = "Add bosskill", -- Requires localization
	["Add loot data"] = "Add loot data", -- Requires localization
	["Add raid attendees as boss attendees"] = "Do you want to add tracked raid attendees as boss attendees?", -- Requires localization
	Bossname = "Bossname",
	Button_Add = "Add", -- Requires localization
	Button_Delete = "L\195\182schen",
	Button_Export = "Export",
	Button_ExportHeroic = "Export H",
	Button_ExportNormal = "Export N",
	Button_Modify = "Modify", -- Requires localization
	Button_TakeSnapshot = "Take Snapshot", -- Requires localization
	["Can not delete current raid"] = "Fehler: Kann laufenden Raid nicht l\195\182schen.",
	Cell_Hard = "Hard",
	Cell_Normal = "Normal",
	Col_Cost = "Kosten",
	Col_Date = "Datum",
	Col_Difficulty = "Modus",
	Col_Join = "Join", -- Requires localization
	Col_Leave = "Leave", -- Requires localization
	Col_Looter = "Looter",
	Col_Name = "Name",
	Col_Num = "#",
	Col_Size = "Gr\195\182\195\159e",
	Col_Time = "Zeit",
	Col_Zone = "Zone",
	["Confirm boss attendee entry deletion"] = "Willst du %s von der Bossteilnehmerliste l\195\182schen?",
	["Confirm boss entry deletion"] = "Willst du den Eintrag %d - %s - von der Bosskillliste l\195\182schen?",
	["Confirm loot entry deletion"] = "Willst du %s von der Lootliste l\195\182schen?",
	["Confirm raid attendee entry deletion"] = "Willst du %s von der Raidteilnehmerliste l\195\182schen?",
	["Confirm raid entry deletion"] = "Willst du Raid Nummer %d l\195\182schen?",
	["Difficulty N or H"] = "Difficulty ('N' or 'H')", -- Requires localization
	["End tracking of current raid before exporting it"] = "Fehler: Der aktive Raid kann nicht exportiert werden.",
	["Entered time is not between start and end of raid"] = "Fehler: Eingegebene Zeit liegt nicht zwischen dem Start und dem Ende des Raids.",
	Header_Title = "MRT - Raidlog",
	["Item cost invalid"] = "Fehler: Itempreis ist keine Zahl",
	Itemlink = "Itemlink",
	Looter = "Looter",
	["Modify loot data"] = "Modifiziere Lootdaten.",
	["No active raid"] = "Fehler: Kein aktiver Raid.",
	["No boss attendee selected"] = "Fehler: Kein Bossteilnehmer ausgew\195\164hlt.",
	["No boss name entered"] = "Fehler: Kein Bossname eingegeben.",
	["No boss selected"] = "Fehler: Kein Boss ausgew\195\164hlt.",
	["No itemLink found"] = "Fehler: Itemlink ist ung\195\188ltig.",
	["No loot selected"] = "Fehler: Kein Item ausgew\195\164hlt.",
	["No raid attendee selected"] = "Fehler: Kein Raidteilnehmer ausgew\195\164hlt.",
	["No raid selected"] = "Fehler: Kein Raid ausgew\195\164hlt.",
	["No valid difficulty entered"] = "Fehler: Kein g\195\188ltiger Wert f\195\188r die Schwierigkeit eingegeben.",
	["No valid time entered"] = "Fehler: Keine g\195\188ltige Zeit eingegeben.",
	Note = "Notiz",
	TT_BA_Add = "F\195\188gt einen Teilnehmer zur Bossteilnehmer-Liste hinzu.",
	TT_BA_Delete = "L\195\182scht den makierten Bossteilnehmer.",
	TT_Boss_Add = "F\195\188gt einen Boss hinzu.",
	TT_Boss_Add_TimeEB = "Format HH:MM\n\nLasse das Feld leer, wenn du den Boss\nals den letzten des Raids eintragen willst.",
	TT_Boss_Delete = "L\195\182sche den ausgew\195\164hlten Boss.",
	TT_Boss_Export = "Exportiere den ausgew\195\164hlten Boss.",
	TT_Loot_Add = "F\195\188ge ein Item zur Lootliste hinzu.",
	TT_Loot_Delete = "L\195\182sche das ausgew\195\164hlte Item.",
	TT_Loot_Modify = "\195\132ndere die Daten des ausgew\195\164hlten Items.",
	TT_RA_Add = "F\195\188ge einen Teilnehmer zur Raidteilnehmer-Liste hinzu.",
	TT_RA_Delete = "L\195\182sche den ausgew\195\164hlten Raidteilnehmer.",
	TT_Raid_Delete = "L\195\182sche den ausgew\195\164hlten Raid.",
	TT_Raid_Export = "Exportiere den ausgew\195\164hlten Raid.",
	TT_Raid_ExportH = "Exportiere alle heroischen Bosse des ausgew\195\164hlten Raids.",
	TT_Raid_ExportN = "Exportiere alle normalen Bosse des ausgew\195\164hlten Raids.",
	TT_TakeSnapshot = "Make a snapshot of the current raidgroup. \nDoesn't work, if raidtracking is in progress. \nIn that case, add a boss event.", -- Requires localization
	Tables_BossAttendeesTitle = "Bossteilnehmer",
	Tables_BossLootTitle = "Bossloot",
	Tables_RaidAttendeesTitle = "Raidteilnehmer",
	Tables_RaidBosskillsTitle = "Raidbosskills",
	Tables_RaidLogTitle = "Raidliste",
	Tables_RaidLootTitle = "Raidloot",
	Time = "Uhrzeit",
	Value = "Wert",
}


------------
--  Misc  --
------------
ItemValues = {
    [1] = "Schlecht",
    [2] = "Verbreitet",
    [3] = "Selten",
    [4] = "Rar",
    [5] = "Episch",
    [6] = "Legend\195\164r",
    [7] = "Artefakt", 
}
