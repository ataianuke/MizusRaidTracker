-- *******************************************************
-- **          Mizus RaidTracker - zhCN Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  luomoon
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
        ["你们盲目地冲进了疯狂的深渊！"] = "钢铁议会",  -- Normalmode - Stormcaller Brundir last
        ["你们能从我的失败中得到什么？你们终究会被平等地毁灭，凡人！"] = "钢铁议会",  -- Semi-Hardmode - Runemaster Molgeim last
        ["这不可能……"] = "钢铁议会",  -- Hardmode - Steelbreaker last
        ["我……我终于从他的魔掌中……解脱了。"] = "霍迪尔",  -- Hodir
        ["住手！我认输了！"] = "托里姆",  -- Thorim
        ["他对我的控制已经不复存在了。我又一次恢复了理智。谢谢你们，英雄们。"] = "弗蕾亚",  -- Freya
        ["看起来我的计算有一点小小的偏差。"] = "米米尔隆",  -- Mimiron
        ["我曾经看过尘世沉浸在造物者的烈焰之中，众生连一声悲泣都无法呼出，就此凋零。整个星系在弹指之间历经了毁灭与重生。然而在这段历程之中，我的心却无法感受到丝毫的…恻隐之念。我‧感‧受‧不‧到。成千上万的生命就这么消逝。他们是否拥有与你同样坚韧的生命?他们是否与你同样热爱生命?"] = "观察者奥尔加隆",  -- Algalon
    },
    
    ["Trial of the Crusader"] = {
        ["肤浅且可悲的胜利。今天的内耗让我们又一次被削弱了。这种愚蠢的行为只能让巫妖王受益！伟大的战士们就这样白白牺牲，而真正的威胁却步步逼近。巫妖王正计算着我们的死期。"] = "阵营冠军",  -- Faction Champions
    },
        
    ["Icecrown Citadel"] = {
        ["我早就警告过你，恶棍！兄弟姐妹们，前进！"] = "冰冠炮舰战斗", -- Gunship Battle Muradin (A)
        ["联盟不行了。向巫妖王进攻！"] = "冰冠炮舰战斗", -- Gunship Battle Saurfang (H)
        ["我获得了新生！伊瑟拉的恩泽赐予我消灭邪恶的力量！"] = "踏梦者瓦莉瑟瑞娅", -- Dreamwalker
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
