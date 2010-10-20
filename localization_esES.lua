-- *******************************************************
-- **          Mizus RaidTracker - esES Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- The localizations is written by:
--  Hestrall, Mizukichan
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "esES" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
    ["El Ojo de la Eternidad"] = "The Eye of Eternity",
    ["El Sagrario Obsidiana"] = "The Obsidian Sanctum",
    ["La Cámara de Archavon"] = "Vault of Archavon",
    ["Naxxramas"] = "Naxxramas",
    ["Ulduar"] = "Ulduar",
    ["Prueba del Cruzado"] = "Trial of the Crusader",
    ["Trial of the Grand Crusader"] = "Trial of the Grand Crusader",
    ["Guarida de Onyxia"] = "Onyxia's Lair",
    ["Ciudadela de la Corona de Hielo"] = "Icecrown Citadel",
    ["El Sagrario Rubí"] = "The Ruby Sanctum", 
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Four Horsemen",

    -- Ulduar
    ["You rush headlong into the maw of madness!"] = "Iron Council",  -- Normalmode - Stormcaller Brundir last
    ["What have you gained from my defeat? You are no less doomed, mortals!"] = "Iron Council",  -- Semi-Hardmode - Runemaster Molgeim last
    ["Impossible..."] = function() return MRT_IsInstanceUlduar("Iron Council") end,  -- Hardmode - Steelbreaker last  // also yelled by Lich King -> instance check necessary
    ["I... I am released from his grasp... at last."] = "Hodir",
    ["Stay your arms! I yield!"] = "Thorim",
    ["His hold on me dissipates. I can see clearly once more. Thank you, heroes."] = "Freya",
    ["It would appear that I've made a slight miscalculation. I allowed my mind to be corrupted by the fiend in the prison, overriding my primary directive. All systems seem to be functional now. Clear."] = "Mimiron",
    ["I have seen worlds bathed in the Makers' flames, their denizens fading without as much as a whimper. Entire planetary systems born and razed in the time that it takes your mortal hearts to beat once. Yet all throughout, my own heart devoid of emotion... of empathy. I. Have. Felt. Nothing. A million-million lives wasted. Had they all held within them your tenacity? Had they all loved life as you do?"] = "Algalon the Observer",

    -- Trial of the Crusader
    ["A shallow and tragic victory. We are weaker as a whole from the losses suffered today. Who but the Lich King could benefit from such foolishness? Great warriors have lost their lives. And for what? The true threat looms ahead - the Lich King awaits us all in death."] = "Faction Champions",
    ["The Scourge cannot be stopped..."] = "Val'kyr Twins",
        
    -- Icecrown Citadel
    ["Don't say I didn't warn ya, scoundrels! Onward, brothers and sisters!"] = "Gunship Battle", -- Muradin
    ["The Alliance falter. Onward to the Lich King!"] = "Gunship Battle", -- Saurfang
    ["My queen, they... come."] = "Blood Prince Council", -- Prince Keleseth
    ["I AM RENEWED! Ysera grant me the favor to lay these foul creatures to rest!"] = "Valithria Dreamwalker", -- Dreamwalker

    -- Ruby Sanctum
    ["Relish this victory, mortals, for it will be your last. This world will burn with the master's return!"] = "Halion", -- Halion
}


---------------------------------
--  Core frames local strings  --
---------------------------------
MRT_L.Core = @localization(locale="esES", format="lua_table", handle-unlocalized="comment", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
MRT_L.Options = @localization(locale="esES", format="lua_table", handle-unlocalized="comment", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
MRT_L.GUI = @localization(locale="esES", format="lua_table", handle-unlocalized="comment", namespace="MRT_L/GUI")@

