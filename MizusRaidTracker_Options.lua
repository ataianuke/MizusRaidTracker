-- ********************************************************
-- **            Mizus Raid Tracker - Options            **
-- **            <ENTER URL HERE>            **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall
--
-- The localizations are written by:
--    * enGB/enUS: Mizukichan
--    * deDE: Mizukichan
--
--
--    This file is part of Mizus Raid Tracker.
--
--    Mizus Raid Tracker is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as 
--    published by the Free Software Foundation, either version 3 of the 
--    License, or (at your option) any later version.
--
--    Mizus Raid Tracker is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Mizus Raid Tracker.  
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
    MRT_Options_TrackingPanel_LogAVRaids_CB_Text:SetText(MRT_L.Options["TP_LogAVRaids"].." - NYI! - will always track AV");
    MRT_Options_TrackingPanel_AskForDKPValue_CB:SetChecked(MRT_Options["Tracking_AskForDKPValue"]);
    MRT_Options_TrackingPanel_AskForDKPValue_CB_Text:SetText(MRT_L.Options["TP_AskForDKPValue"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:SetValue(MRT_Options["Tracking_MinItemQualityToLog"]);
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderText:SetText("SliderText");
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText("|c"..MRT_ItemColors[MRT_Options["Tracking_MinItemQualityToLog"]+1]..MRT_L.Options["TP_MinItemQualityToLog_Values"][MRT_Options["Tracking_MinItemQualityToLog"]+1]);
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
    -- AttendancePanel
    -- Check tracking status and adjust to new settings
    if (not MRT_Options["General_MasterEnable"]) then 
        MRT_EndActiveRaid();
    else 
        local instanceInfoName, instanceInfoType, instanceInfoDifficulty = GetInstanceInfo();
        if (MRT_L.Raidzones[instanceInfoName]) then
            MRT_CheckTrackingStatus(instanceInfoName, instanceInfoDifficulty);
        end
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
    -- AttendancePanel
end


------------------------
--  Slider functions  --
------------------------
function MRT_Options_TP_MinItemQualityToLog_Slider()
    local sliderValue = MRT_Options_TrackingPanel_MinItemQualityToLog_Slider:GetValue();
    local sliderText = "|c"..MRT_ItemColors[sliderValue+1]..MRT_L.Options["TP_MinItemQualityToLog_Values"][sliderValue+1];
    MRT_Options_TrackingPanel_MinItemQualityToLog_SliderValue:SetText(sliderText);
end
