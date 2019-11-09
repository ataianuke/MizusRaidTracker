-- *********************************************************
-- **           Mizus Raid Tracker - Constants            **
-- *********************************************************
--


-- Check for addon table
if (not MizusRaidTracker) then MizusRaidTracker = {}; end
local mrt = MizusRaidTracker

mrt.diffIDsLFR = { 7, 17 }
mrt.diffIDsNormal = { 1, 3, 4, 9, 12, 14 }
mrt.diffIDsHeroic = { 2, 5, 6, 11, 15 }
mrt.raidSizes = { 5, 5, 10, 25, 10, 25, 25, 5, 40, 40, 3, 3, 40, 30, 30, 20, 30, 5, 5, 5 }

-- these are probably not needed anymore
MRT_ItemColorValues = {
    ["ff9d9d9d"] = 0,  -- poor
    ["ffffffff"] = 1,  -- common
    ["ff1eff00"] = 2,  -- uncommon
    ["ff0070dd"] = 3,  -- rare
    ["ffa335ee"] = 4,  -- epic
    ["ffff8000"] = 5,  -- legendary
    ["ffe6cc80"] = 6,  -- artifact / heirloom
}

MRT_ItemColors = {
    [1] = "ff9d9d9d",  -- poor
    [2] = "ffffffff",  -- common
    [3] = "ff1eff00",  -- uncommon
    [4] = "ff0070dd",  -- rare
    [5] = "ffa335ee",  -- epic
    [6] = "ffff8000",  -- legendary
    [7] = "ffe6cc80",  -- artifact / heirloom
    [8] = "ffe6cc80",
}

MRT_ItemColorsNonAlpha = {
    [1] = "9d9d9d",  -- poor
    [2] = "ffffff",  -- common
    [3] = "1eff00",  -- uncommon
    [4] = "0070dd",  -- rare
    [5] = "a335ee",  -- epic
    [6] = "ff8000",  -- legendary
    [7] = "e6cc80",  -- artifact / heirloom
}

MRT_ItemValues = {
    [1] = ITEM_QUALITY0_DESC,
    [2] = ITEM_QUALITY1_DESC,
    [3] = ITEM_QUALITY2_DESC,
    [4] = ITEM_QUALITY3_DESC,
    [5] = ITEM_QUALITY4_DESC,
    [6] = ITEM_QUALITY5_DESC,
    [7] = ITEM_QUALITY6_DESC, 
}


----------------------
--  Zone name list  --
----------------------
MRT_RaidZones = {
    -- Classic - Classic only
    [309] = true,       -- Zul'Gurub
    -- Classic - Retail & Classic
    [469] = true,       -- Blackwing Lair
    [409] = true,       -- Molten Core
    [509] = true,       -- Ruins of Ahn'Qiraj
    [531] = true,       -- Temple of Ahn'Qiraj
    -- Burning Crusade
    [532] = true,       -- Karazhan
    [565] = true,       -- Gruul's Lair
    [544] = true,       -- Magtheridon's Lair
    [548] = true,       -- Serpentshrine Cavern
    [550] = true,       -- Tempest Keep
    [534] = true,       -- Hyjal Summit
    [564] = true,       -- Black Temple
    [580] = true,       -- Sunwell Plateau
    -- Wrath of the Lich King
    [616] = true,       -- The Eye of Eternity
    [615] = true,       -- The Obsidian Sanctum
    [624] = true,       -- Vault of Archavon
    [533] = true,       -- Naxxramas (also in Classic)
    [603] = true,       -- Ulduar
    [649] = true,       -- Trial of the Crusader
    [249] = true,       -- Onyxia's Lair (also in Classic)
    [631] = true,       -- Icecrown Citadel
    [724] = true,       -- The Ruby Sanctum
    -- Cataclysm
    [757] = true,       -- Baradin Hold
    [669] = true,       -- Blackwing Descent
    [671] = true,       -- The Bastion of Twilight
    [754] = true,       -- Throne of the Four Winds
    [720] = true,       -- Firelands
    [967] = true,       -- Dragon Soul
    -- Mists of Pandaria
    [996] = true,       -- Terrace of Endless Spring
    [1008] = true,      -- Mogu'shan Vaults
    [1009] = true,      -- Heart of Fear
    [1098] = true,      -- Throne of Thunder
	[1136] = true,		-- Siege of Orgrimmar
    -- Warlords of Draenor
    [1228] = true,      -- Highmaul
    [1205] = true,      -- Blackrock Foundry
    [1448] = true,      -- Hellfire Citadel
    -- Legion
    [1520] = true,      -- The Emerald Nightmare
    [1648] = true,      -- Trial of Valor
    [1530] = true,      -- The Nighthold
    [1676] = true,      -- Tomb of Sargeras
	[1712] = true,		-- Antorus
    -- Battle for Azeroth
    [1861] = true,      -- Uldir
    [2070] = true,      -- Battle of Dazar'alor
    [2096] = true,      -- Crucible of Storms
    [2164] = true,      -- Eternal Palace
}

MRT_LegacyRaidZonesLegion = {
    [1520] = true,      -- The Emerald Nightmare
    [1648] = true,      -- Trial of Valor
    [1530] = true,      -- The Nighthold
    [1676] = true,      -- Tomb of Sargeras
	[1712] = true,		-- Antorus
}

MRT_LegacyRaidZonesWarlords = {
    [1228] = true,      -- Highmaul
    [1205] = true,      -- Blackrock Foundry
    [1448] = true,      -- Hellfire Citadel
}

MRT_LegacyRaidZonesPanadria = {
    [996] = true,       -- Terrace of Endless Spring
    [1008] = true,      -- Mogu'shan Vaults
    [1009] = true,      -- Heart of Fear
    [1098] = true,      -- Throne of Thunder
	[1136] = true,		-- Siege of Orgrimmar
}

MRT_LegacyRaidZonesCataclysm = {
    [757] = true,       -- Baradin Hold
    [669] = true,       -- Blackwing Descent
    [671] = true,       -- The Bastion of Twilight
    [754] = true,       -- Throne of the Four Winds
    [720] = true,       -- Firelands
    [967] = true,       -- Dragon Soul
}

MRT_LegacyRaidZonesWotLK = {
    [616] = true,       -- The Eye of Eternity
    [615] = true,       -- The Obsidian Sanctum
    [624] = true,       -- Vault of Archavon
    [533] = true,       -- Naxxramas
    [603] = true,       -- Ulduar
    [649] = true,       -- Trial of the Crusader
    [249] = true,       -- Onyxia's Lair
    [631] = true,       -- Icecrown Citadel
    [724] = true,       -- The Ruby Sanctum
}

MRT_LegacyRaidZonesBC = {
    [532] = true,       -- Karazhan
    [565] = true,       -- Gruul's Lair
    [544] = true,       -- Magtheridon's Lair
    [548] = true,       -- Serpentshrine Cavern
    [550] = true,       -- Tempest Keep
    [534] = true,       -- Hyjal Summit
    [564] = true,       -- Black Temple
    [580] = true,       -- Sunwell Plateau
}

MRT_LegacyRaidZonesClassic = {
    [469] = true,       -- Blackwing Lair
    [409] = true,       -- Molten Core
    [509] = true,       -- Ruins of Ahn'Qiraj
    [531] = true,       -- Temple of Ahn'Qiraj
}

mrt.raidZonesClassic = {
    [469] = true,       -- Blackwing Lair
    [409] = true,       -- Molten Core
    [533] = true,       -- Naxxramas
    [249] = true,       -- Onyxia's Lair
    [509] = true,       -- Ruins of Ahn'Qiraj
    [531] = true,       -- Temple of Ahn'Qiraj
    [309] = true,       -- Zul'Gurub
}

MRT_PvPRaids = {
    [757] = true,       -- Baradin Hold
    [624] = true,       -- Vault of Archavon
}


-----------------------------------
--  ID-List of trackable Bosses  --
-----------------------------------
MRT_BossIDList = {
    ------------------------------
    --  Wrath of the Lich King  --
    ------------------------------
    --  Stormwind - Added for Debuging
    --[[
    [721] = "Rabbit",
    [32428] = "Underbelly Rat",
    [32470] = "Sewer Frog",
    --]]
 
}

MRT_EncounterIDList = {
    -----------------------------
    --  Classic - Classic only --
    -----------------------------
    -- Zul'Gurub
    [785] = 14517,              -- High Priestess Jeklik
    [784] = 14507,              -- High Priest Venoxis
    [786] = 14510,              -- High Priestess Mar'li    
    [789] = 14509,              -- High Priest Thekal
    [791] = 14515,              -- High Priestess Arlokk
    [787] = 14988,              -- Bloodlord Mandokir
    [792] = 11380,              -- Jin'do the Hexxer
    [790] = 15114,              -- Gahz'ranka
    [788] = 15083,              -- Edge of Madness
    [793] = 14834,              -- Hakkar
    
    -----------------------
    --  Classic - Retail --
    -----------------------
    -- Molten Core
    [663] = 12118,              -- Lucifron
    [664] = 11982,              -- Magmadar
    [665] = 12259,              -- Gehennas
    [666] = 12057,              -- Garr
    [667] = 12264,              -- Shazzrah
    [668] = 12056,              -- Baron Geddon
    [670] = 11988,              -- Golemagg the Incinerator
    [669] = 12098,              -- Sulfuron Harbinger
    [671] = 12018,              -- Majordomo Executus
    [672] = 11502,              -- Ragnaros
    
    -- Blackwing Lair
    [610] = 12435,              -- Razorgore the Untamed
    [611] = 13020,              -- Vaelastrasz the Corrupt 
    [612] = 12017,              -- Broodlord Lashlayer
    [613] = 11983,              -- Firemaw
    [614] = 14601,              -- Ebonroc
    [615] = 11981,              -- Flamegor
    [616] = 14020,              -- Chromaggus
    [617] = 11583,              -- Nefarian 
    
    -- Ruins of Ahn'Qiraj
    [718] = 15348,              -- Kurinnaxx
    [719] = 15341,              -- General Rajaxx
    [720] = 15340,              -- Moam
    [721] = 15370,              -- Buru the Gorger
    [722] = 15369,              -- Ayamiss the Hunter
    [723] = 15339,              -- Ossirian the Unscarred
    
    -- Temple of Ahn'Qiraj
    [709] = 15263,              -- The Prophet Skeram
    [711] = 15516,              -- Battleguard Sartura
    [712] = 15510,              -- Fankriss the Unyielding
    [714] = 15509,              -- Princess Huhuran
    [715] = 15276,              -- Twin Emperors
    [717] = 15589,              -- C'Thun
    [710] = 15544,              -- Bug Trio
    [713] = 15299,              -- Viscidus
    [716] = 15517,              -- Ouro
    
    
    -----------------------
    --  Burning Crusade  --
    -----------------------
    -- Karazhan
    [652] = 16151,              -- Attumen the Huntsman
    [653] = 15687,              -- Moroes
    [654] = 16457,              -- Maiden of Virtue
    [655] = 17521,              -- Opera Hall
    [656] = 15691,              -- The Curator
    [658] = 16524,              -- Shade of Aran
    [657] = 15688,              -- Terestian Illhoof
    [659] = 15689,              -- Netherspite              -- FIXME - needs verification
    [660] = 21752,              -- Chess Event
    [661] = 15690,              -- Prince Malchezaar
    [662] = 17225,              -- Nightbane
    
    -- Gruul's Lair
    [650] = 19044,              -- Gruul
    
    -- Magtheridon's Lair
    [651] = 17257,              -- Magtheridon
    
    -- Serpentshrine Cavern
    [623] = 21216,              -- Hydross the Unstable
    [624] = 21217,              -- The Lurker Below
    [625] = 21215,              -- Leotheras the Blind
    [626] = 21214,              -- Fathom-Lord Karathress
    [627] = 21213,              -- Morogrim Tidewalker
    [628] = 21212,              -- Lady Vashj
    
    -- Tempest Keep
    [730] = 19514,              -- Al'ar
    [731] = 19516,              -- Void Reaver
    [732] = 18805,              -- High Astromancer Solarian
    [733] = 19622,              -- Kael'thas Sunstrider
    
    -- Hyjal Summit
    [618] = 17767,              -- Rage Winterchill
    [619] = 17808,              -- Anetheron
    [620] = 17888,              -- Kaz'rogal
    [621] = 17842,              -- Azgalor
    [622] = 17968,              -- Archimonde
    
    -- Black Temple
    [601] = 22887,              -- High Warlord Naj'entus
    [602] = 22898,              -- Supremus
    [603] = 22841,              -- Shade of Akama
    [604] = 22871,              -- Teron Gorefiend
    [605] = 22948,              -- Gurtogg Bloodboil
    [606] = 23420,              -- Reliquary of Souls
    [607] = 22947,              -- Mother Shahraz
    [608] = 22949,              -- The Illidari Council
    [609] = 22917,              -- Illidan Stormrage
    
    -- Sunwell Plateau
    [724] = 24850,              -- Kalecgos
    [725] = 24882,              -- Brutallus
    [726] = 25038,              -- Felmyst
    [727] = 25165,              -- Eredar Twins
    [728] = 25741,              -- M'uru
    [729] = 25315,              -- Kil'jaeden
    
    
	------------------------------
    --  Wrath of the Lich King  --
    ------------------------------
    -- Naxxramas
    [1107] = 15956,             -- Anub'Rekhan
    [1110] = 15953,             -- Grand Widow Faerlina
    [1116] = 15952,             -- Maexxna
    [1117] = 15954,             -- Noth the Plaguebringer
    [1112] = 15936,             -- Heigan the Unclean
    [1115] = 16011,             -- Loatheb
    [1113] = 16061,             -- Instructor Razuvious
    [1109] = 16060,             -- Gothik the Harvester
    [1121] = 16063,             -- The Four Horsemen          
    [1118] = 16028,             -- Patchwerk
    [1111] = 15931,             -- Grobbulus
    [1108] = 15932,             -- Gluth
    [1120] = 15928,             -- Thaddius
    [1119] = 15989,             -- Sapphiron
    [1114] = 15990,             -- Kel'Thuzad
    
    -- The Obsidian Sanctum
    [1090] = 28860,             -- Sartharion
    
    -- Eye of Eternity
    [1094] = 28859,             -- Malygos
    
    -- Archavon's Chamber
    [1126] = 31125,             -- Archavon the Stone Watcher
    [1127] = 33993,             -- Emalon the Storm Watcher
    [1128] = 35013,             -- Koralon the Flame Watcher
    [1129] = 38433,             -- Toravon the Ice Watcher
    
    -- Ulduar
    [1132] = 33113,             -- Flame Leviathan
    [1136] = 33118,             -- Ignis the Furnace Master
    [1139] = 33186,             -- Razorscale
    [1142] = 33293,             -- XT-002 Deconstructor
    [1140] = 32857,             -- Assembly of Iron         
    [1137] = 32930,             -- Kologarn
    [1131] = 33515,             -- Auriaya
	[1133] = 32906,             -- Freya
	[1135] = 32845,             -- Hodir
	[1138] = 33350,             -- Mimiron
	[1141] = 32865,             -- Thorim
    [1134] = 33271,             -- General Vezax
    [1143] = 33288,             -- Yogg-Saron
    [1130] = 32871,             -- Algalon
        
    -- Onyxias Lair
    [1084] = 10184,             -- Onyxia
    
    -- Trial of the Crusader
    [1088] = 34797,             -- Northrend Beasts         -- ID of Icehowl - EncounterID might be buggy
    [1087] = 34780,             -- Lord Jaraxxus
	[1086] = 34445,             -- Faction Champions        -- EncounterID might be buggy
    [1089] = 34497,             -- The Twin Val'kyr
    [1085] = 34564,             -- Anub'arak
    
    -- Icecrown Citadel
    [1101] = 36612,             -- Lord Marrowgar
    [1100] = 36855,             -- Lady Deathwhisper
	[1099] = 37215,             -- Gunship Battle		    -- this one might not work
    [1096] = 37813,             -- Deathbringer Saurfang
    [1097] = 36626,             -- Festergut
    [1104] = 36627,             -- Rotface
    [1102] = 36678,             -- Professor Putricide
    [1095] = 37972,             -- Blood Prince Council
    [1103] = 37955,             -- Blood-Queen Lana'thel
    [1098] = 36789,             -- Dreamwalker Valithria
    [1105] = 36853,             -- Sindragosa
    [1106] = 36597,             -- The Lich King
    
    -- The Ruby Sanctum
    [1150] = 39863,             -- Halion
	
	
    -----------------
    --  Cataclysm  --
    -----------------
    -- Baradin Hold
    [1033] = 47120,             -- Argaloth
    [1250] = 52363,             -- Occu'thar
    [1332] = 55869,             -- Alizabal
    
    -- Blackwing Descent
    [1024] = 41570,				-- Magmaw
    [1027] = 42180,				-- Omnotron Defense System  -- ID of Toxitron
    [1025] = 41378,				-- Maloriak
    [1022] = 41442,				-- Atramedes
    [1023] = 43296,				-- Chimaeron
    [1026] = 41376,				-- Nefarian
    
    -- The Bastion of Twilight
    [1030] = 44600,             -- Halfus Wyrmbreaker
    [1032] = 45992,             -- Valiona and Theralion    -- ID of Valiona
    [1028] = 43735,             -- Ascendant Council        -- ID of Elementium Monstrosity
    [1029] = 43324,             -- Cho'gall
    [1082] = 45213,             -- Sinestra                 -- Might be 1083                    
    
    -- Throne of the Four Winds
    [1035] = 45871,             -- Conclave of Wind
    [1034] = 46753,             -- Al'Akir
    
    -- Firelands
    [1197] = 52498,             -- Beth'tilac
    [1204] = 52558,             -- Lord Rhyolith
    [1206] = 52530,             -- Alysrazor
    [1205] = 53691,             -- Shannox
    [1200] = 53494,             -- Baleroc
    [1185] = 52571,             -- Majordomo Staghelm
    [1203] = 52409,             -- Ragnaros
    
    -- Dragon Soul
    [1292] = 55265,             -- Morchok
    [1294] = 55308,             -- Warlord Zonozz
    [1295] = 55312,             -- Yor'sahj the Unsleeping
    [1296] = 55689,             -- Hagara the Stormbinder
    [1297] = 55294,             -- Ultraxion
    [1298] = 56427,             -- Warmaster Blackhorn      -- Might not work
    [1291] = 53879,             -- Spine of Deathwing 
    [1299] = 56173,             -- Madness of Deathwing


    -------------------------
    --  Mists of Pandaria  --
    -------------------------
    -- Mogu'shan Vaults
    [1395] = 60047,             -- The Stone Guard
    [1390] = 60009,             -- Feng the Accursed
    [1434] = 60143,             -- Gara'jal the Spriritbinder
	[1436] = 60701,             -- The Spirit Kings         -- Zian
    [1500] = 60410,             -- Elegon
    [1407] = 60399,             -- Will of the Emperor      -- qin-xi
    
    -- Terrace of Endless Spring
    [1409] = 60583,             -- Protectors of the Endless -- Kaolan
    [1505] = 62442,             -- Tsulong 
    [1506] = 62983,             -- Lei Shi
    [1431] = 60999,             -- Sha of Fear
    
    -- Heart of Fear
    [1507] = 62980,             -- Imperial Vizier Zor'lok
    [1504] = 62543,             -- Blade Lord Ta'yak
    [1463] = 62164,             -- Garalon
    [1498] = 62397,             -- Wind Lord Mel'jarak
    [1499] = 62511,             -- Amber-Shaper Un'sok
    [1501] = 62837,             -- Grand Empress Shek'zeer

    -- Throne of Thunder
    [1577] = 69465,             -- Jin'rokh the Breaker
    [1575] = 68476,             -- Horridon
    [1570] = 69078,             -- Council of Elders 	    -- Sul
    [1565] = 67977,             -- Tortos
    [1578] = 68065,             -- Megaera
    [1573] = 69712,             -- Ji-Kun
    [1572] = 68036,             -- Durumu the Forgotten
    [1574] = 69017,             -- Primordius
    [1576] = 69427,             -- Dark Animus
    [1559] = 68078,             -- Iron Qon			        -- <Master of Quilen>
    [1560] = 68904,             -- Twin Consorts 		    -- Suen <Mistress of Anger>, Twin Consorts
    [1579] = 68397,             -- Lei Shen			        -- <The Thunder King>
	[1580] = 69473,	            -- Ra-den <Fallen Keeper of Storms>

	-- Siege of Orgrimmar
	[1602] = 71543,	            -- Immerseus
    [1598] = 71475,             -- The Fallen Protectors    -- ID of Rook Stonetoe
	[1624] = 72276,             -- Norushen 				-- ID of Amalgam of Corruption (EncounterID might not work)
	[1604] = 71734,             -- Sha of Pride
	[1622] = 72249,             -- Galakras
	[1600] = 71466,             -- Iron Juggernaut
	[1606] = 71858,             -- Kor'kron Dark Shaman 	-- ID of Wavebinder Kardris - shared healthpool
	[1603] = 71515,             -- General Nazgrim
	[1595] = 71454,             -- Malkorok
	[1594] = 71512,             -- Spoils of Pandaria
	[1599] = 71529,             -- Thok the Bloodthirsty
	[1601] = 71504,             -- Siegecrafter Blackfuse
	[1593] = 71152,             -- Paragons of the Klaxxi	-- ID of Skeer the Bloodseeker
	[1623] = 71865,             -- Garrosh Hellscream
    
    
    ---------------------------
    --  Warlords of Draenor  --
    ---------------------------
    -- Highmaul
    [1721] = 78714,             -- Kargath Bladefist
    [1706] = 77404,             -- The Butcher
    [1722] = 78948,             -- Tectus
    [1720] = 78491,             -- Brackenspore
    [1719] = 78237,             -- Twin Ogron               -- ID of Phemos
    [1723] = 79015,             -- Ko'ragh
    [1705] = 77428,             -- Imperator Mar'gok
    -- Blackrock Foundry
    [1691] = 76877,             -- Gruul
    [1696] = 77182,             -- Oregorger
    [1694] = 76865,             -- Beastlord Darmac
    [1689] = 76814,             -- Flamebender Ka'graz
    [1693] = 76973,             -- Hans'gar and Franzok     -- ID of Hans'gar
    [1692] = 76906,             -- Operator Thogar
    [1690] = 76806,             -- The Blast Furnace        -- ID of Heart of the Mountain
    [1713] = 77692,             -- Kromog
    [1695] = 77231,             -- The Iron Maidens         -- ID of Enforcer Sorka
    [1704] = 77325,             -- Blackhand
    -- Hellfire Citadel
    [1778] = 94515,             -- Hellfire Assault
    [1785] = 90284,             -- Iron Reaver
    [1787] = 90435,             -- Kormrok
    [1786] = 90378,             -- Kilrogg Deadeye
    [1778] = 92142,             -- Hellfire High Council    -- ID of Blademaster Jubei'thos
    [1783] = 90199,             -- Gorefiend
    [1788] = 90316,             -- Shadow-Lord Iskar
    [1794] = 92330,             -- Socrethar the Eternal    -- ID of Soulbound Construct
    [1784] = 90269,             -- Tyrant Velhari
    [1777] = 89890,             -- Fel Lord Zakuun
    [1800] = 93068,             -- Xhul'horac
    [1795] = 91349,             -- Mannoroth
    [1799] = 91331,             -- Archimonde

    
    --------------
    --  Legion  --
    --------------
	-- The Emerald Nightmare
    [1853] = 102672, 			-- Nythendra
    [1873] = 105393, 			-- Il'gynoth
    [1876] = 106087, 			-- Elerethe Renferal
    [1841] = 100497, 			-- Ursoc
    [1854] = 102679, 			-- Dragons of Nightmare     -- ID of Ysondre
    [1877] = 104636, 			-- Cenarius
    [1864] = 103769, 			-- Xavius
	
    -- Trial of Valor
    [1958] = 114263,            -- Odyn
    [1962] = 114323,            -- Guarm
    [2008] = 114537,            -- Helya
    
    -- The Nighthold
    [1849] = 102263,            -- Skorpyon
    [1865] = 104415,            -- Chronomatic Anomaly
    [1867] = 104327,            -- Trilliax
    [1871] = 104881,            -- Aluriel
    [1862] = 103685,            -- Tichondrius
    [1842] = 101002,            -- Krosus
    [1886] = 104528,            -- Tel'arn
    [1863] = 103758,            -- Etraeus
    [1872] = 106643,            -- Elisande
    [1866] = 105503,            -- Gul'dan
    
    -- Tomb of Sageras
    [2032] = 115844,            -- Goroth
    [2048] = 116691,            -- Demonic Inquisition
    [2036] = 116407,            -- Harjatan
    [2050] = 118518,            -- Sisters of the Moon
    [2037] = 115767,            -- Mistress Sassz'ine
    [2054] = 119072,            -- The Desolate Host
    [2052] = 118289,            -- Maiden of Vigilance
    [2038] = 116939,            -- Fallen Avatar
    [2051] = 108573,            -- Kil'jaeden
	
	-- Antorus
	[2076] = 122450,            -- Garothi Worldbreaker
	[2074] = 122477,            -- Felhounds of Sargeras
	[2070] = 122333,            -- Antoran High Command
	[2064] = 122104,            -- Portal Keeper Hasabel
	[2075] = 124445,            -- Eonar the Life-Binder
	[2082] = 124158,            -- Imonar the Soulhunter
	[2088] = 122578,            -- Kin'garoth
	[2069] = 122366,            -- Variamathras
	[2073] = 122468,            -- The Coven of Shivarra
	[2063] = 121975,            -- Aggramar
	[2092] = 125111,            -- Argus the Unmaker
    
    
    --------------------------
    --  Battle for Azeroth  --
    --------------------------
    -- Uldir
    [2144] = 137119,            -- Taloc
    [2141] = 135452,            -- MOTHER
    [2128] = 133298,            -- Fetid Devourer
    [2136] = 134445,            -- Zek'voz, Herald of N'zoth
    [2134] = 134442,            -- Vectis
    [2145] = 138967,            -- Zul, Reborn
    [2135] = 134546,            -- Mythrax the Unraveler
    [2122] = 132998,            -- G'huun
    
    -- Battle of Dazar'alor
    [2265] = 144683,            -- Champion of Light (both factions)
    [2263] = 144638,            -- Grong the Revenant (Alliance)
    [2284] = 147268,            -- King Grong (Horde)
    [2266] = 144691,            -- Grimfang and Firecaller (Alliance)
    [2285] = 144690,            -- Flamefist and Mestrah (Horde)
    [2271] = 145261,            -- Opulence
    [2268] = 144747,            -- Conclave of the Chosen
    [2272] = 145616,            -- King Rastakhan
    [2276] = 144796,            -- High Tinker Mekkatorque
    [2280] = 146251,            -- Stormwall Blockade
    [2281] = 146409,            -- Lady Jaina Proudmoore
    
    -- Crucible of Storms
    [2269] = 146497,            -- Restless Cabal
    [2273] = 145371,            -- Uunat
    
    -- Eternal Palace
    [2289] = 150653,            -- Blackwater Behemoth
    [2293] = 151586,            -- Za'qul, Harbinger of Ny'alotha
    [2303] = 152128,            -- Orgozoa
    [2298] = 151881,            -- Abyssal Commander Sivara
    [2305] = 152364,            -- Radiance of Azshara
    [2304] = 152236,            -- Lady Ashvane
    [2311] = 152852,            -- The Queen's Court
    [2299] = 152910,            -- Queen Azshara
    
}

-- ARRAY 
-- :>
MRT_ArrayBossIDList = {}
MRT_ArrayBossIDList_cache = {}

for key, val in pairs(MRT_BossIDList) do
	MRT_ArrayBossIDList_cache[val] = MRT_ArrayBossIDList_cache[val] or { }
	table.insert(MRT_ArrayBossIDList_cache[val], key) 
end

for key, val in pairs(MRT_ArrayBossIDList_cache) do
	local nc = table.getn(val);

	if( nc > 1) then
		MRT_ArrayBossIDList[key]= val;
	end
end

wipe(MRT_ArrayBossIDList_cache);

-- SpellID list - A list of spell IDs which indicates a dead boss
-- Format: [<SpellID>] = { "<English boss name>", <BossID> }
MRT_BossSpellIDTriggerList = {
    -----------------
    --  Cataclysm  --
    -----------------
    -- Mizukichan - for debugging purposes
    --[139] = { "Mizukichan - Renew" , 1 },
    
    -- Dragon Soul
    [110063] = { "Madness of Deathwing", 56173 },       -- ID of "Astral Recall", cast by Thrall when the fight is won

}


-- The reverse boss ID list is needed for bosses, that are tracked by a boss yell.
MRT_ReverseBossIDList = {
    ------------------------------
    --  Wrath of the Lich King  --
    ------------------------------
    -- Ulduar
    ["Hodir"] = 32845,
    ["Thorim"] = 32865,
    ["Freya"] = 32906,
    ["Mimiron"] = 33350,
    ["Algalon the Observer"] = 32871,
    -- Icecrown Citadel
    ["Valithria Dreamwalker"] = 36789,
    -- Ruby Sanctum
    ["Halion"] = 39863,
    
    ------------------------
    --  Mist of Pandaria  --
    ------------------------
    ["Tsulong"] = 62442,
    ["Lei Shi"] = 62983,
    
    ["Wind Lord Mel'jarak"] = 62397,
    ["Amber-Shaper Un'sok"] = 62511,
    ["Grand Empress Shek'zeer"] = 62837,
	
	["Immerseus"] = 71543,
	["Spoils of Pandaria"] = 71889,		-- ID of ... something
    
}


--------------------------------
--  ID-List of ignored Items  --
--------------------------------
MRT_IgnoredItemIDList = {
    -- Emblems of...
    [40752] = true,     -- ...Heroism
    [40753] = true,     -- ...Valor
    [45624] = true,     -- ...Conquest
    [47241] = true,     -- ...Triumph
    [49426] = true,     -- ...Frost
    
    -- Gems
    [36931] = true,     -- Ametrine
    [36919] = true,     -- Cardinal Ruby
    [36928] = true,     -- Dreadstone
    [36934] = true,     -- Eye of Zul
    [36922] = true,     -- King's Amber
    [36925] = true,     -- Majestic Zircon
    
    -- Shards
    [20725] = true,     -- Nexus Crystal
    [22450] = true,     -- Void Crystal
    [34057] = true,     -- Abyss Crystal
    [52722] = true,     -- Maelstrom Crystal
    [74248] = true,     -- Sha Crystal
    [115502] = true,    -- Small Luminous Shard
    [111245] = true,    -- Luminous Shard
    [115504] = true,    -- Fractured Temporal Crystal
    [113588] = true,    -- Temporal Crystal
    
    -- Sigils of...
    [87208] = true,     -- Sigil of Power
    [87209] = true,     -- Sigil of Wisdom
    
    -- Wrathion Legendary Questline
    [87210] = true,     -- Chimera of Fear
    [94593] = true,     -- Secrets of the Empire
    [94594] = true,     -- Titan Runestones
    [94867] = true,     -- Heart of the Thunder King
    
    -- WoD Legendary Questline
    [115280] = true,    -- Abrogator Stone
    [115288] = true,    -- Felbreaker's Tome
    [115289] = true,    -- Sigil of the Sorcerer King
    [115494] = true,    -- Draenic Thaumaturgical Orb
    [127115] = true,    -- Tome of Chaos
    
    -- WoD Garrison Follower Upgrades
    [114131] = true,    -- Power Overrun Weapon Enhancement
    [114822] = true,    -- Heavily Reinforced Armor Enhancement
    [114622] = true,    -- Goredrenched Weaponry
    [114746] = true,    -- Goredrenched Armor Set
    
    -- Rogue stuff
    [113007] = true,    -- Magma-Infused War Beads
    
    -- Legion Questitems
    [141303] = true,    -- Essence of Clarity (normal)
    [141304] = true,    -- Essence of Clarity (heroic)
    [141305] = true,    -- Essence of Clarity (mythic)
    [143656] = true,    -- Echo of Time (normal)
    [143657] = true,    -- Echo of Time (heroic)
    [143658] = true,    -- Echo of Time (mythic)
    [151248] = true,    -- Fragment of the Guardian's Seal
    [151249] = true,    -- Fragment of the Guardian's Seal
    [151250] = true,    -- Fragment of the Guardian's Seal
	[152902] = true, 	-- Rune of Passage (normal)
	[152906] = true, 	-- Rune of Passage (heroic)
	[152907] = true, 	-- Rune of Passage (mythic)
	[152908] = true, 	-- Sigil of the Dark Titan (normal)
	[152909] = true, 	-- Sigil of the Dark Titan (heroic)
	[152910] = true, 	-- Sigil of the Dark Titan (mythic)
    
    -- BfA Crafting
    [162461] = true,    -- Sanguicell
    [165703] = true,    -- Breath of Bwonsamdi
    [169694] = true,    -- Aqueous Reliquary (Eternal Palace)
    
}


--------------------------------------------------
--  Localized text blocks for attendance check  --
--------------------------------------------------
local MRT_PreformattedTimerText = string.gsub(MRT_L.Core["GuildAttendanceRemainingTimeText"], "%%d", "<<TIME>>");
local MRT_PreformattedTriggerText = string.format(MRT_L.Core["GuildAttendanceAnnounceText2"], "<<TRIGGER>>");
local MRT_PreformattedBossText = string.format(MRT_L.Core["GuildAttendanceBossDownText"], "<<BOSS>>");
MRT_GA_TEXT_CHARNAME_BOSS = "********************".."\n".."MRT: "..MRT_PreformattedBossText.." "..MRT_L.Core["GuildAttendanceAnnounceText"].."\n".."MRT: "..MRT_PreformattedTimerText.."\n".."********************"
MRT_GA_TEXT_CHARNAME_NOBOSS = "********************".."\n".."MRT: "..MRT_L.Core["GuildAttendanceAnnounceText"].."\n".."MRT: "..MRT_PreformattedTimerText.."\n".."********************"
MRT_GA_TEXT_TRIGGER_BOSS = "********************".."\n".."MRT: "..MRT_PreformattedBossText.." "..MRT_PreformattedTriggerText.."\n".."MRT: "..MRT_PreformattedTimerText.."\n".."********************"
MRT_GA_TEXT_TRIGGER_NOBOSS = "********************".."\n".."MRT: "..MRT_PreformattedTriggerText.."\n".."MRT: "..MRT_PreformattedTimerText.."\n".."********************"


--------------------------------------------------
--  Table for converting mapIDs to instanceIDs  --
--------------------------------------------------
mrt.DBConvertMapToInstanceList = {
    -- Wrath of the Lich King
    [527] = 616,        -- The Eye of Eternity
    [531] = 615,        -- The Obsidian Sanctum
    [532] = 624,        -- Vault of Archavon
    [535] = 533,        -- Naxxramas
    [529] = 603,        -- Ulduar
    [543] = 649,        -- Trial of the Crusader
    [718] = 249,        -- Onyxia's Lair
    [604] = 631,        -- Icecrown Citadel
    [609] = 724,        -- The Ruby Sanctum
    -- Cataclysm       
    [752] = 757,        -- Baradin Hold
    [754] = 669,        -- Blackwing Descent
    [758] = 671,        -- The Bastion of Twilight
    [773] = 754,        -- Throne of the Four Winds
    [800] = 720,        -- Firelands
    [824] = 967,        -- Dragon Soul
    -- Mists of Pandaria
    [886] = 996,        -- Terrace of Endless Spring
    [896] = 1008,       -- Mogu'shan Vaults
    [897] = 1009,       -- Heart of Fear
    [930] = 1098,       -- Throne of Thunder
	[953] = 1136,		-- Siege of Orgrimmar
    -- Warlords of Draenor
    [994] = 1228,       -- Highmaul
    [988] = 1205,       -- Blackrock Foundry
    [1026] = 1448,      -- Hellfire Citadel
    -- Legion
    [1094] = 1520,      -- The Emerald Nightmare
    [1114] = 1648,      -- Trial of Valor
    [1088] = 1530,      -- The Nighthold
    [1147] = 1676,      -- Tomb of Sargeras
	[1188] = 1712,		-- Antorus
}
