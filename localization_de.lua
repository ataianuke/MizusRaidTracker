-- *******************************************************
-- **          Mizus Raid Tracker - deDE Local          **
-- **            <ENTER URL HERE>            **
-- *******************************************************
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


----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "deDE" then return end


-----------------------------------
--  Local for the Optionspanels  --
-----------------------------------
-- MainPanel - Text
MRT_L.Options["MP_Description"] = "Trackt Raids, Loot und Teilnehmer";
-- MainPanel - Checkboxes
MRT_L.Options["MP_Enabled"] = "Aktiviert";
MRT_L.Options["MP_Debug"] = "Debugausgaben";
