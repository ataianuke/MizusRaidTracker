-- *******************************************************
-- **          Mizus RaidTracker - koKR Local           **
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
if GetLocale() ~= "koKR" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
	["영원의 눈"] = "The Eye of Eternity",
	["흑요석 성소"] = "The Obsidian Sanctum",
	["아카본 석실"] = "Vault of Archavon",
	["낙스라마스"] = "Naxxramas",
	["울두아르"] = "Ulduar",
	["십자군의 시험장"] = "Trial of the Crusader",
	["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
	["오닉시아의 둥지"] = "Onyxia's Lair",
	["얼음왕관 성채"] = "Icecrown Citadel",
    ["루비 성소"] = "The Ruby Sanctum",
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",  -- Four Horsemen

    -- Ulduar
    ["You rush headlong into the maw of madness!"] = "무쇠 평의회",  -- Normalmode - Stormcaller Brundir last
    ["What have you gained from my defeat? You are no less doomed, mortals!"] = "무쇠 평의회",  -- Semi-Hardmode - Runemaster Molgeim last
    --["Impossible..."] = function() return MRT_IsInstanceUlduar("무쇠 평의회") end,  -- Hardmode - Steelbreaker last  // also yelled by Lich King -> instance check necessary
    ["I... I am released from his grasp... at last."] = "호디르",  -- Hodir
    ["Stay your arms! I yield!"] = "토림",  -- Thorim
    ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "프레이야",  -- Freya
    ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "미미론",  -- Mimiron
    ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "관찰자 알갈론",  -- Algalon

    -- Trial of the Crusader
    ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "진영 대표 용사",  -- Faction Champions
    ["The Scourge cannot be stopped..."] = "발키르 쌍둥이",  -- Val'kyr Twins
        
    -- Icecrown Citadel
    ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "얼음왕관 비행포격선 전투", -- Gunship Battle Muradin (A)
    ["The Alliance falter. Onward to the Lich King!"] = "얼음왕관 비행포격선 전투", -- Gunship Battle Saurfang (H)
    ["My queen, they... come."] = "피의 공작 의회", -- Prince Keleseth
    ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "발리스리아 드림워커", -- Dreamwalker

    -- Ruby Sanctum
    ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "할리온", -- Halion
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
