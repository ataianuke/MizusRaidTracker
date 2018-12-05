-- *******************************************************
-- **          Mizus RaidTracker - zhTW Local           **
-- **              <http://cosmocanyon.de>              **
-- *******************************************************
--
-- This localization is written by:
--  wushiny
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
if GetLocale() ~= "zhTW" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[529]["Algalon"] = "我曾經看過塵世沉浸在造物者的烈焰之中，眾生連一聲悲泣都無法呼出，就此凋零。整個星系在彈指之間歷經了毀滅與重生。然而在這段歷程之中，我的心卻無法感受到絲毫的…惻隱之念。我‧感‧受‧不‧到。成千上萬的生命就這麼消逝。他們是否擁有與你同樣堅韌的生命?他們是否與你同樣熱愛生命?"
_L.yells[529]["Freya"] = "他對我的操控已然退散。我已再次恢復神智了。感激不盡，英雄們。"
_L.yells[529]["Hodir"] = "我…我終於從他的掌控中…解脫了。"
_L.yells[529]["Mimiron"] = "看來我還是產生了些許計算錯誤。任由我的心智受到囚牢中魔鬼的腐化，棄我的首要職責於不顧。所有的系統看起來都正常運作。報告完畢。"
_L.yells[529]["Thorim"] = "住手!我認輸了!"
_L.yells[543]["Faction Champions"] = "膚淺而悲痛的勝利。今天痛失的生命反而令我們更加的頹弱。除了巫妖王之外，誰還能從中獲利?偉大的戰士失去了寶貴生命。為了什麼?真正的威脅就在前方 - 巫妖王在死亡的領域中等著我們。"
_L.yells[604]["Dreamwalker"] = "我重生了!伊瑟拉賦予我讓那些邪惡生物安眠的力量!"
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "別說我沒警告過你，無賴!兄弟姊妹們，向前衝!"
_L.yells[604]["Icecrown Gunship Battle Horde"] = "聯盟已經動搖了。向巫妖王前進!"
_L.yells[609]["Halion"] = "享受這場勝利吧，凡人們，因為這是你們最後一次的勝利。這世界將會在主人回歸時化為火海!"


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "銀行"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "取消"
MRT_L.Core["DKP_Frame_Cost"] = "價值"
MRT_L.Core["DKP_Frame_Delete_Button"] = "刪除"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "分解"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "輸入價值"
MRT_L.Core["DKP_Frame_LootetBy"] = "已被|cFFFFFFFF%s|r拾取"
MRT_L.Core["DKP_Frame_Note"] = "註記"
MRT_L.Core["DKP_Frame_OK_Button"] = "確定"
MRT_L.Core["DKP_Frame_Title"] = "輸入物品價值"
MRT_L.Core["Export_Attendees"] = "參與者"
MRT_L.Core["Export_Button"] = "關閉"
MRT_L.Core["Export_Explanation"] = [=[按 Ctrl+C 複製資料到剪貼簿
按 Ctrl+V 匯入資料到你的瀏覽器]=]
MRT_L.Core["Export_Frame_Title"] = "資料匯出"
MRT_L.Core["Export_Heroic"] = "英雄"
MRT_L.Core["Export_Loot"] = "物品掉落"
MRT_L.Core["Export_Normal"] = "普通"
MRT_L.Core["GuildAttendanceAddNotice"] = "%s增加%s到首領戰鬥參與者列表"
MRT_L.Core["GuildAttendanceAnnounceText"] = "密你的主角色名字給我用來加入DKP列表"
MRT_L.Core["GuildAttendanceAnnounceText2"] = "用'%s'密我來加入dkp列表"
MRT_L.Core["GuildAttendanceBossDownText"] = "擊殺%s!"
MRT_L.Core["GuildAttendanceBossEntry"] = "團隊成員檢查"
MRT_L.Core["GuildAttendanceFailNotice"] = "%s增加%s到首領戰鬥參與者列表失敗"
MRT_L.Core["GuildAttendanceMsgBox"] = "擊殺%s. 現在執行團隊成員檢查嗎?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "剩餘%d分鐘"
MRT_L.Core["GuildAttendanceReply"] = "增加%s到DKP列表"
MRT_L.Core["GuildAttendanceReplyFail"] = "%s已在DKP列表中"
MRT_L.Core["GuildAttendanceTimeUpText"] = "假如你到現在還不曾密我 , 你太慢了"
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "點擊左鍵顯示團隊紀錄瀏覽"
MRT_L.Core["LDB Right-click to open the options menu"] = "點擊右鍵開啟選項"
MRT_L.Core["MB_Cancel"] = "取消"
MRT_L.Core["MB_No"] = "否"
MRT_L.Core["MB_Ok"] = "確定"
MRT_L.Core["MB_Yes"] = "是"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "錯誤:團隊進行中,無法取得快照"
MRT_L.Core["TakeSnapshot_Done"] = "取得快照"
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "錯誤:你不在一個團隊中,無法取得快照"
MRT_L.Core["Trash Mob"] = "小怪"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "僅追蹤前2/前5小隊"
MRT_L.Options["AP_GuildAttendance"] = "啟用工會成員檢查"
MRT_L.Options["AP_GuildAttendanceDuration"] = "紀錄團隊成員的出席區間"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "確認詢問"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "觸發"
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "使用觸發來代替角色名稱"
MRT_L.Options["AP_Minutes"] = "分鐘"
MRT_L.Options["AP_Title"] = "參與者"
MRT_L.Options["AP_TitleText"] = "MRT - 參與者選項"
MRT_L.Options["AP_TrackOfflinePlayers"] = "追蹤離線玩家"
MRT_L.Options["EP_AllXMLExportsTitle"] = "All XML 匯出格式"
MRT_L.Options["EP_BBCode"] = "BBCode格式文字"
MRT_L.Options["EP_BBCode_wowhead"] = "在BBCode格式文字中使用wowhead鏈結"
MRT_L.Options["EP_ChooseExport_Title"] = "匯出格式"
MRT_L.Options["EP_CTRT_AddPoorItem"] = "啟用對於EQdkp(-Plus) CT_RaidTrackerImport 1.16.x的首領偵測修正"
MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (CT RaidTracker相容)"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "忽略每次首領戰鬥"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = "啟用對EQdkp-Plus Raid-Log-Import 0.5.6.x的團隊成員修正"
MRT_L.Options["EP_CTRTTitleText"] = "CTRT相容匯出設定"
MRT_L.Options["EP_Currency"] = "貨幣"
MRT_L.Options["EP_DKPBoard"] = "DKP面板"
MRT_L.Options["EP_EnglishExport"] = "匯出英文的區域名稱及首領名稱"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
MRT_L.Options["EP_EQDKPTitleText"] = "EQdkp-Plus XML設定"
MRT_L.Options["EP_HTML"] = "在 CSS based HTML中使用wowhead鏈結"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "純文字格式"
MRT_L.Options["EP_SetDateTimeFormat"] = "設定日期與時間格式"
MRT_L.Options["EP_TextExportTitleText"] = "文字匯出設定"
MRT_L.Options["EP_Title"] = "匯出"
MRT_L.Options["EP_TitleText"] = "MRT - 匯出選項"
MRT_L.Options["ITP_AutoFocus_Always"] = "總是"
MRT_L.Options["ITP_AutoFocus_Never"] = "從不"
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "不在戰鬥中時"
MRT_L.Options["ITP_AutoFocus_Title"] = "物品價值細節視窗自動置於最上層"
MRT_L.Options["ITP_IgnoreGems"] = "忽略珠寶"
MRT_L.Options["ITP_Title"] = "物品追蹤"
MRT_L.Options["ITP_TitleText"] = "MRT - 物品追蹤選項"
MRT_L.Options["MP_AutoPrunning"] = "自動刪除團隊紀錄, 舊於"
MRT_L.Options["MP_Days"] = "天的"
MRT_L.Options["MP_Debug"] = "啟用除錯訊息"
MRT_L.Options["MP_Description"] = "追蹤團隊,拾取與參與者"
MRT_L.Options["MP_Enabled"] = "啟用MRT自動追蹤"
MRT_L.Options["MP_MinimapIcon"] = "顯示小地圖圖示"
MRT_L.Options["MP_SlashCmd"] = "斜線指令"
MRT_L.Options["TP_AskForDKPValue"] = "詢問物品價值"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "在新地區時建立新團隊紀錄"
MRT_L.Options["TP_Log10MenRaids"] = "追蹤10人團隊"
MRT_L.Options["TP_LogAVRaids"] = "追蹤PVP團隊副本"
MRT_L.Options["TP_LogWotLKRaids"] = "追蹤巫妖王之怒團隊"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "詢問物品價值所需最低品質"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "記錄的物品最低品質"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = "僅追蹤物品等級等於或高於該數值的物品"
MRT_L.Options["TP_Title"] = "追蹤中"
MRT_L.Options["TP_TitleText"] = "MRT - 追蹤選項"
MRT_L.Options["TP_UseServerTime"] = "使用伺服器時間"
MRT_L.Options["TT_EP_AddPoorItem"] = [=[這個選項改變了一點點物品資料匯出的格式來修正
CT_RaidTrackerImport的首領事件偵測. 如果你有
物品掉落沒有聯結到首領事件的問題,使用這個選項]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[%d - 日 [01-31]
 %m - 月 [01-12]
 %y - 雙位數年份 [00-99]
 %Y - 完整年份

 %H - 時, 使用24小時制 [00-23]
 %I - 時, 使用12小時制 [01-12]
 %M - 分 [00-59]
 %S - 秒 [00-59]
 %p - 'am' 或 'pm']=]
MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[此選項略為修改了時間戳記的匯出以通過Raid-Log-Importer的50％門檻
只有在你們的DKP系統採用每次boss戰鬥的情況下,才使用這個選項]=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[指令前不需要斜線
建議在更改設定後重新登入]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "錯誤:找到活動中的團隊事件.請在建立新事件之前結束活動中的團隊事件"
MRT_L.GUI["Add boss attendee"] = "增加首領戰鬥參與者"
MRT_L.GUI["Add bosskill"] = "增加首領擊殺"
MRT_L.GUI["Add loot data"] = "增加物品掉落資料"
MRT_L.GUI["Add raid attendee"] = "增加團隊參與者"
MRT_L.GUI["Bossname"] = "首領名稱"
MRT_L.GUI["Button_Add"] = "增加"
MRT_L.GUI["Button_Delete"] = "刪除"
MRT_L.GUI["Button_EndCurrentRaid"] = "結束當前團隊事件"
MRT_L.GUI["Button_Export"] = "匯出"
MRT_L.GUI["Button_ExportHeroic"] = "匯出(英雄)"
MRT_L.GUI["Button_ExportNormal"] = "匯出(普通)"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "執行公會參與者檢查"
MRT_L.GUI["Button_Modify"] = "修改"
MRT_L.GUI["Button_ResumeLastRaid"] = "恢復上一次的團隊事件"
MRT_L.GUI["Button_StartNewRaid"] = "建立新的團隊事件"
MRT_L.GUI["Button_TakeSnapshot"] = "取得快照"
MRT_L.GUI["Can not delete current raid"] = "錯誤:不能刪除目前的團隊"
MRT_L.GUI["Cell_Hard"] = "困難"
MRT_L.GUI["Cell_Normal"] = "普通"
MRT_L.GUI["Col_Cost"] = "物品價值"
MRT_L.GUI["Col_Date"] = "日期"
MRT_L.GUI["Col_Difficulty"] = "模式"
MRT_L.GUI["Col_Join"] = "加入"
MRT_L.GUI["Col_Leave"] = "離開"
MRT_L.GUI["Col_Looter"] = "拾取者"
MRT_L.GUI["Col_Name"] = "名稱"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "大小"
MRT_L.GUI["Col_Time"] = "時間"
MRT_L.GUI["Col_Zone"] = "區域"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "你想刪除首領戰鬥參與者列表中的%s?"
MRT_L.GUI["Confirm boss entry deletion"] = "你想刪除首領擊殺列表中的%d - %s?"
MRT_L.GUI["Confirm loot entry deletion"] = "你想刪除物品掉落列表中的%s?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "你想刪除團隊參與列表中的%s?"
MRT_L.GUI["Confirm raid entry deletion"] = "你想刪除團隊編號%d?"
MRT_L.GUI["Difficulty N or H"] = "難度('N' 或 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "錯誤:不能匯出活動中的團隊事件"
MRT_L.GUI["Entered join time is not before leave time"] = "錯誤:加入時間不再離開時間之前"
MRT_L.GUI["Entered time is not between start and end of raid"] = "錯誤:輸入的時間不在團隊開始與結束時間之內"
MRT_L.GUI["Header_Title"] = "MRT - 團隊記錄"
MRT_L.GUI["Item cost invalid"] = "錯誤:物品價值不是數字"
MRT_L.GUI["Itemlink"] = "物品鏈結 或 物品代碼 或 物品名稱"
MRT_L.GUI["Looter"] = "拾取者"
MRT_L.GUI["Modify loot data"] = "修改掉落資料"
MRT_L.GUI["No active raid in progress. Please enter time."] = "錯誤:沒有活動中的團隊事件,請輸入時間"
MRT_L.GUI["No active raid."] = "錯誤:沒有活動中的團隊事件"
MRT_L.GUI["No boss attendee selected"] = "錯誤:沒有選擇首領戰鬥參與者"
MRT_L.GUI["No boss name entered"] = "錯誤:沒有輸入首領名稱"
MRT_L.GUI["No boss selected"] = "錯誤:沒有選擇首領"
MRT_L.GUI["No itemLink found"] = "錯誤:不合法的物品鏈結"
MRT_L.GUI["No loot selected"] = "錯誤:沒有選擇物品"
MRT_L.GUI["No name entered"] = "錯誤:沒有輸入名稱"
MRT_L.GUI["No raid attendee selected"] = "錯誤:沒有選擇團隊參與者"
MRT_L.GUI["No raid selected"] = "錯誤:沒有選擇團隊"
MRT_L.GUI["No valid difficulty entered"] = "錯誤:沒有輸入正確的難度"
MRT_L.GUI["No valid raid size"] = "錯誤:輸入不正確的團隊人數"
MRT_L.GUI["No valid time entered"] = "錯誤:沒有輸入正確的時間"
MRT_L.GUI["Note"] = "註記"
MRT_L.GUI["Player not in raid."] = "錯誤:你不再一的團隊中"
MRT_L.GUI["Raid size"] = "團隊人數"
MRT_L.GUI["Resuming last raid failed"] = "錯誤:上一次的團隊事件恢復失敗"
MRT_L.GUI["Resuming last raid successful"] = "成功恢復了上一次的團隊事件"
MRT_L.GUI["Tables_BossAttendeesTitle"] = "首領戰鬥參與者"
MRT_L.GUI["Tables_BossLootTitle"] = "首領掉落"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "團隊成員"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "首領擊殺"
MRT_L.GUI["Tables_RaidLogTitle"] = "團隊記錄列表"
MRT_L.GUI["Tables_RaidLootTitle"] = "團隊拾取"
MRT_L.GUI["Time"] = "時間"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[格式 HH:MM

如果保留空白, MRT將會
使用團隊事件開始時間]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[格式 HH:MM

如果保留空白, MRT將會
使用團隊事件結束或當前時間]=]
MRT_L.GUI["TT_BA_Add"] = "在該首領參與列表中加入一位成員"
MRT_L.GUI["TT_BA_Delete"] = "刪除選擇的首領參與"
MRT_L.GUI["TT_Boss_Add"] = "增加一個首領事件"
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[格式 HH:MM

如果你想在當前的團隊事件中增加一個首領,
請保留空白]=]
MRT_L.GUI["TT_Boss_Delete"] = "刪除選擇的首領事件"
MRT_L.GUI["TT_Boss_Export"] = "匯出選擇的首領事件"
MRT_L.GUI["TT_Loot_Add"] = "在拾取列表中加入一個物品"
MRT_L.GUI["TT_Loot_Delete"] = "刪除選擇的物品"
MRT_L.GUI["TT_Loot_Modify"] = "修改所選物品的資訊"
MRT_L.GUI["TT_RA_Add"] = "增加一位成員到參與者列表"
MRT_L.GUI["TT_RA_Delete"] = "刪除選擇的團隊參與者"
MRT_L.GUI["TT_Raid_Delete"] = "刪除選擇的團隊記錄"
MRT_L.GUI["TT_Raid_Export"] = "匯出選擇的團隊記錄"
MRT_L.GUI["TT_Raid_ExportH"] = "匯出所選團隊記錄的所有英雄模式"
MRT_L.GUI["TT_Raid_ExportN"] = "匯出所選團隊記錄的所有普通模式"
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "如果保留空白, MRT 將會使用預設值25"
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "如果保留空白, MRT 將會使用你現在的區域名稱"
MRT_L.GUI["TT_TakeSnapshot"] = [=[建立當前團隊的簡要資訊,如果團隊追蹤
正在進行中將無法動作,如果有這種狀況,
先加入一個首領事件]=]
MRT_L.GUI["Value"] = "值"
MRT_L.GUI["Zone name"] = "區域名稱"
