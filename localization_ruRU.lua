-- *******************************************************
-- **          Mizus RaidTracker - ruRU Local           **
-- **             <http://cosmocanyon.de>               **
-- *******************************************************
--
-- This localization is written by:
--  homocomputeris, Ingdruid, rinaline, YOti
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
if GetLocale() ~= "ruRU" then return end


-----------------
--  Bossyells  --
-----------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[529]", namespace="Yells/Ulduar")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[543]", namespace="Yells/Trials_of_the_Crusader")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[604]", namespace="Yells/Icecrown_Citadel")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[609]", namespace="Yells/Ruby_Sanctum")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[773]", namespace="Yells/Throne_of_the_Four_Winds")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[800]", namespace="Yells/Firelands")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[886]", namespace="Yells/Terrace_of_Endless_Spring")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[953]", namespace="Yells/Siege_of_Orgrimmar")@
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="_L.yells[1026]", namespace="Yells/Hellfire_Citadel")@


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="english", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
