-- *******************************************************
-- **          Mizus RaidTracker - frFR Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Cinedelle, Deepking, Cyliah
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
if GetLocale() ~= "frFR" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[529]["Algalon"] = "J'ai vu des mondes baigner dans les flammes"
_L.yells[529]["Freya"] = "Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros."
_L.yells[529]["Hodir"] = "Je suis... libéré de son emprise... enfin."
_L.yells[529]["Mimiron"] = "Il semblerait que j'aie pu faire une minime erreur de calcul."
_L.yells[529]["Thorim"] = "Retenez vos coups ! Je me rends !"
_L.yells[543]["Faction Champions"] = "Une victoire tragique et depourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait beneficier d'une telle folie?? De grands guerriers ont perdu la vie. Et pour quoi?? La vraie menace plane à l'horizon?: le roi-liche nous attend, tous, dans la mort."
_L.yells[604]["Dreamwalker"] = "JE REVIS !"
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !"
_L.yells[604]["Icecrown Gunship Battle Horde"] = "L'Alliance baisse pavillon. Sus au roi-liche !"
_L.yells[609]["Halion"] = "Savourez bien cette victoire mortels car ce serra votre dernière. Ce monde brulera au retour du maitre !"
_L.yells[773]["Conclave Of Wind"] = "Le conclave du Vent est dissipé. Votre conduite honorable et votre détermination vous valent le droit de m'affronter, mortels. J'attends votre attaque sur ma plate-forme ! Venez !"
_L.yells[800]["Ragnaros"] = "Trop tôt! ... Vous êtes venu trop tôt..."
_L.yells[886]["Lei Shi"] = "Je… ah… oh ! J’ai… ? Tout était… si… embrouillé."
_L.yells[886]["Tsulong"] = "Je vous remercie, étrangers. J'ai été libéré."
_L.yells[953]["Immerseus"] = "Ah, vous avez réussi ! Les eaux ont retrouvé leur pureté."
_L.yells[953]["Spoils of Pandaria"] = "Système en cours de réinitialisation. Veuillez ne pas le débrancher, ou il pourrait vous sauter à la figure."


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "Banque"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Annuler"
MRT_L.Core["DKP_Frame_Cost"] = "Coût"
MRT_L.Core["DKP_Frame_Delete_Button"] = "Supprimer"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Désenchanté"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "Saisir le coût pour"
MRT_L.Core["DKP_Frame_LootetBy"] = "gagné par |cFFFFFFFF%s|r"
MRT_L.Core["DKP_Frame_Note"] = "Note"
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok"
MRT_L.Core["DKP_Frame_Title"] = "Entrer le coût"
MRT_L.Core["Export_AttendanceNote"] = [=[Dans le Raid-Log-Import-Settings, s'il vous plaît définir l'option
"Temps en secondes, le butin appartient au Boss avant."
ou inférieur à 180 secondes pour éviter les problèmes d'assiduité.]=]
MRT_L.Core["Export_Attendees"] = "Participants"
MRT_L.Core["Export_Button"] = "Fermer"
MRT_L.Core["Export_Explanation"] = [=[Ctrl+C pour copier les données vers le presse-papier
Ctrl+V pour importer ces dernières dans votre navigateur.]=]
MRT_L.Core["Export_Frame_Title"] = "Export de données"
MRT_L.Core["Export_Heroic"] = "Héroïque"
MRT_L.Core["Export_Loot"] = "Loot"
MRT_L.Core["Export_Normal"] = "Normal"
MRT_L.Core["GuildAttendanceAddNotice"] = "%s a ajouté %s à la liste des participants."
MRT_L.Core["GuildAttendanceAnnounceText"] = "Wispez moi les noms de vos mains pour être ajoutés à la liste DKP."
MRT_L.Core["GuildAttendanceAnnounceText2"] = "Whisp moi avec '%s' pour être ajouter à la liste DKP"
MRT_L.Core["GuildAttendanceBossDownText"] = "%s down!"
MRT_L.Core["GuildAttendanceBossEntry"] = "Vérification des joueurs présents"
MRT_L.Core["GuildAttendanceFailNotice"] = "%s n'a pas pu ajouté %s à la liste des participants."
MRT_L.Core["GuildAttendanceMsgBox"] = "%s down. Faire une vérification des présences?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutes restantes."
MRT_L.Core["GuildAttendanceReply"] = "%s ajouté à la liste des DKP."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s est déjà dans la liste des DKP."
MRT_L.Core["GuildAttendanceTimeUpText"] = "Si vous ne m'avez pas encore chuchoter votre réponse, c'est trop tard."
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Clique-gauche pour montrer le navigateur de log de raid"
MRT_L.Core["LDB Right-click to open the options menu"] = "Clique-doit pour ouvrir le menu des options"
MRT_L.Core["MB_Cancel"] = "Annuler"
MRT_L.Core["MB_No"] = "Non"
MRT_L.Core["MB_Ok"] = "Ok"
MRT_L.Core["MB_Yes"] = "Oui"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Erreur : Raid actif en cours. Aucun instantané sauvé."
MRT_L.Core["TakeSnapshot_Done"] = "Instantané sauvé."
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Erreur : Vous n'êtes pas dans un raid. Aucun instantané sauvé."
MRT_L.Core["Trash Mob"] = "Trash Mob"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "Suivre simplement les 2 premiers groupes (sur 5)"
MRT_L.Options["AP_GuildAttendance"] = "Activer la vérification des participants de la guilde"
MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "Texte personnalisé pour la présence de guilde :"
MRT_L.Options["AP_GuildAttendanceDuration"] = "Durée de prise en compte des participants"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Demander une confirmation"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "Déclencheur (Trigger)"
MRT_L.Options["AP_GuildAttendanceUseCustomText"] = [=[Utiliser un texte personnalisé
pour la présence de guilde]=]
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = [=[Utiliser le déclencheur (Trigger) 
à la place du nom du personnage]=]
MRT_L.Options["AP_Minutes"] = "minutes"
MRT_L.Options["AP_Title"] = "Participation"
MRT_L.Options["AP_TitleText"] = "MRT - Options de participation"
MRT_L.Options["AP_TrackOfflinePlayers"] = "Suivre les joueurs hors-ligne"
MRT_L.Options["EP_AllXMLExportsTitle"] = "Pour tous les formats XML"
MRT_L.Options["EP_BBCode"] = "Texte au format BBCode"
MRT_L.Options["EP_BBCode_wowhead"] = "Texte au fomat BBCode avec lien d'objet wowhead"
MRT_L.Options["EP_ChooseExport_Title"] = "Format d'exportation"
MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Activer la correction de détection de rencontre de boss
pour le CT_RaidTrackerImport 1.16.x d'EQdkp(-Plus)]=]
MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (Compatibilité CT RaidTracker)"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "Ignorer la présence par boss"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[Activer la correction de présence pour
le Raid-Log-Import 0.5.6.x d'EQdkp-PLUS]=]
MRT_L.Options["EP_CTRTTitleText"] = "Paramètres du format \"compatibilité CTRT\""
MRT_L.Options["EP_Currency"] = "Monnaie"
MRT_L.Options["EP_DKPBoard"] = "DKPBoard"
MRT_L.Options["EP_EnglishExport"] = "Exporter les zones et nom des boss en anglais"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "XML pour EQdkp-Plus"
MRT_L.Options["EP_EQDKPTitleText"] = "Paramètres du format \"XML pour EQdkp-Plus\""
MRT_L.Options["EP_HTML"] = "HTML avec CSS et lien d'objet wowhead"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "Texte brut"
MRT_L.Options["EP_SetDateTimeFormat"] = "Format d'heure et de date"
MRT_L.Options["EP_TextExportTitleText"] = "Paramètres d'exportation du texte"
MRT_L.Options["EP_Title"] = "Exportation"
MRT_L.Options["EP_TitleText"] = "MRT - Option d'exportation"
MRT_L.Options["ITP_AutoFocus_Always"] = "Toujours"
MRT_L.Options["ITP_AutoFocus_Never"] = "Jamais"
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "Hors combat"
MRT_L.Options["ITP_AutoFocus_Title"] = "Autofocus sur la fenêtre de coût du loot"
MRT_L.Options["ITP_IgnoreEnchantingMats"] = "Ignorer les matériaux d'enchantement"
MRT_L.Options["ITP_IgnoreGems"] = "Ignorer les gemmes"
MRT_L.Options["ITP_Title"] = "Suivi des objets"
MRT_L.Options["ITP_TitleText"] = "MRT - Option du suivi des objets"
MRT_L.Options["ITP_UseEPGP_GP_Values"] = "Utilisez les valeurs EPGP GP"
MRT_L.Options["MP_AutoPrunning"] = "Suppression automatique des raid plus ancien que"
MRT_L.Options["MP_Days"] = "jours"
MRT_L.Options["MP_Debug"] = "Activer les messages de debug"
MRT_L.Options["MP_Description"] = "Suits les raids, loot et participation"
MRT_L.Options["MP_Enabled"] = "Activer le suivi automatique"
MRT_L.Options["MP_MinimapIcon"] = "Afficher le bouton de la minicarte"
MRT_L.Options["MP_SlashCmd"] = "Commande \"slash\""
MRT_L.Options["TP_AskForDKPValue"] = "Demander le prix des objets"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Créer un nouveau raid en entrant dans une nouvelle zone"
MRT_L.Options["TP_Log10MenRaids"] = "Suivre les raids de 10 joueurs"
MRT_L.Options["TP_LogAVRaids"] = "Suivre les raids JcJ (Archavon, Bastion de Baradin)"
MRT_L.Options["TP_LogWotLKRaids"] = "Suivre les raids WotLK"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Qualité minimum des objets à valoriser"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Qualité minimum des objets à suivre"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = [=[Sauvegarder seulement des objets
de niveau égal ou supérieur à ]=]
MRT_L.Options["TP_OnlyTrackItemsBelow"] = "ou de niveau égal ou inférieur à "
MRT_L.Options["TP_Title"] = "Suivi des raids"
MRT_L.Options["TP_TitleText"] = "MRT - Options du suivi des raids"
MRT_L.Options["TP_UseServerTime"] = "Utiliser l'heure serveur"
MRT_L.Options["TT_AP_GA_CustomText"] = [=[Variables utilisables :
<<BOSS>> - Nom du Boss de la rencontre
<<TIME>> - Temps restant pour la vérification de présence de guilde
<<TRIGGER>> - La commande "trigger" personnalisée]=]
MRT_L.Options["TT_EP_AddPoorItem"] = [=[Cette option change un peu l'export des loots pour corriger la détection de rencontre de boss
du CT_RaidTrackerImport. Utiliser la si vous avez des évènements de boss
dans votre suivie de raid sans loot associé (i.e. vérification des présences).]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[%d - jour du mois [01-31] 
 %m - mois [01-12] 
 %y - année sur deux chiffres [00-99] 
 %Y - année complète 

 %H - heure, en format 24h [00-23] 
 %I - heure, en format 12h [01-12] 
 %M - minute [00-59] 
 %S - seconde [00-59] 
 %p - soit 'am' ou 'pm']=]
MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[Cette option modifies un peu l'export des horodatages pour
satisfaire au seuil de 50% de présence du Raid-Log-Importer.
N'utiliser cette option que si vous utilisez un système DKP basé
sur la présence des membres par boss. ]=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[Commande sans "slash" de début
Un rechargement de l'interface est recommandé
après la modification de cette valeure.]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "Erreur : Raid actif trouvé. Merci de clôturer ce raid avant d'en démarrer un nouveau."
MRT_L.GUI["Add boss attendee"] = "Ajouter la participation sur un boss"
MRT_L.GUI["Add bosskill"] = "Ajouter la mort d'un boss"
MRT_L.GUI["Add loot data"] = "Ajouter les loots"
MRT_L.GUI["Add raid attendee"] = "Ajouter une présence de raid"
MRT_L.GUI["Bossname"] = "Nom du boss"
MRT_L.GUI["Button_Add"] = "Ajouter"
MRT_L.GUI["Button_Delete"] = "Supprimer"
MRT_L.GUI["Button_EndCurrentRaid"] = "Clôturer le raid actuel"
MRT_L.GUI["Button_Export"] = "Exporter"
MRT_L.GUI["Button_ExportHeroic"] = "Exporter H"
MRT_L.GUI["Button_ExportNormal"] = "Exporter N"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = [=[Vérification des
participants de la guilde]=]
MRT_L.GUI["Button_Modify"] = "Modifier"
MRT_L.GUI["Button_ResumeLastRaid"] = "Reprendre le dernier raid"
MRT_L.GUI["Button_StartNewRaid"] = "Débuter un nouveau raid"
MRT_L.GUI["Button_TakeSnapshot"] = "Prendre un instantané"
MRT_L.GUI["Can not delete current raid"] = "Erreur : Impossible de supprimer le raid actuel."
MRT_L.GUI["Cell_Hard"] = "Héroïque"
MRT_L.GUI["Cell_Normal"] = "Normal"
MRT_L.GUI["Col_Cost"] = "Coût"
MRT_L.GUI["Col_Date"] = "Date"
MRT_L.GUI["Col_Difficulty"] = "Mode"
MRT_L.GUI["Col_Join"] = "Rejoint"
MRT_L.GUI["Col_Leave"] = "Quitte"
MRT_L.GUI["Col_Looter"] = "Gagnant"
MRT_L.GUI["Col_Name"] = "Nom"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "Taille"
MRT_L.GUI["Col_Time"] = "Heure"
MRT_L.GUI["Col_Zone"] = "Zone"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Voulez-vous supprimer %s de la liste des participants sur ce boss ?"
MRT_L.GUI["Confirm boss entry deletion"] = "Voulez-vous supprimer l'entrée %d - %s de la liste des boss tués ?"
MRT_L.GUI["Confirm loot entry deletion"] = "Voulez-vous supprimer l'objet %s de la liste des loots ?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Voulez-vous supprimer %s de la liste des participants du raid ?"
MRT_L.GUI["Confirm raid entry deletion"] = "Voulez-vous supprimer le raid numéro %d ?"
MRT_L.GUI["Difficulty N or H"] = "Difficulté ('N' ou 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "Erreur : Impossible d'exporter un raid actif."
MRT_L.GUI["Entered join time is not before leave time"] = "Erreur : L'heure d'entrée ne précède pas l'heure de sortie."
MRT_L.GUI["Entered time is not between start and end of raid"] = "Erreur : l'heure saisie n'est pas comprise entre le début et la fin du raid."
MRT_L.GUI["Header_Title"] = "MRT - Log des Raids"
MRT_L.GUI["Item cost invalid"] = "Erreur : le coût de l'objet n'est pas un nombre."
MRT_L.GUI["Itemlink"] = "Lien d'objet, ID d'objet ou nom d'objet"
MRT_L.GUI["Looter"] = "Gagnant"
MRT_L.GUI["Modify loot data"] = "Modifier les données de loot"
MRT_L.GUI["No active raid in progress. Please enter time."] = "Erreur : Pas de raid actif en cours. SVP entrer une heure."
MRT_L.GUI["No active raid."] = "Erreur : Pas de raid actif."
MRT_L.GUI["No boss attendee selected"] = "Erreur : Pas de participant sur le boss sélectionné"
MRT_L.GUI["No boss name entered"] = "Erreur : Pas de nom de boss saisi"
MRT_L.GUI["No boss selected"] = "Erreur : Pas de boss sélectionné"
MRT_L.GUI["No itemLink found"] = "Erreur : lien d'objet invalide"
MRT_L.GUI["No loot selected"] = "Erreur : Pas d'objet sélectionné."
MRT_L.GUI["No name entered"] = "Erreur : Aucun nom saisie"
MRT_L.GUI["No raid attendee selected"] = "Erreur : Pas de participant sélectionné."
MRT_L.GUI["No raid selected"] = "Erreur : Pas de raid sélectionné."
MRT_L.GUI["No valid difficulty entered"] = "Erreur : Pas de difficulté valide sélectionnée."
MRT_L.GUI["No valid raid size"] = "Erreur : Taille de raid saisie invalide."
MRT_L.GUI["No valid time entered"] = "Erreur : Pas d'heure valide sélectionnée."
MRT_L.GUI["Note"] = "Note"
MRT_L.GUI["Player not in raid."] = "Erreur : Vous n'êtes pas dans un raid."
MRT_L.GUI["Raid size"] = "Taille du raid"
MRT_L.GUI["Resuming last raid failed"] = "Reprise du dernier raid échoué"
MRT_L.GUI["Resuming last raid successful"] = "Reprise du dernier raid réussi"
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Participants sur ce boss"
MRT_L.GUI["Tables_BossLootTitle"] = "Loot du boss"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Participants au raid"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Boss tués lors de ce raid"
MRT_L.GUI["Tables_RaidLogTitle"] = "Liste des raids"
MRT_L.GUI["Tables_RaidLootTitle"] = "Loot de ce raid"
MRT_L.GUI["Time"] = "Heure"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[Format HH:MM 

Si laisser vide, MRT utilisera 
l'heure de début de raid.]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[Format HH:MM 

Si laisser vide, MRT utilisera 
l'heure de fin de raid ou l'heure actuelle.]=]
MRT_L.GUI["TT_BA_Add"] = "Ajouter un participant la la liste des participants sur ce boss."
MRT_L.GUI["TT_BA_Delete"] = "Supprimer le participant sélectionné de ce boss "
MRT_L.GUI["TT_Boss_Add"] = "Ajouter une rencontre"
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Format HH:MM 

Laisser à vide si vous désirez ajouter
un boss comme le plus récent du raid actuel.]=]
MRT_L.GUI["TT_Boss_Delete"] = "Supprimer la rencontre sélectionnée"
MRT_L.GUI["TT_Boss_Export"] = "Exporter la rencontre sélectionnée."
MRT_L.GUI["TT_Loot_Add"] = "Ajouter un objet à la liste des loots."
MRT_L.GUI["TT_Loot_Delete"] = "Supprimer l'objet sélectionné."
MRT_L.GUI["TT_Loot_Modify"] = "Modifier la date de l'objet sélectionné."
MRT_L.GUI["TT_RA_Add"] = "Ajouter un participant à la liste des participants du raid."
MRT_L.GUI["TT_RA_Delete"] = "Supprimer le participant sélectionné du raid."
MRT_L.GUI["TT_Raid_Delete"] = "Supprimer le raid sélectionné."
MRT_L.GUI["TT_Raid_Export"] = "Exporter le raid sélectionné."
MRT_L.GUI["TT_Raid_ExportH"] = "Exporter toutes les rencontres en mode héroïque du raid sélectionné."
MRT_L.GUI["TT_Raid_ExportN"] = "Exporter toutes les rencontres en mode normal du raid sélectionné."
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "Si laissé vide, MRT utilisera 25 comme valeur par défaut."
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "Si laissé vide, MRT utilisera le nom de la zone actuelle."
MRT_L.GUI["TT_TakeSnapshot"] = [=[Prendre un instantané du groupe de raid actuel.
Ne fonctionne pas si le suivie de raid est en cours.
Dans ce cas, ajouter un évènement "boss".]=]
MRT_L.GUI["Value"] = "Rareté"
MRT_L.GUI["Zone name"] = "Nom de la Zone"
