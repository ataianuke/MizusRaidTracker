-- ****************************************************
--              LibEPGP-GPCalculator-1.0
-- ****************************************************
-- A library for calculating GP values of items.
-- 
-- This library is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010-2013)
--
-- Licensed under the MIT-License (see LICENSE.txt)
--

assert(LibStub, "LibEPGP_GPCalculator-1.0 requires LibStub")
assert(LibStub:GetLibrary("LibBabble-Inventory-3.0", true), "LibEPGP-GPCalculator-1.0 requires LibBabble-Inventory-3.0")

local libGP = LibStub:NewLibrary("LibEPGP-GPCalculator-1.0", 1)

if not libGP then 
    return -- No upgrade needed
end

do
    -- set up a copy of LBI for handling the different item types
    local LBI = LibStub("LibBabble-Inventory-3.0")
    local LBIR = LBI:GetReverseLookupTable()
    
    local _, _, _, uiVersion = GetBuildInfo()
    local epgpCoefficient = 0
    local standard_ilvl = 0

    -- The coefficient seems to have changed in Cataclysm to 0.06974 - this isn't in the official web documentation but in the EPGP-Addon-Code
    -- Update: coefficient formula: 1000 * 2 ^ (-standard_ilvl / 26)
    -- standard_ilvl = normal raiding gear ilvl
    if (uiVersion < 40200) then
        standard_ilvl = 359
    elseif (uiVersion < 40300) then
        standard_ilvl = 378
    elseif MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] < 90 then
        standard_ilvl = 397
    elseif (uiVersion < 50200) then
        standard_ilvl = 496
    elseif (uiVersion < 50400) then
        standard_ilvl = 522
    elseif MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()] < 100 then
        standard_ilvl = 553
    else
        standard_ilvl = 670
    end
    
    epgpCoefficient = 1000 * 2 ^ (-standard_ilvl / 26)

    -- List of various ItemIDs of token and their corresponding item level:
    local CUSTOM_ITEM_DATA = {
        -- Tier 4
        [29753] = { 4, 120, "INVTYPE_CHEST" },
        [29754] = { 4, 120, "INVTYPE_CHEST" },
        [29755] = { 4, 120, "INVTYPE_CHEST" },
        [29756] = { 4, 120, "INVTYPE_HAND" },
        [29757] = { 4, 120, "INVTYPE_HAND" },
        [29758] = { 4, 120, "INVTYPE_HAND" },
        [29759] = { 4, 120, "INVTYPE_HEAD" },
        [29760] = { 4, 120, "INVTYPE_HEAD" },
        [29761] = { 4, 120, "INVTYPE_HEAD" },
        [29762] = { 4, 120, "INVTYPE_SHOULDER" },
        [29763] = { 4, 120, "INVTYPE_SHOULDER" },
        [29764] = { 4, 120, "INVTYPE_SHOULDER" },
        [29765] = { 4, 120, "INVTYPE_LEGS" },
        [29766] = { 4, 120, "INVTYPE_LEGS" },
        [29767] = { 4, 120, "INVTYPE_LEGS" },

        -- Tier 5
        [30236] = { 4, 133, "INVTYPE_CHEST" },
        [30237] = { 4, 133, "INVTYPE_CHEST" },
        [30238] = { 4, 133, "INVTYPE_CHEST" },
        [30239] = { 4, 133, "INVTYPE_HAND" },
        [30240] = { 4, 133, "INVTYPE_HAND" },
        [30241] = { 4, 133, "INVTYPE_HAND" },
        [30242] = { 4, 133, "INVTYPE_HEAD" },
        [30243] = { 4, 133, "INVTYPE_HEAD" },
        [30244] = { 4, 133, "INVTYPE_HEAD" },
        [30245] = { 4, 133, "INVTYPE_LEGS" },
        [30246] = { 4, 133, "INVTYPE_LEGS" },
        [30247] = { 4, 133, "INVTYPE_LEGS" },
        [30248] = { 4, 133, "INVTYPE_SHOULDER" },
        [30249] = { 4, 133, "INVTYPE_SHOULDER" },
        [30250] = { 4, 133, "INVTYPE_SHOULDER" },

        -- Tier 5 - BoE recipes - BoP crafts
        [30282] = { 4, 128, "INVTYPE_BOOTS" },
        [30283] = { 4, 128, "INVTYPE_BOOTS" },
        [30305] = { 4, 128, "INVTYPE_BOOTS" },
        [30306] = { 4, 128, "INVTYPE_BOOTS" },
        [30307] = { 4, 128, "INVTYPE_BOOTS" },
        [30308] = { 4, 128, "INVTYPE_BOOTS" },
        [30323] = { 4, 128, "INVTYPE_BOOTS" },
        [30324] = { 4, 128, "INVTYPE_BOOTS" },

        -- Tier 6
        [31089] = { 4, 146, "INVTYPE_CHEST" },
        [31090] = { 4, 146, "INVTYPE_CHEST" },
        [31091] = { 4, 146, "INVTYPE_CHEST" },
        [31092] = { 4, 146, "INVTYPE_HAND" },
        [31093] = { 4, 146, "INVTYPE_HAND" },
        [31094] = { 4, 146, "INVTYPE_HAND" },
        [31095] = { 4, 146, "INVTYPE_HEAD" },
        [31096] = { 4, 146, "INVTYPE_HEAD" },
        [31097] = { 4, 146, "INVTYPE_HEAD" },
        [31098] = { 4, 146, "INVTYPE_LEGS" },
        [31099] = { 4, 146, "INVTYPE_LEGS" },
        [31100] = { 4, 146, "INVTYPE_LEGS" },
        [31101] = { 4, 146, "INVTYPE_SHOULDER" },
        [31102] = { 4, 146, "INVTYPE_SHOULDER" },
        [31103] = { 4, 146, "INVTYPE_SHOULDER" },
        [34848] = { 4, 154, "INVTYPE_WRIST" },
        [34851] = { 4, 154, "INVTYPE_WRIST" },
        [34852] = { 4, 154, "INVTYPE_WRIST" },
        [34853] = { 4, 154, "INVTYPE_WAIST" },
        [34854] = { 4, 154, "INVTYPE_WAIST" },
        [34855] = { 4, 154, "INVTYPE_WAIST" },
        [34856] = { 4, 154, "INVTYPE_FEET" },
        [34857] = { 4, 154, "INVTYPE_FEET" },
        [34858] = { 4, 154, "INVTYPE_FEET" },

        -- Tier 6 - BoE recipes - BoP crafts
        [32737] = { 4, 141, "INVTYPE_SHOULDER" },
        [32739] = { 4, 141, "INVTYPE_SHOULDER" },
        [32745] = { 4, 141, "INVTYPE_SHOULDER" },
        [32747] = { 4, 141, "INVTYPE_SHOULDER" },
        [32749] = { 4, 141, "INVTYPE_SHOULDER" },
        [32751] = { 4, 141, "INVTYPE_SHOULDER" },
        [32753] = { 4, 141, "INVTYPE_SHOULDER" },
        [32755] = { 4, 141, "INVTYPE_SHOULDER" },

        -- Magtheridon's Head
        [32385] = { 4, 125, "INVTYPE_FINGER" },
        [32386] = { 4, 125, "INVTYPE_FINGER" },

        -- Kael'thas' Sphere
        [32405] = { 4, 138, "INVTYPE_NECK" },

        -- T7
        [40610] = { 4, 200, "INVTYPE_CHEST" },
        [40611] = { 4, 200, "INVTYPE_CHEST" },
        [40612] = { 4, 200, "INVTYPE_CHEST" },
        [40613] = { 4, 200, "INVTYPE_HAND" },
        [40614] = { 4, 200, "INVTYPE_HAND" },
        [40615] = { 4, 200, "INVTYPE_HAND" },
        [40616] = { 4, 200, "INVTYPE_HEAD" },
        [40617] = { 4, 200, "INVTYPE_HEAD" },
        [40618] = { 4, 200, "INVTYPE_HEAD" },
        [40619] = { 4, 200, "INVTYPE_LEGS" },
        [40620] = { 4, 200, "INVTYPE_LEGS" },
        [40621] = { 4, 200, "INVTYPE_LEGS" },
        [40622] = { 4, 200, "INVTYPE_SHOULDER" },
        [40623] = { 4, 200, "INVTYPE_SHOULDER" },
        [40624] = { 4, 200, "INVTYPE_SHOULDER" },

        -- T7 (heroic)
        [40625] = { 4, 213, "INVTYPE_CHEST" },
        [40626] = { 4, 213, "INVTYPE_CHEST" },
        [40627] = { 4, 213, "INVTYPE_CHEST" },
        [40628] = { 4, 213, "INVTYPE_HAND" },
        [40629] = { 4, 213, "INVTYPE_HAND" },
        [40630] = { 4, 213, "INVTYPE_HAND" },
        [40631] = { 4, 213, "INVTYPE_HEAD" },
        [40632] = { 4, 213, "INVTYPE_HEAD" },
        [40633] = { 4, 213, "INVTYPE_HEAD" },
        [40634] = { 4, 213, "INVTYPE_LEGS" },
        [40635] = { 4, 213, "INVTYPE_LEGS" },
        [40636] = { 4, 213, "INVTYPE_LEGS" },
        [40637] = { 4, 213, "INVTYPE_SHOULDER" },
        [40638] = { 4, 213, "INVTYPE_SHOULDER" },
        [40639] = { 4, 213, "INVTYPE_SHOULDER" },

        -- Key to the Focusing Iris
        [44569] = { 4, 213, "INVTYPE_NECK" },
        [44577] = { 4, 226, "INVTYPE_NECK" },

        -- T8
        [45635] = { 4, 219, "INVTYPE_CHEST" },
        [45636] = { 4, 219, "INVTYPE_CHEST" },
        [45637] = { 4, 219, "INVTYPE_CHEST" },
        [45647] = { 4, 219, "INVTYPE_HEAD" },
        [45648] = { 4, 219, "INVTYPE_HEAD" },
        [45649] = { 4, 219, "INVTYPE_HEAD" },
        [45644] = { 4, 219, "INVTYPE_HAND" },
        [45645] = { 4, 219, "INVTYPE_HAND" },
        [45646] = { 4, 219, "INVTYPE_HAND" },
        [45650] = { 4, 219, "INVTYPE_LEGS" },
        [45651] = { 4, 219, "INVTYPE_LEGS" },
        [45652] = { 4, 219, "INVTYPE_LEGS" },
        [45659] = { 4, 219, "INVTYPE_SHOULDER" },
        [45660] = { 4, 219, "INVTYPE_SHOULDER" },
        [45661] = { 4, 219, "INVTYPE_SHOULDER" },

        -- T8 (heroic)
        [45632] = { 4, 226, "INVTYPE_CHEST" },
        [45633] = { 4, 226, "INVTYPE_CHEST" },
        [45634] = { 4, 226, "INVTYPE_CHEST" },
        [45638] = { 4, 226, "INVTYPE_HEAD" },
        [45639] = { 4, 226, "INVTYPE_HEAD" },
        [45640] = { 4, 226, "INVTYPE_HEAD" },
        [45641] = { 4, 226, "INVTYPE_HAND" },
        [45642] = { 4, 226, "INVTYPE_HAND" },
        [45643] = { 4, 226, "INVTYPE_HAND" },
        [45653] = { 4, 226, "INVTYPE_LEGS" },
        [45654] = { 4, 226, "INVTYPE_LEGS" },
        [45655] = { 4, 226, "INVTYPE_LEGS" },
        [45656] = { 4, 226, "INVTYPE_SHOULDER" },
        [45657] = { 4, 226, "INVTYPE_SHOULDER" },
        [45658] = { 4, 226, "INVTYPE_SHOULDER" },

        -- Reply Code Alpha
        [46052] = { 4, 226, "INVTYPE_RING" },
        [46053] = { 4, 239, "INVTYPE_RING" },

        -- T9.245 (10M heroic/25M)
        [47242] = { 4, 245, "INVTYPE_CUSTOM_MULTISLOT_TIER" },

        -- T9.258 (25M heroic)
        [47557] = { 4, 258, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [47558] = { 4, 258, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [47559] = { 4, 258, "INVTYPE_CUSTOM_MULTISLOT_TIER" },

        -- T10.264 (10M heroic/25M)
        [52025] = { 4, 264, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [52026] = { 4, 264, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [52027] = { 4, 264, "INVTYPE_CUSTOM_MULTISLOT_TIER" },

        -- T10.279 (25M heroic)
        [52028] = { 4, 279, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [52029] = { 4, 279, "INVTYPE_CUSTOM_MULTISLOT_TIER" },
        [52030] = { 4, 279, "INVTYPE_CUSTOM_MULTISLOT_TIER" },

        -- T11
        [63683] = { 4, 359, "INVTYPE_HEAD" },
        [63684] = { 4, 359, "INVTYPE_HEAD" },
        [63682] = { 4, 359, "INVTYPE_HEAD" },
        [64315] = { 4, 359, "INVTYPE_SHOULDER" },
        [64316] = { 4, 359, "INVTYPE_SHOULDER" },
        [64314] = { 4, 359, "INVTYPE_SHOULDER" },

        -- T11 Heroic
        [65001] = { 4, 372, "INVTYPE_HEAD" },
        [65000] = { 4, 372, "INVTYPE_HEAD" },
        [65002] = { 4, 372, "INVTYPE_HEAD" },
        [65088] = { 4, 372, "INVTYPE_SHOULDER" },
        [65087] = { 4, 372, "INVTYPE_SHOULDER" },
        [65089] = { 4, 372, "INVTYPE_SHOULDER" },
        [67424] = { 4, 372, "INVTYPE_CHEST" },
        [67425] = { 4, 372, "INVTYPE_CHEST" },
        [67423] = { 4, 372, "INVTYPE_CHEST" },
        [67426] = { 4, 372, "INVTYPE_LEGS" },
        [67427] = { 4, 372, "INVTYPE_LEGS" },
        [67428] = { 4, 372, "INVTYPE_LEGS" },
        [67431] = { 4, 372, "INVTYPE_HAND" },
        [67430] = { 4, 372, "INVTYPE_HAND" },
        [67429] = { 4, 372, "INVTYPE_HAND" },

        -- T12
        [71674] = { 4, 378, "INVTYPE_SHOULDER" },
        [71688] = { 4, 378, "INVTYPE_SHOULDER" },
        [71681] = { 4, 378, "INVTYPE_SHOULDER" },
        [71668] = { 4, 378, "INVTYPE_HEAD" },
        [71682] = { 4, 378, "INVTYPE_HEAD" },
        [71675] = { 4, 378, "INVTYPE_HEAD" },

        -- T12 Heroic
        [71679] = { 4, 391, "INVTYPE_CHEST" },
        [71686] = { 4, 391, "INVTYPE_CHEST" },
        [71672] = { 4, 391, "INVTYPE_CHEST" },
        [71677] = { 4, 391, "INVTYPE_HEAD" },
        [71684] = { 4, 391, "INVTYPE_HEAD" },
        [71670] = { 4, 391, "INVTYPE_HEAD" },
        [71676] = { 4, 391, "INVTYPE_HAND" },
        [71683] = { 4, 391, "INVTYPE_HAND" },
        [71669] = { 4, 391, "INVTYPE_HAND" },
        [71678] = { 4, 391, "INVTYPE_LEGS" },
        [71685] = { 4, 391, "INVTYPE_LEGS" },
        [71671] = { 4, 391, "INVTYPE_LEGS" },
        [71680] = { 4, 391, "INVTYPE_SHOULDER" },
        [71687] = { 4, 391, "INVTYPE_SHOULDER" },
        [71673] = { 4, 391, "INVTYPE_SHOULDER" },

        -- T12 misc
        [71617] = { 4, 391, "INVTYPE_TRINKET" }, -- crystallized firestone

        -- T13 normal
        [78184] = { 4, 397, "INVTYPE_CHEST" },
        [78179] = { 4, 397, "INVTYPE_CHEST" },
        [78174] = { 4, 397, "INVTYPE_CHEST" },
        [78182] = { 4, 397, "INVTYPE_HEAD" },
        [78177] = { 4, 397, "INVTYPE_HEAD" },
        [78172] = { 4, 397, "INVTYPE_HEAD" },
        [78183] = { 4, 397, "INVTYPE_HAND" },
        [78178] = { 4, 397, "INVTYPE_HAND" },
        [78173] = { 4, 397, "INVTYPE_HAND" },
        [78181] = { 4, 397, "INVTYPE_LEGS" },
        [78176] = { 4, 397, "INVTYPE_LEGS" },
        [78171] = { 4, 397, "INVTYPE_LEGS" },
        [78180] = { 4, 397, "INVTYPE_SHOULDER" },
        [78175] = { 4, 397, "INVTYPE_SHOULDER" },
        [78170] = { 4, 397, "INVTYPE_SHOULDER" },

        -- T13 heroic
        [78847] = { 4, 410, "INVTYPE_CHEST" },
        [78848] = { 4, 410, "INVTYPE_CHEST" },
        [78849] = { 4, 410, "INVTYPE_CHEST" },
        [78850] = { 4, 410, "INVTYPE_HEAD" },
        [78851] = { 4, 410, "INVTYPE_HEAD" },
        [78852] = { 4, 410, "INVTYPE_HEAD" },
        [78853] = { 4, 410, "INVTYPE_HAND" },
        [78854] = { 4, 410, "INVTYPE_HAND" },
        [78855] = { 4, 410, "INVTYPE_HAND" },
        [78856] = { 4, 410, "INVTYPE_LEGS" },
        [78857] = { 4, 410, "INVTYPE_LEGS" },
        [78858] = { 4, 410, "INVTYPE_LEGS" },
        [78859] = { 4, 410, "INVTYPE_SHOULDER" },
        [78860] = { 4, 410, "INVTYPE_SHOULDER" },
        [78861] = { 4, 410, "INVTYPE_SHOULDER" },

        -- T14 normal
        [89248] = { 4, 496, "INVTYPE_SHOULDER" },
        [89247] = { 4, 496, "INVTYPE_SHOULDER" },
        [89246] = { 4, 496, "INVTYPE_SHOULDER" },

        [89245] = { 4, 496, "INVTYPE_LEGS" },
        [89244] = { 4, 496, "INVTYPE_LEGS" },
        [89243] = { 4, 496, "INVTYPE_LEGS" },

        [89234] = { 4, 496, "INVTYPE_HEAD" },
        [89236] = { 4, 496, "INVTYPE_HEAD" },
        [89235] = { 4, 496, "INVTYPE_HEAD" },

        [89242] = { 4, 496, "INVTYPE_HAND" },
        [89241] = { 4, 496, "INVTYPE_HAND" },
        [89240] = { 4, 496, "INVTYPE_HAND" },

        [89239] = { 4, 496, "INVTYPE_CHEST" },
        [89238] = { 4, 496, "INVTYPE_CHEST" },
        [89237] = { 4, 496, "INVTYPE_CHEST" },

        -- T14 heroic
        [89261] = { 4, 509, "INVTYPE_SHOULDER" },
        [89263] = { 4, 509, "INVTYPE_SHOULDER" },
        [89262] = { 4, 509, "INVTYPE_SHOULDER" },

        [89252] = { 4, 509, "INVTYPE_LEGS" },
        [89254] = { 4, 509, "INVTYPE_LEGS" },
        [89253] = { 4, 509, "INVTYPE_LEGS" },

        [89258] = { 4, 509, "INVTYPE_HEAD" },
        [89260] = { 4, 509, "INVTYPE_HEAD" },
        [89259] = { 4, 509, "INVTYPE_HEAD" },

        [89255] = { 4, 509, "INVTYPE_HAND" },
        [89257] = { 4, 509, "INVTYPE_HAND" },
        [89256] = { 4, 509, "INVTYPE_HAND" },

        [89249] = { 4, 509, "INVTYPE_CHEST" },
        [89251] = { 4, 509, "INVTYPE_CHEST" },
        [89250] = { 4, 509, "INVTYPE_CHEST" },

        -- T15 normal
        [95573] = { 4, 522, "INVTYPE_SHOULDER" },
        [95583] = { 4, 522, "INVTYPE_SHOULDER" },
        [95578] = { 4, 522, "INVTYPE_SHOULDER" },

        [95572] = { 4, 522, "INVTYPE_LEGS" },
        [95581] = { 4, 522, "INVTYPE_LEGS" },
        [95576] = { 4, 522, "INVTYPE_LEGS" },

        [95571] = { 4, 522, "INVTYPE_HEAD" },
        [95582] = { 4, 522, "INVTYPE_HEAD" },
        [95577] = { 4, 522, "INVTYPE_HEAD" },

        [95570] = { 4, 522, "INVTYPE_HAND" },
        [95580] = { 4, 522, "INVTYPE_HAND" },
        [95575] = { 4, 522, "INVTYPE_HAND" },

        [95569] = { 4, 522, "INVTYPE_CHEST" },
        [95579] = { 4, 522, "INVTYPE_CHEST" },
        [95574] = { 4, 522, "INVTYPE_CHEST" },

        -- T15 heroic
        [96699] = { 4, 535, "INVTYPE_SHOULDER" },
        [96700] = { 4, 535, "INVTYPE_SHOULDER" },
        [96701] = { 4, 535, "INVTYPE_SHOULDER" },

        [96631] = { 4, 535, "INVTYPE_LEGS" },
        [96632] = { 4, 535, "INVTYPE_LEGS" },
        [96633] = { 4, 535, "INVTYPE_LEGS" },

        [96625] = { 4, 535, "INVTYPE_HEAD" },
        [96623] = { 4, 535, "INVTYPE_HEAD" },
        [96624] = { 4, 535, "INVTYPE_HEAD" },

        [96599] = { 4, 535, "INVTYPE_HAND" },
        [96600] = { 4, 535, "INVTYPE_HAND" },
        [96601] = { 4, 535, "INVTYPE_HAND" },

        [96567] = { 4, 535, "INVTYPE_CHEST" },
        [96568] = { 4, 535, "INVTYPE_CHEST" },
        [96566] = { 4, 535, "INVTYPE_CHEST" },

        -- T16 Normal
        [99685] = { 4, 553, "INVTYPE_SHOULDER" },
        [99695] = { 4, 553, "INVTYPE_SHOULDER" },
        [99690] = { 4, 553, "INVTYPE_SHOULDER" },

        [99684] = { 4, 553, "INVTYPE_LEGS" },
        [99693] = { 4, 553, "INVTYPE_LEGS" },
        [99688] = { 4, 553, "INVTYPE_LEGS" },

        [99683] = { 4, 553, "INVTYPE_HEAD" },
        [99694] = { 4, 553, "INVTYPE_HEAD" },
        [99689] = { 4, 553, "INVTYPE_HEAD" },

        [99682] = { 4, 553, "INVTYPE_HAND" },
        [99692] = { 4, 553, "INVTYPE_HAND" },
        [99687] = { 4, 553, "INVTYPE_HAND" },

        [99696] = { 4, 553, "INVTYPE_CHEST" },
        [99691] = { 4, 553, "INVTYPE_CHEST" },
        [99686] = { 4, 553, "INVTYPE_CHEST" },

        -- T16 Normal Essences
        [105857] = { 4, 553, "INVTYPE_HEAD" },
        [105859] = { 4, 553, "INVTYPE_HEAD" },
        [105858] = { 4, 553, "INVTYPE_HEAD" },

        -- T16 Heroic
        [99717] = { 4, 566, "INVTYPE_SHOULDER" },
        [99719] = { 4, 566, "INVTYPE_SHOULDER" },
        [99718] = { 4, 566, "INVTYPE_SHOULDER" },

        [99726] = { 4, 566, "INVTYPE_LEGS" },
        [99713] = { 4, 566, "INVTYPE_LEGS" },
        [99712] = { 4, 566, "INVTYPE_LEGS" },

        [99723] = { 4, 566, "INVTYPE_HEAD" },
        [99725] = { 4, 566, "INVTYPE_HEAD" },
        [99724] = { 4, 566, "INVTYPE_HEAD" },

        [99720] = { 4, 566, "INVTYPE_HAND" },
        [99722] = { 4, 566, "INVTYPE_HAND" },
        [99721] = { 4, 566, "INVTYPE_HAND" },

        [99714] = { 4, 566, "INVTYPE_CHEST" },
        [99716] = { 4, 566, "INVTYPE_CHEST" },
        [99715] = { 4, 566, "INVTYPE_CHEST" },

        -- T16 Heroic Essences
        [105868] = { 4, 566, "INVTYPE_HEAD" },
        [105867] = { 4, 566, "INVTYPE_HEAD" },
        [105866] = { 4, 566, "INVTYPE_HEAD" },
        
        -- T17
        -- Item IDs are identical across difficulties, so specify nil for item level
        -- and specify the tier number instead: the raid difficulty and tier number
        -- will be used to get the item level.
        [119309] = { 4, 665, "INVTYPE_SHOULDER" },
        [119322] = { 4, 665, "INVTYPE_SHOULDER" },
        [119314] = { 4, 665, "INVTYPE_SHOULDER" },

        [119307] = { 4, 665, "INVTYPE_LEGS" },
        [119320] = { 4, 665, "INVTYPE_LEGS" },
        [119313] = { 4, 665, "INVTYPE_LEGS" },

        [119308] = { 4, 665, "INVTYPE_HEAD" },
        [119321] = { 4, 665, "INVTYPE_HEAD" },
        [119312] = { 4, 665, "INVTYPE_HEAD" },

        [119306] = { 4, 665, "INVTYPE_HAND" },
        [119319] = { 4, 665, "INVTYPE_HAND" },
        [119311] = { 4, 665, "INVTYPE_HAND" },

        [119305] = { 4, 665, "INVTYPE_CHEST" },
        [119318] = { 4, 665, "INVTYPE_CHEST" },
        [119315] = { 4, 665, "INVTYPE_CHEST" },

        -- T17 essences
        [119310] = { 4, 665, "INVTYPE_HEAD" },
        [120277] = { 4, 665, "INVTYPE_HEAD" },
        [119323] = { 4, 665, "INVTYPE_HEAD" },
        [120279] = { 4, 665, "INVTYPE_HEAD" },
        [119316] = { 4, 665, "INVTYPE_HEAD" },
        [120278] = { 4, 665, "INVTYPE_HEAD" },

    }


    -- List of tokens, which can be traded for a head, shoulder, chest, hands or legs slot item
    local TOKEN_5PART = {
        [47242] = 245,              -- T9/25-Token universal (Trophy of the Crusade)
        [47557] = 258,              -- T9-Heroic-Token Paladin/Priest/Warlock
        [47558] = 258,              -- T9-Heroic-Token Hunter/Shaman/Warrior
        [47559] = 258,              -- T9-Heroic-Token Death Knight/Druid/Mage/Rogue
        [52025] = 264,              -- T10-Token Death Knight/Druid/Mage/Rogue
        [52026] = 264,              -- T10-Token Hunter/Shaman/Warrior
        [52027] = 264,              -- T10-Token Paladin/Priest/Warlock
        [52028] = 277,              -- T10-Heroic-Token Death Knight/Druid/Mage/Rogue
        [52029] = 277,              -- T10-Heroic-Token Hunter/Shaman/Warrior
        [52030] = 277,              -- T10-Heroic-Token Paladin/Priest/Warlock
        [66998] = 372,              -- T11-Heroic-Token universal (Essence of the Forlorn)
        -- T16 LFR Essences
        [105860] = 528,
        [105861] = 528,
        [105862] = 528,
        -- T16 Flex Essences
        [105863] = 540,
        [105864] = 540,
        [105865] = 540,
        -- T16 Normal Essences
        [105857] = 553,             -- T16-Normal-Token Warrior/Hunter/Shaman/Monk
        [105858] = 553,             -- T16-Normal-Token Paladin/Priest/Warlock
        [105859] = 553,             -- T16-Normal-Token Rogue/Death Knight
        -- T16 Heroic Essences
        [105866] = 566,
        [105867] = 566,
        [105868] = 566,
        -- T17 Essences (also using bonus ID system)
        [119310] = 665,
        [120277] = 665,
        [119323] = 665,
        [120279] = 665,
        [119316] = 665,
        [120278] = 665,
    }


    --- Calculate and return a simple list of possible GP values. If there is more than one possible GP value, the function will also return a
    -- human readable string, for presenting the different values to a user and a special list, to represent which value apply under which conditions.
    -- @param item Either an ItemID or ItemString or ItemLink. Item need to be cached in client.
    -- @param class Optional - Specify the class, which will receive the item. Fully capitalized english class name with no spaces (use second return parameter of WoW-API-Function 'UnitClass')
    -- @param spec Optional - Specify the general specialization, which will receive the item. (Either "TANK", "DD" or "HEALER")
    -- @param slot Optional - Specify the slot, for which this item will be used. For possible values, see itemEquipLoc (http://www.wowpedia.org/ItemEquipLoc)
    -- @usage local GPValues, GPValueText, GPListType, GPList = LibEPGP_GPCalculator:GetItemGP(item, class, spec, slot)
    -- GPValues is a list with possible GP values for the given parameters. If no value could be calculated, it will return { 0 }. The maximum length of the list is 2.
    -- GPValueText is a human readable string, which you can present to the user for doing a GP value choice. If there is only a unique possible GP value for the given parameters, then this variable will be nil.
    -- GPListType is a string, specifing the type of the return list with GP values. If there are multiple possible GP values, this will be either "SHIELD", "1HWEAPON", "2HWEAPON", "RANGED" or "TOKEN". Otherwise nil.
    -- GPList is a list representing the different possible GP values in a machine processable form. There are five different list types. If the GP value for the given parameters is unique, this will be nil.
    -- @usage Example 1: A cloth chest item for a priest - only one possible GP value - ItemString and class are given
    -- LibEPGP-GPCalculator:GetItemGP("item:50717:0:0:0:0:0:0:0:0", "PRIEST") == { 778 }, nil, nil, nil
    -- @usage Example 2: A 1H weapon for a warrior - two possible values, depending on if used for tanking, or if placed in MH or OH - ItemID and class are given
    -- LibEPGP-GPCalculator.GetItemGP(50412, "WARRIOR") => { 825, 275 }, "Either 275 GP (for Hunter or Tank or if used as Offhand) or 825 GP (for anything else)", "1HWEAPON", { ["OTHER"] = 825, ["OFFHAND"] = 275, ["TANK"] = 275, ["HUNTER"] = 275 }
    -- @usage Example 3: A T10-Token - two possible GP values, depending on the slot - ItemID is given
    -- LibEPGP-GPCalculator.GetItemGP(52030) => { 778, 583 }, "Either 778 GP (for Head, Chest or Legs) or 583 GP (for Shoulders or Hands)", "TOKEN", { ["HEAD"] = 778, ["CHEST"] = 778, ["LEGS"] = 778, ["SHOULDERS"] = 583, ["HANDS"] = 583, }
    -- @usage Example 4: A bag - no possible values - ItemId is given
    -- LibEPGP-GPCalculator.GetItemGP(38082) => { 0 }, nil, nil, nil
    function libGP:GetItemGP(item, class, spec, slot)
        --[[
        The basic GP formular is: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
        The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
        The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who will use the item
        --]]
        -- Gather item information
        local _, itemLink, itemRarity, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(item)
        -- Check if a valid item was supplied
        if not itemLink then
            error(("Argument #1 to LibEPGP_GPCalculator:GetValues was invalid or not a cached item. It must be a cached ItemID, ItemString or ItemLink. Got: %s"):format(item) , 2)
        end
        -- Get ItemID
        local itemID = string.match(itemLink, "|Hitem:(%d+)")
        -- Convert simple tokens to armor
        if LBIR[itemType] == "Miscellaneous" and CUSTOM_ITEM_DATA[itemID] and not TOKEN_5PART[itemID] then
            _, itemLevel, itemEquipLoc = unpack(CUSTOM_ITEM_DATA[itemID])
            itemType = "Armor"
        end
        -- Armor: With the exception of shields, the GP values for armor items are unique
        if LBIR[itemType] == "Armor" then
            -- Slots Wrist, Neck, Back, Finger, Offhand-Items and Relics have a fixed modifier of 0.5
            if itemEquipLoc == "INVTYPE_WRIST" or itemEquipLoc == "INVTYPE_NECK" or itemEquipLoc == "INVTYPE_CLOAK" or itemEquipLoc == "INVTYPE_FINGER" or itemEquipLoc == "INVTYPE_HOLDABLE" or itemEquipLoc == "INVTYPE_RELIC" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
            -- Slots Shoulder, Hands, Waist, Feet and Trinkets have a fixed modifier of 0.75
            if itemEquipLoc == "INVTYPE_SHOULDER" or itemEquipLoc == "INVTYPE_HAND" or itemEquipLoc == "INVTYPE_WAIST" or itemEquipLoc == "INVTYPE_FEET" or itemEquipLoc == "INVTYPE_TRINKET" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.75) }
            end
            -- Slots Head, Chest, Legs have a fixed modifier of 1
            if itemEquipLoc == "INVTYPE_HEAD" or itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" or itemEquipLoc == "INVTYPE_LEGS" then
                return { libGP:GetGP(itemLevel, itemRarity, 1) }
            end
            -- If a shield is used for tanking, it has a modifier of 1.5 - else 0.5
            -- Additional idea: all caster shields of a quality of rare (or better) seem to have +Int on them. This could avoid the return of multiple values
            --            also: shield with +Str are tank shields
            if itemEquipLoc == "INVTYPE_SHIELD" then
                -- 0.5, if class is shaman (non-tank), or spec is either HEAL or DD
                if class == "SHAMAN" or spec == "DD" or spec == "HEAL" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- 1.5, if class is warrior (Shield is only used for tanking then) or spec is TANK
                elseif class == "WARRIOR" or spec == "TANK" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 0.5), libGP:GetGP(itemLevel, itemRarity, 1.5) }
                    local GPValueText = ("Either %d GP (for Tanks) or %d GP (for other specs)"):format(GPValues[2], GPValues[1])
                    local GPListType = "SHIELD"
                    local GPList = { ["OTHER"] = GPValues[1], ["TANK"] = GPValues[2] }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
        end
        -- Weapons: They are a bit more complicated
        if LBIR[itemType] == "Weapon" then
            -- a 1H main-hand weapon is always mod 1.5, except for hunter and tanks (0.5 then)
            -- If no spec is given, then return mod 1.5 for all non tanking classes.
            -- INVTYPE_WEAPONMAINHAND can't be an offhand.
            if itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
                if class == "HUNTER" or spec == "TANK" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                elseif class == "MAGE" or class == "PRIEST" or class == "ROGUE" or class == "SHAMAN" or class == "WARLOCK" or spec ~= nil then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter or Tank) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "1HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["TANK"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- a 1H off-hand weapon is always mod 0.5
            if itemEquipLoc == "INVTYPE_WEAPONOFFHAND" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
            -- 1H weapon is 1.5, except for hunters and tanks - or if used as offhand (0.5 then)
            -- Additional idea: There are classes, who can't equip off hand weapons. Should return the 1.5 mod value then.
            if itemEquipLoc == "INVTYPE_WEAPON" then
                if class == "HUNTER" or spec == "TANK" or slot == "INVTYPE_WEAPONOFFHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                elseif class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or slot == "INVTYPE_WEAPONMAINHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter or Tank or if used as Offhand) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "1HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["TANK"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- 2H weapon is 2, except for warrior OH (1) or hunter (1)
            -- Possible extension: If the weapon has Int on it, it is not for a warrior or hunter -> mod 2!
            if itemEquipLoc == "INVTYPE_2HWEAPON" then
                -- 1, if used for Offhand or class is hunter
                if class == "HUNTER" or slot == "INVTYPE_WEAPONOFFHAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1) }
                -- 2, if class is not Warrior and not hunter and not nil
                elseif class ~= nil and class ~= "WARRIOR" and class ~= "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 2) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 2), libGP:GetGP(itemLevel, itemRarity, 1) }
                    local GPValueText = ("Either %d GP (for Hunter or is used as Offhand) or %d GP (for anything else)"):format(GPValues[2], GPValues[1])
                    local GPListType = "2HWEAPON"
                    local GPList = { ["OTHER"] = GPValues[1], ["OFFHAND"] = GPValues[2], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- Bows are mod 0.5, except for hunters (1.5 then)
            if itemEquipLoc == "INVTYPE_RANGED" then
                -- 1.5, if used by hunter
                if class == "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- 0.5, if not used by hunter
                elseif class ~= nil then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter) or %d GP (for any other class)"):format(GPValues[2], GPValues[1])
                    local GPListType = "RANGED"
                    local GPList = { ["OTHER"] = GPValues[1], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- INVTYPE_RANGEDRIGHT covers wands, crossbows and guns. Wands are always 0.5. Crossbows and guns are under the same rules as bows.
            if itemEquipLoc == "INVTYPE_RANGEDRIGHT" then
                -- 1.5, if used by hunter
                if class == "HUNTER" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1.5) }
                -- 0.5, if other class or item is a wand
                elseif class ~= nil or LBIR[itemSubType] == "Wands" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
                -- if nothing matches, return both values
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1.5), libGP:GetGP(itemLevel, itemRarity, 0.5) }
                    local GPValueText = ("Either %d GP (for Hunter) or %d GP (for any other class)"):format(GPValues[2], GPValues[1])
                    local GPListType = "RANGED"
                    local GPList = { ["OTHER"] = GPValues[1], ["HUNTER"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
            -- Thrown weapons are ranged weapons, which have a mod of 0.5 except for hunters. 
            -- However, in WoW it does not make sense for a Hunter to carry thrown weapons, so this case can be ignored. 
            -- ... I think. At least I hope... Why do I have this strange feeling that there is at least one Hunter out there that will prove me wrong some day?
            if itemEquipLoc == "INVTYPE_THROWN" then
                return { libGP:GetGP(itemLevel, itemRarity, 0.5) }
            end
        end
        -- Misc: Tier Tokens are under this category. Depending on the type of the token, it may be able to redeem different slots 
        if LBIR[itemType] == "Miscellaneous" then
            if TOKEN_5PART[itemID] then
                itemLevel = TOKEN_5PART[itemID]
                if slot == "INVTYPE_HEAD" or slot == "INVTYPE_CHEST" or slot == "INVTYPE_ROBE" or slot == "INVTYPE_LEGS" then
                    return { libGP:GetGP(itemLevel, itemRarity, 1) }
                elseif slot == "INVTYPE_SHOULDER" or slot == "INVTYPE_HAND" then
                    return { libGP:GetGP(itemLevel, itemRarity, 0.75) }
                else
                    local GPValues = { libGP:GetGP(itemLevel, itemRarity, 1), libGP:GetGP(itemLevel, itemRarity, 0.75) }
                    local GPValueText = ("Either %d GP (for Head, Chest or Legs) or %d GP (for Shoulders or Hands)"):format(GPValues[1], GPValues[2])
                    local GPListType = "TOKEN"
                    local GPList = { ["HEAD"] = GPValues[1], ["CHEST"] = GPValues[1], ["LEGS"] = GPValues[1], ["SHOULDERS"] = GPValues[2], ["HANDS"] = GPValues[2], }
                    return GPValues, GPValueText, GPListType, GPList
                end
            end
        end
        -- If the item was not recognized, return { 0 }
        return { 0 }
    end

    --- Calculates the GP for an item with known itemLevel, rarity and slot mod.
    -- @param itemLevel The itemLevel of an item
    -- @param rarity The rarity of an item. Possible values are: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
    -- @param slotMod The slot modifier according to the EPGP-System.
    -- @return a number, representing the GP value for the given variables
    function libGP:GetGP(itemLevel, rarity, slotMod)
        --[[
        The basic GP formular was: GP = 0.483 x 2^(ilvl/26 + (rarity - 4)) x slot mod (http://www.epgpweb.com/help/gearpoints)
        The coefficient seems to have changed in Cataclysm to 0.06974 - this isn't in the official web documentation but in the EPGP-Addon-Code
        The rarity is defined as: Uncommon (Green) = 2 / Rare (Blue) = 3 / Epic (Purple) = 4 / Legendary (Orange) = 5
        The slot modifier depends on the gearslot and may additionally depends on the class and spec of the character who will use the item
        --]]
        -- sanity check inputs here
        -- calculate the GP value
        return floor( epgpCoefficient * 2 ^ ( itemLevel/26 + (rarity - 4) ) * slotMod )
    end
end
