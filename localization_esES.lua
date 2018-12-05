-- *******************************************************
-- **          Mizus RaidTracker - esES Local           **
-- **              <http://cosmocanyon.de>              **
-- *******************************************************
--
-- This localization is written by:
--  Hestrall
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
if GetLocale() ~= "esES" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[604]["Dreamwalker"] = "¡ESTOY RENOVADA! Ysera, haz que estas asquerosas criaturas descansen."
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "¡No digáis que no lo avisé, sinvergüenzas! Adelante, hermanos."
_L.yells[886]["Lei Shi"] = "Yo... ah... ¿eh? ¿Yo he...? ¿Era yo...? Todo... estaba... turbio."
_L.yells[886]["Tsulong"] = "Gracias, forasteros. Me habéis liberado. / Gracias, forasteros. Me han liberado."


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "Banco"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Cancelar"
MRT_L.Core["DKP_Frame_Cost"] = "Coste"
MRT_L.Core["DKP_Frame_Delete_Button"] = "Borrar"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Desencantado"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "Introducir coste para"
MRT_L.Core["DKP_Frame_LootetBy"] = " Asignado a |cFFFFFFFF%s|r."
MRT_L.Core["DKP_Frame_Note"] = "Nota"
MRT_L.Core["DKP_Frame_OK_Button"] = "Ok"
MRT_L.Core["DKP_Frame_Title"] = "Intruzca el coste"
MRT_L.Core["Export_Attendees"] = "Asistente"
MRT_L.Core["Export_Button"] = "Cerrar"
MRT_L.Core["Export_Explanation"] = [=[Pulsa Ctrl+C para copiar los datos al  portapapeles.
Pulsa Ctrl+V para importar los datos en tu navegador.]=]
MRT_L.Core["Export_Frame_Title"] = "Exportación de datos"
MRT_L.Core["Export_Heroic"] = "Heroico"
MRT_L.Core["Export_Loot"] = "Botín"
MRT_L.Core["Export_Normal"] = "Normal"
MRT_L.Core["GuildAttendanceAnnounceText"] = "Susurrame el nombre de tu personake principal para ser añadido a la lista de DKP"
MRT_L.Core["GuildAttendanceBossDownText"] = "%s caido!"
MRT_L.Core["GuildAttendanceBossEntry"] = "Comprobación de asistencia"
MRT_L.Core["GuildAttendanceMsgBox"] = "%s caido. ¿Realizar comprobación de asistencia ahora?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d minutos restantes."
MRT_L.Core["GuildAttendanceReply"] = "%s añadido a la lista de DKP."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s ya esta en la lista de DKP."
MRT_L.Core["GuildAttendanceTimeUpText"] = "Si no me has susurrado hasta ahora, es demasido tarde."
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Click-Izquierdo para cambiar el navegador de log de raid."
MRT_L.Core["LDB Right-click to open the options menu"] = "Click-derecho para abrir el menu de opciones."
MRT_L.Core["MB_Cancel"] = "Cancelar"
MRT_L.Core["MB_No"] = "No"
MRT_L.Core["MB_Ok"] = "Ok"
MRT_L.Core["MB_Yes"] = "Si"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Error: Raid activa en progreso. No se ha tomado snapshot."
MRT_L.Core["TakeSnapshot_Done"] = "Snapshot realizado."
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Error: No estas en una raid. No se ha tomado snapshot."


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "Registrar solo los primeros 2/5 grupos"
MRT_L.Options["AP_GuildAttendance"] = "Habilitar comprobación de asistencia de hermandad"
MRT_L.Options["AP_GuildAttendanceDuration"] = "Duracion de recepcion de asistentes"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Preguntar por confirmación"
MRT_L.Options["AP_Minutes"] = "Minutos"
MRT_L.Options["AP_Title"] = "Asistente"
MRT_L.Options["AP_TitleText"] = "MRT - Opciones de asistencia"
MRT_L.Options["AP_TrackOfflinePlayers"] = "Registrar jugadores desconectados"
MRT_L.Options["EP_BBCode"] = "Texto con formatoc BBCode"
MRT_L.Options["EP_ChooseExport_Title"] = "Formato de exportación"
MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Añadir un objero de bajo nivel a cada boss
(Solución al problema de deteción de encuentos en EQDKP-CTRT)]=]
MRT_L.Options["EP_CTRT_compatible"] = "Compatible con CT RaidTracker"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "Ignorar asistencia a boss."
MRT_L.Options["EP_CTRTTitleText"] = "Configuración compartible con exportación CTRT"
MRT_L.Options["EP_Currency"] = "Moneada"
MRT_L.Options["EP_Plain_Text"] = "Texto plano"
MRT_L.Options["EP_SetDateTimeFormat"] = "Ajustar el formato de fecha y hora"
MRT_L.Options["EP_TextExportTitleText"] = "Configuración de exportación de texto"
MRT_L.Options["EP_Title"] = "Exportar"
MRT_L.Options["EP_TitleText"] = "MRT - Opciones de exportación"
MRT_L.Options["MP_Debug"] = "Habilidar mensajes de debug"
MRT_L.Options["MP_Description"] = "Registrar raids, botín y asistencia"
MRT_L.Options["MP_Enabled"] = "Habilitar MRT"
MRT_L.Options["MP_SlashCmd"] = "Comando"
MRT_L.Options["TP_AskForDKPValue"] = "Preguntar por el valor del objeto"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Crear una nueva raid en una nueva zona."
MRT_L.Options["TP_Log10MenRaids"] = "Registrar raids de 10 jugadores"
MRT_L.Options["TP_LogAVRaids"] = "Registrar Camara de Archavon"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Nivel minimo del objeto para preguntar por el coste"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Nivel minimo del objeto para registrar"
MRT_L.Options["TP_Title"] = "Seguimiento"
MRT_L.Options["TP_TitleText"] = "MRT - Opciones de seguimiento"
MRT_L.Options["TP_UseServerTime"] = "Usar tiempo del servidor."
MRT_L.Options["TT_EP_AddPoorItem"] = [=[Solo para antiguo CTRT-Import-Plugin.
NO para el Raid-Log-Import-Plugin.]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[ %d - Dia del mes [01-31]
 %m - mes [01-12]
 %y - dos-digitos año [00-99]
 %Y - año completo

 %H - hora, usando notación de 24-horas [00-23]
 %I - hora, usando notación de 24-horas [01-12]
 %M - minuto [00-59]
 %S - segundo [00-59]
 %p - tanto 'am' como 'pm']=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[Comando sin la barra.
Se recomienda reloguear despues de cambiar este campo.]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "Error: Raid ativa no encontrada. Por favor finalizar la raid actual antes de empezar una nueva."
MRT_L.GUI["Add boss attendee"] = "Añadir asistente a Boss"
MRT_L.GUI["Add bosskill"] = "Añadir muerte de Boss"
MRT_L.GUI["Add loot data"] = "Añadir datos de loot"
MRT_L.GUI["Bossname"] = "Nombre del Boss"
MRT_L.GUI["Button_Add"] = "Añadir"
MRT_L.GUI["Button_Delete"] = "Borrar"
MRT_L.GUI["Button_EndCurrentRaid"] = "Finalizar raid actual"
MRT_L.GUI["Button_Export"] = "Exportar"
MRT_L.GUI["Button_ExportHeroic"] = "Exportar H"
MRT_L.GUI["Button_ExportNormal"] = "Exportar N"
MRT_L.GUI["Button_Modify"] = "Modificar"
MRT_L.GUI["Button_StartNewRaid"] = "Empezar nueva raid"
MRT_L.GUI["Button_TakeSnapshot"] = "Tomar snapshot"
MRT_L.GUI["Can not delete current raid"] = "Error: No se puede borrar la raid actual"
MRT_L.GUI["Cell_Hard"] = "Hard"
MRT_L.GUI["Cell_Normal"] = "Normal"
MRT_L.GUI["Col_Cost"] = "Coste"
MRT_L.GUI["Col_Date"] = "Fecha"
MRT_L.GUI["Col_Difficulty"] = "Modo"
MRT_L.GUI["Col_Join"] = "Unir"
MRT_L.GUI["Col_Leave"] = "Dejar"
MRT_L.GUI["Col_Looter"] = "Despojador"
MRT_L.GUI["Col_Name"] = "Nombre"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "Tamaño"
MRT_L.GUI["Col_Time"] = "Tiempo"
MRT_L.GUI["Col_Zone"] = "Zona"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "¿Quieres borrar a %s de la lista de asistentes?"
MRT_L.GUI["Confirm boss entry deletion"] = "¿Quieres borrar la entrada %d - %s - de la lista de bosskills?"
MRT_L.GUI["Confirm loot entry deletion"] = "¿Quieres borrar el objeto %s de la lista de botín?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "¿Quieres borrar al asistente %s de la lista de asistentes a raid?"
MRT_L.GUI["Confirm raid entry deletion"] = "¿Quieres borrar a la raid número %d?"
MRT_L.GUI["Difficulty N or H"] = "Dificultad ('N' o 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "Error: No se puede exportar la raid activa."
MRT_L.GUI["Entered time is not between start and end of raid"] = "Error: El tiempo introducido no esta entre el principio y fin de raid."
MRT_L.GUI["Header_Title"] = "MRT - Log de raid"
MRT_L.GUI["Item cost invalid"] = "Error: El coste del Objeto no es un número"
MRT_L.GUI["Itemlink"] = "Link al objeto"
MRT_L.GUI["Looter"] = "Despojador"
MRT_L.GUI["Modify loot data"] = "Modificar información el loot"
MRT_L.GUI["No active raid in progress. Please enter time."] = "No hay raid activa en progreso. Por favor introduzca un tiempo."
MRT_L.GUI["No active raid."] = "Error: no hay raid activa."
MRT_L.GUI["No boss attendee selected"] = "No hay seleccionado ningún asistente"
MRT_L.GUI["No boss name entered"] = "No se ha introducido el nombre del boss."
MRT_L.GUI["No boss selected"] = "No se ha seleccionado nigún boss."
MRT_L.GUI["No itemLink found"] = "Nos se ha encontrado el objeto."
MRT_L.GUI["No loot selected"] = "No se ha seleccionado loot."
MRT_L.GUI["No raid attendee selected"] = "Error: No se ha seleccionado asistente."
MRT_L.GUI["No raid selected"] = "Error: No se ha seleccionado raid."
MRT_L.GUI["No valid difficulty entered"] = "Error: No se a introducido una dificultad valida."
MRT_L.GUI["No valid raid size"] = "Tamaño de la raid no valido"
MRT_L.GUI["No valid time entered"] = "Error: No se ha introducido un tiempo valido."
MRT_L.GUI["Note"] = "Nota"
MRT_L.GUI["Player not in raid."] = "Jugador no esta en la raid."
MRT_L.GUI["Raid size"] = "Tamaño de la raid"
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Asistentes al boss."
MRT_L.GUI["Tables_BossLootTitle"] = "Botín del boss."
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Asistentes a raid."
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Bosskills de la raid"
MRT_L.GUI["Tables_RaidLogTitle"] = "Lista de raid."
MRT_L.GUI["Tables_RaidLootTitle"] = "Botín de raid"
MRT_L.GUI["Time"] = "Tiempo"
MRT_L.GUI["TT_BA_Add"] = "Añadir un asistente a la lista de asistentes al boss."
MRT_L.GUI["TT_BA_Delete"] = "Borrar el asistente seleccionado."
MRT_L.GUI["TT_Boss_Add"] = "Añadir un encuentro."
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Formato HH:MM

Dejar en blanco, si quieres añadir un boss
a la raid mas reciente.]=]
MRT_L.GUI["TT_Boss_Delete"] = "Borrar el encuentro seleccionado."
MRT_L.GUI["TT_Boss_Export"] = "Exportar el encuentro seleccionado."
MRT_L.GUI["TT_Loot_Add"] = "Añadir un objeto a lista de loot."
MRT_L.GUI["TT_Loot_Delete"] = "Borrar el item seleccionado"
MRT_L.GUI["TT_Loot_Modify"] = "Modificar datos del item seleccionado"
MRT_L.GUI["TT_RA_Add"] = "Añadir un asistente a la lista de asistentes a raid."
MRT_L.GUI["TT_RA_Delete"] = "Borrar el asistente seleccionado."
MRT_L.GUI["TT_Raid_Delete"] = "Borrar la raid seleccionada."
MRT_L.GUI["TT_Raid_Export"] = "Exportar la raid seleccionada."
MRT_L.GUI["TT_Raid_ExportH"] = "Exportar todos los encuentros heroicos de la raid seleccionada."
MRT_L.GUI["TT_Raid_ExportN"] = "Exportar todos los encuentros normales de la raid seleccionada."
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "Si lo dejas en blanco, MRT usará tu zona actual."
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "Si lo dejas en blanco, MRT utilizará la zona actual"
MRT_L.GUI["TT_TakeSnapshot"] = [=[Realizar un snapshot del actual grupo de raid.
No funciona, si un registro de raid esta en progreso.
En ese caso, añadir un evento (boss).]=]
MRT_L.GUI["Value"] = "Valor"
MRT_L.GUI["Zone name"] = "Nombre de zona"
