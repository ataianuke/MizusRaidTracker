-- *******************************************************
-- **          Mizus RaidTracker - koKR Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  7destiny
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
	["오닉시아의 둥지"] = "Onyxia's Lair",
	["얼음왕관 성채"] = "Icecrown Citadel",
    ["루비 성소"] = "The Ruby Sanctum",
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    ["Naxxramas"] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",  -- Four Horsemen
    },
    
    ["Ulduar"] = {
        ["You rush headlong into the maw of madness!"] = "무쇠 평의회",  -- Normalmode - Stormcaller Brundir last
        ["What have you gained from my defeat? You are no less doomed, mortals!"] = "무쇠 평의회",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "무쇠 평의회",  -- Hardmode - Steelbreaker last
        ["드디어... 드디어 그의 손아귀를... 벗어나는구나."] = "호디르",  -- Hodir
        ["무기를 거둬라! 내가 졌다!"] = "토림",  -- Thorim
        ["내게서 그의 지배력이 걷혔다. 다시 온전한 정신을 찾았도다. 영웅들이여, 고맙다."] = "프레이야",  -- Freya
        ["^내가 계산을 좀 잘못한 것 같군"] = "미미론",  -- Mimiron
        ["나는 창조주의 불길이 씻어내린 세상을 보았다."] = "관찰자 알갈론",  -- Algalon
    },
    
    ["Trial of the Crusader"] = {
        ["상처뿐인 승리로군."] = "진영 대표 용사",  -- Faction Champions
        ["The Scourge cannot be stopped..."] = "발키르 쌍둥이",  -- Val'kyr Twins
    },
        
    ["Icecrown Citadel"] = {
        ["형제자매여, 전진"] = "얼음왕관 비행포격선 전투", -- Gunship Battle Muradin (A)
        ["리치 왕을 향해 전진하라"] = "얼음왕관 비행포격선 전투", -- Gunship Battle Saurfang (H)
        ["My queen, they... come."] = "피의 공작 의회", -- Prince Keleseth
        ["다시 힘을 얻었다! 이세라여, 더러운 생명들에 안식을 내릴 수 있도록 은혜를 베푸소서!"] = "발리스리아 드림워커", -- Dreamwalker
    },

    ["The Ruby Sanctum"] = {
        ["필멸자들아, 승리를 만끽해라. 그것이 마지막일 테니. 주인님이 돌아오시면 이 세상은 불타버리리라!"] = "할리온", -- Halion
    },
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
