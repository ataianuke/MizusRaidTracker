-- *********************************************************
-- **           Mizus Raid Tracker - Constants            **
-- **            <ENTER URL HERE>            **
-- *********************************************************
--

MRT_InstanceDifficultyTable = {
    [1] = "10 Normal",              -- Note: also 5 Normal / 40 player raid
    [2] = "25 Normal",              -- Note: also 5 Heroic
    [3] = "10 Heroic",
    [4] = "25 Heroic",
}

-----------------------------------
--  ID-List of trackable Bosses  --
-----------------------------------
MRT_BossIDList = {
    ------------------------------------
    --  Dalaran - Added for Debuging  --
    ------------------------------------
    [721] = "Rabbit",
    [32428] = "Underbelly Rat",
    
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
    
    ------------------------
    --  Obsidian Sanctum  --
    ------------------------
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
    [34797] = "Icehowl",            -- Northrend Beasts, third boss
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
    [37755] = "Sindragosa",
    [29983] = "The Lich King",
}