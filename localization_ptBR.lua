-- ********************************************************
-- **           Mizus RaidTracker - ptBR Local           **
-- **           <http://nanaki.affenfelsen.de>           **
-- ********************************************************
--
-- This localization is written by:
--  <NOBODY>
--
-- Note: 
--  MRT requires a correct localization of bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "ptBR" then return end


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    [535] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",
    },

    -- Ulduar
    [529] = {
        ["You rush headlong into the maw of madness!"] = "Iron Council",  -- Normalmode - Stormcaller Brundir last
        ["What have you gained from my defeat? You are no less doomed, mortals."] = "Iron Council",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "Iron Council",  -- Hardmode - Steelbreaker last
        ["I... I am released from his grasp... at last."] = "Hodir",
        ["Stay your arms! I yield!"] = "Thorim",
        ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Freya",
        ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Mimiron",
        ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "Algalon the Observer",
    },
    
    -- Trial of the Crusader
    [543] = {
        ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions",
    },
    
    -- Icecrown Citadel
    [604] = {
        ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Icecrown Gunship Battle", -- Muradin
        ["The Alliance falter. Onward to the Lich King!"] = "Icecrown Gunship Battle", -- Saurfang
        ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker", -- Dreamwalker
    },
    
    -- Ruby Sanctum
    [609] = {
        ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "Halion", -- Halion
    },
    
    -- Throne of the Four Winds
    [773] = {
        ["The Conclave of Wind has dissipated. Your honorable conduct and determination have earned you the right to face me in battle, mortals. I await your assault on my platform! Come!"] = "Conclave of Wind", -- Conclave of Wind
    },
    
    -- Firelands
    [800] = {
        ["Too soon! ... You have come too soon..."] = "Ragnaros",
    },
    
    -- Terrace of Endless Spring
    [886] = {
        --["Não. .. as águas ... Eu devo ... resistir ... Eu não deve ... medo ..."] = "Protetores do Infinito",
        ["Eu agradeço, forasteiros. Eu fui libertado."] = "Tsulong", 
        ["Eu... ah... oh! Eu o quê...? Eu fiz o quê...? Estava tudo tão... tão turvo..."] = "Lei Shi",
    },
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="ptBR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@

