-- *********************************************************
-- **           Mizus Raid Tracker - Constants            **
-- **           <http://nanaki.affenfelsen.de>            **
-- *********************************************************
--

MRT_InstanceDifficultyTable = {
    [1] = "10 Normal",              -- Note: also 5 Normal / 40 player raid
    [2] = "25 Normal",              -- Note: also 5 Heroic
    [3] = "10 Heroic",
    [4] = "25 Heroic",
}

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
    -- Wrath of the Lich King
    [527] = true,       -- The Eye of Eternity
    [531] = true,       -- The Obsidian Sanctum
    [532] = true,       -- Vault of Archavon
    [535] = true,       -- Naxxramas
    [529] = true,       -- Ulduar
    [543] = true,       -- Trial of the Crusader
    [718] = true,       -- Onyxia's Lair
    [604] = true,       -- Icecrown Citadel
    [609] = true,       -- The Ruby Sanctum
    -- Cataclysm
    [752] = true,       -- Baradin Hold
    [754] = true,       -- Blackwing Descent
    [758] = true,       -- The Bastion of Twilight
    [773] = true,       -- Throne of the Four Winds
    [800] = true,       -- Firelands
    [824] = true,       -- Dragon Soul
    -- Mists of Pandaria
    [886] = true,       -- Terrace of Endless Spring
    [896] = true,       -- Mogu'shan Vaults
    [897] = true,       -- Heart of Fear
    [930] = true,       -- Throne of Thunder
	[953] = true,		-- Siege of Orgrimmar
}

MRT_LegacyRaidZonesPanadria = {
    [886] = true,       -- Terrace of Endless Spring
    [896] = true,       -- Mogu'shan Vaults
    [897] = true,       -- Heart of Fear
    [930] = true,       -- Throne of Thunder
	[953] = true,		-- Siege of Orgrimmar
}

MRT_LegacyRaidZonesCataclysm = {
    [752] = true,       -- Baradin Hold
    [754] = true,       -- Blackwing Descent
    [758] = true,       -- The Bastion of Twilight
    [773] = true,       -- Throne of the Four Winds
    [800] = true,       -- Firelands
    [824] = true,       -- Dragon Soul
}

MRT_LegacyRaidZonesWotLK = {
    [527] = true,       -- The Eye of Eternity
    [531] = true,       -- The Obsidian Sanctum
    [532] = true,       -- Vault of Archavon
    [535] = true,       -- Naxxramas
    [529] = true,       -- Ulduar
    [543] = true,       -- Trial of the Crusader
    [718] = true,       -- Onyxia's Lair
    [604] = true,       -- Icecrown Citadel
    [609] = true,       -- The Ruby Sanctum
}

MRT_LegacyRaidZonesBC = {
    [799] = true,       -- Karazhan
    [776] = true,       -- Gruul's Lair
    [779] = true,       -- Magtheridon's Lair
    [780] = true,       -- Serpentshrine Cavern
    [782] = true,       -- Tempest Keep
    [775] = true,       -- Hyjal Summit
    [796] = true,       -- Black Temple
    [789] = true,       -- Sunwell Plateau
}

MRT_LegacyRaidZonesClassic = {
    [755] = true,       -- Blackwing Lair
    [696] = true,       -- Molten Core
    [717] = true,       -- Ruins of Ahn'Qiraj
    [766] = true,       -- Temple of Ahn'Qiraj
}

MRT_PvPRaids = {
    [752] = true,       -- Baradin Hold
    [532] = true,       -- Vault of Archavon
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
    
    -- Naxxramas
    [15956] = "Anub'Rekhan",
    [15953] = "Grand Widow Faerlina",
    [15952] = "Maexxna",
    [15954] = "Noth the Plaguebringer",
    [15936] = "Heigan the Unclean",
    [16011] = "Loatheb",
    [16061] = "Instructor Razuvious",
    [16060] = "Gothik the Harvester",
        -- Four Horsemen not supported - boss event with multiple NPCs without shared health pool and without boss yell
    [16028] = "Patchwerk",
    [15931] = "Grobbulus",
    [15932] = "Gluth",
    [15928] = "Thaddius",
    [15989] = "Sapphiron",
    [15990] = "Kel'Thuzad",
    
    -- The Obsidian Sanctum
    [28860] = "Sartharion",
    
    -- Eye of Eternity
    [28859] = "Malygos",
    
    -- Archavon's Chamber
    [31125] = "Archavon the Stone Watcher",
    [33993] = "Emalon the Storm Watcher",
    [35013] = "Koralon the Flame Watcher",
    [38433] = "Toravon the Ice Watcher",
    
    -- Ulduar
    [33113] = "Flame Leviathan",
    [33118] = "Ignis the Furnace Master",
    [33186] = "Razorscale",
    [33293] = "XT-002 Deconstructor",
        -- The Assembly of Iron will need bossyell for correct tracking
    [32930] = "Kologarn",
    [33515] = "Auriaya",
        -- Freya, Hodir, Mimiron and Thorim will need bossyells - they don't die
    [33271] = "General Vezax",
    [33288] = "Yogg-Saron",
        -- Algalon needs a bossyell - he doesn't die
        
    -- Onyxias Lair
    [10184] = "Onyxia",
    
    -- Trial of the Crusader
    [34797] = "Icehowl",                        -- Northrend Beasts, third boss
    [34780] = "Lord Jaraxxus",
        -- Faction Champions will need bossyell
    [34497] = "The Twin Val'kyr",               -- ID of Fjola Lightbane
    [34564] = "Anub'arak",    
    
    -- Icecrown Citadel
    [36612] = "Lord Marrowgar",
    [36855] = "Lady Deathwhisper",
        -- Gunship Battle will need bossyell
    [37813] = "Deathbringer Saurfang",
    [36626] = "Festergut",
    [36627] = "Rotface",
    [36678] = "Professor Putricide",       
    [37972] = "Blood Prince Council",           -- ID of Keleseth
    [37955] = "Blood-Queen Lana'thel",
        -- Dreamwalker will need bossyell
    [36853] = "Sindragosa",
    [36597] = "The Lich King",
    
    -- The Ruby Sanctum
    -- Tracking of Halion via BossIDs disabled, because of missing UNIT_DIED-Events in Twilight Realm / Detection switched to bossyell
    -- [39863] = "Halion",                      -- according to wowhead
    
    -----------------
    --  Cataclysm  --
    -----------------
    -- Baradin Hold
    [47120] = "Argaloth",
    [52363] = "Occu'thar",
    [55869] = "Alizabal",
    
    -- Blackwing Descent
    [41570] = "Magmaw",
    [42180] = "Omnotron Defense System",        -- ID of Toxitron   - Omnotron Defense System may need bossyell
    [41378] = "Maloriak",
    [41442] = "Atramedes",
    [43296] = "Chimaeron",
    [41376] = "Nefarian",
    
    -- The Bastion of Twilight
    [44600] = "Halfus Wyrmbreaker",
    [45992] = "Valiona and Theralion",          -- ID of Valiona    - Valiona & Theralion - Twin drakes with shared health pool
    [43735] = "Ascendant Council",              -- ID of Elementium Monstrosity
    [43324] = "Cho'gall",
    [45213] = "Sinestra",
    
    -- Throne of the Four Winds
        -- Conclave of Wind needs bossyell
    [46753] = "Al'Akir",
    
    -- Firelands
    [52498] = "Beth'tilac",
    [52558] = "Lord Rhyolith",
    [52530] = "Alysrazor",
    [53691] = "Shannox",
    [53494] = "Baleroc",
    [52571] = "Majordomo Staghelm",
    [52409] = "Ragnaros",
    
    -- Dragon Soul
    [55265] = "Morchok",
    [55308] = "Warlord Zonozz",
    [55312] = "Yor'sahj the Unsleeping",
    [55689] = "Hagara the Stormbinder",
    [55294] = "Ultraxion",
    [56427] = "Warmaster Blackhorn",
    [53879] = "Spine of Deathwing",   
        -- Madness of Deathwing needs SpellID
        
    -------------------------
    --  Mists of Pandaria  --
    -------------------------
    -- Mogu'shan Vaults
    [60047] = "The Stone Guard",
    [60009] = "Feng the Accursed",
    [60143] = "Gara'jal the Spriritbinder",
    [60708] = "The Spirit Kings", -- Meng
	[60701] = "The Spirit Kings", -- Zian
	[60709] = "The Spirit Kings", -- Qiang
	[60710] = "The Spirit Kings", -- Subetai
    [60410] = "Elegon",
    [60399] = "Will of the Emperor", -- qin-xi
	[60400] = "Will of the Emperor", -- jan-xi
    
    -- Terrace of Endless Spring
    [60583] = "Protectors of the Endless", -- Kaolan
	[60586] = "Protectors of the Endless", -- Asani
	[60585] = "Protectors of the Endless", -- Regail
        -- Tsulong via boss yell
        -- Lei Shi via boss yell
    [60999] = "Sha of Fear",
    
    -- Heart of Fear
    [62980] = "Imperial Vizier Zor'lok",
    [62543] = "Blade Lord Ta'yak",
    [62164] = "Garalon",
    [62397] = "Wind Lord Mel'jarak",
    [62511] = "Amber-Shaper Un'sok",
    [62837] = "Grand Empress Shek'zeer",

    -- Throne of Thunder
    -- Last Stand of the Zandalari
    [69465] = "Jin'rokh the Breaker",
    [68476] = "Horridon",
    [69134] = "Council of Elders", 		-- kazra'jin
    [69078] = "Council of Elders", 		-- sul
    [69131] = "Council of Elders", 		-- Malakk
    [69132] = "Council of Elders", 		-- Marli
    -- Forgotten Depths
    [67977] = "Tortos",
    [68065] = "Megaera",
    [69712] = "Ji-Kun",
    -- Halls of Flesh-Shaping
    [68036] = "Durumu the Forgotten",
    [69017] = "Primordius",
    [69427] = "Dark Animus",
    -- Pinnacle of Storms
    [68078] = "Iron Qon", 				-- <Master of Quilen>
    [68905] = "Twin Consorts", 			-- Lu'lin <Mistress of Solitude>, Twin Consorts
    [68904] = "Twin Consorts", 			-- Suen <Mistress of Anger>, Twin Consorts
    [68397] = "Lei Shen", 				-- <The Thunder King>
		-- Ra-den <Fallen Keeper of Storms> via boss yell (doesn't die)
	-- Siege of Orgrimmar
		-- Immerseus via boss yell (doesn't die)
		-- The Fallen Protectors via boss yell - they don't die
	[72276] = "Norushen", 				-- ID of Amalgam of Corruption
	[71734] = "Sha of Pride",
	[72249] = "Galakras",
	[71466] = "Iron Juggernaut",
	[71858] = "Kor'kron Dark Shaman", 	-- ID of Wavebinder Kardris - shared healthpool
	[71515] = "General Nazgrim",
	[71454] = "Malkorok",
		-- Spoils of Pandaria via boss yell (no boss)
	[71529] = "Thok the Bloodthirsty",
	[71504] = "Siegecrafter Blackfuse",
	[71152] = "Paragons of the Klaxxi",	-- ID of Skeer the Bloodseeker
	[71153] = "Paragons of the Klaxxi", -- ID of Hisek the Swarmkeeper
	[71154] = "Paragons of the Klaxxi", -- ID of Ka'roz the Locust
	[71155] = "Paragons of the Klaxxi", -- ID of Korven the Prime
	[71156] = "Paragons of the Klaxxi", -- ID of Kaz'tik the Manipulator
	[71157] = "Paragons of the Klaxxi", -- ID of Xaril the Poisoned Mind
	[71158] = "Paragons of the Klaxxi", -- ID of Rik'kal the Dissector
	[71160] = "Paragons of the Klaxxi", -- ID of Iyyokuk the Lucid
	[71161] = "Paragons of the Klaxxi", -- ID of Kil'ruk the Wind-Reaver
	[71865] = "Garrosh Hellscream",
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


-- Boss rename list - When a boss kill with one of the below mentioned IDs is detected, then MRT will change the boss name given by
-- the combat log with the corresponding name entered below (e.g.: 37972: Prince Keleseth -> Blood Prince Council)
-- The resulting english name will be run through LibBabble-Boss-3.0 in order to get a localized name.
MRT_BossRenameList = {
    ------------------------------
    --  Wrath of the Lich King  --
    ------------------------------
    -- Trial of the Crusader
    [34497] = "The Twin Val'kyr",
    -- Icecrown Citadel
    [37972] = "Blood Prince Council",
    
    -----------------
    --  Cataclysm  --
    -----------------
    -- Blackwing Descent
    [42180] = "Omnotron Defense System",
    -- The Bastion of Twilight
    [45992] = "Valiona and Theralion",
    [43735] = "Ascendant Council",
    -- Throne of the Four Winds
    [45871] = "Conclave of Wind",
    -- Dragon Soul
    [53879] = "Spine of Deathwing",   
    [56173] = "Madness of Deathwing",
  
}


-- The reverse boss ID list is needed for bosses, that are tracked by a boss yell.
MRT_ReverseBossIDList = {
    ------------------------------
    --  Wrath of the Lich King  --
    ------------------------------
    -- Ulduar
    ["Iron Council"] = 32857,
    ["Hodir"] = 32845,
    ["Thorim"] = 32865,
    ["Freya"] = 32906,
    ["Mimiron"] = 33350,
    ["Algalon the Observer"] = 32871,
    -- Icecrown Citadel
    ["Valithria Dreamwalker"] = 36789,
    -- Ruby Sanctum
    ["Halion"] = 39863,
    
    -----------------
    --  Cataclysm  --
    -----------------
    ["Conclave of Wind"] = 45871,

    ------------------------
    --  Mist of Pandaria  --
    ------------------------
    ["Tsulong"] = 62442,
    ["Lei Shi"] = 62983,
    
    ["Wind Lord Mel'jarak"] = 62397,
    ["Amber-Shaper Un'sok"] = 62511,
    ["Grand Empress Shek'zeer"] = 62837,
	
	["Immerseus"] = 71543,
	["Fallen Protectors"] = 71475,		-- ID of Rook Stonetoe
	["Spoils of Pandaria"] = 71889,		-- ID of ... something
}


--------------------------------
--  ID-List of ignored Items  --
--------------------------------
MRT_IgnoredItemIDList = {
    -- Emblems of...
    [40752] = true,  -- ...Heroism
    [40753] = true,  -- ...Valor
    [45624] = true,  -- ...Conquest
    [47241] = true,  -- ...Triumph
    [49426] = true,  -- ...Frost
    
    -- Gems
    [36931] = true,  -- Ametrine
    [36919] = true,  -- Cardinal Ruby
    [36928] = true,  -- Dreadstone
    [36934] = true,  -- Eye of Zul
    [36922] = true,  -- King's Amber
    [36925] = true,  -- Majestic Zircon
    
    -- Shards
    [20725] = true,  -- Nexus Crystal
    [22450] = true,  -- Void Crystal
    [34057] = true,  -- Abyss Crystal
    [52722] = true,  -- Maelstrom Crystal
    [74248] = true,  -- Sha Crystal
    
    -- Sigils of...
    [87208] = true,  -- Sigil of Power
    [87209] = true,  -- Sigil of Wisdom
    
    -- Wrathion Legendary Questline
    [87210] = true,  -- Chimera of Fear
    [94593] = true,  -- Secrets of the Empire
    [94594] = true,  -- Titan Runestones
    [94867] = true,  -- Heart of the Thunder King
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
