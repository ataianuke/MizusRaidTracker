-- *******************************************************
-- **          Mizus RaidTracker - ruRU Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Mizukichan
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "ruRU" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
	["Око Вечности"] = "The Eye of Eternity",
	["Обсидиановое святилище"] = "The Obsidian Sanctum",
	["Склеп Аркавона"] = "Vault of Archavon",
	["Наксрамас"] = "Naxxramas",
	["Ульдуар"] = "Ulduar",
	["Испытание крестоносца"] = "Trial of the Crusader",
	["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
	["Логово Ониксии"] = "Onyxia's Lair",
	["Цитадель Ледяной Короны"] = "Icecrown Citadel",
    ["Рубиновое святилище"] = "The Ruby Sanctum",
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",  -- Four Horsemen

    -- Ulduar
    ["You rush headlong into the maw of madness!"] = "Железное собрание",  -- Normalmode - Stormcaller Brundir last
    ["What have you gained from my defeat? You are no less doomed, mortals!"] = "Железное собрание",  -- Semi-Hardmode - Runemaster Molgeim last
    --["Impossible..."] = "Железное собрание",  -- Hardmode - Steelbreaker last  // also yelled by Lich King -> instance check necessary
    ["I... I am released from his grasp... at last."] = "Ходир",  -- Hodir
    ["Stay your arms! I yield!"] = "Торим",  -- Thorim
    ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Фрейя",  -- Freya
    ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Мимирон",  -- Mimiron
    ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "Алгалон Наблюдатель",  -- Algalon

    -- Trial of the Crusader
    ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Чемпионы фракций",  -- Faction Champions
    ["The Scourge cannot be stopped..."] = "Валь'киры-близнецы",  -- Val'kyr Twins
        
    -- Icecrown Citadel
    ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Бой на кораблях", -- Gunship Battle Muradin (A)
    ["The Alliance falter. Onward to the Lich King!"] = "Бой на кораблях", -- Gunship Battle Saurfang (H)
    ["My queen, they... come."] = "Совет Принцев Крови", -- Prince Keleseth
    ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Валитрия Сноходица", -- Dreamwalker

    -- Ruby Sanctum
    ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "Халион", -- Halion
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
