-- *******************************************************
-- **          Mizus RaidTracker - frFR Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Cinedelle, Cyliah
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "frFR" then return end


-----------------
--  RaidZones  --
-----------------
-- @Locals: Only change the zone names of the keys - NOT the values!
-- 'keys' = text in squared brackets
MRT_L.Raidzones = {
    -- Wrath of the Lich King
	["L'Œil de l'éternité"] = "The Eye of Eternity",
	["Le sanctum Obsidien"] = "The Obsidian Sanctum",
	["Caveau d'Archavon"] = "Vault of Archavon",
	["Naxxramas"] = "Naxxramas",
	["Ulduar"] = "Ulduar",
	["L'épreuve du croisé"] = "Trial of the Crusader",
	["Repaire d'Onyxia"] = "Onyxia's Lair",
	["Citadelle de la Couronne de glace"] = "Icecrown Citadel",
    ["Le sanctum Rubis"] = "The Ruby Sanctum",
}


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    ["Naxxramas"] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Quatre cavaliers",
    },
    
    ["Ulduar"] = {
        ["You rush headlong into the maw of madness!"] = "Assemblée du Fer",  -- Normalmode - Stormcaller Brundir last
        ["What have you gained from my defeat? You are no less doomed, mortals!"] = "Assemblée du Fer",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "Assemblée du Fer",  -- Hardmode - Steelbreaker last
        ["Je suis... libéré de son emprise... enfin."] = "Hodir",
        ["Retenez vos coups ! Je me rends !"] = "Thorim",
        ["Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros."] = "Freya",
        ["Il semblerait que j'aie pu faire une minime erreur de calcul. J'ai permis \195\160 mon esprit de se laisser corrompre par ce d\195\169mon dans la prison qui a désactiv\195\169 ma directive principale. Tous les syst\195\168mes fonctionnent \195\160 nouveau. Termin\195\169."] = "Mimiron",
        ["J'ai vu des mondes baigner dans les flammes"] = "Algalon l'Observateur",
    },
      
    ["Trial of the Crusader"] = {
        ["Une victoire tragique et depourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait beneficier d'une telle folie?? De grands guerriers ont perdu la vie. Et pour quoi?? La vraie menace plane à l'horizon?: le roi-liche nous attend, tous, dans la mort."] = "Champions de faction",
        ["Personne ne peux arrêter le fléau"] = "Soeurs Val'kyr",
    },
        
    ["Icecrown Citadel"] = {
        ["Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !"] = "Bataille des canonnières", -- Muradin
        ["L'Alliance baisse pavillon. Sus au roi-liche !"] = "Bataille des canonnières", -- Saurfang
        ["Ma reine, ils"] = "Conseil des princes de sang", -- Prince Keleseth
        ["JE REVIS !"] = "Valithria Marcherêve", -- Dreamwalker
    },

    ["The Ruby Sanctum"] = {
        ["Savourez bien cette victoire mortels car ce serra votre dernière. Ce monde brulera au retour du maitre !"] = "Halion", -- Halion
    },
}


---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
