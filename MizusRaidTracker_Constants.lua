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
}

MRT_PvPRaids = {
    ["Vault of Archavon"] = true;
}

-----------------------------------
--  ID-List of trackable Bosses  --
-----------------------------------
MRT_BossIDList = {
    ------------------------------------
    --  Dalaran - Added for Debuging  --
    ------------------------------------
    --[721] = "Rabbit",
    --[32428] = "Underbelly Rat",
    
    -----------------
    --  Naxxramas  --
    -----------------
    [15956] = "Anub'Rekhan",
    [15953] = "Grand Widow Faerlina",
    [15952] = "Maexxna",
    [15954] = "Noth the Plaguebringer",
    [15936] = "Heigan the Unclean",
    [16011] = "Loatheb",
    [16061] = "Instructor Razuvious",
    [16060] = "Gothik the Harvester",
        -- Four Horsemen will need bossyell
    [16028] = "Patchwerk",
    [15931] = "Grobbulus",
    [15932] = "Gluth",
    [15928] = "Thaddius",
    [15989] = "Sapphiron",
    [15990] = "Kel'Thuzad",
    
    ----------------------------
    --  The Obsidian Sanctum  --
    ----------------------------
    [28860] = "Sartharion",
    
    -----------------------
    --  Eye of Eternity  --
    -----------------------
    [28859] = "Malygos",
    
    --------------------------
    --  Archavon's Chamber  --
    --------------------------
    [31125] = "Archavon the Stone Watcher",
    [33993] = "Emalon the Storm Watcher",
    [35013] = "Koralon the Flame Watcher",
    [38433] = "Toravon the Ice Watcher",
    
    --------------
    --  Ulduar  --
    --------------
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
        
    --------------------
    --  Onyxias Lair  --
    --------------------
    [10184] = "Onyxia",
    
    -----------------------------
    --  Trial of the Crusader  --
    -----------------------------
    [34797] = "Icehowl",                  -- Northrend Beasts, third boss
    [34780] = "Lord Jaraxxus",
        -- Faction Champions will need bossyell
        -- Val'kyr Twins will need bossyell for "correct" naming - each Val'kyr alone is trackable
    [34564] = "Anub'arak",    
    
    ------------------------
    --  Icecrown Citadel  --
    ------------------------
    [36612] = "Lord Marrowgar",
    [36855] = "Lady Deathwhisper",
        -- Gunship Battle will need bossyell
    [37813] = "Deathbringer Saurfang",
    [36626] = "Festergut",
    [36627] = "Rotface",
    [36678] = "Professor Putricide",       
        -- Blood Prince Council will need bossyell for "correct" naming - Prince Keleseth alone is trackable
    [37955] = "Blood-Queen Lana'thel",
        -- Dreamwalker will need bossyell
    [36853] = "Sindragosa",
    [36597] = "The Lich King",
    
    ------------------------
    --  The Ruby Sanctum  --
    ------------------------
--  Tracking of Halion via BossIDs disabled, because of missing UNIT_DIED-Events in Twilight Realm / Detection switched to bossyell
--    [39863] = "Halion",                     -- according to wowhead (possibly the true ID)
--    [39864] = "Halion",                     -- according to armory
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
    [34057] = true,  -- Abyss Crystal
}

----------------------------------
--  Iron Council Instancecheck  --
----------------------------------
function MRT_IsInstanceUlduar(boss)
    local instanceInfoName = GetInstanceInfo();
    if (MRT_L.Raidzones[instanceInfoName] == MRT_L.Raidzones["Ulduar"]) then
        return boss;
    else
        return nil;
    end
end