-- *******************************************************
-- **          Mizus RaidTracker - esES Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Hestrall
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "esES" then return end


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    [535] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Cofre de los Cuatro Jinetes",
    },
    
    -- Ulduar
    [529] = {
        ["I... I am released from his grasp... at last."] = "Hodir",
        ["Stay your arms! I yield!"] = "Thorim",
        ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Freya",
        ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Mimiron",
        ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "Algalon el Observador",
    },
    
    -- Trial of the Crusader
    [543] = {
        ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Campeones de la facción",
    },
    
    -- Icecrown Citadel
    [604] = {
        ["¡No digáis que no lo avisé, sinvergüenzas! Adelante, hermanos."] = "Batalla aérea", -- Muradin
        ["The Alliance falter. Onward to the Lich King!"] = "Batalla aérea", -- Saurfang
        ["¡ESTOY RENOVADA! Ysera, haz que estas asquerosas criaturas descansen."] = "Valithria Caminasueños", -- Dreamwalker
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
        --["¡No debéis estar aquí! He de proteger el agua... ¡Si no puedo expulsaros, os mataré!"] = "Protectores de la Eternidad",
        --["¡No deben estar aquí! He de proteger el agua... ¡Si no puedo expulsarlos, los mataré!"] = "Protectores de la Eternidad",
        ["Gracias, forasteros. Me habéis liberado. / Gracias, forasteros. Me han liberado."] = "Tsulong", 
        ["Yo... ah... ¿eh? ¿Yo he...? ¿Era yo...? Todo... estaba... turbio."] = "Lei Shi",
    },
    
    -- Hear of Fear
    [897] = {
        --["Empress... I have... failed you..."] = "Wind Lord Mel'jarak",
        --["Forgive me, Empress...."] = "Amber-Shaper Un'sok",
        --["Augh... ah ... I...  have failed."] = "Grand Empress Shek'zeer",
    },
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
