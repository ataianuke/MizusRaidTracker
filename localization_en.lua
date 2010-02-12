-- ********************************************************
-- **        Mizus Raid Tracker - enGB/enUS Local        **
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
--    * Attribution. You must attribute the work in the manner specified by the author or licensor (but not in any way that suggests that they endorse you or your use of the work).
--    * Noncommercial. You may not use this work for commercial purposes.
--    * Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.
--


-----------------------------
--  Create Tablestructure  --
-----------------------------
MRT_L = {};
MRT_L["Options"] = {};
MRT_L["Bossyells"] = {};


-----------------
--  Bossyells  --
-----------------
-- Trial of the Crusader
MRT_L.Bossyells["The Scourge cannot be stopped..."] = "Twin Val'kyr";
MRT_L.Bossyells["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions";
	
-- Icecrown Citadel
MRT_L.Bossyells["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Icecrown Gunship Battle"; -- Muradin
MRT_L.Bossyells["Damage control! Put those fires out! You haven't seen the last of the horde!"] = "Icecrown Gunship Battle"; -- Saurfang
MRT_L.Bossyells["My queen, they... come."] = "Blood Prince Council"; -- Prince Keleseth
MRT_L.Bossyells["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker"; -- Dreamwalker


---------------------------
--  Optionspanels local  --
---------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Tracks raids, loot and attendance";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Enabled";
MRT_L.Options["MP_Debug"] = "Debugmessages";

-- TrackingPanel - Title
MRT_L.Options["TP_Title"] = "Tracking";

-- AttendancePanel - Title
MRT_L.Options["AP_Title"] = "Attendance";

