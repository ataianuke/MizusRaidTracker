-- *******************************************************
-- **          Mizus RaidTracker - ruRU Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  homocomputeris, Ingdruid, rinaline, YOti
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
if GetLocale() ~= "ruRU" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[886]["Lei Shi"] = "Я... а... о! Я?.. Все было таким... мутным."
_L.yells[886]["Tsulong"] = "Спасибо вам, незнакомцы. Я свободен."


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "Банк"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "Отменить"
MRT_L.Core["DKP_Frame_Cost"] = "Стоимость"
MRT_L.Core["DKP_Frame_Delete_Button"] = "Удалить"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "Распылено"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "Ввести стоимость для"
MRT_L.Core["DKP_Frame_LootetBy"] = "|cFFFFFFFF%s|r получает добычу."
MRT_L.Core["DKP_Frame_Note"] = "Прим."
MRT_L.Core["DKP_Frame_OK_Button"] = "ОК"
MRT_L.Core["DKP_Frame_Title"] = "Введите цену"
MRT_L.Core["Export_Attendees"] = "Присутствие и замены"
MRT_L.Core["Export_Button"] = "Закрыть"
MRT_L.Core["Export_Explanation"] = [=[Нажмите Ctrl+C чтобы скопировать данные в буфер обмена.
Нажмите Ctrl+V чтобы вставить данные в браузер.]=]
MRT_L.Core["Export_Frame_Title"] = "Экспорт данных"
MRT_L.Core["Export_Heroic"] = "Героический"
MRT_L.Core["Export_Loot"] = "Добыча"
MRT_L.Core["Export_Normal"] = "Обычный"
MRT_L.Core["GuildAttendanceAddNotice"] = "%s добавил %s в список посещения и замен."
MRT_L.Core["GuildAttendanceAnnounceText"] = "Шепните мне имя вашего мейна, чтобы добавиться в DKP-список."
MRT_L.Core["GuildAttendanceAnnounceText2"] = "Шепните (/ш) мне '%s', чтобы добавиться в список присутствия и замен."
MRT_L.Core["GuildAttendanceBossDownText"] = "%s повержен!"
MRT_L.Core["GuildAttendanceBossEntry"] = "Проверка присутствия и замен"
MRT_L.Core["GuildAttendanceFailNotice"] = "У %s не получилось добавить %s в список посещения и замен."
MRT_L.Core["GuildAttendanceMsgBox"] = "%s повержен. Запустить проверку присутствия?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "Осталось %d минут."
MRT_L.Core["GuildAttendanceReply"] = "%s добавлен в DKP-список."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s уже есть в DKP-списке."
MRT_L.Core["GuildAttendanceTimeUpText"] = "Если вы не шепнете мне сейчас, будет слишком поздно."
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Щелкните ЛКМ, чтобы просмотреть журнал рейдов."
MRT_L.Core["LDB Right-click to open the options menu"] = "Щелкните ПКМ, чтобы открыть окно опций."
MRT_L.Core["MB_Cancel"] = "Отменить"
MRT_L.Core["MB_No"] = "Нет"
MRT_L.Core["MB_Ok"] = "ОК"
MRT_L.Core["MB_Yes"] = "Да"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "Ошибка. Рейд уже записывается. Снимок не сделан."
MRT_L.Core["TakeSnapshot_Done"] = "Снимок сделан."
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "Ошибка: Вы не в рейде. Снимок не сделан."
MRT_L.Core["Trash Mob"] = "Треш-мобы"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "Отслеживать только первые 2/4/5/6 группы"
MRT_L.Options["AP_GuildAttendance"] = "Включить проверку участников гильдии"
MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "Свободный текст"
MRT_L.Options["AP_GuildAttendanceDuration"] = "Длительность получения запроссов"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "Спрашивать подтверждение"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "Триггер"
MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "Использовать другой текст для проверки присутствия"
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "Использовать триггер вместо имени персонажа"
MRT_L.Options["AP_Minutes"] = "минут"
MRT_L.Options["AP_Title"] = "Участники"
MRT_L.Options["AP_TitleText"] = "MRT - Опции участников"
MRT_L.Options["AP_TrackOfflinePlayers"] = "Отслеживать оффлайн игроков"
MRT_L.Options["EP_AllXMLExportsTitle"] = "Все форматы экспорта XML"
MRT_L.Options["EP_BBCode"] = "BBCode форматированный текст"
MRT_L.Options["EP_BBCode_wowhead"] = "BBCode с ссылками на WoWHead"
MRT_L.Options["EP_ChooseExport_Title"] = "Наст. экспорта"
MRT_L.Options["EP_CTRT_AddPoorItem"] = [=[Вкл. определение босса для
EQdkp(-Plus) CT_RaidTrackerImport 1.16.x]=]
MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1(CT RaidTracker совместимый)"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[Исправлять проблему с присутствием в рейде
для EQdkp-Plus Raid-Log-Import 0.5.6.x.]=]
MRT_L.Options["EP_CTRTTitleText"] = "CTRT совместимый, настройки экспорта"
MRT_L.Options["EP_Currency"] = "Валюта"
MRT_L.Options["EP_DKPBoard"] = "DKPBoard"
MRT_L.Options["EP_EnglishExport"] = "Экспортировать названия зон и имена боссов на английском"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
MRT_L.Options["EP_EQDKPTitleText"] = "Настройка EQdkp-Plus XML"
MRT_L.Options["EP_HTML"] = "HTML с CSS со ссылками на WoWHead"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "Простой текст"
MRT_L.Options["EP_SetDateTimeFormat"] = "Время и дата"
MRT_L.Options["EP_TextExportTitleText"] = "Настр. текста при экспорте"
MRT_L.Options["EP_Title"] = "Экспорт"
MRT_L.Options["EP_TitleText"] = "MRT - Экспорт - опции"
MRT_L.Options["ITP_AutoFocus_Always"] = "Всегда"
MRT_L.Options["ITP_AutoFocus_Never"] = "Никогда "
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "Вне боя"
MRT_L.Options["ITP_AutoFocus_Title"] = "Переносить курсор в окно стоимости предметов."
MRT_L.Options["ITP_IgnoreEnchantingMats"] = "не отслеживать вещи для зачарования"
MRT_L.Options["ITP_IgnoreGems"] = "Не отслеживать камни"
MRT_L.Options["ITP_Title"] = "Отслеживание предметов"
MRT_L.Options["ITP_TitleText"] = "MRT - настройка отслеживания предметов"
MRT_L.Options["ITP_UseEPGP_GP_Values"] = "Использовать EPGP GP систему"
MRT_L.Options["MP_AutoPrunning"] = "Автоматически удалять рейды старше"
MRT_L.Options["MP_Days"] = "суток"
MRT_L.Options["MP_Debug"] = "Вкл. сообщения об ошибках"
MRT_L.Options["MP_Description"] = "Отслеживание рейда, добычи, посещаемости"
MRT_L.Options["MP_Enabled"] = "Вкл автоматич. наблюдение"
MRT_L.Options["MP_MinimapIcon"] = "Показывать кнопку у миникарты"
MRT_L.Options["MP_ResetGuiPos"] = "Сбросить положение GUI"
MRT_L.Options["MP_SlashCmd"] = "Команды "
MRT_L.Options["TP_AskForDKPValue"] = "Запрос стоимости ДКП"
MRT_L.Options["TP_AskForDKPValuePersonal"] = "...если настройки персональной добычи"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "Создать новый рейд в новой зоне"
MRT_L.Options["TP_Log10MenRaids"] = "Отслеживать 10ппл рейды"
MRT_L.Options["TP_LogAVRaids"] = "Отслеживать ПвП рейды"
MRT_L.Options["TP_LogCataclysmRaids"] = "Отслеживать рейды \"Катаклизм\""
MRT_L.Options["TP_LogLFRRaids"] = "Отслеживать ЛФР рейды"
MRT_L.Options["TP_LogLootModePersonal"] = "Отслеживать персональную добычи"
MRT_L.Options["TP_LogWotLKRaids"] = "Отслеживать WotLK рейды"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "Мин. уровень добычи для запроса "
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "Мин. уровень добычи для записи"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = "Отслеживать предметы уровня не ниже"
MRT_L.Options["TP_OnlyTrackItemsBelow"] = "уровня не выше"
MRT_L.Options["TP_Title"] = "Отслеживание рейдов"
MRT_L.Options["TP_TitleText"] = "MRT - Опции "
MRT_L.Options["TP_UseServerTime"] = "Исп. серверное время"
MRT_L.Options["TT_AP_GA_CustomText"] = [=[Available variables:
<<BOSS>> - Название босса
<<TIME>> - Оповещение для гильдии
<<TRIGGER>> - The custom trigger command]=]
MRT_L.Options["TT_EP_AddPoorItem"] = [=[Эта опция исправляет запись рейдов для CT_RaidTrackerImport.
Используйте ее, если записанных боях с боссами не показывается добыча.]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[ %d - день [01-31] 
 %m - месяц [01-12] 
 %y - последние цифры года [00-99] 
 %Y - год полностью

 %H - 24-часовой формат [00-23] 
 %I - 12-часовой формат [01-12] 
 %M - минуты [00-59] 
 %S - секунды [00-59] 
 %p - обозначение 'am' или 'pm']=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[Убрать косую черту перед командой.
Перезагрузите интерфейс после изменения этой опции.]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "Ошибка: Обнаружен активный рейд. Пожалуйста завершите активный рейд прежде чем создавать новый."
MRT_L.GUI["Add boss attendee"] = "Добавить участника на босса"
MRT_L.GUI["Add bosskill"] = "Добавить убийство босса"
MRT_L.GUI["Add loot data"] = "Добавить добычу"
MRT_L.GUI["Add raid attendee"] = "Добавить участника в рейд"
MRT_L.GUI["Bossname"] = "Имя босса"
MRT_L.GUI["Button_Add"] = "Добавить"
MRT_L.GUI["Button_Delete"] = "Удалить"
MRT_L.GUI["Button_EndCurrentRaid"] = "Закончить текущий рейд"
MRT_L.GUI["Button_Export"] = "Экспорт"
MRT_L.GUI["Button_ExportHeroic"] = "Экспорт Г"
MRT_L.GUI["Button_ExportNormal"] = "Экспорт Н"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "Сделать запрос на присутствие"
MRT_L.GUI["Button_Modify"] = "Изменить"
MRT_L.GUI["Button_ResumeLastRaid"] = "Восстановить последний рейд"
MRT_L.GUI["Button_StartNewRaid"] = "Начать новый рейд"
MRT_L.GUI["Button_TakeSnapshot"] = "Сделать снимок"
MRT_L.GUI["Can not delete current raid"] = "Ошибка: невозможно удалить текущий рейд."
MRT_L.GUI["Cell_Hard"] = "Героический"
MRT_L.GUI["Cell_LFR"] = "ЛФР"
MRT_L.GUI["Cell_Normal"] = "Нормальный"
MRT_L.GUI["Col_Cost"] = "Стоимость"
MRT_L.GUI["Col_Date"] = "Дата"
MRT_L.GUI["Col_Difficulty"] = "Режим"
MRT_L.GUI["Col_Join"] = "Присоединиться"
MRT_L.GUI["Col_Leave"] = "Покинуть"
MRT_L.GUI["Col_Looter"] = "Получатель"
MRT_L.GUI["Col_Name"] = "Имя"
MRT_L.GUI["Col_Num"] = "№"
MRT_L.GUI["Col_Size"] = "Размер"
MRT_L.GUI["Col_Time"] = "Время"
MRT_L.GUI["Col_Zone"] = "Зона"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "Хотите удалить %s из списка участников на боссе?"
MRT_L.GUI["Confirm boss entry deletion"] = "Удалить %d - %s - из списка убийства?"
MRT_L.GUI["Confirm loot entry deletion"] = "Вы действительно хотите удалить предмет %s из списка добычи?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "Удалить %s из списка посещаемости?"
MRT_L.GUI["Confirm raid entry deletion"] = "Вы действительно хотите удалить рейд %d?"
MRT_L.GUI["Difficulty N or H"] = "Сложность ('N' or 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "Ошибка. Не возможно экспортировать открытый рейд"
MRT_L.GUI["Entered join time is not before leave time"] = "Время присоединения к рейду должно быть меньше времени выхода из рейда."
MRT_L.GUI["Entered time is not between start and end of raid"] = "Введенное значение времени не находится в диапазоне времени рейда"
MRT_L.GUI["Header_Title"] = "MRT - Лог рейда"
MRT_L.GUI["Item cost invalid"] = "Ошибка: неправильная стоимость предмета"
MRT_L.GUI["Itemlink"] = "Ссылка на предмет или ID предмета или имя предмета"
MRT_L.GUI["Looter"] = "Получатель"
MRT_L.GUI["Modify loot data"] = "Изменить дату получения"
MRT_L.GUI["No active raid in progress. Please enter time."] = "Ошибка: нет активного рейда. Пожалуйста введите время."
MRT_L.GUI["No active raid."] = "Ошибка: нет активного рейда"
MRT_L.GUI["No boss attendee selected"] = "Ошибка: Нет выделенного босса"
MRT_L.GUI["No boss name entered"] = "Ошибка: не введено имя босса"
MRT_L.GUI["No boss selected"] = "Ошибка: босс не выбран"
MRT_L.GUI["No itemLink found"] = "Ошибка: ссылка на предмет неверна"
MRT_L.GUI["No loot selected"] = "Ошибка: предмет не выбран"
MRT_L.GUI["No name entered"] = "Ошибка: Имя не введено"
MRT_L.GUI["No raid attendee selected"] = "Ошибка: Нет выделенного рейда"
MRT_L.GUI["No raid selected"] = "Ошибка: не выбран рейд"
MRT_L.GUI["No valid difficulty entered"] = "Ошибка: введена неправильная сложность"
MRT_L.GUI["No valid raid size"] = "Ошибка. Введите размер рейда"
MRT_L.GUI["No valid time entered"] = "Ошибка: введено неправильное время"
MRT_L.GUI["Note"] = "Прим."
MRT_L.GUI["Player not in raid."] = "Ошибка:  вы не в рейде"
MRT_L.GUI["Raid size"] = "Размер рейды"
MRT_L.GUI["Resuming last raid failed"] = "Ошибка: Последний рейд не восстановлен"
MRT_L.GUI["Resuming last raid successful"] = "Последний рейд восстановлен"
MRT_L.GUI["Tables_BossAttendeesTitle"] = "Участники"
MRT_L.GUI["Tables_BossLootTitle"] = "Добыча"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "Участники рейда"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "Убитые боссы"
MRT_L.GUI["Tables_RaidLogTitle"] = "Список рейдов"
MRT_L.GUI["Tables_RaidLootTitle"] = "Список добычи"
MRT_L.GUI["Time"] = "Время"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[Время в формате ЧЧ:ММ.

Если поле пустое, MRT будет выставлять
время начала рейда.]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[Время в формате ЧЧ:ММ.

Если поле пустое, MRT будет выставлять
время окончания рейда.]=]
MRT_L.GUI["TT_BA_Add"] = "Добавить в список"
MRT_L.GUI["TT_BA_Delete"] = "Удалить выделенного  из списка"
MRT_L.GUI["TT_Boss_Add"] = "Добавить босса в событие"
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[Формат ЧЧ:ММ

Leave blank, if you want to add a boss 
as the most recent of the current raid.]=]
MRT_L.GUI["TT_Boss_Delete"] = "Удалить выделенного босса из списка"
MRT_L.GUI["TT_Boss_Export"] = "Экспортировать выделенное"
MRT_L.GUI["TT_Loot_Add"] = "Добавить добычу в список"
MRT_L.GUI["TT_Loot_Delete"] = "Удалить добычу"
MRT_L.GUI["TT_Loot_Modify"] = "Изменить стоимость или получателя, добавить заметку"
MRT_L.GUI["TT_RA_Add"] = "Добавить в список"
MRT_L.GUI["TT_RA_Delete"] = "Убрать участника из списка замен."
MRT_L.GUI["TT_Raid_Delete"] = "Удалить выбранный рейд"
MRT_L.GUI["TT_Raid_Export"] = "Экспортировать выбранный рейд"
MRT_L.GUI["TT_Raid_ExportH"] = "Экспортировать все бои с боссами в героическом режиме"
MRT_L.GUI["TT_Raid_ExportN"] = "Экспортировать все бои с боссами в обычном режиме"
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "Если поле пустое, MRT будет использовать значение 25."
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "если оставить чистым, MRT использует текущую зону"
MRT_L.GUI["TT_TakeSnapshot"] = [=[Сделать снимок текущей рейдовой группы.
Если влючено слежение за рейдом,
то добавьте схватку с боссом.]=]
MRT_L.GUI["Value"] = "Стоимость"
MRT_L.GUI["Zone name"] = "Название местности"
