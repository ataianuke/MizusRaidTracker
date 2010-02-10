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
--	  * deDE: Mizukichan
--
-- The code of this addon is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. (see license.txt)
-- All included textures and sounds are copyrighted by their respective owners, license information for these media files can be found in the modules that make use of them.
--
--
--  You are free:
--    * to Share - to copy, distribute, display, and perform the work
--    * to Remix - to make derivative works
--  Under the following conditions:
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work). (A link to http://www.deadlybossmods.com is sufficient)
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--

------------------------------------------------------
--  Register panels, parse values and localization  --
------------------------------------------------------
function MRT_Options_MainPanel_OnLoad(panel)
	panel.name = "MizusRaidTracker";
	MRT_Options_MainPanel_Title:SetText(MRT_ADDON_TITLE.." v."..MRT_ADDON_VERSION);
	MRT_Options_MainPanel_Description:SetText("Tracks raids, loot and attendance (HARDCODED - FIXME!)");
	MRT_Options_MainPanel_Enabled_CB_Text:SetText("Enabled (HARDCODED - FIXME!)");
	InterfaceOptions_AddCategory(panel);
end

function MRT_Options_TrackingPanel_OnLoad(panel)
	panel.name = "Tracking";
	panel.parent = "MizusRaidTracker";
	InterfaceOptions_AddCategory(panel);
end

