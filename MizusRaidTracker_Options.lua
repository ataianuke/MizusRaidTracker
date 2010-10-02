-- *******************************************************
-- **            Mizus RaidTracker - Options            **
-- **           <http://nanaki.affenfelsen.de>          **
-- *******************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010)
--
-- The localizations are written by:
--    * enGB/enUS: Mizukichan
--    * deDE: Mizukichan
--
--
--    This file is part of Mizus RaidTracker.
--
--    Mizus RaidTracker is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as 
--    published by the Free Software Foundation, either version 3 of the 
--    License, or (at your option) any later version.
--
--    Mizus RaidTracker is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Mizus RaidTracker.  
--    If not, see <http://www.gnu.org/licenses/>.

-----------------------
--  Register panels  --
-----------------------
function MRT_Options_MainPanel_OnLoad(panel)
    panel.name = "Mizus RaidTracker";
    panel.okay = function(self) MRT_Options_OnOkay(self); end;
    panel.cancel = function(self) MRT_Options_OnCancel(self); end;
    InterfaceOptions_AddCategory(panel);
end

function MRT_Options_TrackingPanel_OnLoad(panel)
    panel.name = MRT_L.Options["TP_Title"];
    panel.parent = "Mizus RaidTracker";
    InterfaceOptions_AddCategory(panel);
end

function MRT_Options_AttendancePanel_OnLoad(panel)
    panel.name = MRT_L.Options["AP_Title"];
    panel.parent = "Mizus RaidTracker";
    InterfaceOptions_AddCategory(panel);
end

function MRT_Options_ExportPanel_OnLoad(panel)
    panel.name = MRT_L.Options["EP_Title"];
    panel.parent = "Mizus RaidTracker";
    InterfaceOptions_AddCategory(panel);
end    


--------------------------------------------------------
--  parse values and localization after ADDON_LOADED  --
--------------------------------------------------------
function MRT_Options_ParseValues()
    -- MainPanel
    MRT_Options_MainPanel_Title:SetText(MRT_ADDON_TITLE.." v."..MRT_ADDON_VERSION);
    MRT_Options_MainPanel_Description:SetText(MRT_L.Options["MP_Description"]);
    MRT_Options_MainPanel_Enabled_CB:SetChecked(MRT_Options["General_MasterEnable"]);
    MRT_Options_MainPanel_Enabled_CB_Text:SetText(MRT_L.Options["MP_Enabled"]);
    MRT_Options_MainPanel_Debug_CB:SetChecked(MRT_Options["General_DebugEnabled"]);
    MRT_Options_MainPanel_Debug_CB_Text:SetText(MRT_L.Options["MP_Debug"]);
    MRT_Options_MainPanel_SlashCmd_EB_Text:SetText(MRT_L.Options["MP_SlashCmd"]);
    MRT_Options_MainPanel_SlashCmd_EB:SetText(MRT_Options["General_SlashCmdHandler"]);
    MRT_Options_MainPanel_SlashCmd_EB:SetCursorPosition(0);
    -- TrackingPanel
    MRT_Options_TrackingPanel_Title:SetText(MRT_L.Options["TP_TitleText"]);
    MRT_Options_TrackingPanel_Description:SetText("");
    MRT_Options_TrackingPanel_Log10MenRaids_CB:SetChecked(MRT_Options["Tracking_Log10MenRaids"]);
    MRT_Options_TrackingPanel_Log10MenRaids_CB_Text:SetText(MRT_L.Options["TP_Log10MenRaids"]);
    MRT_Options_TrackingPanel_LogAVRaids_CB:SetChecked(MRT_Options["Tracking_LogAVRaids"]);
    MRT_Options_TrackingPanel_LogAVRaids_CB_Text:SetText(MRT_L.Options["TP_LogAVRaids"]);
    MRT_Options_TrackingPanel_CreateNewRaidOnNewZone_CB:SetChecked(MRT_Options["Tracking_CreateNewRaidOnNewZone"]);
    MRT_Options_TrackingPanel_CreateNewRaidOnNewZone_CB_Text:SetText(MRT_L.Options["TP_CreateNewRaidOnNewZone"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToLog"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderText:SetText(MRT_L.Options["TP_MinItemQualityToLog_Desc"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToLog"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToLog"]+1]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB:SetChecked(MRT_Options["Tracking_AskForDKPValue"]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB_Text:SetText(MRT_L.Options["TP_AskForDKPValue"]);    
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToGetDKPValue"]);
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_SliderText:SetText(MRT_L.Options["TP_MinItemQualityToGetCost_Desc"]);
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]);
    MRT_Options_TrackingPanel_UseServerTime_CB:SetChecked(MRT_Options["Tracking_UseServerTime"]);
    MRT_Options_TrackingPanel_UseServerTime_CB_Text:SetText(MRT_L.Options["TP_UseServerTime"]);
    -- AttendancePanel
    MRT_Options_AttendancePanel_Title:SetText(MRT_L.Options["AP_TitleText"]);
    MRT_Options_AttendancePanel_Description:SetText("");
    MRT_Options_AttendancePanel_GA_CB:SetChecked(MRT_Options["Attendance_GuildAttendanceCheckEnabled"]);
    MRT_Options_AttendancePanel_GA_CB_Text:SetText(MRT_L.Options["AP_GuildAttendance"]);
    MRT_Options_AttendancePanel_GA_NoAuto_CB:SetChecked(MRT_Options["Attendance_GuildAttendanceCheckNoAuto"]);
    MRT_Options_AttendancePanel_GA_NoAuto_CB_Text:SetText(MRT_L.Options["AP_GuildAttendanceNoAuto"]);
    MRT_Options_AttendancePanel_GADuration_Slider:SetValue(MRT_Options["Attendance_GuildAttendanceCheckDuration"]);
    MRT_Options_AttendancePanel_GADuration_SliderText:SetText(MRT_L.Options["AP_GuildAttendanceDuration"]);
    MRT_Options_AttendancePanel_GADuration_SliderValue:SetText(MRT_Options["Attendance_GuildAttendanceCheckDuration"].." "..MRT_L.Options["AP_Minutes"]);
    MRT_Options_AttendancePanel_GroupRestriction:SetChecked(MRT_Options["Attendance_GroupRestriction"]);
    MRT_Options_AttendancePanel_GroupRestriction_Text:SetText(MRT_L.Options["AP_GroupRestriction"]);
    MRT_Options_AttendancePanel_OfflinePlayers:SetChecked(MRT_Options["Attendance_TrackOffline"]);
    MRT_Options_AttendancePanel_OfflinePlayers_Text:SetText(MRT_L.Options["AP_TrackOfflinePlayers"]);
    -- ExportPanel
    MRT_Options_ExportPanel_Title:SetText(MRT_L.Options["EP_TitleText"]);
    MRT_Options_ExportPanel_Description:SetText("");
    MRT_Options_ExportPanel_ChooseExport_Title:SetText(MRT_L.Options["EP_ChooseExport_Title"]);
    MRT_Options_ExportPanel_Create_ChooseExport_DropDownMenu();
    MRT_Options_ExportPanel_CTRTExport_Title:SetText(MRT_L.Options["EP_CTRTTitleText"]);
    MRT_Options_ExportPanel_AddPoorItemToEachBoss_CB:SetChecked(MRT_Options["Export_CTRT_AddPoorItem"]);
    MRT_Options_ExportPanel_AddPoorItemToEachBoss_CB_Text:SetText(MRT_L.Options["EP_CTRT_AddPoorItem"]);
    MRT_Options_ExportPanel_IgnorePerBossAttendance_CB:SetChecked(MRT_Options["Export_CTRT_IgnorePerBossAttendance"]);
    MRT_Options_ExportPanel_IgnorePerBossAttendance_CB_Text:SetText(MRT_L.Options["EP_CTRT_IgnorePerBossAttendance"]);
    MRT_Options_ExportPanel_TextExport_Title:SetText(MRT_L.Options["EP_TextExportTitleText"]);
    MRT_Options_ExportPanel_SetDateFormat_EB_Text:SetText(MRT_L.Options["EP_SetDateTimeFormat"]);
    MRT_Options_ExportPanel_SetDateFormat_EB:SetText(MRT_Options["Export_DateTimeFormat"]);
    MRT_Options_ExportPanel_SetDateFormat_EB:SetCursorPosition(0);                                          -- Editboxes in OptionPanels needs its Position at 0 - nasty bug.
    MRT_Options_ExportPanel_Currency_EB_Text:SetText(MRT_L.Options["EP_Currency"]);
    MRT_Options_ExportPanel_Currency_EB:SetText(MRT_Options["Export_Currency"]);
    MRT_Options_ExportPanel_Currency_EB:SetCursorPosition(0);        
end


--------------------------------------------------------------
--  Save changes - if required, change actual trackerstate  --
--------------------------------------------------------------
function MRT_Options_OnOkay(panel)
    MRT_Debug("InterfaceOptions - OkayButton pressed");
    -- MainPanel
    MRT_Options["General_MasterEnable"] = MRT_Options_MainPanel_Enabled_CB:GetChecked();
    MRT_Options["General_DebugEnabled"] = MRT_Options_MainPanel_Debug_CB:GetChecked();
    MRT_Options["General_SlashCmdHandler"] = MRT_Options_MainPanel_SlashCmd_EB:GetText();
    -- TrackingPanel
    MRT_Options["Tracking_Log10MenRaids"] = MRT_Options_TrackingPanel_Log10MenRaids_CB:GetChecked();
    MRT_Options["Tracking_LogAVRaids"] = MRT_Options_TrackingPanel_LogAVRaids_CB:GetChecked();
    MRT_Options["Tracking_CreateNewRaidOnNewZone"] = MRT_Options_TrackingPanel_CreateNewRaidOnNewZone_CB:GetChecked();
    MRT_Options["Tracking_MinItemQualityToLog"] = MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:GetValue();
    MRT_Options["Tracking_AskForDKPValue"] = MRT_Options_TrackingPanel_AskForDKPValue_CB:GetChecked();
    MRT_Options["Tracking_MinItemQualityToGetDKPValue"] = MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:GetValue();
    MRT_Options["Tracking_UseServerTime"] = MRT_Options_TrackingPanel_UseServerTime_CB:GetChecked();
    -- AttendancePanel
    MRT_Options["Attendance_GuildAttendanceCheckEnabled"] = MRT_Options_AttendancePanel_GA_CB:GetChecked();
    MRT_Options["Attendance_GuildAttendanceCheckNoAuto"] = MRT_Options_AttendancePanel_GA_NoAuto_CB:GetChecked();
    MRT_Options["Attendance_GuildAttendanceCheckDuration"] = MRT_Options_AttendancePanel_GADuration_Slider:GetValue();
    MRT_Options["Attendance_GroupRestriction"] = MRT_Options_AttendancePanel_GroupRestriction:GetChecked();
    MRT_Options["Attendance_TrackOffline"] = MRT_Options_AttendancePanel_OfflinePlayers:GetChecked();
    -- ExportPanel
    MRT_Options["Export_ExportFormat"] = UIDropDownMenu_GetSelectedID(MRT_Options_ExportPanel_ChooseExport_DropDownMenu);
    MRT_Options["Export_CTRT_AddPoorItem"] = MRT_Options_ExportPanel_AddPoorItemToEachBoss_CB:GetChecked();
    MRT_Options["Export_CTRT_IgnorePerBossAttendance"] = MRT_Options_ExportPanel_IgnorePerBossAttendance_CB:GetChecked();
    MRT_Options["Export_DateTimeFormat"] = MRT_Options_ExportPanel_SetDateFormat_EB:GetText();
    MRT_Options["Export_Currency"] = MRT_Options_ExportPanel_Currency_EB:GetText();
    -- Set slash command to new value
    SLASH_MIZUSRAIDTRACKER1 = "/"..MRT_Options["General_SlashCmdHandler"];
    -- Check tracking status and adjust to new settings
    local currentRaidSize = MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidSize"];
    local currentRaidZoneEN = MRT_L.Raidzones[MRT_RaidLog[MRT_NumOfCurrentRaid]["RaidZone"]];
    if (not MRT_Options["General_MasterEnable"]) then 
        MRT_EndActiveRaid();
    elseif (not MRT_NumOfCurrentRaid) then
        local instanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
        if (MRT_L.Raidzones[instanceInfoName]) then
            MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty);
        end
    elseif ((currentRaidSize == 10) and not MRT_Options["Tracking_Log10MenRaids"]) then
        MRT_EndActiveRaid();
    elseif (MRT_PvPRaids[currentRaidZoneEN] and not MRT_Options["Tracking_LogAVRaids"]) then
        MRT_EndActiveRaid();
    end
end


----------------------
--  Revert changes  --
----------------------
function MRT_Options_OnCancel(panel)
    MRT_Debug("InterfaceOptions - CancelButton pressed");
    MRT_Options_ParseValues();   
end


------------------------
--  Slider functions  --
------------------------
function MRT_Options_TP_MinItemQualityToLog_Slider()
    local sliderValue = MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:GetValue();
    local sliderText = "|c"..MRT_ItemColors[sliderValue+1]..MRT_L.ItemValues[sliderValue+1];
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText(sliderText);
end

function MRT_Options_TP_MinItemQualityToGetCost_Slider()
    local sliderValue = MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:GetValue();
    local sliderText = "|c"..MRT_ItemColors[sliderValue+1]..MRT_L.ItemValues[sliderValue+1];
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_SliderValue:SetText(sliderText);
end

function MRT_Options_AP_GADuration_Slider()
    local sliderValue = MRT_Options_AttendancePanel_GADuration_Slider:GetValue();
    local sliderText = sliderValue.." "..MRT_L.Options["AP_Minutes"];
    MRT_Options_AttendancePanel_GADuration_SliderValue:SetText(sliderText);
end


-----------------------
--  Create function  --
-----------------------
function MRT_Options_ExportPanel_Create_ChooseExport_DropDownMenu()
    -- Create DropDownFrame
    if (not MRT_Options_ExportPanel_ChooseExport_DropDownMenu) then
        CreateFrame("Frame", "MRT_Options_ExportPanel_ChooseExport_DropDownMenu", MRT_Options_ExportPanel, "UIDropDownMenuTemplate");
    end
    -- Anchor DropDownFrame
    MRT_Options_ExportPanel_ChooseExport_DropDownMenu:ClearAllPoints();
    MRT_Options_ExportPanel_ChooseExport_DropDownMenu:SetPoint("TOPLEFT", MRT_Options_ExportPanel_ChooseExport_Title, "BOTTOMLEFT", -15, -5);
    MRT_Options_ExportPanel_ChooseExport_DropDownMenu:Show();
    -- List of DropDownMenuItems
    local items = {
        MRT_L.Options["EP_CTRT_compatible"],
        MRT_L.Options["EP_Plain_Text"],
        MRT_L.Options["EP_BBCode"],
    }
    -- Click handler function
    local function OnClick(self)
       UIDropDownMenu_SetSelectedID(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, self:GetID())
    end
    -- DropDownMenu initialize function
    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for k,v in pairs(items) do
            info = UIDropDownMenu_CreateInfo()
            info.text = v
            info.value = v
            info.func = OnClick
            UIDropDownMenu_AddButton(info, level)
        end
    end
    -- Setup DropDownMenu
    UIDropDownMenu_Initialize(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, initialize);
    UIDropDownMenu_SetWidth(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, 200);
    UIDropDownMenu_SetButtonWidth(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, 224);
    UIDropDownMenu_SetSelectedID(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, MRT_Options["Export_ExportFormat"]);
    UIDropDownMenu_JustifyText(MRT_Options_ExportPanel_ChooseExport_DropDownMenu, "LEFT");
end


-----------------------
--  ToolTip handler  --
-----------------------
function MRT_Options_SetTT(frame, zone)
    MRT_Options_TT:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
    MRT_Options_TT:SetText(MRT_L.Options["TT_"..zone]);
    MRT_Options_TT:Show();
end

function MRT_Options_HideTT()
    MRT_Options_TT:Hide();
    MRT_Options_TT:SetOwner(UIParent, "ANCHOR_NONE");
end
