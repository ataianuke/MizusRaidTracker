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

------------------------------------------------------
--  Register panels, parse values and localization  --
------------------------------------------------------
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


---------------------------------------------------
--  parse values and localization on first show  --
---------------------------------------------------
function MRT_Options_ParseValues()
    MRT_Options_MainPanel_Title:SetText(MRT_ADDON_TITLE.." v."..MRT_ADDON_VERSION);
    MRT_Options_MainPanel_Description:SetText(MRT_L.Options["MP_Description"]);
    MRT_Options_MainPanel_Enabled_CB:SetChecked(MRT_Options["General_MasterEnable"]);
    MRT_Options_MainPanel_Enabled_CB_Text:SetText(MRT_L.Options["MP_Enabled"]);
    MRT_Options_MainPanel_Debug_CB:SetChecked(MRT_Options["General_DebugEnabled"]);
end


--------------------
--  Save changes  --
--------------------
function MRT_Options_OnOkay(panel)
    MRT_Debug("InterfaceOptions - OkayButton pressed");
end


----------------------
--  Revert changes  --
----------------------
function MRT_Options_OnCancel(panel)
    MRT_Debug("InterfaceOptions - CancelButton pressed");
end
