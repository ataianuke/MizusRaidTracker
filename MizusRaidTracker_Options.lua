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
--      * deDE: Mizukichan
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

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
