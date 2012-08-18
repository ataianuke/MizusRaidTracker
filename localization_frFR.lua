-- *******************************************************
-- **          Mizus RaidTracker - frFR Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Cinedelle, Deepking, Cyliah
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "frFR" then return end


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    ["Naxxramas"] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Quatre cavaliers",
    },
    
    ["Ulduar"] = {
        ["Vous courez tout droit dans la gueule de la folie !"] = "Assemblée du Fer",  -- Normalmode - Stormcaller Brundir last
        ["Que vous apporte ma chute? Votre destin n'en est pas moins scellé, mortels!"] = "Assemblée du Fer",  -- Semi-Hardmode - Runemaster Molgeim last
        ["Impossible..."] = "Assemblée du Fer",  -- Hardmode - Steelbreaker last
        ["Je suis... libéré de son emprise... enfin."] = "Hodir",
        ["Retenez vos coups ! Je me rends !"] = "Thorim",
        ["Son emprise sur moi se dissipe. J'y vois à nouveau clair. Merci, héros."] = "Freya",
        ["Il semblerait que j'aie pu faire une minime erreur de calcul. J'ai permis \195\160 mon esprit de se laisser corrompre par ce d\195\169mon dans la prison qui a désactiv\195\169 ma directive principale. Tous les syst\195\168mes fonctionnent \195\160 nouveau. Termin\195\169."] = "Mimiron",
        ["J'ai vu des mondes baigner dans les flammes"] = "Algalon l'Observateur",
    },
      
    ["Trial of the Crusader"] = {
        ["Une victoire tragique et depourvue de sens. La perte subie aujourd'hui nous affaiblira tous, car qui d'autre que le roi-liche pourrait beneficier d'une telle folie?? De grands guerriers ont perdu la vie. Et pour quoi?? La vraie menace plane à l'horizon?: le roi-liche nous attend, tous, dans la mort."] = "Champions de faction",
    },
        
    ["Icecrown Citadel"] = {
        ["Vous direz pas que j'vous avais pas prévenus, canailles ! Mes frères et sœurs, en avant !"] = "Bataille des canonnières", -- Muradin
        ["L'Alliance baisse pavillon. Sus au roi-liche !"] = "Bataille des canonnières", -- Saurfang
        ["JE REVIS !"] = "Valithria Marcherêve", -- Dreamwalker
    },

    ["The Ruby Sanctum"] = {
        ["Savourez bien cette victoire mortels car ce serra votre dernière. Ce monde brulera au retour du maitre !"] = "Halion", -- Halion
    },
    
    ["Throne of the Four Winds"] = {
        ["Le conclave du Vent est dissip\195\169. Votre conduite honorable et votre d\195\169termination vous valent le droit de m'affronter, mortels. J'attends votre attaque sur ma plate-forme ! Venez !"] = "Conclave of Wind", -- Conclave of Wind
    },
    
    ["Firelands"] = {
        ["Trop tôt! ... Vous êtes venu trop ..."] = "Ragnaros",
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
