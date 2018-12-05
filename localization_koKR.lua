-- *******************************************************
-- **          Mizus RaidTracker - koKR Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  7destiny, Eldanus
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
if GetLocale() ~= "koKR" then return end


-----------------
--  Bossyells  --
-----------------
_L.yells[529]["Algalon"] = "나는 창조주의 불길이 씻어내린 세상을 보았다. 모두 변변히 저항도 못하고 사그라졌지. 너희 필멸자의 심장이 단 한번 뛸 시간에 전 행성계가 탄생하고 무너졌다. 그러나 그 모든 시간 동안, 나는 공감이란 감정을... 몰랐다. 나는, 아무것도, 느끼지, 못했다. 무수한, 무수한 생명이 꺼졌다. 그들이 모두 너희처럼 강인했더냐? 그들이 모두 너희처럼 삶을 사랑했단 말이냐?"
_L.yells[529]["Freya"] = "내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다."
_L.yells[529]["Hodir"] = "드디어... 드디어 그의 손아귀를... 벗어나는구나."
_L.yells[529]["Mimiron"] = "내가 계산을 좀 잘못한 것 같군. 감옥에 갇힌 마귀가 내 마음을 타락시키고 제1지시를 재정의하고 말았다. 이제 모든 시스템이 제 기능을 찾았다. 정상이다."
_L.yells[529]["Thorim"] = "무기를 거둬라! 내가 졌다!"
_L.yells[543]["Faction Champions"] = "상처뿐인 승리로군."
_L.yells[604]["Dreamwalker"] = "다시 힘을 얻었다! 이세라여, 더러운 생명들에 안식을 내릴 수 있도록 은혜를 베푸소서!"
_L.yells[604]["Icecrown Gunship Battle Alliance"] = "악당 놈들, 분명히 경고했다! 형제자매여, 전진!"
_L.yells[604]["Icecrown Gunship Battle Horde"] = "얼라이언스는 기가 꺾였다. 리치 왕을 향해 전진하라!"
_L.yells[609]["Halion"] = "필멸자들아, 승리를 만끽해라. 그것이 마지막일 테니. 주인님이 돌아오시면 이 세상은 불타버리리라!"
_L.yells[773]["Conclave Of Wind"] = "바람의 비밀의회가 패배했군. 필멸자들이여, 너희의 명예로운 전투와 투지가 가상하여 나를 직접 상대할 기회를 주겠다. 내 너희의 공격을 기다리고 있다! 오너라!"


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core["DKP_Frame_Bank_Button"] = "은행"
MRT_L.Core["DKP_Frame_Cancel_Button"] = "취소"
MRT_L.Core["DKP_Frame_Cost"] = "비용"
MRT_L.Core["DKP_Frame_Delete_Button"] = "삭제"
MRT_L.Core["DKP_Frame_Disenchanted_Button"] = "마력 추출"
MRT_L.Core["DKP_Frame_EnterCostFor"] = "비용 입력"
MRT_L.Core["DKP_Frame_LootetBy"] = "|cFFFFFFFF%s|r 전리품을 획득했습니다."
MRT_L.Core["DKP_Frame_Note"] = "Note"
MRT_L.Core["DKP_Frame_OK_Button"] = "예"
MRT_L.Core["DKP_Frame_Title"] = "비용 입력"
MRT_L.Core["Export_Attendees"] = "참석자"
MRT_L.Core["Export_Button"] = "닫기"
MRT_L.Core["Export_Explanation"] = [=[Ctrl+C - 클립보드에서 데이터를 복사합니다.
Ctrl+V - 당신의 웹브라우저에서 데이터를 가져옵니다.]=]
MRT_L.Core["Export_Frame_Title"] = "데이터 내보내기"
MRT_L.Core["Export_Heroic"] = "영웅"
MRT_L.Core["Export_Loot"] = "전리품"
MRT_L.Core["Export_Normal"] = "일반"
MRT_L.Core["GuildAttendanceAnnounceText"] = "DKP 목록에 추가할 캐릭터 이름을 귓말로 말해주세요."
MRT_L.Core["GuildAttendanceBossDownText"] = "%s 다운!"
MRT_L.Core["GuildAttendanceBossEntry"] = "참여 체크"
MRT_L.Core["GuildAttendanceMsgBox"] = "%s 다운. 지금 참여자 체크를 만드시겠습니까?"
MRT_L.Core["GuildAttendanceRemainingTimeText"] = "%d 분 남았습니다."
MRT_L.Core["GuildAttendanceReply"] = "DKP에 %s 추가하였습니다."
MRT_L.Core["GuildAttendanceReplyFail"] = "%s - DKP 목록에 이미 있습니다."
MRT_L.Core["GuildAttendanceTimeUpText"] = "나의 귓속말이 보인다면 당신은 늦어서 입니다."
MRT_L.Core["LDB Left-click to toggle the raidlog browser"] = "Left-click - 공격대로그 브라우저 토글"
MRT_L.Core["LDB Right-click to open the options menu"] = "Right-click - 설정 메뉴 열기"
MRT_L.Core["MB_Cancel"] = "취소"
MRT_L.Core["MB_No"] = "아니오"
MRT_L.Core["MB_Ok"] = "예"
MRT_L.Core["MB_Yes"] = "예"
MRT_L.Core["TakeSnapshot_CurrentRaidError"] = "오류: 진행중인 공격대가 없습니다. 스냅샷을 촬영 할수업습니다."
MRT_L.Core["TakeSnapshot_Done"] = "스냅샷을 촬영합니다."
MRT_L.Core["TakeSnapshot_NotInRaidError"] = "오류: 당신은 공격대에 참여하지 않았습니다. 스냅샷 촬영을 할수없습니다."
MRT_L.Core["Trash Mob"] = "잔몹"


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options["AP_GroupRestriction"] = "첫번째 2/5 파티만 추적"
MRT_L.Options["AP_GuildAttendance"] = "공격대 참여 체크 활성화"
MRT_L.Options["AP_GuildAttendanceCustomTextTitle"] = "사용자 정의 공격대 참가자 확인 메세지:"
MRT_L.Options["AP_GuildAttendanceDuration"] = "참여 시간"
MRT_L.Options["AP_GuildAttendanceNoAuto"] = "확인 요청"
MRT_L.Options["AP_GuildAttendanceTrigger"] = "트리거"
MRT_L.Options["AP_GuildAttendanceUseCustomText"] = "사용자 정의 공격대 참가자 확인 메세지 사용"
MRT_L.Options["AP_GuildAttendanceUseTrigger"] = "케릭터 이름 대신 트리거 사용"
MRT_L.Options["AP_Minutes"] = "분"
MRT_L.Options["AP_Title"] = "참여"
MRT_L.Options["AP_TitleText"] = "MRT - 참여 설정"
MRT_L.Options["AP_TrackOfflinePlayers"] = "오프라인 플레이어 추적"
MRT_L.Options["EP_AllXMLExportsTitle"] = "모든 XML 내보내기 형식"
MRT_L.Options["EP_BBCode"] = "BB코드 형식의 텍스트"
MRT_L.Options["EP_BBCode_wowhead"] = "Wowhead 링크가 추가된 BBCode 형식의 텍스트"
MRT_L.Options["EP_ChooseExport_Title"] = "내보내기 형식"
MRT_L.Options["EP_CTRT_compatible"] = "CT RaidTracker 호환"
MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"] = "보스당 참가자 기록 빼기"
MRT_L.Options["EP_CTRT_RLIAttendanceFix"] = [=[EQdkp-Plus Raid-Log-Import 0.5.6.x
에 맞게\n참가자 기록 조정 켜기]=]
MRT_L.Options["EP_CTRTTitleText"] = "CT Raid Tracker 로 내보내기 설정"
MRT_L.Options["EP_Currency"] = "현재"
MRT_L.Options["EP_EnglishExport"] = "보스 이름과 지역 이름을 영어로 내보내기"
MRT_L.Options["EP_EQDKP_Plus_XML"] = "EQdkp-Plus XML"
MRT_L.Options["EP_EQDKPTitleText"] = "EQdkp-Plus XML 설정"
MRT_L.Options["EP_HTML"] = "Wowhead 링크가 추가된 CSS 기반 HTML"
MRT_L.Options["EP_MLDKP_15"] = "MLdkp 1.5"
MRT_L.Options["EP_Plain_Text"] = "일반 텍스트"
MRT_L.Options["EP_SetDateTimeFormat"] = "날짜와 시간 형식 설정"
MRT_L.Options["EP_TextExportTitleText"] = "텍스트 내보내기 설정"
MRT_L.Options["EP_Title"] = "내보내기"
MRT_L.Options["EP_TitleText"] = "MRT - 내보내기 설정"
MRT_L.Options["ITP_AutoFocus_Always"] = "항상"
MRT_L.Options["ITP_AutoFocus_Never"] = "하지 않음"
MRT_L.Options["ITP_AutoFocus_NoCombat"] = "전투중이 아닐때"
MRT_L.Options["ITP_AutoFocus_Title"] = "전리품 비용 다이얼로그를 자동주시"
MRT_L.Options["ITP_IgnoreEnchantingMats"] = "마력 추출 아이템 기록 안함"
MRT_L.Options["ITP_IgnoreGems"] = "보석 기록 안함"
MRT_L.Options["ITP_Title"] = "아이템 추적"
MRT_L.Options["ITP_TitleText"] = "MRT - 아이템 추적 옵션"
MRT_L.Options["ITP_UseEPGP_GP_Values"] = "EPGP GP 값 사용"
MRT_L.Options["MP_AutoPrunning"] = "오래된 레이드 자동 삭제"
MRT_L.Options["MP_Days"] = "날짜"
MRT_L.Options["MP_Debug"] = "디버그 메세지 활성화"
MRT_L.Options["MP_Description"] = "공격대 참여와 전리품 추적"
MRT_L.Options["MP_Enabled"] = "MRT 활성화"
MRT_L.Options["MP_MinimapIcon"] = "미니맵 아이콘 표시"
MRT_L.Options["MP_SlashCmd"] = "슬러쉬 명령어"
MRT_L.Options["TP_AskForDKPValue"] = "아이템 비용"
MRT_L.Options["TP_CreateNewRaidOnNewZone"] = "새 지역시 새 공격대 생성"
MRT_L.Options["TP_Log10MenRaids"] = "10인 공격대 추적"
MRT_L.Options["TP_LogAVRaids"] = "아카본 석실 추적"
MRT_L.Options["TP_LogWotLKRaids"] = "리분 공격대 던전 자동 인식"
MRT_L.Options["TP_MinItemQualityToGetCost_Desc"] = "비용을 묻는 최소 아이템 등급"
MRT_L.Options["TP_MinItemQualityToLog_Desc"] = "로그의 최소 아이템 등급"
MRT_L.Options["TP_OnlyTrackItemsAbove"] = "아이템레벨이 같거나 이상만 추적"
MRT_L.Options["TP_OnlyTrackItemsBelow"] = " 동급 또는 이하의 아이템레벨"
MRT_L.Options["TP_Title"] = "추적"
MRT_L.Options["TP_TitleText"] = "MRT - 추적 설정"
MRT_L.Options["TP_UseServerTime"] = "서버 시간 사용"
MRT_L.Options["TT_AP_GA_CustomText"] = [=[사용 가능 변수:
<<BOSS>> - 보스 이벤트 이름
<<TIME>> - 공격대 참가자 확인에 남은 시간
<<TRIGGER>> - 사용자 정의 트리거 명령어]=]
MRT_L.Options["TT_EP_DateTimeTT"] = [=[%d - 일 [01-31]
%m - 월 [01-12]
%y - 두자리 년도 [00-99]
%Y - 전체 년도

%H -시간, 24시간 단위 [00-23]
%I - 시간, 12시간 단위 [01-12]
%M - 분 [00-59]
%S - 초 [00-59]
%p - 'am' 또는 'pm' 택일]=]
MRT_L.Options["TT_EP_RLIAttendanceFix"] = [=[이 옵션은 Raid-Log-Importer의 50% 참가자 한계수치 검사를
통과하기 위해\n레이드 기록의 타임스탬프를 조금 변경합니다.
사용중인 DKP 시스템이 보스당 참가자를 기록하는 방식일 경우에만 사용하세요.]=]
MRT_L.Options["TT_MP_SlashCmd"] = [=[앞에 슬래시는 빼고 명령어만 입력하세요.
이 값의 변경은 재기록 후에 하는 것이 좋습니다.]=]


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI["Active raid found. End current one first."] = "오류: 활성화중인 공격대를 찾았습니다. 새로운 공격대를 시작하기전에 활성화중인 공격대를 종료하세요."
MRT_L.GUI["Add boss attendee"] = "보스 참석자 추가"
MRT_L.GUI["Add bosskill"] = "보스킬 추가"
MRT_L.GUI["Add loot data"] = "전리품 데이터 추가"
MRT_L.GUI["Add raid attendee"] = "공격대 참여자 추가"
MRT_L.GUI["Bossname"] = "보스이름"
MRT_L.GUI["Button_Add"] = "추가"
MRT_L.GUI["Button_Delete"] = "삭제"
MRT_L.GUI["Button_EndCurrentRaid"] = "현재 공격대 종료"
MRT_L.GUI["Button_Export"] = "내보내기"
MRT_L.GUI["Button_ExportHeroic"] = "내보내기 H"
MRT_L.GUI["Button_ExportNormal"] = "내보내기 N"
MRT_L.GUI["Button_MakeGuildAttendanceCheck"] = "길드 출석체크 만듬"
MRT_L.GUI["Button_Modify"] = "수정"
MRT_L.GUI["Button_ResumeLastRaid"] = "지난 레이드 재개"
MRT_L.GUI["Button_StartNewRaid"] = "새 공격대 시작"
MRT_L.GUI["Button_TakeSnapshot"] = "탱커 스냅샷"
MRT_L.GUI["Can not delete current raid"] = "오류: 현재 공격대를 삭제할 수 없습니다."
MRT_L.GUI["Cell_Hard"] = "영웅"
MRT_L.GUI["Cell_Normal"] = "일반"
MRT_L.GUI["Col_Cost"] = "비용"
MRT_L.GUI["Col_Date"] = "날짜"
MRT_L.GUI["Col_Difficulty"] = "모드"
MRT_L.GUI["Col_Join"] = "참여"
MRT_L.GUI["Col_Leave"] = "탈퇴"
MRT_L.GUI["Col_Looter"] = "전리품 획득자"
MRT_L.GUI["Col_Name"] = "이름"
MRT_L.GUI["Col_Num"] = "#"
MRT_L.GUI["Col_Size"] = "크기"
MRT_L.GUI["Col_Time"] = "시간"
MRT_L.GUI["Col_Zone"] = "지역"
MRT_L.GUI["Confirm boss attendee entry deletion"] = "보스 참석자 목록에서 %s 삭제를 하겠습니까?"
MRT_L.GUI["Confirm boss entry deletion"] = "보스처치 목록에서 항목 %d - %s 삭제를 하겠습니까?"
MRT_L.GUI["Confirm loot entry deletion"] = "전리품 목록에서 %s 아이템 삭제를 하겠습니까?"
MRT_L.GUI["Confirm raid attendee entry deletion"] = "공격대 참여자 목록에서 %s 삭제를 하겠습니까?"
MRT_L.GUI["Confirm raid entry deletion"] = "공격대 %d 삭제를 하겠습니까?"
MRT_L.GUI["Difficulty N or H"] = "난이도 ('N' 또는 'H')"
MRT_L.GUI["End tracking of current raid before exporting it"] = "오류: 활동 공격대를 내보낼수 없습니다."
MRT_L.GUI["Entered join time is not before leave time"] = "오류: 참여와 떠난 시간이 입력되지 않았습니다."
MRT_L.GUI["Entered time is not between start and end of raid"] = "오류: 공격대의 시작과 종료의 사이의 시간을 입력되지 않았습니다."
MRT_L.GUI["Header_Title"] = "MRT - 공격대로그"
MRT_L.GUI["Item cost invalid"] = "오류: 아이템 비용이 숫자가 아닙니다."
MRT_L.GUI["Itemlink"] = "아이템링크"
MRT_L.GUI["Looter"] = "전리품 획득자"
MRT_L.GUI["Modify loot data"] = "전리품 데이터 수정"
MRT_L.GUI["No active raid in progress. Please enter time."] = "오류: 진행중인 활동 공격대가 없습니다. 시간 입력을 부탁합니다."
MRT_L.GUI["No active raid."] = "오류: 공격대가 활성화 되지 않았습니다."
MRT_L.GUI["No boss attendee selected"] = "오류: 보스 참여자가 선택되지 않았습니다."
MRT_L.GUI["No boss name entered"] = "오류: 보스 이름이 입력되지 않았습니다."
MRT_L.GUI["No boss selected"] = "오류: 보스가 선택되지 않았습니다."
MRT_L.GUI["No itemLink found"] = "오류: 유효하지 않은 아이템링크입니다."
MRT_L.GUI["No loot selected"] = "오류: 아이템이 선택되지 않았습니다."
MRT_L.GUI["No name entered"] = "오류: 이름이 입력되지 않았습니다."
MRT_L.GUI["No raid attendee selected"] = "오류: 공격대 참여자가 선택되지 않았습니다."
MRT_L.GUI["No raid selected"] = "오류: 공격대가 선택되지 않았습니다."
MRT_L.GUI["No valid difficulty entered"] = "오류: 난이도가 입력되지 않았습니다."
MRT_L.GUI["No valid raid size"] = "오류: 공격대 크기가 입력되지 않았습니다."
MRT_L.GUI["No valid time entered"] = "오류: 시간이 입력되지 않았습니다."
MRT_L.GUI["Note"] = "Note"
MRT_L.GUI["Player not in raid."] = "오류: 당신은 공격대에 참여하지 않았습니다."
MRT_L.GUI["Raid size"] = "공격대 크기"
MRT_L.GUI["Resuming last raid failed"] = "오류: 지난 레이드 재개에 실패했습니다"
MRT_L.GUI["Resuming last raid successful"] = "지난 레이드를 재개했습니다."
MRT_L.GUI["Tables_BossAttendeesTitle"] = "보스 참여자"
MRT_L.GUI["Tables_BossLootTitle"] = "보스 전리품"
MRT_L.GUI["Tables_RaidAttendeesTitle"] = "공격대 참여자"
MRT_L.GUI["Tables_RaidBosskillsTitle"] = "공격대 보스처치"
MRT_L.GUI["Tables_RaidLogTitle"] = "공격대 목록"
MRT_L.GUI["Tables_RaidLootTitle"] = "공격대 전리품"
MRT_L.GUI["Time"] = "시간"
MRT_L.GUI["TT_Attendee_Add_JoinEB"] = [=[HH:MM 형식

만약 공간을 비운다면 MRT에서
공격대 시작 시간을 사용합니다.]=]
MRT_L.GUI["TT_Attendee_Add_LeaveEB"] = [=[HH:MM 형식

만약 공간을 비운다면 MRT에서 현재 시간
또는 공격대 종료 시간을 사용합니다.]=]
MRT_L.GUI["TT_BA_Add"] = "보스 참여 목록에 참여를 추가합니다."
MRT_L.GUI["TT_BA_Delete"] = "선택한 보스 참여를 삭제합니다."
MRT_L.GUI["TT_Boss_Add"] = "보스 교전을 추가합니다."
MRT_L.GUI["TT_Boss_Add_TimeEB"] = [=[HH:MM 형식

현재 공격대의 최근 보스를 추가할려면
비워두세요.]=]
MRT_L.GUI["TT_Boss_Delete"] = "선택한 보스 교전을 삭제합니다."
MRT_L.GUI["TT_Boss_Export"] = "선택한 보스 교전을 내보냅니다."
MRT_L.GUI["TT_Loot_Add"] = "전리품 목록에 아이템을 추가합니다."
MRT_L.GUI["TT_Loot_Delete"] = "선택된 아이템을 삭제합니다."
MRT_L.GUI["TT_Loot_Modify"] = "선택된 아이템의 데이터를 수정합니다."
MRT_L.GUI["TT_RA_Add"] = "공격대 참여자 목록의 참여자를 추가합니다."
MRT_L.GUI["TT_RA_Delete"] = "선택한 공격대 참여자를 삭제합니다."
MRT_L.GUI["TT_Raid_Delete"] = "선택된 공격대를 삭제합니다."
MRT_L.GUI["TT_Raid_Export"] = "선택된 공격대를 내보냅니다."
MRT_L.GUI["TT_Raid_ExportH"] = "선택된 공격대의 영웅 모드의 교전을 내보냅니다."
MRT_L.GUI["TT_Raid_ExportN"] = "선택된 공격대의 일반 모드의 교전을 내보냅니다."
MRT_L.GUI["TT_StartNewRaid_RaidSizeEB"] = "만약 좌측을 비우면 MRT 에서 25 기본값을 사용합니다."
MRT_L.GUI["TT_StartNewRaid_ZoneNameEB"] = "만약 빈공간이면 MRT에서 당신의 현재 지역을 사용합니다."
MRT_L.GUI["TT_TakeSnapshot"] = [=[현재 공격대의 스냅샷을 촬영합니다.
레이드 트래킹 중이면 작동하지 않습니다.
이런 경우 보스 이벤트를 추가해 주세요.]=]
MRT_L.GUI["Value"] = "가격"
MRT_L.GUI["Zone name"] = "지역 이름"
