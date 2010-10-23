-- *******************************************************
-- **          Mizus RaidTracker - zhTW Local           **
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
if GetLocale() ~= "zhTW" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
	["永恆之眼"] = "The Eye of Eternity",
	["黑曜聖所"] = "The Obsidian Sanctum",
	["亞夏梵穹殿"] = "Vault of Archavon",
	["納克薩瑪斯"] = "Naxxramas",
	["奧杜亞"] = "Ulduar",
	["十字軍試煉"] = "Trial of the Crusader",
	["奧妮克希亞的巢穴"] = "Onyxia's Lair",
	["冰冠城塞"] = "Icecrown Citadel",
    ["晶紅聖所"] = "The Ruby Sanctum",
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    ["Naxxramas"] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",  -- Four Horsemen
    },
    
    ["Ulduar"] = {
        ["You rush headlong into the maw of madness!"] = "鐵之集會",  -- Normalmode - Stormcaller Brundir last
        ["What have you gained from my defeat? You are no less doomed, mortals!"] = "鐵之集會",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "鐵之集會",  -- Hardmode - Steelbreaker last
        ["I... I am released from his grasp... at last."] = "霍迪爾",  -- Hodir
        ["Stay your arms! I yield!"] = "索林姆",  -- Thorim
        ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "芙蕾雅",  -- Freya
        ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "彌米倫",  -- Mimiron
        ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "『觀察者』艾爾加隆",  -- Algalon
    },
    
    ["Trial of the Crusader"] = {
        ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "陣營勇士",  -- Faction Champions
        ["The Scourge cannot be stopped..."] = "華爾琪雙子",  -- Val'kyr Twins
    },
        
    ["Icecrown Citadel"] = {
        ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "寒冰皇冠空中艦艇戰", -- Gunship Battle Muradin (A)
        ["The Alliance falter. Onward to the Lich King!"] = "寒冰皇冠空中艦艇戰", -- Gunship Battle Saurfang (H)
        ["My queen, they... come."] = "血親王議會", -- Prince Keleseth
        ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "瓦莉絲瑞雅·夢行者", -- Dreamwalker
    },

    ["The Ruby Sanctum"] = {
        ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "海萊恩", -- Halion
    },
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
