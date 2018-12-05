-- *******************************************************
-- **          Mizus RaidTracker - deDE Local           **
-- **              <http://cosmocanyon.de>              **
-- *******************************************************
--
-- This localization is written by:
--  Mizukichan, Enokra, gOOvER
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

-- Check for addon table
if (not MizusRaidTracker) then return; end
local _L = MizusRaidTracker._L

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "deDE" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[529]["Algalon"] = "Ich sah Welten umhüllt von den Flammen der Schöpfer, sah ohne einen Hauch von Trauer ihre Bewohner vergehen. Ganze Planetensysteme geboren und vernichtet, während Eure sterblichen Herzen nur einmal schlagen. Doch immer war mein Herz kalt... ohne Mitgefühl. Ich - habe - nichts - gefühlt. Millionen, Milliarden Leben verschwendet. Trugen sie alle dieselbe Beharrlichkeit in sich, wie Ihr? Liebten sie alle das Leben so sehr, wie Ihr es tut?"
_L.yells[529]["Freya"] = "Seine Macht über mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."
_L.yells[529]["Hodir"] = "Ich... bin von ihm befreit... endlich."
_L.yells[529]["Mimiron"] = "Es scheint, als wäre mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gefängnis meine Primärdirektive überschreibt. Alle Systeme nun funktionstüchtig."
_L.yells[529]["Thorim"] = "Senkt Eure Waffen! Ich ergebe mich!"
_L.yells[543]["Faction Champions"] = "Ein tragischer Sieg. Wir wurden schwächer durch die heutigen Verluste. Wer außer dem Lichkönig profitiert von solchen Torheiten? Große Krieger gaben ihr Leben. Und wofür? Die wahre Bedrohung erwartet uns noch - der Lichkönig erwartet uns alle im Tod."
_L.yells[604]["Dreamwalker"] = "ICH BIN GEHEILT! Ysera, erlaubt mir, diese üblen Kreaturen zu beseitigen!"
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "Sagt nicht, ich hätte Euch nicht gewarnt, Ihr Schurken! Vorwärts, Brüder und Schwestern!"
_L.yells[604]["Icecrown Gunship Battle Horde"] = "Die Allianz wankt. Vorwärts zum Lichkönig!"
_L.yells[609]["Halion"] = "Genießt euren Sieg, Sterbliche, denn es war euer letzter. Bei der Rückkehr des Meisters wird diese Welt brennen!"
_L.yells[773]["Conclave Of Wind"] = "Das Konklave des Windes hat sich aufgelöst. Euer ehrenvolles Betragen sowie eure Entschlossenheit haben euch das Recht verschafft, mir in der Schlacht gegenüberzutreten, Sterbliche. Ich erwarte Euren Angriff auf meiner Plattform! Kommt!"
_L.yells[800]["Ragnaros"] = "Zu früh!… Ihr kommt zu früh..."
_L.yells[886]["Lei Shi"] = "Ich... ah... oh! Hab ich...? War ich...? Es war... so... trüb."
_L.yells[886]["Tsulong"] = "Ich danke Euch, Fremdlinge. Ich wurde befreit."
_L.yells[953]["Immerseus"] = "Ah, Ihr habt es geschafft! Das Wasser ist wieder rein."
_L.yells[953]["Spoils of Pandaria"] = "System wird neu gestartet. Die Energieversorgung muss stabil bleiben, sonst fliegt die ganze Chose in die Luft."
_L.yells[1026]["Hellfire Assault"] = "Alles muss man selbst machen..."


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "Bank"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Abbruch"
MRT_L.Core["DKP_Frame_Cost"] = "Kosten"
MRT_L.Core["DKP_Frame_Delete_Button"] = "Löschen"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Entzaubert"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "Gib die Kosten für"
MRT_L.Core["DKP_Frame_LootetBy"] = "erbeutet von |cFFFFFFFF%s|r ein."
MRT_L.Core["DKP_Frame_Note"] = "Notiz"
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok"
MRT_L.Core["DKP_Frame_Title"] = "Kosten eingeben"
MRT_L.Core["Export_AttendanceNote"] = [=[Setze bitte den Wert der Raid-Log-Import Einstellung
"Time in seconds, the loot belongs to the boss before."
auf 180 (oder weniger) Sekunden, um Fehler bei 
den Teilnehmerzuordnungen zu vermeiden.]=]
MRT_L.Core["Export_Attendees"] = "Teilnehmer"
MRT_L.Core["Export_Button"] = "Schließen"
MRT_L.Core["Export_Explanation"] = [=[Drücke Strg+C, um die Daten in die Zwischenablage zu kopieren.
Drücke Strg+V, um die Daten in den Browser zu importieren.]=]
MRT_L.Core["Export_Frame_Title"] = "Datenexport"
MRT_L.Core["Export_Heroic"] = "Heroic"
MRT_L.Core["Export_Loot"] = "Loot"
MRT_L.Core["Export_Normal"] = "Normal"
MRT_L.Core["GuildAttendanceAddNotice"] = "%s hat %s zur Bossteilnehmerliste hinzugefügt."
MRT_L.Core["GuildAttendanceAnnounceText"] = "Flüstert mir den Namen eures Mainchars, um zur DKP-Liste hinzugefügt zu werden."
MRT_L.Core["GuildAttendanceAnnounceText2"] = "Flüstert mir '%s', um zur DKP-Liste hinzugefügt zu werden."
MRT_L.Core["GuildAttendanceBossDownText"] = "%s down!"
MRT_L.Core["GuildAttendanceBossEntry"] = "Teilnehmer-Check"
MRT_L.Core["GuildAttendanceFailNotice"] = "%s versuchte vergeblich %s in die Boss-Teilnehmerliste einzutragen."
MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Soll jetzt ein Teilnehmer-Check durchgeführt werden?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d Minuten verbleibend."
MRT_L.Core["GuildAttendanceReply"] = "%s zur DKP-Liste hinzugefügt."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s befindet sich bereits in der DKP-Liste."
MRT_L.Core["GuildAttendanceTimeUpText"] = "Wer mich jetzt noch nicht angeflüster hat, ist zu spät!"
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Links-Klick um den Raidlog-Browser zu öffnen."
MRT_L.Core["LDB Right-click to open the options menu"] = "Rechts-Klick um das Optionsmenü zu öffnen"
MRT_L.Core["MB_Cancel"] = "Abbruch"
MRT_L.Core["MB_No"] = "Nein"
MRT_L.Core["MB_Ok"] = "Ok"
MRT_L.Core["MB_Yes"] = "Ja"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Fehler: Es ist ein aktiver Raid vorhanden. Kein Snapshot möglich."
MRT_L.Core["TakeSnapshot_Done"] = "Snapshot angefertigt."
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Fehler: Du bist nicht in einem Raid. Kein Snapshot möglich."
MRT_L.Core["Trash Mob"] = "Trash Mob"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "Logge nur die ersten 2/4/5/6 Gruppen"
MRT_L.Options["AP_GuildAttendance"] = "Aktiviere Gilden-Teilnehmer-Check"
MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "Eigener Text für den Gilden-Teilnehmer-Check:"
MRT_L.Options["AP_GuildAttendanceDuration"] = "Dauer des Teilnehmer-Checks"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Nach Bestätigung fragen"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "Trigger"
MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "Benutze eigenen Text für den Gilden-Teilnehmer-Check"
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "Benutze einen Trigger anstelle des Charakternamens"
MRT_L.Options["AP_Minutes"] = "Minuten"
MRT_L.Options["AP_Title"] = "Teilnehmer"
MRT_L.Options["AP_TitleText"] = "MRT - Teilnehmer-Optionen"
MRT_L.Options["AP_TrackOfflinePlayers"] = "Logge Spieler, die offline sind"
MRT_L.Options["EP_AllXMLExportsTitle"] = "Alle XML Export-Formate"
MRT_L.Options["EP_BBCode"] = "BBCode formatierter Text"
MRT_L.Options["EP_BBCode_wowhead"] = "BBCode formatierter Text mit wowhead Links"
MRT_L.Options["EP_ChooseExport_Title"] = "Exportformat"
MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Aktiviere Bosserkennungs-Fix für den
EQdkp(-Plus) CT_RaidTrackerImport 1.16.x]=]
MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (CT RaidTracker kompatibel)"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "Ignoriere Anwesenheit pro Boss"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[Aktiviere Anwesenheits-Fix für den
EQdkp-Plus Raid-Log-Import 0.5.6.x]=]
MRT_L.Options["EP_CTRTTitleText"] = "CTRT-kompatible Exporteinstellungen"
MRT_L.Options["EP_Currency"] = "Währung"
MRT_L.Options["EP_DKPBoard"] = "DKPBoard"
MRT_L.Options["EP_EnglishExport"] = "Exportiere Instanz- und Bossnamen auf Englisch"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
MRT_L.Options["EP_EQDKPTitleText"] = "EQdkp-Plux XML Einstellungen"
MRT_L.Options["EP_HTML"] = "CSS basierendes HTML mit Wowhead Links"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "Klartext"
MRT_L.Options["EP_SetDateTimeFormat"] = "Format für Datum und Zeit"
MRT_L.Options["EP_TextExportTitleText"] = "Text-Exporteinstellungen"
MRT_L.Options["EP_Title"] = "Export"
MRT_L.Options["EP_TitleText"] = "MRT - Export-Optionen"
MRT_L.Options["ITP_AutoFocus_Always"] = "Immer"
MRT_L.Options["ITP_AutoFocus_Never"] = "Nie"
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "Wenn nicht im Kampf"
MRT_L.Options["ITP_AutoFocus_Title"] = "Automatischer Fokus auf das Loot-Kosten-Fenster"
MRT_L.Options["ITP_IgnoreEnchantingMats"] = "Ignoriere Verzauberungsmaterialien"
MRT_L.Options["ITP_IgnoreGems"] = "Ignoriere Edelsteine"
MRT_L.Options["ITP_Title"] = "Item Tracking"
MRT_L.Options["ITP_TitleText"] = "MRT - Item-Tracking-Einstellungen"
MRT_L.Options["ITP_UseEPGP_GP_Values"] = "Benutze EPGP GP Werte"
MRT_L.Options["MP_AutoPrunning"] = "Lösche automatisch alle Raids, die älter sind als"
MRT_L.Options["MP_Days"] = "Tage"
MRT_L.Options["MP_Debug"] = "Aktiviere Debugnachrichten"
MRT_L.Options["MP_Description"] = "Trackt Raids, Loot und Teilnehmer"
MRT_L.Options["MP_Enabled"] = "Aktiviere automatisches Tracking"
MRT_L.Options["MP_MinimapIcon"] = "Minimap-Symbol anzeigen"
MRT_L.Options["MP_ResetGuiPos"] = "UI Position zurücksetzen"
MRT_L.Options["MP_SlashCmd"] = "Slash Befehl"
MRT_L.Options["TP_AskForDKPValue"] = "Frage nach Gegenstandskosten"
MRT_L.Options["TP_AskForDKPValuePersonal"] = "... auch im persönlichen Plündermodus"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Erstelle einen neuen Raid nach einem Zonenwechsel."
MRT_L.Options["TP_Log10MenRaids"] = "Logge 10 Spieler Raids"
MRT_L.Options["TP_LogAVRaids"] = "Logge PVP-Schlachtzüge (AK, BF)"
MRT_L.Options["TP_LogCataclysmRaids"] = "Logge Cataclysm Schlachtzüge"
MRT_L.Options["TP_LogLFRRaids"] = "LFR Raids aufzeichnen"
MRT_L.Options["TP_LogLootModePersonal"] = "Logger Plündermodus 'persönlich'"
MRT_L.Options["TP_LogMoPRaids"] = "Logge Pandaria Schlachtzüge"
MRT_L.Options["TP_LogWarlordsRaids"] = "Logge Warlords of Draenor Schlachtzüge"
MRT_L.Options["TP_LogWotLKRaids"] = "Logge WotLK-Schlachtzüge"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Min. Itemqualität für die nach Kosten gefragt wird"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Min. Itemqualität die getrackt wird"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = "Tracke nur Items mit Itemlevel gleich oder höher"
MRT_L.Options["TP_OnlyTrackItemsBelow"] = "oder mit Itemlevel gleich oder kleiner"
MRT_L.Options["TP_Title"] = "Raid Tracking"
MRT_L.Options["TP_TitleText"] = "MRT - Raid-Tracking-Einstellungen"
MRT_L.Options["TP_UseServerTime"] = "Nutze die Serverzeit."
MRT_L.Options["TT_AP_GA_CustomText"] = [=[Verfügbare Variablen:
<<BOSS>> - Name des Bossevents
<<TIME>> - Restdauer des Gilden-Teilnehmer-Checks
<<TRIGGER>> - Der eingestellte Trigger]=]
MRT_L.Options["TT_EP_AddPoorItem"] = [=[Diese Option ändert den Itemexport ein wenig, um die Bosserkennung
des alten CT_RaidTrackerImport zu fixen. Benutze diese Option, wenn du
in deinem Raid Bossevents ohne Loot hast. (z.B. Teilnehmerchecks)]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[%d - Tag des Monats [01-31]
%m - Monat [01-12]
%y - Jahr (zweistellig) [00-99]
%Y - volle Jahreszahl

%H - Stunde im 24 Stunden-Format [00-23]
%I - Stunde im 12 Stunden-Format [01-12]
%M - Minute [00-59]
%S - Sekunde [00-59]
%p - entweder 'am' oder 'pm']=]
MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[Diese Option ändert den Export der Zeitstempel ein wenig um die
50% Anwesenheitsschwelle des Raid-Log-Importers zu erreichen.
Benutze diese Option nur, wenn dein DKP System auf Bossanwesenheit basiert.]=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[Kommando ohne führenden Schrägstrich.
Nach dem Ändern des Wertes sollte ein Relog durchgeführt werden.]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "Fehler: Aktiven Raid gefunden. Bitte beende den aktuellen Raid, bevor du einen neuen startest."
MRT_L.GUI["Add boss attendee"] = "Füge Boss Teilnehmer hinzu"
MRT_L.GUI["Add bosskill"] = "Bosskill hinzufügen"
MRT_L.GUI["Add loot data"] = "Loot Daten hinzufügen"
MRT_L.GUI["Add raid attendee"] = "Füge Raidteilnehmer hinzu"
MRT_L.GUI["Bossname"] = "Bossname"
MRT_L.GUI["Button_Add"] = "Hinzufügen"
MRT_L.GUI["Button_Delete"] = "Löschen"
MRT_L.GUI["Button_EndCurrentRaid"] = "Beende aktuellen Raid"
MRT_L.GUI["Button_Export"] = "Export"
MRT_L.GUI["Button_ExportHeroic"] = "Export H"
MRT_L.GUI["Button_ExportNormal"] = "Export N"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "Starte Teilnehmercheck"
MRT_L.GUI["Button_Modify"] = "Bearbeiten"
MRT_L.GUI["Button_ResumeLastRaid"] = "Letzten Raid fortsetzen"
MRT_L.GUI["Button_StartNewRaid"] = "Starte neuen Raid"
MRT_L.GUI["Button_TakeSnapshot"] = "Snapshot machen"
MRT_L.GUI["Can not delete current raid"] = "Fehler: Kann laufenden Raid nicht löschen."
MRT_L.GUI["Cell_Hard"] = "Hard"
MRT_L.GUI["Cell_Normal"] = "Normal"
MRT_L.GUI["Col_Cost"] = "Kosten"
MRT_L.GUI["Col_Date"] = "Datum"
MRT_L.GUI["Col_Difficulty"] = "Modus"
MRT_L.GUI["Col_Join"] = "Beitreten"
MRT_L.GUI["Col_Leave"] = "Verlassen"
MRT_L.GUI["Col_Looter"] = "Looter"
MRT_L.GUI["Col_Name"] = "Name"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "Größe"
MRT_L.GUI["Col_Time"] = "Zeit"
MRT_L.GUI["Col_Zone"] = "Zone"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Willst du %s von der Bossteilnehmerliste löschen?"
MRT_L.GUI["Confirm boss entry deletion"] = "Willst du den Eintrag %d - %s - von der Bosskillliste löschen?"
MRT_L.GUI["Confirm loot entry deletion"] = "Willst du %s von der Lootliste löschen?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Willst du %s von der Raidteilnehmerliste löschen?"
MRT_L.GUI["Confirm raid entry deletion"] = "Willst du Raid Nummer %d löschen?"
MRT_L.GUI["Difficulty N or H"] = "Schwierigkeit ('N' oder 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "Fehler: Der aktive Raid kann nicht exportiert werden."
MRT_L.GUI["Entered join time is not before leave time"] = "Fehler: Eingegebene Startzeit ist nicht vor der Endzeit."
MRT_L.GUI["Entered time is not between start and end of raid"] = "Fehler: Eingegebene Zeit liegt nicht zwischen dem Start und dem Ende des Raids."
MRT_L.GUI["Header_Title"] = "MRT - Raidlog"
MRT_L.GUI["Item cost invalid"] = "Fehler: Itempreis ist keine Zahl"
MRT_L.GUI["Itemlink"] = "Itemlink oder ItemID oder Itemname"
MRT_L.GUI["Looter"] = "Looter"
MRT_L.GUI["Modify loot data"] = "Modifiziere Lootdaten."
MRT_L.GUI["No active raid in progress. Please enter time."] = "Fehler: Kein aktiver Raid. Bitte gib eine Uhrzeit an."
MRT_L.GUI["No active raid."] = "Fehler: Kein aktiver Raid."
MRT_L.GUI["No boss attendee selected"] = "Fehler: Kein Bossteilnehmer ausgewählt."
MRT_L.GUI["No boss name entered"] = "Fehler: Kein Bossname eingegeben."
MRT_L.GUI["No boss selected"] = "Fehler: Kein Boss ausgewählt."
MRT_L.GUI["No itemLink found"] = "Fehler: Itemlink ist ungültig."
MRT_L.GUI["No loot selected"] = "Fehler: Kein Item ausgewählt."
MRT_L.GUI["No name entered"] = "Fehler: Kein Name eingegeben."
MRT_L.GUI["No raid attendee selected"] = "Fehler: Kein Raidteilnehmer ausgewählt."
MRT_L.GUI["No raid selected"] = "Fehler: Kein Raid ausgewählt."
MRT_L.GUI["No valid difficulty entered"] = "Fehler: Kein gültiger Wert für die Schwierigkeit eingegeben."
MRT_L.GUI["No valid raid size"] = "Fehler: Keine gültiger Wert für die Raidgröße angegeben."
MRT_L.GUI["No valid time entered"] = "Fehler: Keine gültige Zeit eingegeben."
MRT_L.GUI["Note"] = "Notiz"
MRT_L.GUI["Player not in raid."] = "Error: Du bist in keinem Raid."
MRT_L.GUI["Raid size"] = "Raidgröße"
MRT_L.GUI["Resuming last raid failed"] = "Fehler: Die Fortsetzung des letzten Raids ist fehlgeschlagen."
MRT_L.GUI["Resuming last raid successful"] = "Der letzte Raid wird nun fortgesetzt..."
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Bossteilnehmer"
MRT_L.GUI["Tables_BossLootTitle"] = "Bossloot"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Raidteilnehmer"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Raidbosskills"
MRT_L.GUI["Tables_RaidLogTitle"] = "Raidliste"
MRT_L.GUI["Tables_RaidLootTitle"] = "Raidloot"
MRT_L.GUI["Time"] = "Uhrzeit"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[Format SS:MM

Wenn keine Eingabe erfolgt,
dann benutzt MRT die Raidstartzeit.]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[Format SS:MM

Wenn kein Wert eingegeben, dann benutzt 
MRT die Schlachtzugend- oder aktuelle Zeit.]=]
MRT_L.GUI["TT_BA_Add"] = "Fügt einen Teilnehmer zur Bossteilnehmer-Liste hinzu."
MRT_L.GUI["TT_BA_Delete"] = "Löscht den makierten Bossteilnehmer."
MRT_L.GUI["TT_Boss_Add"] = "Fügt einen Boss hinzu."
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Format HH:MM

Lasse das Feld leer, wenn du den Boss
als den letzten des Raids eintragen willst.]=]
MRT_L.GUI["TT_Boss_Delete"] = "Lösche den ausgewählten Boss."
MRT_L.GUI["TT_Boss_Export"] = "Exportiere den ausgewählten Boss."
MRT_L.GUI["TT_Loot_Add"] = "Füge ein Item zur Lootliste hinzu."
MRT_L.GUI["TT_Loot_Delete"] = "Lösche das ausgewählte Item."
MRT_L.GUI["TT_Loot_Modify"] = "Ändere die Daten des ausgewählten Items."
MRT_L.GUI["TT_RA_Add"] = "Füge einen Teilnehmer zur Raidteilnehmer-Liste hinzu."
MRT_L.GUI["TT_RA_Delete"] = "Lösche den ausgewählten Raidteilnehmer."
MRT_L.GUI["TT_Raid_Delete"] = "Lösche den ausgewählten Raid."
MRT_L.GUI["TT_Raid_Export"] = "Exportiere den ausgewählten Raid."
MRT_L.GUI["TT_Raid_ExportH"] = "Exportiere alle heroischen Bosse des ausgewählten Raids."
MRT_L.GUI["TT_Raid_ExportN"] = "Exportiere alle normalen Bosse des ausgewählten Raids."
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "Ohne Eingabe benutzt MRT 25 als den Standardwert."
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "Ohne Eingabe benutzt MRT deine momentane Zone."
MRT_L.GUI["TT_TakeSnapshot"] = [=[Eine Aufnahme des momentanen Schlachtzugs machen.
Funktioniert nicht, wenn die Schlachtzugbeobachung läuft.
Füge in dem Fall ein Bossereignis hinzu.]=]
MRT_L.GUI["Value"] = "Wert"
MRT_L.GUI["Zone name"] = "Zonenname"
