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
    panel.name = "MizusRaidTracker";
    panel.okay = function(self) MRT_Options_OnOkay(self); end;
    panel.cancel = function(self) MRT_Options_OnCancel(self); end;
    InterfaceOptions_AddCategory(panel);
end

function MRT_Options_TrackingPanel_OnLoad(panel)
    panel.name = MRT_L.Options["TP_Title"];
    panel.parent = "MizusRaidTracker";
    InterfaceOptions_AddCategory(panel);
end

function MRT_Options_AttendancePanel_OnLoad(panel)
    panel.name = MRT_L.Options["AP_Title"];
    panel.parent = "MizusRaidTracker";
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
    -- TrackingPanel
    MRT_Options_TrackingPanel_Title:SetText(MRT_L.Options["TP_TitleText"]);
    MRT_Options_TrackingPanel_Log10MenRaids_CB:SetChecked(MRT_Options["Tracking_Log10MenRaids"]);
    MRT_Options_TrackingPanel_Log10MenRaids_CB_Text:SetText(MRT_L.Options["TP_Log10MenRaids"]);
    MRT_Options_TrackingPanel_LogAVRaids_CB:SetChecked(MRT_Options["Tracking_LogAVRaids"]);
    MRT_Options_TrackingPanel_LogAVRaids_CB_Text:SetText(MRT_L.Options["TP_LogAVRaids"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToLog"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderText:SetText(MRT_L.Options["TP_MinItemQualityToLog_Desc"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToLog"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToLog"]+1]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB:SetChecked(MRT_Options["Tracking_AskForDKPValue"]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB_Text:SetText(MRT_L.Options["TP_AskForDKPValue"]);    
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToGetDKPValue"]);
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_SliderText:SetText(MRT_L.Options["TP_MinItemQualityToGetCost_Desc"]);
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]);
    -- AttendancePanel
    MRT_Options_AttendancePanel_Title:SetText(MRT_L.Options["AP_TitleText"]);
    MRT_Options_AttendancePanel_Description:SetText("Not yet implemented");
end


--------------------------------------------------------------
--  Save changes - if required, change actual trackerstate  --
--------------------------------------------------------------
function MRT_Options_OnOkay(panel)
    MRT_Debug("InterfaceOptions - OkayButton pressed");
    -- MainPanel
    MRT_Options["General_MasterEnable"] = MRT_Options_MainPanel_Enabled_CB:GetChecked();
    MRT_Options["General_DebugEnabled"] = MRT_Options_MainPanel_Debug_CB:GetChecked();
    -- TrackingPanel
    MRT_Options["Tracking_Log10MenRaids"] = MRT_Options_TrackingPanel_Log10MenRaids_CB:GetChecked();
    MRT_Options["Tracking_LogAVRaids"] = MRT_Options_TrackingPanel_LogAVRaids_CB:GetChecked();
    MRT_Options["Tracking_MinItemQualityToLog"] = MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:GetValue();
    MRT_Options["Tracking_AskForDKPValue"] = MRT_Options_TrackingPanel_AskForDKPValue_CB:GetChecked();
    MRT_Options["Tracking_MinItemQualityToGetDKPValue"] = MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:GetValue();
    -- AttendancePanel
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
    -- MainPanel
    MRT_Options_MainPanel_Enabled_CB:SetChecked(MRT_Options["General_MasterEnable"]);
    MRT_Options_MainPanel_Debug_CB:SetChecked(MRT_Options["General_DebugEnabled"]);
    -- TrackingPanel
    MRT_Options_TrackingPanel_Log10MenRaids_CB:SetChecked(MRT_Options["Tracking_Log10MenRaids"]);
    MRT_Options_TrackingPanel_LogAVRaids_CB:SetChecked(MRT_Options["Tracking_LogAVRaids"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToLog"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToLog"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToLog"]+1]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB:SetChecked(MRT_Options["Tracking_AskForDKPValue"]);
    MRT_Options_TrackingPanel_MinItemQualityToGetCost_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToGetDKPValue"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]..MRT_L.ItemValues[MRT_Options["Tracking_MinItemQualityToGetDKPValue"]+1]);
    -- AttendancePanel
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
