-- *******************************************************
-- **          Mizus RaidTracker - zhCN Local           **
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
if GetLocale() ~= "zhCN" then return end


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    ["Naxxramas"] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",  -- Four Horsemen
    },
    
    ["Ulduar"] = {
        ["You rush headlong into the maw of madness!"] = "钢铁议会",  -- Normalmode - Stormcaller Brundir last
        ["What have you gained from my defeat? You are no less doomed, mortals!"] = "钢铁议会",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "钢铁议会",  -- Hardmode - Steelbreaker last
        ["I... I am released from his grasp... at last."] = "霍迪尔",  -- Hodir
        ["Stay your arms! I yield!"] = "托里姆",  -- Thorim
        ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "弗蕾亚",  -- Freya
        ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "米米尔隆",  -- Mimiron
        ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "观察者奥尔加隆",  -- Algalon
    },
    
    ["Trial of the Crusader"] = {
        ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "阵营冠军",  -- Faction Champions
    },
        
    ["Icecrown Citadel"] = {
        ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "冰冠炮舰战斗", -- Gunship Battle Muradin (A)
        ["The Alliance falter. Onward to the Lich King!"] = "冰冠炮舰战斗", -- Gunship Battle Saurfang (H)
        ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "踏梦者瓦莉瑟瑞娅", -- Dreamwalker
    },

    ["The Ruby Sanctum"] = {
        ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "海里昂", -- Halion
    },
    
    ["Throne of the Four Winds"] = {
        ["The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!"] = "Conclave of Wind", -- Conclave of Wind
    },
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
