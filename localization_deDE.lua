-- *******************************************************
-- **          Mizus RaidTracker - deDE Local           **
-- **          <http://nanaki.affenfelsen.de>           **
-- *******************************************************
--
-- This localization is written by:
--  Mizukichan, Enokra, gOOvER
--
-- Note: 
--  MRT requires a correct localization of RaidZones and Bossyells for working
--

----------------------
--  Are you local?  --
----------------------
if GetLocale() ~= "deDE" then return end


-----------------
--  Bossyells  --
-----------------
MRT_L.Bossyells = {
    -- Naxxramas
    [535] = {
        ["I grow tired of these games. Proceed, and I will banish your souls to oblivion!"] = "Die vier Reiter", -- FIXME!
    },

    -- Ulduar
    [529] = {
        ["Ihr lauft geradewegs in den Schlund des Wahnsinns!"] = "Versammlung des Eisens",  -- Normalmode - Stormcaller Brundir last
        ["Was gewinnt Ihr durch meinen Tod? Ihr seid dennoch verdammt, Sterbliche."] = "Versammlung des Eisens",  -- Semi-Hardmode - Runemaster Molgeim last FIXME!
        ["Unm\195\182glich..."] = "Versammlung des Eisens",  -- Hardmode - Steelbreaker last
        ["Ich... bin von ihm befreit... endlich."] = "Hodir",
        ["Senkt Eure Waffen! Ich ergebe mich!"] = "Thorim",
        ["Seine Macht \195\188ber mich beginnt zu schwinden. Endlich kann ich wieder klar sehen. Ich danke Euch, Helden."] = "Freya",
        ["Es scheint, als w\195\164re mir eine klitzekleine Fehlkalkulation unterlaufen. Ich habe zugelassen, dass das Scheusal im Gef\195\164ngnis meine Prim\195\164rdirektive \195\188berschreibt. Alle Systeme nun funktionst\195\188chtig."] = "Mimiron",
        ["Ich sah Welten umhüllt von den Flammen der Schöpfer, sah ohne einen Hauch von Trauer ihre Bewohner vergehen. Ganze Planetensysteme geboren und vernichtet, während Eure sterblichen Herzen nur einmal schlagen. Doch immer war mein Herz kalt... ohne Mitgefühl. Ich - habe - nichts - gefühlt. Millionen, Milliarden Leben verschwendet. Trugen sie alle dieselbe Beharrlichkeit in sich, wie Ihr? Liebten sie alle das Leben so sehr, wie Ihr es tut?"] = "Algalon",  -- FIXME!
    },

    -- Trial of the Crusader
    [543] = {
        ["Ein tragischer Sieg. Wir wurden schw\195\164cher durch die heutigen Verluste. Wer au\195\159er dem Lichk\195\182nig profitiert von solchen Torheiten? Gro\195\159e Krieger gaben ihr Leben. Und wof\195\188r? Die wahre Bedrohung erwartet uns noch - der Lichk\195\182nig erwartet uns alle im Tod."] = "Fraktionschampions",
    },
    
    -- Icecrown Citadel
    [604] = {
        ["Sagt nicht, ich h\195\164tte Euch nicht gewarnt, Ihr Schurken! Vorw\195\164rts, Br\195\188der und Schwestern!"] = "Eiskrone Luftschiffkampf", -- Muradin
        ["Die Allianz wankt. Vorw\195\164rts zum Lichk\195\182nig!"] = "Eiskrone Luftschiffkampf", -- Saurfang
        ["ICH BIN GEHEILT! Ysera, erlaubt mir, diese \195\188blen Kreaturen zu beseitigen!"] = "Valithria Traumwandler",
    },

    -- Ruby Sanctum
    [609] = {
        ["Genie\195\159t euren Sieg, Sterbliche, denn es war euer letzter. Bei der R\195\188ckkehr des Meisters wird diese Welt brennen!"] = "Halion", -- Halion
    },
    
    -- Throne of the Four Winds
    [773] = {
        ["Das Konklave des Windes hat sich aufgelöst. Euer ehrenvolles Betragen sowie eure Entschlossenheit haben euch das Recht verschafft, mir in der Schlacht gegenüberzutreten, Sterbliche. Ich erwarte Euren Angriff auf meiner Plattform! Kommt!"] = "Conclave of Wind", -- Conclave of Wind
    },
    
    -- Firelands
    [800] = {
        ["Zu fr\195\188h!... Ihr kommt zu fr\195\188h..."] = "Ragnaros",
    },
    
    -- Terrace of Endless Spring
    [886] = {
        ["Ich danke Euch, Fremdlinge. Ich wurde befreit."] = "Tsulong", 
        ["Ich... ah... oh! Hab ich...? War ich...? Es war... so... trüb."] = "Lei Shi",
    },
    
    -- Siege of Orgrimmar
    [953] = {
        ["Ah, Ihr habt es geschafft! Das Wasser ist wieder rein."] = "Immerseus",
        ["System resetting. Don't turn the power off, or the whole thing will probably explode."] = "Spoils of Pandaria",
    },
}
-- german miss
---------------------------------
--  Core frames local strings  --
---------------------------------
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Core", namespace="MRT_L/Core")@


-----------------------------------
--  Option panels local strings  --
-----------------------------------
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.Options", namespace="MRT_L/Options")@


-------------------
--  GUI strings  --
-------------------
--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="comment", table-name="MRT_L.GUI", namespace="MRT_L/GUI")@
