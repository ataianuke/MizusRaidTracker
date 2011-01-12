-- *******************************************************
-- **            Mizus RaidTracker - Exports            **
-- **           <http://nanaki.affenfelsen.de>          **
-- *******************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall (2010-2011)
--
--    This file is part of Mizus RaidTracker.
--
--    Mizus RaidTracker is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as 
--    published by the Free Software Foundation, either version 3 of the 
--    License, or (at your option) any later version.
--
--    Mizus RaidTracker is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Mizus RaidTracker.  
--    If not, see <http://www.gnu.org/licenses/>.



--------------
--  Locals  --
--------------
local deformat = LibStub("LibDeformat-3.0");
local LBB = LibStub("LibBabble-Boss-3.0");
local LBBL = LBB:GetUnstrictLookupTable();
local LBZ = LibStub("LibBabble-Zone-3.0");
local LBZR = LBZ:GetReverseLookupTable();


------------------------------
--  export frame functions  --
------------------------------
function MRT_ExportFrame_Show(export)
    MRT_ExportFrame_EB:SetText(export)
    MRT_ExportFrame_EB:HighlightText();
    MRT_ExportFrame:Show();
end

function MRT_ExportFrame_Hide()
    MRT_ExportFrame:Hide();
end

------------------------
--  export functions  --
------------------------
-- MRT_CreateRaidExport:
-- - this function should work like a hub for all exports
-- - if additional export functions are added, implement an option to the option panel
--   to choose the export format
-- - this function shall then call the correct export function
-- arg usage: (int, nil, nil) = export complete raid
--            (int, int, nil) = export one boss
--            (int, nil, <H, N>) = export all hard-/normalmode events
--            (int, int, <H, N>) = -> will be treated as (int, int, nil)
function MRT_CreateRaidExport(raidID, bossID, difficulty)
    -- basic "catch bad args" routines
    -- check if bad raidID
    if (MRT_RaidLog[raidID] == nil) then return end;
    -- check if bad bossID
    if (bossID ~= nil) then
        if (MRT_RaidLog[raidID]["Bosskills"][bossID] == nil) then return end;
        difficulty = nil;
    end
    -- check if bad difficulty-setting
    if ((difficulty ~= nil) and (difficulty ~= "H") and (difficulty ~= "N")) then return end;
    -- Choose the correct export function here
    local dkpstring;
    -- 1: CTRT-compatible export
    if (MRT_Options["Export_ExportFormat"] == 1) then
        dkpstring = MRT_CreateCTRTClassicDKPString(raidID, bossID, difficulty);
    -- 2: EQDKP-Plus-XML
    elseif (MRT_Options["Export_ExportFormat"] == 2) then
        dkpstring = MRT_CreateEQDKPPlusXMLString(raidID, bossID, difficulty);
    -- 3: MLDKP 1.5
    elseif (MRT_Options["Export_ExportFormat"] == 3) then
        dkpstring = MRT_CreateMLDKP15ExportString(raidID, bossID, difficulty);
    -- 4: DKPBoard
    elseif (MRT_Options["Export_ExportFormat"] == 4) then
        dkpstring = MRT_CreateDKPBoardComExportString(raidID, bossID, difficulty);
    -- 5: plain text export
    elseif (MRT_Options["Export_ExportFormat"] == 5) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, nil);
    -- 6: BBCode formated export
    elseif (MRT_Options["Export_ExportFormat"] == 6) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, 1);
    -- 7: BBCode formated export with wowhead links
    elseif (MRT_Options["Export_ExportFormat"] == 7) then
        dkpstring = MRT_CreateTextExport(raidID, bossID, difficulty, 2);
    -- 8: CSS based HTML with wowhead links
    elseif (MRT_Options["Export_ExportFormat"] == 8) then
        dkpstring = MRT_CreateHTMLExport(raidID, bossID, difficulty)
    end
    -- Show the data export
    MRT_ExportFrame_Show(dkpstring);
end

-- complete rewrite of the old function based on the experience of newer functions
function MRT_CreateCTRTClassicDKPString(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- create generic functions for repeated blocks
    local function createBossInfoString(index, bossInfo, attendeeList)
        local bossXml = "<key"..index..">";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[bossInfo.Name] or bossInfo.Name).."</name>";
        else
            bossXml = bossXml.."<name>"..bossInfo.Name.."</name>";
        end
        bossXml = bossXml.."<difficulty>"..bossInfo.Difficulty.."</difficulty>";
        bossXml = bossXml.."<time>"..MRT_MakeEQDKP_Time(bossInfo.Date).."</time>";
        bossXml = bossXml.."<attendees>";
        if attendeeList then
            for i, name in ipairs(attendeeList) do
                bossXml = bossXml.."<key"..i.."><name>"..name.."</name></key"..i..">";
            end
        else
            for i, name in ipairs(bossInfo.Players) do
                bossXml = bossXml.."<key"..i.."><name>"..name.."</name></key"..i..">";
            end
        end
        bossXml = bossXml.."</attendees></key"..index..">";
        return bossXml;
    end
    local function createPlayerInfoString(index, name, realm)
        local playerInfoString = "<key"..index..">";
        playerInfoString = playerInfoString.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerInfoString = playerInfoString.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerInfoString = playerInfoString.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerInfoString = playerInfoString.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                playerInfoString = playerInfoString.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        playerInfoString = playerInfoString.."</key"..index..">";
        return playerInfoString;
    end
    local function createItemInfoString(index, itemInfo)
        local bossInfo = MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber];
        local itemXml = "<key"..index..">";
        itemXml = itemXml.."<ItemName>"..itemInfo.ItemName.."</ItemName>";
        itemXml = itemXml.."<ItemID>"..deformat(itemInfo.ItemString, "item:%s").."</ItemID>";
        itemXml = itemXml.."<Color>"..itemInfo.ItemColor.."</Color>";
        itemXml = itemXml.."<Count>"..itemInfo.ItemCount.."</Count>";
        itemXml = itemXml.."<Player>"..itemInfo.Looter.."</Player>";
        itemXml = itemXml.."<Costs>"..itemInfo.DKPValue.."</Costs>";
        itemXml = itemXml.."<Time>"..MRT_MakeEQDKP_Time(bossInfo.Date + index).."</Time>";
        itemXml = itemXml.."<Difficulty>"..bossInfo.Difficulty.."</Difficulty>";
        itemXml = itemXml.."<Boss>"..bossInfo.Name.."</Boss>";
        itemXml = itemXml.."<Note><![CDATA[";
        if itemInfo.Note then
            itemXml = itemXml..itemInfo.Note;
        end
        itemXml = itemXml.." - Zone: "..MRT_RaidLog[raidID]["RaidZone"].." - Boss: "..bossInfo.Name.." - "..itemInfo.DKPValue.." DKP]]>";
        itemXml = itemXml.."</Note></key"..index..">";
        return itemXml;
    end
    local function createJoinString(index, name, realm, joinTimeStamp)
        local joinXml = "<key"..index..">";
        joinXml = joinXml.."<player>"..name.."</player>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                joinXml = joinXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                joinXml = joinXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                joinXml = joinXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                joinXml = joinXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        joinXml = joinXml.."<time>"..MRT_MakeEQDKP_Time(joinTimeStamp).."</time>";
        joinXml = joinXml.."</key"..index..">";
        return joinXml;
    end
    local function createLeaveString(index, name, leaveTimeStamp)
        local leaveString = leaveString.."<key"..index..">";
        leaveString = leaveString.."<player>"..name.."</player>";
        leaveString = leaveString.."<time>"..MRT_MakeEQDKP_Time(leaveTimeStamp).."</time>";
        leaveString = leaveString.."</key"..index..">";
        return leaveString;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    if (bossID and bossID > 1) then raidStart = MRT_RaidLog[raidID]["Bosskills"][bossID - 1]["Date"] or MRT_RaidLog[raidID]["StartTime"]; end
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    local index = 1;
    -- starte creating string - header first
    local xml = "<RaidInfo>";
    xml = xml.."<key>"..MRT_MakeEQDKP_Time(raidStart).."</key>";
    xml = xml.."<realm>"..realm.."</realm>";
    xml = xml.."<start>"..MRT_MakeEQDKP_Time(raidStart).."</start>";
    xml = xml.."<end>"..MRT_MakeEQDKP_Time(raidStop).."</end>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<zone>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</zone>";
    else
        xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    -- player infos: gather all players, sort them, create player info once per player
    local playerList = {};
    -- prepare player information and join/leave times
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    elseif (MRT_Options["Export_CTRT_RLIPerBossAttendanceFix"]) then
        -- in the "one raid per boss"-setting, the RLI slices the export in subraids.
        -- each player needs to have 50% attendance in each raid slice to be a valid attendee
        -- attendance fix solution:
        -- export all players, who have attended all bosses, with 100% attendance time.
        -- for all other players, create a set of join/leave-times for each time slice
        -- so, lets start - scan raid attendees first
        local attendanceCount = {};
        local lastBossTimeStamp;
        local joinLeavePair;
        for key, playerInfo in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not attendanceCount[playerInfo.Name]) then
                attendanceCount[playerInfo.Name] = 0;
            end
        end
        -- if we have no bosses, than #BossKills = 0 - convenient.
        -- now count attendance for each boss
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, playerName in ipairs(bossInfo["Players"]) do
                if (not attendanceCount[playerName]) then
                    attendanceCount[playerName] = 1;
                else
                    attendanceCount[playerName] = attendanceCount[playerName] + 1;
                end
            end
        end
        -- and the last step, create join/leave-pairs. if 100% attendance, create one join/leave-pair. if not, make one for each attended boss
        for playerName, bossKillCount in pairs(attendanceCount) do
            if (bossKillCount == #MRT_RaidLog[raidID]["Bosskills"]) then
                playerList[playerName] = { { Join = raidStart, Leave = raidStop, }, };
            else
                lastBossTimeStamp = raidStart;
                for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                    for j, attendeeName in ipairs(bossInfo["Players"]) do
                        if (attendeeName == playerName and raidStart <= lastBossTimeStamp) then
                            joinLeavePair = { Join = lastBossTimeStamp, Leave = (bossInfo.Date + 10), };
                            if (not playerList[playerName]) then playerList[playerName] = {}; end
                            tinsert(playerList[playerName], joinLeavePair);
                        end
                    end
                    lastBossTimeStamp = bossInfo.Date + 20;
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee - if only one boss is exported, watch out for changed raid start
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            if (raidStart <= playerTimes.Join) then
                joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            elseif (raidStart < (playerTimes.Leave or now) ) then
                joinLeavePair = { Join = raidStart, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee and raidStart <= bossInfo.Date) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- player data complete
    -- prepare a list with sorted player names to fill the boss info
    local sortedPlayerList = {};
    for name, joinLeaveTable in pairs(playerList) do
        tinsert(sortedPlayerList, name);
    end
    table.sort(sortedPlayerList);
    -- player list sorted - create playerInfo data
    xml = xml.."<PlayerInfos>";
    for i, name in ipairs(sortedPlayerList) do
        xml = xml..createPlayerInfoString(i, name, realm);
    end
    xml = xml.."</PlayerInfos>";
    -- next: BossKillInfo
    local isFirstBoss = true;
    local exportedBosses = {};
    index = 1;
    if (bossID) then
        xml = xml.."<BossKills>";
        if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
            xml = xml..createBossInfoString(1, MRT_RaidLog[raidID]["Bosskills"][bossID], sortedPlayerList);
        else
            xml = xml..createBossInfoString(1, MRT_RaidLog[raidID]["Bosskills"][bossID], nil);
        end
        isFirstBoss = false;
        tinsert(exportedBosses, bossID);
    else
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if ( (not difficulty) or ((bossInfo["Difficulty"] < 3) and difficulty == "N") or ((bossInfo["Difficulty"] > 2) and difficulty == "H") ) then
                if (isFirstBoss) then 
                    xml = xml.."<BossKills>";
                    isFirstBoss = false;
                end
                if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
                    xml = xml..createBossInfoString(index, bossInfo, sortedPlayerList);
                else
                    xml = xml..createBossInfoString(index, bossInfo, nil);
                end
                index = index + 1;
                tinsert(exportedBosses, i);
            end
        end
    end
    if (not isFirstBoss) then
        xml = xml.."</BossKills>";
    end
    -- extra note entry:
    xml = xml.."<note><![CDATA[ - Zone: "..MRT_RaidLog[raidID]["RaidZone"].."]]></note>";
    -- next: Join data
    index = 1;
    xml = xml.."<Join>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, joinLeaveEntry in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(index, name, realm, joinLeaveEntry.Join);
            index = index + 1;
        end
    end
    xml = xml.."</Join>";
    -- next: Leave data
    xml = xml.."<Leave>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, joinLeaveEntry in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(index, name, realm, joinLeaveEntry.Leave);
            index = index + 1;
        end
    end
    xml = xml.."</Leave>";
    -- and last: Loot
    index = 1;
    -- prepare a simple lookup-table:
    local exportedBossesLookup = {};
    for i, bossNum in ipairs(exportedBosses) do
        exportedBossesLookup[bossNum] = true;
    end
    xml = xml.."<Loot>";
    for lootId, lootInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (exportedBossesLookup[lootInfo.BossNumber]) then
            xml = xml..createItemInfoString(index, lootInfo);
            index = index + 1;
        end
    end
    -- apply EQdkp CTRT-Import-Plugin-Fix if enabled
    if (MRT_Options["Export_CTRT_AddPoorItem"]) then
        local lootInfo = {
            ["ItemLink"] = "|cff9d9d9d|Hitem:35788:0:0:0:0:0:0:0:0|h[Destroyed Magic Item]|h|r",
            ["ItemString"] = "item:35788:0:0:0:0:0:0:0:0",
            ["ItemId"] = 35788,
            ["ItemName"] = "Destroyed Magic Item",
            ["ItemColor"] = "ff9d9d9d",
            ["ItemCount"] = 1,
            ["Looter"] = "disenchanted",
            ["DKPValue"] = 0,
        };
        for i, bossNum in ipairs(exportedBosses) do
            lootInfo.BossNumber = bossNum;
            lootInfo.Time = MRT_RaidLog[raidID]["Bosskills"][bossNum]["Date"] + index;              -- a little random seed to prevent an item with bosskill time
            xml = xml..createItemInfoString(index, lootInfo);
            index = index + 1;
        end
    end
    xml = xml.."</Loot>";
    -- end
    xml = xml.."</RaidInfo>";
    return xml;
end

-- EQdkp-Plus-XML export format
function MRT_CreateEQDKPPlusXMLString(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- start to create generic functions for repeated blocks
    local function createBossInfoString(raidID, bossID)
        local bossXml = "<bosskill>";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).."</name>";
        else
            bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        end
        bossXml = bossXml.."<time>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"].."</time>";
        bossXml = bossXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        bossXml = bossXml.."</bosskill>";
        return bossXml;
    end
    -- joinLeaveTable is a set of joinLeave Timestamps - example: joinLeaveTable = { {["Join"] = timestamp, ["Leave"] = timestamp}, {["Join"] = timestamp, ["Leave"] = timestamp} }
    local function createPlayerInfoString(name, realm, joinLeaveTable)
        if (#joinLeaveTable == 0) then return ""; end
        local playerXml = "<member>";
        playerXml = playerXml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerXml = playerXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Guild"]) then
                playerXml = playerXml.."<guild>"..MRT_PlayerDB[realm][name]["Guild"].."</guild>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerXml = playerXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerXml = playerXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                playerXml = playerXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        playerXml = playerXml.."<times>";
            for i, val in ipairs(joinLeaveTable) do
                playerXml = playerXml.."<time type='join'>"..val["Join"].."</time>";
                playerXml = playerXml.."<time type='leave'>"..val["Leave"].."</time>";
            end
        playerXml = playerXml.."</times></member>";
        return playerXml;
    end
    local function createItemInfoString(raidID, itemID)
        local bossID = MRT_RaidLog[raidID]["Loot"][itemID]["BossNumber"];
        local itemXml = "<item>";
        itemXml = itemXml.."<name>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemName"].."</name>";
        itemXml = itemXml.."<time>"..MRT_RaidLog[raidID]["Loot"][itemID]["Time"].."</time>";
        itemXml = itemXml.."<member>"..MRT_RaidLog[raidID]["Loot"][itemID]["Looter"].."</member>";
        itemXml = itemXml.."<itemid>"..deformat(MRT_RaidLog[raidID]["Loot"][itemID]["ItemString"], "item:%s").."</itemid>";
        itemXml = itemXml.."<cost>"..MRT_RaidLog[raidID]["Loot"][itemID]["DKPValue"].."</cost>";
        if MRT_RaidLog[raidID]["Loot"][itemID]["Note"] then
            itemXml = itemXml.."<note>"..MRT_RaidLog[raidID]["Loot"][itemID]["Note"].."</note>";
        end
        itemXml = itemXml.."<boss>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</boss>";
        itemXml = itemXml.."</item>";
        return itemXml;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    if (bossID and bossID > 1) then raidStart = MRT_RaidLog[raidID]["Bosskills"][bossID - 1]["Date"] or MRT_RaidLog[raidID]["StartTime"]; end
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    -- start creating head
    local xml = "<raidlog><head><export><name>EQdkp Plus XML</name><version>1.0</version></export>";
    xml = xml.."<tracker><name>"..MRT_ADDON_TITLE.."</name><version>"..MRT_ADDON_VERSION.."</version></tracker>";
    xml = xml.."<gameinfo><game>World of Warcraft</game><language>"..GetLocale().."</language><charactername>"..UnitName("Player").."</charactername></gameinfo></head>";
    -- head finished. now the raid data - first the zone information
    xml = xml.."<raiddata><zones><zone>";
    xml = xml.."<enter>"..raidStart.."</enter><leave>"..raidStop.."</leave>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<name>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</name>";
    else
        xml = xml.."<name>"..MRT_RaidLog[raidID]["RaidZone"].."</name>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    xml = xml.."</zone></zones>";
    -- now the bosskills
    xml = xml.."<bosskills>";
    if (not bossID) then
        -- if no bossID is given, export complete raid or all boss of a specific difficulty
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if (not difficulty) then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] < 3) and difficulty == "N") then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createBossInfoString(raidID, i);
            end
        end
    else
        -- export a specific boss
        xml = xml..createBossInfoString(raidID, bossID);
    end
    xml = xml.."</bosskills>";
    -- now the member data
    xml = xml.."<members>";
    local playerList = {};
    -- prepare player information
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    elseif (MRT_Options["Export_EQDKP_RLIPerBossAttendanceFix"]) then
        --[[
        in the "one raid per boss"-setting, the RLI slices the export in subraids.
        each player needs to have 50% attendance in each raid slice to be a valid attendee
        attendance fix solution:
        export all players, who have attended all bosses, with 100% attendance time.
        for all other players, create a set of join/leave-times for each time slice
        --]]
        --[[
        additionally (01/12/2011):
        If the time between raidStart and the first bosskill is large enough, add a temporary first bosskill to allow for an extra
        MRT_DELAY_FIRST_RAID_ENTRY_FOR_RLI_BOSSATTENDANCE_FIX_DATA seconds attendance window for extra start DKP.
        --]]
        local tempBossExists = false;
        if (#MRT_RaidLog[raidID]["Bosskills"] > 0 and raidStart + (MRT_DELAY_FIRST_RAID_ENTRY_FOR_RLI_BOSSATTENDANCE_FIX_DATA * 3) < MRT_RaidLog[raidID]["Bosskills"][1]["Date"]) then
            local tempBossAttendeesByName = {}
            for key, playerInfo in pairs(MRT_RaidLog[raidID]["Players"]) do
                if (playerInfo.Join <= raidStart + MRT_DELAY_FIRST_RAID_ENTRY_FOR_RLI_BOSSATTENDANCE_FIX_DATA) then
                    tempBossAttendeesByName[playerInfo.Name] = true;
                end
            end
            local tempBossAttendees = {}
            for name, bool in pairs(tempBossAttendeesByName) do
                tinsert(tempBossAttendees, name);
            end
            local tempBossInfo = {
                Players = tempBossAttendees,
                Name = "TempExportBossEntry",
                Date = raidStart + MRT_DELAY_FIRST_RAID_ENTRY_FOR_RLI_BOSSATTENDANCE_FIX_DATA,
            }
            tinsert(MRT_RaidLog[raidID]["Bosskills"], 1, tempBossInfo);
            tempBossExists = true;
        end
        -- so, lets start - scan raid attendees first
        local attendanceCount = {};
        local lastBossTimeStamp;
        local joinLeavePair;
        for key, playerInfo in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not attendanceCount[playerInfo.Name]) then
                attendanceCount[playerInfo.Name] = 0;
            end
        end
        -- if we have no bosses, than #BossKills = 0 - convenient.
        -- now count attendance for each boss
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, playerName in ipairs(bossInfo["Players"]) do
                if (not attendanceCount[playerName]) then
                    attendanceCount[playerName] = 1;
                else
                    attendanceCount[playerName] = attendanceCount[playerName] + 1;
                end
            end
        end
        -- and the last step, create join/leave-pairs. if 100% attendance, create one join/leave-pair. if not, make one for each attended boss
        for playerName, bossKillCount in pairs(attendanceCount) do
            if (bossKillCount == #MRT_RaidLog[raidID]["Bosskills"]) then
                playerList[playerName] = { { Join = raidStart, Leave = raidStop, }, };
            else
                lastBossTimeStamp = raidStart;
                for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                    for j, attendeeName in ipairs(bossInfo["Players"]) do
                        if (attendeeName == playerName and raidStart <= lastBossTimeStamp) then
                            joinLeavePair = { Join = lastBossTimeStamp, Leave = (bossInfo.Date + 10), };
                            if (not playerList[playerName]) then playerList[playerName] = {}; end
                            tinsert(playerList[playerName], joinLeavePair);
                        end
                    end
                    lastBossTimeStamp = bossInfo.Date + 20;
                end
            end
        end
        --[[
        additionally (01/12/2011):
        And remove the TempBoss, if it exists
        --]]
        if (tempBossExists == true) then
            tremove(MRT_RaidLog[raidID]["Bosskills"], 1);
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee
        local joinLeavePair = nil;
        -- create join/leave-timestamps for raid attendees
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            if (raidStart <= playerTimes.Join) then
                joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            elseif (raidStart < (playerTimes.Leave or now) ) then
                joinLeavePair = { Join = raidStart, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            end
        end
        -- create join/leave-timestamps for boss attendees
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then 
                    -- if the player is not in the playerList right now, create an entry. 
                    -- Since the player didn't show up until now, this isn't a raid attendee
                    playerList[attendeeName] = {};
                else
                    -- check if the player is a raid attendee at this point
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee and raidStart <= bossInfo.Date) then
                    joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- prepare a list with sorted player names to fill the boss info
    local sortedPlayerList = {};
    for name, joinLeaveTable in pairs(playerList) do
        tinsert(sortedPlayerList, name);
    end
    table.sort(sortedPlayerList);
    -- player data should now be complete - export it:
    for i, name in ipairs(sortedPlayerList) do
        xml = xml..createPlayerInfoString(name, realm, playerList[name]);
    end
    xml = xml.."</members>";
    -- and last, add items
    xml = xml.."<items>";
    for i, itemInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (itemInfo.Looter ~= "_deleted_") then
            if (not bossID and not difficulty) then
                xml = xml..createItemInfoString(raidID, i);
            elseif (bossID and itemInfo["BossNumber"] == bossID) then
                xml = xml..createItemInfoString(raidID, i);
            elseif ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] < 3) and difficulty == "N") or ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createItemInfoString(raidID, i);
            end
        end
    end
    -- finish
    xml = xml.."</items></raiddata></raidlog>";
    return xml;
end

function MRT_CreateMLDKP15ExportString(raidID, bossID, difficulty)
    -- MLDKP1.5 seems to have the instanceID as an optional value - since ID-Stuff changed massivly with the release of Patch 4.0.1, MRT will NOT support exporting of an instanceID in any form
    -- MLDKP1.5 uses numbers for exporting classes and races, so we need a set of tables here. If these tables should be needed somewhere else, then these should be put in the constants file
    local MLDKP_ClassTable = {
        ["WARRIOR"] = 1,
        ["ROGUE"] = 2,
        ["HUNTER"] = 3,
        ["PALADIN"] = 4,
        ["SHAMAN"] = 5,
        ["DRUID"] = 6,
        ["WARLOCK"] = 7,
        ["MAGE"] = 8,
        ["PRIEST"] = 9,
        ["DEATHKNIGHT"] = 10,   -- Wrath of the Lich King
    };
    local MLDKP_RaceTable = {
        ["Gnome"] = 1,
        ["Human"] = 2,
        ["Dwarf"] = 3,
        ["NightElf"] = 4,
        ["Troll"] = 5,
        ["Scourge"] = 6,        -- Unlocalized name for race 'Undead'
        ["Orc"] = 7,
        ["Tauren"] = 8,
        ["Draenei"] = 9,        -- The Burning Crusade
        ["BloodElf"] = 10,      -- The Burning Crusade
        ["Worgen"] = 11,        -- Cataclysm (FIXME: Is this string correct? - if not, the export will fail horribly)
        ["Goblin"] = 12,        -- Cataclysm (FIXME: Is this string correct? - if not, the export will fail horribly)
    };
    local LBBR = LBB:GetReverseLookupTable();
    -- start to create generic functions for repeated blocks
    local function createBossInfoString(raidID, bossID)
        local bossXml = "<bosskill>";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).."</name>";
        else
            bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        end
        bossXml = bossXml.."<time>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"].."</time>";
        bossXml = bossXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        bossXml = bossXml.."</bosskill>";
        return bossXml;
    end
    local function createPlayerInfoString(name, realm)
        local playerXml = "<player>";
        playerXml = playerXml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerXml = playerXml.."<race>"..MLDKP_RaceTable[MRT_PlayerDB[realm][name]["Race"]].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Guild"]) then
                playerXml = playerXml.."<guild>"..MRT_PlayerDB[realm][name]["Guild"].."</guild>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerXml = playerXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerXml = playerXml.."<class>"..MLDKP_ClassTable[MRT_PlayerDB[realm][name]["Class"]].."</class>";
            end
        end
        playerXml = playerXml.."</player>";
        return playerXml;
    end
    local function createItemInfoString(raidID, itemID)
        local bossID = MRT_RaidLog[raidID]["Loot"][itemID]["BossNumber"];
        local lootXml = "<loot>";
        lootXml = lootXml.."<itemname>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemName"].."</itemname>";
        lootXml = lootXml.."<itemid>"..deformat(MRT_RaidLog[raidID]["Loot"][itemID]["ItemString"], "item:%s").."</itemid>";
        lootXml = lootXml.."<count>"..MRT_RaidLog[raidID]["Loot"][itemID]["ItemCount"].."</count>";
        lootXml = lootXml.."<player>"..MRT_RaidLog[raidID]["Loot"][itemID]["Looter"].."</player>";
        lootXml = lootXml.."<costs>"..MRT_RaidLog[raidID]["Loot"][itemID]["DKPValue"].."</costs>";
        lootXml = lootXml.."<time>"..MRT_RaidLog[raidID]["Loot"][itemID]["Time"].."</time>";
        lootXml = lootXml.."<difficulty>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"].."</difficulty>";
        lootXml = lootXml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
        lootXml = lootXml.."<boss>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</boss>";
        if (MRT_RaidLog[raidID]["Loot"][itemID]["Note"]) then
            lootXml = lootXml.."<note><![CDATA["..MRT_RaidLog[raidID]["Loot"][itemID]["Note"].."]]></note>";
        end
        lootXml = lootXml.."</loot>";
        return lootXml;
    end
    local function createJoinString(name, joinTimeStamp)
        local joinXml = "<join>";
        joinXml = joinXml.."<player>"..name.."</player>";
        joinXml = joinXml.."<time>"..joinTimeStamp.."</time>";
        joinXml = joinXml.."</join>";
        return joinXml;
    end
    local function createLeaveString(name, leaveTimeStamp)
        local leaveXml = "<leave>";
        leaveXml = leaveXml.."<player>"..name.."</player>";
        leaveXml = leaveXml.."<time>"..leaveTimeStamp.."</time>";
        leaveXml = leaveXml.."</leave>";
        return leaveXml;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    -- start creating header
    local xml = '<?xml version="1.0"?><!DOCTYPE ML_Raidtracker PUBLIC "-//MLdkp//DTD ML_Raidtracker V 1.5//EN" "http://www.mldkp.net/dtds/1.0/ML_Raidtracker.dtd">';
    xml = xml.."<raidinfo>";
    xml = xml.."<version>1.5</version>";
    xml = xml.."<start>"..raidStart.."</start>";
    xml = xml.."<end>"..raidStop.."</end>";
    xml = xml.."<realm>"..realm.."</realm>";
    if (MRT_Options["Export_ExportEnglish"]) then
        xml = xml.."<zone>"..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]).."</zone>";
    else
        xml = xml.."<zone>"..MRT_RaidLog[raidID]["RaidZone"].."</zone>";
    end
    if (MRT_RaidLog[raidID]["RaidSize"] == 10) then
        xml = xml.."<difficulty>1</difficulty>";
    elseif (MRT_RaidLog[raidID]["RaidSize"] == 25) then
        xml = xml.."<difficulty>2</difficulty>";
    end
    xml = xml.."<exporter>"..UnitName("Player").."</exporter>";
    -- header complete, gather playerInfo
    local playerList = {};
    -- prepare player information
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
            tinsert(playerList[playerTimes.Name], joinLeavePair);
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                    joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- start parsing player data
    xml = xml.."<playerinfos>";
    for name, joinLeaveTable in pairs(playerList) do
        xml = xml..createPlayerInfoString(name, realm);
    end
    xml = xml.."</playerinfos>";
    -- now start creating bossinfo
    local isFirstBosskill = true;
    if (not bossID) then
        -- if no bossID is given, export complete raid or all boss of a specific difficulty
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if (not difficulty) then
                if (isFirstBosskill) then
                    isFirstBosskill = false;
                    xml = xml.."<bosskills>";
                end
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] < 3) and difficulty == "N") or ((bossInfo["Difficulty"] > 2) and difficulty == "H") then
                if (isFirstBosskill) then
                    isFirstBosskill = false;
                    xml = xml.."<bosskills>";
                end
                xml = xml..createBossInfoString(raidID, i);
            end
        end
    else
        -- export a specific boss
        isFirstBosskill = false;
        xml = xml.."<bosskills>";
        xml = xml..createBossInfoString(raidID, bossID);
    end
    if (not isFirstBosskill) then
        xml = xml.."</bosskills>";
    end
    -- next are the join-blocks
    xml = xml.."<joins>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, subTable in ipairs(joinLeaveTable) do
            xml = xml..createJoinString(name, subTable.Join);
        end
    end
    xml = xml.."</joins>";
    -- and now the leave blocks
    xml = xml.."<leaves>";
    for name, joinLeaveTable in pairs(playerList) do
        for i, subTable in ipairs(joinLeaveTable) do
            xml = xml..createLeaveString(name, subTable.Leave);
        end
    end
    xml = xml.."</leaves>";
    -- now the loot list
    xml = xml.."<loots>";
    for i, itemInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (itemInfo.Looter ~= "_deleted_") then
            if (not bossID and not difficulty) then
                xml = xml..createItemInfoString(raidID, i);
            elseif (bossID and itemInfo["BossNumber"] == bossID) then
                xml = xml..createItemInfoString(raidID, i);
            elseif ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] < 3) and difficulty == "N") or ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createItemInfoString(raidID, i);
            end
        end
    end
    xml = xml.."</loots>";
    xml = xml.."</raidinfo>";
    return xml;
end

-- 
function MRT_CreateDKPBoardComExportString(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- special exportTimeFunction
    local function getStringHoursMinSec(bigSeconds)
        local seconds = bigSeconds % 60;
        local minutes = ( (bigSeconds - seconds) / 60 ) % 60;
        local hours = ( ( (bigSeconds - seconds) / 60 ) - minutes ) / 60;
        return string.format("%02d", hours)..":"..string.format("%02d", minutes)..":"..string.format("%02d", seconds);
    end
    -- start to create generic functions for repeated blocks
    local function createBossInfoString(raidID, bossID)
        local bossXml = "<Boss>";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossXml = bossXml.."<name>"..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).."</name>";
        else
            bossXml = bossXml.."<name>"..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].."</name>";
        end
        bossXml = bossXml.."<time>"..MRT_MakeEQDKP_Time(MRT_RaidLog[raidID]["Bosskills"][bossID]["Date"]).."</time>";
        bossXml = bossXml.."<participants>";
        for i, playerName in ipairs(MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"]) do
            bossXml = bossXml.."<participant>"..playerName.."</participant>";
        end
        bossXml = bossXml.."</participants>";
        bossXml = bossXml.."</Boss>";
        return bossXml;
    end
    -- joinLeaveTable is a set of joinLeave Timestamps - example: joinLeaveTable = { {["Join"] = timestamp, ["Leave"] = timestamp}, {["Join"] = timestamp, ["Leave"] = timestamp} }
    local function createPlayerInfoString(name, realm, joinLeaveTable)
        if (#joinLeaveTable == 0) then return ""; end
        -- calculate onlinetime and offlinetime - waittime is not supported, because of lack of an extra wait list
        local firstJoinTimestamp = 0;
        local lastLeaveTimestamp = 0;
        local onlineTimeInSec = 0;
        for i, joinLeavePair in ipairs(joinLeaveTable) do
            onlineTimeInSec = onlineTimeInSec + joinLeavePair.Leave - joinLeavePair.Join;
            if (firstJoinTimestamp == 0 or firstJoinTimestamp > joinLeavePair.Join) then
                firstJoinTimestamp = joinLeavePair.Join;
            end
            if (lastLeaveTimestamp < joinLeavePair.Leave) then
                lastLeaveTimestamp = joinLeavePair.Leave;
            end
        end
        local offlineTimeInSec = lastLeaveTimestamp - firstJoinTimestamp - onlineTimeInSec;
        -- check for negative offline times - just in case something is fucked up
        if (offlineTimeInSec < 0) then
            offlineTimeInSec = 0;
        end
        local playerXml = "<Raider>";
        playerXml = playerXml.."<name>"..name.."</name>";
        if (MRT_PlayerDB[realm][name]) then
            if (MRT_PlayerDB[realm][name]["Race"]) then
                playerXml = playerXml.."<race>"..MRT_PlayerDB[realm][name]["Race"].."</race>";
            end
            if (MRT_PlayerDB[realm][name]["Guild"]) then
                playerXml = playerXml.."<guild>"..MRT_PlayerDB[realm][name]["Guild"].."</guild>";
            end
            if (MRT_PlayerDB[realm][name]["Sex"]) then
                playerXml = playerXml.."<sex>"..MRT_PlayerDB[realm][name]["Sex"].."</sex>";
            end
            if (MRT_PlayerDB[realm][name]["Class"]) then
                playerXml = playerXml.."<class>"..MRT_PlayerDB[realm][name]["Class"].."</class>";
            end
            if (MRT_PlayerDB[realm][name]["Level"]) then
                playerXml = playerXml.."<level>"..MRT_PlayerDB[realm][name]["Level"].."</level>";
            end
        end
        playerXml = playerXml.."<join>"..MRT_MakeEQDKP_Time(firstJoinTimestamp).."</join>";
        playerXml = playerXml.."<leave>"..MRT_MakeEQDKP_Time(lastLeaveTimestamp).."</leave>";
        playerXml = playerXml.."<offlinetime>"..getStringHoursMinSec(offlineTimeInSec).."</offlinetime>";
        playerXml = playerXml.."<waittime>00:00:00</waittime>";
        playerXml = playerXml.."<onlinetime>"..getStringHoursMinSec(onlineTimeInSec).."</onlinetime>";
        playerXml = playerXml.."</Raider>";
        return playerXml;
    end
    local function createItemInfoString(itemInfo)
        local bossInfo = MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber];
        local itemXml = "<Loot>";
        itemXml = itemXml.."<ItemName>"..itemInfo.ItemName.."</ItemName>";
        itemXml = itemXml.."<Color>"..itemInfo.ItemColor.."</Color>";
        itemXml = itemXml.."<ItemID>"..itemInfo.ItemId.."</ItemID>";
        itemXml = itemXml.."<Count>"..itemInfo.ItemCount.."</Count>";
        if (itemInfo.Looter == "disenchanted") then
            itemXml = itemXml.."<Buyer>Disenchanted</Buyer>";
        else
            itemXml = itemXml.."<Buyer>"..itemInfo.Looter.."</Buyer>";
        end
        itemXml = itemXml.."<Cost>"..itemInfo.DKPValue.."</Cost>";
        itemXml = itemXml.."<Time>"..MRT_MakeEQDKP_Time(bossInfo.Date).."</Time>";
        itemXml = itemXml.."<Drop>"..bossInfo.Name.."</Drop>";
        itemXml = itemXml.."</Loot>";
        return itemXml;
    end
    -- set up a few locals
    local now = MRT_GetCurrentTime();
    local raidStart = MRT_RaidLog[raidID]["StartTime"];
    if (bossID and bossID > 1) then raidStart = MRT_RaidLog[raidID]["Bosskills"][bossID - 1]["Date"] or MRT_RaidLog[raidID]["StartTime"]; end
    local raidStop = MRT_RaidLog[raidID]["StopTime"] or now;
    local realm = MRT_RaidLog[raidID]["Realm"];
    local playerList = {};
    -- prepare player information
    if (MRT_Options["Export_CTRT_IgnorePerBossAttendance"]) then
        -- use raidstart/raidstop for everyone, so gather all players:
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then
                playerList[playerTimes.Name] = { { Join = raidStart, Leave = raidStop, }, };
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = { { Join = raidStart, Leave = raidStop, }, };
                end
            end
        end
    else
        -- use join/leave times - add a short join/leave-pair, if a player is only tracked as a boss attendee
        local joinLeavePair = nil;
        for key, playerTimes in pairs(MRT_RaidLog[raidID]["Players"]) do
            if (not playerList[playerTimes.Name]) then playerList[playerTimes.Name] = {}; end
            if (raidStart <= playerTimes.Join) then
                joinLeavePair = { Join = playerTimes.Join, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            elseif (raidStart < (playerTimes.Leave or now) ) then
                joinLeavePair = { Join = raidStart, Leave = (playerTimes.Leave or now), };
                tinsert(playerList[playerTimes.Name], joinLeavePair);
            end
        end
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            local attendee;
            for j, attendeeName in ipairs(bossInfo["Players"]) do
                attendee = false;
                if (not playerList[attendeeName]) then
                    playerList[attendeeName] = {};
                    joinLeavePair = { Join = (bossInfo.Date - 10), Leave = (bossInfo.Date + 10), };
                else
                    for k, joinLeaveTable in ipairs(playerList[attendeeName]) do
                        if (joinLeaveTable.Join < bossInfo.Date and bossInfo.Date < joinLeaveTable.Leave) then
                            attendee = true;
                        end
                    end
                end
                if (not attendee and raidStart <= bossInfo.Date) then
                    tinsert(playerList[attendeeName], joinLeavePair);
                end
            end
        end
    end
    -- prepare a list with sorted player names to fill the boss info
    local sortedPlayerList = {};
    for name, joinLeaveTable in pairs(playerList) do
        tinsert(sortedPlayerList, name);
    end
    table.sort(sortedPlayerList);
    -- start creating head
    local xml = "<RaidInfo>";
    xml = xml.."<key>"..MRT_MakeEQDKP_Time(raidStart).."</key>";
    xml = xml.."<start>"..MRT_MakeEQDKP_Time(raidStart).."</start>";
    xml = xml.."<end>"..MRT_MakeEQDKP_Time(raidStop).."</end>";
    xml = xml.."<Raiders>";
    for i, name in ipairs(sortedPlayerList) do
        xml = xml..createPlayerInfoString(name, realm, playerList[name]);
    end
    xml = xml.."</Raiders>";
    xml = xml.."<BossKills>";
    if (not bossID) then
        -- if no bossID is given, export complete raid or all boss of a specific difficulty
        for i, bossInfo in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
            if (not difficulty) then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] < 3) and difficulty == "N") then
                xml = xml..createBossInfoString(raidID, i);
            elseif ((bossInfo["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createBossInfoString(raidID, i);
            end
        end
    else
        -- export a specific boss
        xml = xml..createBossInfoString(raidID, bossID);
    end
    xml = xml.."</BossKills>";
    -- and last, add items
    xml = xml.."<Loots>";
    for i, itemInfo in ipairs(MRT_RaidLog[raidID]["Loot"]) do
        if (itemInfo.Looter ~= "_deleted_") then
            if (not bossID and not difficulty) then
                xml = xml..createItemInfoString(itemInfo);
            elseif (bossID and itemInfo["BossNumber"] == bossID) then
                xml = xml..createItemInfoString(itemInfo);
            elseif ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] < 3) and difficulty == "N") or ((MRT_RaidLog[raidID]["Bosskills"][itemInfo.BossNumber]["Difficulty"] > 2) and difficulty == "H") then
                xml = xml..createItemInfoString(itemInfo);
            end
        end
    end
    -- finish
    xml = xml.."</Loots></RaidInfo>";
    return xml;
end

-- Planned format options:
-- @param addFormat: nil = plainText, 1 = BBCode, 2 = BBCode with wowhead-links, 3 = ?
function MRT_CreateTextExport(raidID, bossID, difficulty, addFormat)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- Generate generic getBossData-Function:
    local function getBossData(raidID, bossID)
        -- Set up vars, create sorted playerList
        local bossData = "";
        local isFirstItem = true;
        local playerList = MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"];
        table.sort(playerList);
        -- Create data
        -- Begin boss headline formatting
        if (addFormat == 1 or addFormat == 2) then
            bossData = bossData.."[b]";
        elseif (addFormat == 3) then
        end
        -- Boss headline
        if (MRT_Options["Export_ExportEnglish"]) then
            bossData = bossData..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]).." - ";
        else
            bossData = bossData..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"].." - ";
        end
        if (MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"] < 3) then
            bossData = bossData..MRT_L.Core["Export_Normal"];
        else
            bossData = bossData..MRT_L.Core["Export_Heroic"];
        end
        -- End boss headline formatting
        if (addFormat == 1 or addFormat == 2) then
            bossData = bossData.."[/b]";
        elseif (addFormat == 3) then
        end
        -- End of boss headline
        bossData = bossData.."\n";
        bossData = bossData..MRT_L.Core["Export_Attendees"].."("..tostring(#playerList).."):\n";
        bossData = bossData..table.concat(playerList, ", ");
        bossData = bossData.."\n\n";
        for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
            if (val["BossNumber"] == bossID and val["Looter"] ~= "_deleted_") then
                if (isFirstItem) then bossData = bossData..MRT_L.Core["Export_Loot"]..":\n"; isFirstItem = false; end
                bossData = bossData.."- ";
                if (addFormat == 2) then bossData = bossData.."[url=http://www.wowhead.com/?item="..val["ItemId"].."]"; end
                bossData = bossData..val["ItemName"];
                if (addFormat == 2) then bossData = bossData.."[/url]"; end
                bossData = bossData.." - "..val["DKPValue"].." "..MRT_Options["Export_Currency"];
                bossData = bossData.." - "..val["Looter"];
                if val["Note"] then bossData = bossData.." ("..val["Note"]..")"; end
                bossData = bossData.."\n";
            end
        end
        bossData = bossData.."\n\n";
        return bossData;
    end
    -- Start creating export data
    local export = "";
    -- Begin headline formatting
    if (addFormat == 1 or addFormat == 2) then
        export = export.."[u][b]";
    elseif (addFormat == 3) then
    end
    -- Begin headline text
    export = export..date(MRT_Options["Export_DateTimeFormat"], MRT_RaidLog[raidID]["StartTime"]);
    export = export.." - ";
    if (MRT_Options["Export_ExportEnglish"]) then
        export = export..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]);
    else
        export = export..MRT_RaidLog[raidID]["RaidZone"];
    end
    export = export.." ("..MRT_RaidLog[raidID]["RaidSize"]..")";
    -- End headline formatting
    if (addFormat == 1 or addFormat == 2) then
        export = export.."[/b][/u]";
    elseif (addFormat == 3) then
    end
    -- End of headline
    export = export.."\n\n";
    -- If boss events are present, create a list of boss events
    local bossDataExist = nil;
    if (MRT_RaidLog[raidID]["Bosskills"] and #MRT_RaidLog[raidID]["Bosskills"] > 0) then
        if ((bossID == nil) and (difficulty == nil)) then
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                export = export..getBossData(raidID, idx);
            end
            bossDataExist = true;
        elseif (bossID) then
            export = export..getBossData(raidID, bossID);
            bossDataExist = true;
        else
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                if ((val["Difficulty"] < 3) and difficulty == "N") or ((val["Difficulty"] > 2) and difficulty == "H") then
                    export = export..getBossData(raidID, idx);
                    bossDataExist = true;
                end
            end
        end
    end
    -- If no boss events are present, create a list of raid atendees
    if (not bossDataExist) then
        -- Create list, remove duplicates, sort list, add list to export data 
        -- Very dirty hack for sorting out duplicates, i know....
        local keyPlayerList = {};
        local numPlayerList = {};
        for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
            keyPlayerList[val["Name"]] = val["Name"];
        end
        for key, val in pairs(keyPlayerList) do
            tinsert(numPlayerList, val);
        end
        table.sort(numPlayerList);
        -- Add export data
        export = export..MRT_L.Core["Export_Attendees"].."("..tostring(#numPlayerList).."):\n";
        export = export..table.concat(numPlayerList, ", ");
    end  
    return export;
end

-- CSS based HTML, including wowhead links (contributed by Kevin)
function MRT_CreateHTMLExport(raidID, bossID, difficulty)
    -- get reverse lookup table, if exports should be in english
    local LBBR = LBB:GetReverseLookupTable();
    -- Generate generic getBossData-Function:
    local function getBossData(raidID, bossID)
        -- Set up vars, create sorted playerList
        local bossData = "<div class=\"bossData\">";
        local isFirstItem = true;
        local playerList = MRT_RaidLog[raidID]["Bosskills"][bossID]["Players"];
        table.sort(playerList);
        -- Create data
        -- Begin boss headline formatting
        bossData = bossData.."<div class=\"boss\">";
        -- Boss headline
        bossData = bossData.."<span class=\"name\">";
        if (MRT_Options["Export_ExportEnglish"]) then
            bossData = bossData..(LBBR[MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]] or MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"]);
        else
            bossData = bossData..MRT_RaidLog[raidID]["Bosskills"][bossID]["Name"];
        end
        bossData = bossData.."</span><span class=\"difficulty\">";
        if (MRT_RaidLog[raidID]["Bosskills"][bossID]["Difficulty"] < 3) then
            bossData = bossData..MRT_L.Core["Export_Normal"];
        else
            bossData = bossData..MRT_L.Core["Export_Heroic"];
        end
        -- End boss headline formatting
        bossData = bossData.."</span></div>";
        -- End of boss headline
        bossData = bossData.."<div class=\"info\">";
        bossData = bossData.."<span class=\"label\">"..MRT_L.Core["Export_Attendees"].." ("..tostring(#playerList)..")</span>";
        bossData = bossData.."<span class=\"attendees\">"..table.concat(playerList, ", ").."</span>";
        bossData = bossData.."</div>";
        bossData = bossData.."<div class=\"loot\">";
        for idx, val in ipairs(MRT_RaidLog[raidID]["Loot"]) do
            if (val["BossNumber"] == bossID and val["Looter"] ~= "_deleted_") then
                if (isFirstItem) then bossData = bossData.."<span class=\"label\">"..MRT_L.Core["Export_Loot"].."</span><ul>"; isFirstItem = false; end
                bossData = bossData.."<li>";
                bossData = bossData.."<a class=\"item\" href=\"http://www.wowhead.com/?item="..val["ItemId"].."\">";
                bossData = bossData..val["ItemName"];
                bossData = bossData.."</a>";
                bossData = bossData.."<span class=\"value\">"..val["DKPValue"].." "..MRT_Options["Export_Currency"].."</span>";
                bossData = bossData.."<span class=\"looter\">"..val["Looter"].."</span>";
                if val["Note"] then bossData = bossData.."<span=\"note\">("..val["Note"]..")</span>"; end
                bossData = bossData.."</li>";
            end
        end
        if (isFirstItem) then
            bossData = bossData.."</div></div>";
        else
            bossData = bossData.."</ul></div></div>";
        end
        return bossData;
    end
    -- Start creating export data
    local export = "<div class=\"raidExport\">";
    -- Begin headline formatting
    export = export.."<div class=\"headline\">";
    -- Begin headline text
    export = export.."<span class=\"zone\">";
    if (MRT_Options["Export_ExportEnglish"]) then
        export = export..(LBZR[MRT_RaidLog[raidID]["RaidZone"]] or MRT_RaidLog[raidID]["RaidZone"]);
    else
        export = export..MRT_RaidLog[raidID]["RaidZone"];
    end
    export = export.." ("..MRT_RaidLog[raidID]["RaidSize"]..")</span>";
    export = export.."<span class=\"start\">"..date(MRT_Options["Export_DateTimeFormat"], MRT_RaidLog[raidID]["StartTime"]).."</span>";
    -- End headline formatting
    export = export.."</div>";
    -- If boss events are present, create a list of boss events
    local bossDataExist = nil;
    if (MRT_RaidLog[raidID]["Bosskills"] and #MRT_RaidLog[raidID]["Bosskills"] > 0) then
        if ((bossID == nil) and (difficulty == nil)) then
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                export = export..getBossData(raidID, idx);
            end
            bossDataExist = true;
        elseif (bossID) then
            export = export..getBossData(raidID, bossID);
            bossDataExist = true;
        else
            for idx, val in ipairs(MRT_RaidLog[raidID]["Bosskills"]) do
                if ((val["Difficulty"] < 3) and difficulty == "N") or ((val["Difficulty"] > 2) and difficulty == "H") then
                    export = export..getBossData(raidID, idx);
                    bossDataExist = true;
                end
            end
        end
    end
    -- If no boss events are present, create a list of raid atendees
    if (not bossDataExist) then
        -- Create list, remove duplicates, sort list, add list to export data 
        -- Very dirty hack for sorting out duplicates, i know....
        local keyPlayerList = {};
        local numPlayerList = {};
        for key, val in pairs(MRT_RaidLog[raidID]["Players"]) do
            keyPlayerList[val["Name"]] = val["Name"];
        end
        for key, val in pairs(keyPlayerList) do
            tinsert(numPlayerList, val);
        end
        table.sort(numPlayerList);
        -- Add export data
        export = export.."<div class=\"info\">";
        export = export.."<span class=\"label\">"..MRT_L.Core["Export_Attendees"].." ("..tostring(#numPlayerList)..")</span>";
        export = export.."<span class=\"attendees\">"..table.concat(numPlayerList, ", ").."</span>";
        export = export.."</div>";
    end
    export = export.."</div>";
    return export;
end
