-- *******************************************************
-- **          Mizus RaidTracker - zhCN Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  luomoon
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
if GetLocale() ~= "zhCN" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[529]["Algalon"] = "我曾经看过尘世沉浸在造物者的烈焰之中，众生连一声悲泣都无法呼出，就此凋零。整个星系在弹指之间历经了毁灭与重生。然而在这段历程之中，我的心却无法感受到丝毫的…恻隐之念。我‧感‧受‧不‧到。成千上万的生命就这么消逝。他们是否拥有与你同样坚韧的生命?他们是否与你同样热爱生命?"
_L.yells[529]["Freya"] = "他对我的控制已经不复存在了。我又一次恢复了理智。谢谢你们，英雄们。"
_L.yells[529]["Hodir"] = "我……我终于从他的魔掌中……解脱了。"
_L.yells[529]["Mimiron"] = "看起来我的计算有一点小小的偏差。"
_L.yells[529]["Thorim"] = "住手！我认输了！"
_L.yells[543]["Faction Champions"] = "肤浅且可悲的胜利。今天的内耗让我们又一次被削弱了。这种愚蠢的行为只能让巫妖王受益！伟大的战士们就这样白白牺牲，而真正的威胁却步步逼近。巫妖王正计算着我们的死期。"
_L.yells[604]["Dreamwalker"] = "我获得了新生！伊瑟拉的恩泽赐予我消灭邪恶的力量！"
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "我早就警告过你，恶棍！兄弟姐妹们，前进！"
_L.yells[604]["Icecrown Gunship Battle Horde"] = "联盟不行了。向巫妖王进攻！"


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "银行"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "取消"
MRT_L.Core["DKP_Frame_Cost"] = "分值"
MRT_L.Core["DKP_Frame_Delete_Button"] = "删除"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "分解"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "输入分值"
MRT_L.Core["DKP_Frame_LootetBy"] = "已被|cFFFFFFFF%s|r拾取"
MRT_L.Core["DKP_Frame_Note"] = "备注"
MRT_L.Core["DKP_Frame_OK_Button"] = "确定"
MRT_L.Core["DKP_Frame_Title"] = "输入物品分值"
MRT_L.Core["Export_Attendees"] = "参与者"
MRT_L.Core["Export_Button"] = "关闭"
MRT_L.Core["Export_Explanation"] = [=[按 Ctrl+C 将字符串复制到剪切板，
按 Ctrl+V 导入到浏览器]=]
MRT_L.Core["Export_Frame_Title"] = "数据导出"
MRT_L.Core["Export_Heroic"] = "英雄"
MRT_L.Core["Export_Loot"] = "物品掉落"
MRT_L.Core["Export_Normal"] = "普通"
MRT_L.Core["GuildAttendanceAddNotice"] = "%s增加%s到首领战斗参与者列表"
MRT_L.Core["GuildAttendanceAnnounceText"] = "密我你的主角色名字来加入DKP列表"
MRT_L.Core["GuildAttendanceAnnounceText2"] = "用'%s'密语我来加入到DKP列表。"
MRT_L.Core["GuildAttendanceBossDownText"] = "击杀%s！"
MRT_L.Core["GuildAttendanceBossEntry"] = "团队成员检查"
MRT_L.Core["GuildAttendanceFailNotice"] = "%s增加%s到首领战斗参与者列表失败"
MRT_L.Core["GuildAttendanceMsgBox"] = "%s已击杀，现在进行团队成员检查么？"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "剩余%d分钟"
MRT_L.Core["GuildAttendanceReply"] = "增加%s到DKP列表"
MRT_L.Core["GuildAttendanceReplyFail"] = "%s已在DKP列表"
MRT_L.Core["GuildAttendanceTimeUpText"] = "假如你到现在还不曾密我, 你太慢了"
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "左键点击显示团队记录浏览"
MRT_L.Core["LDB Right-click to open the options menu"] = "右键点击打开选项"
MRT_L.Core["MB_Cancel"] = "取消"
MRT_L.Core["MB_No"] = "否"
MRT_L.Core["MB_Ok"] = "确定"
MRT_L.Core["MB_Yes"] = "是"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "错误: 团队活动进行中，无法取得快照"
MRT_L.Core["TakeSnapshot_Done"] = "取得快照"
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "错误: 你不在一个团队中，无法取得快照"
MRT_L.Core["Trash Mob"] = "小怪"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "仅追踪前2/前5小队"
MRT_L.Options["AP_GuildAttendance"] = "启用公会成员检查"
MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "自定义公会成员文本:"
MRT_L.Options["AP_GuildAttendanceDuration"] = "记录团队成员的持续时间"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "确认询问"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "触发"
MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "使用自定义公会成员文本"
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "使用触发来代替角色名字"
MRT_L.Options["AP_Minutes"] = "分钟"
MRT_L.Options["AP_Title"] = "参与者"
MRT_L.Options["AP_TitleText"] = "MRT - 参与者选项"
MRT_L.Options["AP_TrackOfflinePlayers"] = "追踪离线玩家"
MRT_L.Options["EP_AllXMLExportsTitle"] = "All XML 导出格式"
MRT_L.Options["EP_BBCode"] = "BBCode文字格式"
MRT_L.Options["EP_BBCode_wowhead"] = "在BBCode文字格式中使用wowhead链接"
MRT_L.Options["EP_ChooseExport_Title"] = "导出格式"
MRT_L.Options["EP_CTRT_AddPoorItem"] = "启用对于EQdkp(-Plus) CT_RaidTrackerImport 1.16.x的首领侦测修正"
MRT_L.Options["EP_CTRT_compatible"] = "EQdkp / MLdkp 1.1 (CT_RaidTracker兼容)"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "忽略每次首领战斗"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = "启用对于EQdkp-Plus Raid-Log-Import 0.5.6.3的团队成员修正"
MRT_L.Options["EP_CTRTTitleText"] = "CTRT兼容格式导出设置"
MRT_L.Options["EP_Currency"] = "货币"
MRT_L.Options["EP_DKPBoard"] = "DKP面板"
MRT_L.Options["EP_EnglishExport"] = "导出英文的地区和首领名称"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
MRT_L.Options["EP_EQDKPTitleText"] = "EQdkp-Plus XML 设置"
MRT_L.Options["EP_HTML"] = "在CSS based HTML中使用wowhead链接"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "纯文本格式"
MRT_L.Options["EP_SetDateTimeFormat"] = "设置日期和时间格式"
MRT_L.Options["EP_TextExportTitleText"] = "纯文本导出设置"
MRT_L.Options["EP_Title"] = "导出"
MRT_L.Options["EP_TitleText"] = "MRT - 导出选项"
MRT_L.Options["ITP_AutoFocus_Always"] = "总是"
MRT_L.Options["ITP_AutoFocus_Never"] = "从不"
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "不在战斗中时"
MRT_L.Options["ITP_AutoFocus_Title"] = "物品价值细节窗口置顶"
MRT_L.Options["ITP_IgnoreEnchantingMats"] = "忽略附魔材料"
MRT_L.Options["ITP_Title"] = "物品追踪"
MRT_L.Options["ITP_TitleText"] = "MRT - 物品追踪选项"
MRT_L.Options["MP_AutoPrunning"] = "自动删除团队记录，早于"
MRT_L.Options["MP_Days"] = "天的"
MRT_L.Options["MP_Debug"] = "启用除错信息"
MRT_L.Options["MP_Description"] = "追踪团队, 拾取和参与者"
MRT_L.Options["MP_Enabled"] = "启用自动追踪"
MRT_L.Options["MP_MinimapIcon"] = "显示小地图图标"
MRT_L.Options["MP_SlashCmd"] = "斜杠命令"
MRT_L.Options["TP_AskForDKPValue"] = "询问物品价值"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "在新地图时建立新的团队记录"
MRT_L.Options["TP_Log10MenRaids"] = "追踪10人团队"
MRT_L.Options["TP_LogAVRaids"] = "追踪PVP团队(宝库, BH)"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "询问物品价值所需最低品质"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "记录的物品最低品质"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = "紧追踪物品等级等于或高于该数值的物品"
MRT_L.Options["TP_OnlyTrackItemsBelow"] = "或等于和低于该数值"
MRT_L.Options["TP_Title"] = "追踪中"
MRT_L.Options["TP_TitleText"] = "MRT - 团队追踪选项"
MRT_L.Options["TP_UseServerTime"] = "使用服务器时间"
MRT_L.Options["TT_AP_GA_CustomText"] = [=[可用的变量: 
 <<BOSS>> - 首领事件名称 
 <<TIME>> - 公会成员检查的剩余时间 
 <<TRIGGER>> - 自定义触发命令]=]
MRT_L.Options["TT_EP_AddPoorItem"] = [=[这个选项改变了一点物品数据导出的格式 
来修正CT_RaidTrackerImport的首领事件侦测。
如果你有物品掉落没有关联到首领事件的情况，使用这个选项(e.g. 成员检查)]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[%d - 日 [01-31] 
 %m - 月 [01-12] 
 %y - 两位数表示年份 [00-99] 
 %Y - 完整年份 

 %H - 时，24小时制 [00-23] 
 %I - 时，12小时制 [01-12] 
 %M - 分 [00-59] 
 %S - 秒 [00-59] 
 %p - 'am'或'pm']=]
MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[这个选项改变了一点时间戳数据导出的格式 
来修正Raid-Log-Importer的50%时间门槛。
只有你的DKP系统采用每次首领战斗的情况下，才启用此选项。]=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[命令前不需要斜杠，
建议修改后退出重新登录游戏]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "错误: 找到进行中的团队事件，请在新建团队事件前结束当前团队事件"
MRT_L.GUI["Add boss attendee"] = "增加首领战斗参与者"
MRT_L.GUI["Add bosskill"] = "增加首领击杀"
MRT_L.GUI["Add loot data"] = "增加物品掉落资料"
MRT_L.GUI["Add raid attendee"] = "增加团队成员"
MRT_L.GUI["Bossname"] = "首领名称"
MRT_L.GUI["Button_Add"] = "增加"
MRT_L.GUI["Button_Delete"] = "删除"
MRT_L.GUI["Button_EndCurrentRaid"] = "结束当前团队事件"
MRT_L.GUI["Button_Export"] = "导出"
MRT_L.GUI["Button_ExportHeroic"] = "导出(英雄)"
MRT_L.GUI["Button_ExportNormal"] = "导出(普通)"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "进行公会成员检查"
MRT_L.GUI["Button_Modify"] = "修改"
MRT_L.GUI["Button_ResumeLastRaid"] = "恢复上一次的团队事件"
MRT_L.GUI["Button_StartNewRaid"] = "建立新的团队事件"
MRT_L.GUI["Button_TakeSnapshot"] = "取得快照"
MRT_L.GUI["Can not delete current raid"] = "错误: 不能删除当前团队事件"
MRT_L.GUI["Cell_Hard"] = "困难"
MRT_L.GUI["Cell_Normal"] = "普通"
MRT_L.GUI["Col_Cost"] = "物品价值"
MRT_L.GUI["Col_Date"] = "日期"
MRT_L.GUI["Col_Difficulty"] = "模式"
MRT_L.GUI["Col_Join"] = "加入"
MRT_L.GUI["Col_Leave"] = "离开"
MRT_L.GUI["Col_Looter"] = "拾取者"
MRT_L.GUI["Col_Name"] = "名称"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "人数"
MRT_L.GUI["Col_Time"] = "时间"
MRT_L.GUI["Col_Zone"] = "地区"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "你想将%s从首领战斗列表中删除么？"
MRT_L.GUI["Confirm boss entry deletion"] = "你想将%d - %s从首领战斗列表中删除么？"
MRT_L.GUI["Confirm loot entry deletion"] = "你想将%s从物品掉落列表中删除么？"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "你想将%s从团队成员列表中删除么？"
MRT_L.GUI["Confirm raid entry deletion"] = "你想将编号%d的团队事件删除么？"
MRT_L.GUI["Difficulty N or H"] = "难度('N'-普通或'H'-英雄)"
MRT_L.GUI["End tracking of current raid before exporting it"] = "错误: 无法导出当前进行中的团队事件"
MRT_L.GUI["Entered join time is not before leave time"] = "错误: 加入时间不在离开时间之前"
MRT_L.GUI["Entered time is not between start and end of raid"] = "错误: 加入时间不在团队活动开始和结束之间"
MRT_L.GUI["Header_Title"] = "MRT - 团队记录"
MRT_L.GUI["Item cost invalid"] = "错误: 物品价值不是数字"
MRT_L.GUI["Itemlink"] = "物品链接或物品编号或物品名称"
MRT_L.GUI["Looter"] = "拾取者"
MRT_L.GUI["Modify loot data"] = "修改掉落资料"
MRT_L.GUI["No active raid in progress. Please enter time."] = "错误: 没有进行中的团队事件，请输入时间"
MRT_L.GUI["No active raid."] = "错误: 没有进行中的团队时间"
MRT_L.GUI["No boss attendee selected"] = "错误: 没有选择首领战斗参与者"
MRT_L.GUI["No boss name entered"] = "错误: 没有输入首领名称"
MRT_L.GUI["No boss selected"] = "错误: 没有选择首领"
MRT_L.GUI["No itemLink found"] = "错误: 不合法的物品链接"
MRT_L.GUI["No loot selected"] = "错误: 没有选择物品"
MRT_L.GUI["No name entered"] = "错误: 没有输入名称"
MRT_L.GUI["No raid attendee selected"] = "错误: 没有选择团队成员"
MRT_L.GUI["No raid selected"] = "错误: 没有选择团队事件"
MRT_L.GUI["No valid difficulty entered"] = "错误: 没有输入正确的难度"
MRT_L.GUI["No valid raid size"] = "错误: 没有输入正确的团队人数"
MRT_L.GUI["No valid time entered"] = "错误: 没有输入正确的时间"
MRT_L.GUI["Note"] = "备注"
MRT_L.GUI["Player not in raid."] = "错误: 你不在一个团队中"
MRT_L.GUI["Raid size"] = "团队人数"
MRT_L.GUI["Resuming last raid failed"] = "错误: 上一次团队事件记录恢复失败"
MRT_L.GUI["Resuming last raid successful"] = "成功恢复上一次团队事件记录"
MRT_L.GUI["Tables_BossAttendeesTitle"] = "首领战斗参与者"
MRT_L.GUI["Tables_BossLootTitle"] = "首领掉落"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "团队成员"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "首领击杀"
MRT_L.GUI["Tables_RaidLogTitle"] = "团队记录列表"
MRT_L.GUI["Tables_RaidLootTitle"] = "团队拾取"
MRT_L.GUI["Time"] = "时间"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[格式 HH:MM 

如果留空, MRT 将会使用 
 团队事件开始时间]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[格式 HH:MM 

如果留空, MRT 将会使用 
 团队结束时间或当前时间]=]
MRT_L.GUI["TT_BA_Add"] = "在该首领参与列表中加入一名成员"
MRT_L.GUI["TT_BA_Delete"] = "删除选中的首领参与成员"
MRT_L.GUI["TT_Boss_Add"] = "增加一个首领事件"
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[格式 HH:MM 

如果你想在当前团队事件中增加一个首领，
请保留空白]=]
MRT_L.GUI["TT_Boss_Delete"] = "删除选择的首领事件"
MRT_L.GUI["TT_Boss_Export"] = "导出选择的首领事件"
MRT_L.GUI["TT_Loot_Add"] = "增加一个物品到拾取列表"
MRT_L.GUI["TT_Loot_Delete"] = "删除选择的物品"
MRT_L.GUI["TT_Loot_Modify"] = "修改所选物品的数据"
MRT_L.GUI["TT_RA_Add"] = "增加一名成员到团队成员列表"
MRT_L.GUI["TT_RA_Delete"] = "删除选择的团队成员"
MRT_L.GUI["TT_Raid_Delete"] = "删除选择的团队事件"
MRT_L.GUI["TT_Raid_Export"] = "导出选择的团队时间"
MRT_L.GUI["TT_Raid_ExportH"] = "导出所选团队事件的所有英雄模式"
MRT_L.GUI["TT_Raid_ExportN"] = "导出所选团队事件的所有普通模式"
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "如果留空, MRT 将会使用25人作为默认值"
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "如果留空, MRT 将会使用当前区域名称"
MRT_L.GUI["TT_TakeSnapshot"] = [=[建立当前团队的快照 
正在进行中的团队追踪将无法工作 
这种情况下，建立一个首领事件]=]
MRT_L.GUI["Value"] = "值"
MRT_L.GUI["Zone name"] = "地区名称"
