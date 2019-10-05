-- ********************************************************
-- **              Mizus RaidTracker - GUI               **
-- **              <http://cosmocanyon.de>               **
-- ********************************************************
--
-- This addon is written and copyrighted by:
--    * Mîzukichan @ EU-Antonidas (2010-2018)
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


-- Check for addon table
if (not MizusRaidTracker) then MizusRaidTracker = {}; end
local mrt = MizusRaidTracker


--------------
--  Locals  --
--------------
local deformat = LibStub("LibDeformat-3.0");
local ScrollingTable = LibStub("ScrollingTable");

local MRT_GUI_RaidLogTableSelection = nil;
local MRT_GUI_RaidBosskillsTableSelection = nil;

local MRT_ExternalLootNotifier = {};

local lastShownNumOfRaids = nil;
local lastSelectedRaidNum = nil;
local lastShownNumOfBosses = nil;
local lastSelectedBossNum = nil;

-- table definitions
local MRT_RaidLogTableColDef = { 
    {["name"] = MRT_L.GUI["Col_Num"], ["width"] = 25, ["defaultsort"] = "dsc"}, 
    {["name"] = MRT_L.GUI["Col_Date"], ["width"] = 75}, 
    {["name"] = MRT_L.GUI["Col_Zone"], ["width"] = 100},
    {["name"] = MRT_L.GUI["Col_Size"], ["width"] = 25},
};
local MRT_RaidAttendeesTableColDef = {
    {["name"] = "", ["width"] = 1},                            -- invisible column for storing the player number index from the raidlog-table
    {["name"] = MRT_L.GUI["Col_Name"], ["width"] = 74},
    {["name"] = MRT_L.GUI["Col_Join"], ["width"] = 45},
    {["name"] = MRT_L.GUI["Col_Leave"], ["width"] = 45},
};
local MRT_RaidBosskillsTableColDef = {
    {["name"] = MRT_L.GUI["Col_Num"], ["width"] = 25, ["defaultsort"] = "dsc"},
    {["name"] = MRT_L.GUI["Col_Time"], ["width"] = 40},
    {["name"] = MRT_L.GUI["Col_Name"], ["width"] = 105},
    {["name"] = MRT_L.GUI["Col_Difficulty"], ["width"] = 45},
};
local MRT_BossLootTableColDef = {
    {["name"] = "", ["width"] = 1},                            -- invisible column for storing the loot number index from the raidlog-table
    {                                                          -- coloumn for Item Icon - need to store ID
        ["name"] = "Icon", 
        ["width"] = 30,
        ["DoCellUpdate"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, fShow, self, ...)
            -- icon handling
            if fShow then 
                --MRT_Debug("self:GetCell(realrow, column) = "..self:GetCell(realrow, column));
                local itemId = self:GetCell(realrow, column);
                local itemTexture = GetItemIcon(itemId); 
                --cellFrame:SetBackdrop( { bgFile = itemTexture } );            -- put this back in, if and when SetBackdrop can handle texture IDs
                if not (cellFrame.cellItemTexture) then
                    cellFrame.cellItemTexture = cellFrame:CreateTexture();
                end
                cellFrame.cellItemTexture:SetTexture(itemTexture);
                cellFrame.cellItemTexture:SetTexCoord(0, 1, 0, 1);
                cellFrame.cellItemTexture:Show();
                cellFrame.cellItemTexture:SetPoint("CENTER", cellFrame.cellItemTexture:GetParent(), "CENTER");
                cellFrame.cellItemTexture:SetWidth(30);
                cellFrame.cellItemTexture:SetHeight(30);
            end
            -- tooltip handling
            local itemLink = self:GetCell(realrow, 6);
            cellFrame:SetScript("OnEnter", function() 
                                             MRT_GUI_ItemTT:SetOwner(cellFrame, "ANCHOR_RIGHT");
                                             MRT_GUI_ItemTT:SetHyperlink(itemLink);
                                             MRT_GUI_ItemTT:Show();
                                           end);
            cellFrame:SetScript("OnLeave", function()
                                             MRT_GUI_ItemTT:Hide();
                                             MRT_GUI_ItemTT:SetOwner(UIParent, "ANCHOR_NONE");
                                           end);
        end,
    },
    {["name"] = MRT_L.GUI["Col_Name"], ["width"] = 179},
    {["name"] = MRT_L.GUI["Col_Looter"], ["width"] = 85},
    {["name"] = MRT_L.GUI["Col_Cost"], ["width"] = 30},
    {["name"] = "", ["width"] = 1},                            -- invisible column for itemString (needed for tooltip)
    {
        ["name"] = MRT_L.GUI["Note"], 
        ["width"] = 30,
        ["DoCellUpdate"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, fShow, self, ...)
            -- icon handling
            local lootNote = self:GetCell(realrow, column);
            if fShow and lootNote then
                cellFrame:SetBackdrop( { bgFile = "Interface\\BUTTONS\\UI-GuildButton-PublicNote-Up", insets = { left = 5, right = 5, top = 5, bottom = 5 }, } );
                cellFrame:SetScript("OnEnter", function() 
                                                 MRT_GUI_ItemTT:SetOwner(cellFrame, "ANCHOR_RIGHT");
                                                 MRT_GUI_ItemTT:SetText(lootNote);
                                                 MRT_GUI_ItemTT:Show();
                                               end);
                cellFrame:SetScript("OnLeave", function()
                                                 MRT_GUI_ItemTT:Hide();
                                                 MRT_GUI_ItemTT:SetOwner(UIParent, "ANCHOR_NONE");
                                               end);
            else
                cellFrame:SetBackdrop(nil);
                cellFrame:SetScript("OnEnter", nil);
                cellFrame:SetScript("OnLeave", nil);
                MRT_GUI_ItemTT:Hide();
                MRT_GUI_ItemTT:SetOwner(UIParent, "ANCHOR_NONE");
            end
        end,
    },
};
local MRT_BossAttendeesTableColDef = {
    {["name"] = "", ["width"] = 1},                            -- invisible column for storing the attendee number index from the raidlog-table
    {["name"] = MRT_L.GUI["Col_Name"], ["width"] = 85},
};
local MRT_PlayerDropDownTableColDef = {
    {["name"] = "", ["width"] = 100},
};


-----------------
--  API-Stuff  --
-----------------
function MRT_RegisterLootNotifyGUI(functionToCall)
    local isRegistered = nil;
    for i, val in ipairs(MRT_ExternalLootNotifier) do
        if (val == functionToCall) then
            isRegistered = true;
        end
    end
    if (isRegistered) then
        return false;
    else
        tinsert(MRT_ExternalLootNotifier, functionToCall);
        return true;
    end
end

function MRT_UnregisterLootNotifyGUI(functionCalled)
    local isRegistered = nil;
    for i, val in ipairs(MRT_ExternalLootNotifier) do
        if (val == functionCalled) then
            isRegistered = i;
        end
    end
    if (isRegistered) then
        tremove(MRT_ExternalLootNotifier, isRegistered);
        return true;
    else
        return false;
    end
end


---------------------------------------------------------------
--  parse localization and set up tables after ADDON_LOADED  --
---------------------------------------------------------------
function MRT_GUI_ParseValues()
    -- Parse title strings
    MRT_GUIFrame_Title:SetText(MRT_L.GUI["Header_Title"]);
    MRT_GUIFrame_RaidLogTitle:SetText(MRT_L.GUI["Tables_RaidLogTitle"]);
    MRT_GUIFrame_RaidAttendeesTitle:SetText(MRT_L.GUI["Tables_RaidAttendeesTitle"]);
    MRT_GUIFrame_RaidBosskillsTitle:SetText(MRT_L.GUI["Tables_RaidBosskillsTitle"]);
    MRT_GUIFrame_BossLootTitle:SetText(MRT_L.GUI["Tables_RaidLootTitle"]);
    MRT_GUIFrame_BossAttendeesTitle:SetText(MRT_L.GUI["Tables_BossAttendeesTitle"]);
    -- Create and anchor tables
    MRT_GUI_RaidLogTable = ScrollingTable:CreateST(MRT_RaidLogTableColDef, 12, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidLogTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidLogTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidLogTable:EnableSelection(true);
    MRT_GUI_RaidAttendeesTable = ScrollingTable:CreateST(MRT_RaidAttendeesTableColDef, 12, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidAttendeesTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidAttendeesTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidAttendeesTable:EnableSelection(true);
    MRT_GUI_RaidBosskillsTable = ScrollingTable:CreateST(MRT_RaidBosskillsTableColDef, 12, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidBosskillsTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidBosskillsTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidBosskillsTable:EnableSelection(true);
    MRT_GUI_BossLootTable = ScrollingTable:CreateST(MRT_BossLootTableColDef, 6, 30, nil, MRT_GUIFrame);           -- ItemId should be squared - so use 30x30 -> 30 pixels high
    MRT_GUI_BossLootTable.head:SetHeight(15);                                                                     -- Manually correct the height of the header (standard is rowHight - 30 pix would be different from others tables around and looks ugly)
    MRT_GUI_BossLootTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_BossLootTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_BossLootTable:EnableSelection(true);
    MRT_GUI_BossAttendeesTable = ScrollingTable:CreateST(MRT_BossAttendeesTableColDef, 12, nil, nil, MRT_GUIFrame);
    MRT_GUI_BossAttendeesTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_BossAttendeesTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_BossAttendeesTable:EnableSelection(true);
    -- parse button local / anchor buttons relative to tables
    MRT_GUIFrame_RaidLog_Export_Button:SetText(MRT_L.GUI["Button_Export"]);
    MRT_GUIFrame_RaidLog_Export_Button:SetPoint("TOPLEFT", MRT_GUI_RaidLogTable.frame, "BOTTOMLEFT", 0, -5);
    MRT_GUIFrame_RaidLog_Delete_Button:SetText(MRT_L.GUI["Button_Delete"]);
    MRT_GUIFrame_RaidLog_Delete_Button:SetPoint("LEFT", MRT_GUIFrame_RaidLog_Export_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_RaidLog_ExportNormal_Button:SetText(MRT_L.GUI["Button_ExportNormal"]);
    MRT_GUIFrame_RaidLog_ExportNormal_Button:SetPoint("TOP", MRT_GUIFrame_RaidLog_Export_Button, "BOTTOM", 0, -5);
    MRT_GUIFrame_RaidLog_ExportHeroic_Button:SetText(MRT_L.GUI["Button_ExportHeroic"]);
    MRT_GUIFrame_RaidLog_ExportHeroic_Button:SetPoint("LEFT", MRT_GUIFrame_RaidLog_ExportNormal_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_RaidBosskills_Add_Button:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUIFrame_RaidBosskills_Add_Button:SetPoint("TOPLEFT", MRT_GUI_RaidBosskillsTable.frame, "BOTTOMLEFT", 0, -5);
    MRT_GUIFrame_RaidBosskills_Delete_Button:SetText(MRT_L.GUI["Button_Delete"]);
    MRT_GUIFrame_RaidBosskills_Delete_Button:SetPoint("LEFT", MRT_GUIFrame_RaidBosskills_Add_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_RaidBosskills_Export_Button:SetText(MRT_L.GUI["Button_Export"]);
    MRT_GUIFrame_RaidBosskills_Export_Button:SetPoint("TOP", MRT_GUIFrame_RaidBosskills_Add_Button, "BOTTOM", 0, -5);
    MRT_GUIFrame_RaidAttendees_Add_Button:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUIFrame_RaidAttendees_Add_Button:SetPoint("TOPLEFT", MRT_GUI_RaidAttendeesTable.frame, "BOTTOMLEFT", 0, -5);
    MRT_GUIFrame_RaidAttendees_Delete_Button:SetText(MRT_L.GUI["Button_Delete"]);
    MRT_GUIFrame_RaidAttendees_Delete_Button:SetPoint("LEFT", MRT_GUIFrame_RaidAttendees_Add_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_BossLoot_Add_Button:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUIFrame_BossLoot_Add_Button:SetPoint("TOPLEFT", MRT_GUI_BossLootTable.frame, "BOTTOMLEFT", 0, -5);
    MRT_GUIFrame_BossLoot_Modify_Button:SetText(MRT_L.GUI["Button_Modify"]);
    MRT_GUIFrame_BossLoot_Modify_Button:SetPoint("LEFT", MRT_GUIFrame_BossLoot_Add_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_BossLoot_Delete_Button:SetText(MRT_L.GUI["Button_Delete"]);
    MRT_GUIFrame_BossLoot_Delete_Button:SetPoint("LEFT", MRT_GUIFrame_BossLoot_Modify_Button, "RIGHT", 10, 0);
    MRT_GUIFrame_BossAttendees_Add_Button:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUIFrame_BossAttendees_Add_Button:SetPoint("TOPLEFT", MRT_GUI_BossAttendeesTable.frame, "BOTTOMLEFT", 0, -5);
    MRT_GUIFrame_BossAttendees_Delete_Button:SetText(MRT_L.GUI["Button_Delete"]);
    MRT_GUIFrame_BossAttendees_Delete_Button:SetPoint("TOP", MRT_GUIFrame_BossAttendees_Add_Button, "BOTTOM", 0, -5);
    MRT_GUIFrame_TakeSnapshot_Button:SetText(MRT_L.GUI["Button_TakeSnapshot"]);
    MRT_GUIFrame_TakeSnapshot_Button:SetPoint("TOPLEFT", MRT_GUI_BossLootTable.frame, "TOPLEFT", -215, 0);
    MRT_GUIFrame_StartNewRaid_Button:SetText(MRT_L.GUI["Button_StartNewRaid"]);
    MRT_GUIFrame_MakeAttendanceCheck_Button:SetText(MRT_L.GUI["Button_MakeGuildAttendanceCheck"]);
    MRT_GUIFrame_EndCurrentRaid_Button:SetText(MRT_L.GUI["Button_EndCurrentRaid"]);
    MRT_GUIFrame_ResumeLastRaid_Button:SetText(MRT_L.GUI["Button_ResumeLastRaid"]);
    -- Create difficulty drop down menu
    mrt:UI_CreateTwoRowDDM()
    -- Insert table data
    MRT_GUI_CompleteTableUpdate();
    -- Create and anchor drop down menu table for add/modify loot dialog
    MRT_GUI_PlayerDropDownTable = ScrollingTable:CreateST(MRT_PlayerDropDownTableColDef, 9, nil, nil, MRT_GUI_FourRowDialog);
    MRT_GUI_PlayerDropDownTable.head:SetHeight(1);
    MRT_GUI_PlayerDropDownTable.frame:SetFrameLevel(3);
    MRT_GUI_PlayerDropDownTable.frame:Hide();
    MRT_GUI_PlayerDropDownTable:EnableSelection(false);
    MRT_GUI_PlayerDropDownTable:RegisterEvents({
        ["OnClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)
            if (not realrow) then return true; end
            local playerName = MRT_GUI_PlayerDropDownTable:GetCell(realrow, column);
            if (playerName) then
                MRT_GUI_FourRowDialog_EB2:SetText(playerName);
                MRT_GUI_PlayerDropDownList_Toggle();
            end
            return true;
        end
    });
end

function mrt:UI_CreateTwoRowDDM()
    -- Create DropDownFrame
    if (not MRT_GUI_TwoRowDialog_DDM) then
        CreateFrame("Frame", "MRT_GUI_TwoRowDialog_DDM", MRT_GUI_TwoRowDialog, "MRT_Lib_UIDropDownMenuTemplate")
        MRT_GUI_TwoRowDialog_DDM:CreateFontString("MRT_GUI_TwoRowDialog_DDM_Text", "OVERLAY", "ChatFontNormal")
    end
    -- List of DropDownMenuItems
    local items = {}
    if mrt.isClassic then
        items = {
            { [9] = RAID_DIFFICULTY_40PLAYER },
            { [4] = RAID_DIFFICULTY_20PLAYER },
            { [3] = RAID_DIFFICULTY_10PLAYER }
        }
    else
        items = {
            { [16] = select(1, GetDifficultyInfo(16)).." (20)" },
            { [15] = select(1, GetDifficultyInfo(15)).." (30)" },
            { [14] = select(1, GetDifficultyInfo(14)).." (30)" },
            { [17] = select(1, GetDifficultyInfo(17)).." (30)" },
            { [9] = select(1, GetDifficultyInfo(9)) },                          -- 40 Player
            { [4] = select(1, GetDifficultyInfo(4)) },                          -- 25 Player
            { [3] = select(1, GetDifficultyInfo(3)) },                          -- 10 Player
        }
    end
    -- Anchor DropDownFrame
    MRT_GUI_TwoRowDialog_DDM:ClearAllPoints();
    MRT_GUI_TwoRowDialog_DDM:SetPoint("TOP", MRT_GUI_TwoRowDialog_EB1, "TOP", -4, -64);
    MRT_GUI_TwoRowDialog_DDM_Text:ClearAllPoints();
    MRT_GUI_TwoRowDialog_DDM_Text:SetPoint("BOTTOMLEFT", MRT_GUI_TwoRowDialog_DDM, "TOPLEFT", 14, 0);
    MRT_GUI_TwoRowDialog_DDM:Show();
    -- Click handler function
    local function OnClick(self)
       MRT_Lib_UIDropDownMenu_SetSelectedID(MRT_GUI_TwoRowDialog_DDM, self:GetID())
    end
    -- DropDownMenu initialize function
    local function initialize(self, level)
        local info = MRT_Lib_UIDropDownMenu_CreateInfo()
        for k2, v2 in ipairs(items) do
            for k, v in pairs(v2) do
                info = MRT_Lib_UIDropDownMenu_CreateInfo()
                info.text = v
                info.value = k
                info.func = OnClick
                MRT_Lib_UIDropDownMenu_AddButton(info, level)
            end
        end
    end
    -- Setup DropDownMenu
    MRT_Lib_UIDropDownMenu_Initialize(MRT_GUI_TwoRowDialog_DDM, initialize);
    MRT_Lib_UIDropDownMenu_SetWidth(MRT_GUI_TwoRowDialog_DDM, 236);
    MRT_Lib_UIDropDownMenu_SetButtonWidth(MRT_GUI_TwoRowDialog_DDM, 260);
    MRT_Lib_UIDropDownMenu_SetSelectedID(MRT_GUI_TwoRowDialog_DDM, 3);
    MRT_Lib_UIDropDownMenu_JustifyText(MRT_GUI_TwoRowDialog_DDM, "LEFT");
    -- Setup text
    MRT_GUI_TwoRowDialog_DDM_Text:SetText(MRT_L.GUI["Raid size"])
    -- Hide element
    MRT_GUI_TwoRowDialog_DDM:Hide();
end


---------------------
--  Show/Hide GUI  --
---------------------
function MRT_GUI_Toggle()
    if (not MRT_GUIFrame:IsShown()) then
        MRT_GUIFrame:Show();
        MRT_GUIFrame:SetScript("OnUpdate", function() MRT_GUI_OnUpdateHandler(); end);
        if (lastShownNumOfRaids ~= #MRT_RaidLog) then
            MRT_GUI_CompleteTableUpdate();
        elseif (lastSelectedRaidNum and lastShownNumOfBosses ~= #MRT_RaidLog[lastSelectedRaidNum]["Bosskills"]) then
            MRT_GUI_RaidDetailsTableUpdate(lastSelectedRaidNum);
        else
            MRT_GUI_RaidAttendeesTableUpdate(lastSelectedRaidNum);
            MRT_GUI_BossDetailsTableUpdate(lastSelectedBossNum);
        end
    else
        MRT_GUIFrame:Hide();
        MRT_GUIFrame:SetScript("OnUpdate", nil);
    end
end


----------------------
--  Button handler  --
----------------------
function MRT_GUI_RaidExportComplete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then 
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_CreateRaidExport(raidnum, nil, nil);
end

function MRT_GUI_RaidExportNormal()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then 
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_CreateRaidExport(raidnum, nil, "N");
end

function MRT_GUI_RaidExportHard()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then 
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_CreateRaidExport(raidnum, nil, "H");
end

function MRT_GUI_RaidDelete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum == MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["Can not delete current raid"]);
        return;
    end
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.text = string.format(MRT_L.GUI["Confirm raid entry deletion"], raidnum);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.OnAccept = function() MRT_GUI_RaidDeleteAccept(raidnum); end
    StaticPopup_Show("MRT_GUI_ZeroRowDialog");
end

function MRT_GUI_RaidDeleteAccept(raidnum)
    table.remove(MRT_RaidLog, raidnum);
    -- Modify MRT_NumOfCurrentRaid if there is an active raid
    if (MRT_NumOfCurrentRaid ~= nil) then
        MRT_NumOfCurrentRaid = #MRT_RaidLog;
    end
    -- Do a table update
    MRT_GUI_CompleteTableUpdate();
end

function MRT_GUI_BossAdd()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local raidDiff;
    if (not mrt.isClassic) then
        raidDiff = GetRaidDifficultyID();
    else
        raidDiff = 1;
    end
    MRT_GUI_ThreeRowDialog_Title:SetText(MRT_L.GUI["Add bosskill"]);
    MRT_GUI_ThreeRowDialog_EB1_Text:SetText(MRT_L.GUI["Bossname"]);
    MRT_GUI_ThreeRowDialog_EB1:SetText("");
    MRT_GUI_ThreeRowDialog_EB2_Text:SetText(MRT_L.GUI["Difficulty N or H"]);
    if (raidDiff < 3) then
        MRT_GUI_ThreeRowDialog_EB2:SetText("N");
    else
        MRT_GUI_ThreeRowDialog_EB2:SetText("H");
    end
    MRT_GUI_ThreeRowDialog_EB3_Text:SetText(MRT_L.GUI["Time"]);
    MRT_GUI_ThreeRowDialog_EB3:SetText("");
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnEnter", function() MRT_GUI_SetTT(MRT_GUI_ThreeRowDialog_EB3, "Boss_Add_TimeEB"); end);
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnLeave", function() MRT_GUI_HideTT(); end);
    MRT_GUI_ThreeRowDialog_OKButton:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUI_ThreeRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_BossAddAccept(raidnum); end);
    MRT_GUI_ThreeRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_ThreeRowDialog:Show();
end

function MRT_GUI_BossAddAccept(raidnum)
    -- sanity check inputs - if error, print error message (bossname is free text, Time has to match HH:MM)
    local bossname = MRT_GUI_ThreeRowDialog_EB1:GetText();
    local difficulty = MRT_GUI_ThreeRowDialog_EB2:GetText();
    local enteredTime = MRT_GUI_ThreeRowDialog_EB3:GetText();
    local hours = nil;
    local minutes = nil;
    local bossTimestamp = nil;
    if (bossname == "") then
        MRT_Print(MRT_L.GUI["No boss name entered"]);
        return;
    end
    if (enteredTime == "") then
        -- check if there is an active raid
        if (MRT_NumOfCurrentRaid == nil) then
            MRT_Print(MRT_L.GUI["No active raid in progress. Please enter time."]);
            return;
        end
        hours = 255;
        minutes = 255;
    else
        hours, minutes = deformat(enteredTime, "%d:%d");
        if (hours == nil or minutes == nil or hours > 23 or hours < 0 or minutes > 59 or minutes < 0) then
            MRT_Print(MRT_L.GUI["No valid time entered"]);
            return;
        end
        -- check timeline of chosen raid
        local raidStart = MRT_RaidLog[raidnum]["StartTime"];
        local raidStartDateTable = date("*t", raidStart);
        raidStartDateTable.hour = hours;
        raidStartDateTable.min = minutes;
        bossTimestamp = time(raidStartDateTable);
        -- if bossTimestamp < raidStart, try raidStart + 24 hours (one day - time around 01:25 is next day)
        if (bossTimestamp < raidStart) then
            bossTimestamp = bossTimestamp + 86400;
        end
        local raidStop = MRT_RaidLog[raidnum]["StopTime"];
        if (MRT_RaidLog[raidnum]["StopTime"] == nil) then 
            if (bossTimestamp < raidStart or bossTimestamp > time()) then
                MRT_Print(MRT_L.GUI["Entered time is not between start and end of raid"]);
                return;
            end
        else
            if (bossTimestamp < raidStart or bossTimestamp > raidStop) then
                MRT_Print(MRT_L.GUI["Entered time is not between start and end of raid"]);
                return;
            end
        end
    end
    MRT_GUI_HideDialogs();
    local insertPos = nil;
    -- add boss to kill list
    -- if boss shall be added as last recent boss kill, just call 'AddBosskill' - else do it manually
    if (hours == 255 and minutes == 255) then
        if (difficulty == "H") then
            MRT_AddBosskill(bossname, "H");
        else
            MRT_AddBosskill(bossname, "N");
        end;
    else
        -- prepare bossdata table
        local bossdata = {};
        bossdata["Players"] = {};
        bossdata["Name"] = bossname;
        bossdata["Date"] = bossTimestamp;
        bossdata["Difficulty"] = MRT_RaidLog[raidnum]["DiffID"];
        if (difficulty == "H" and (bossdata["Difficulty"] == 3 or bossdata["Difficulty"] == 4)) then
            bossdata["Difficulty"] = bossdata["Difficulty"] + 2;
        end
        -- search position in RaidLog (based on time) and insert data
        if (#MRT_RaidLog[raidnum]["Bosskills"] > 0) then
            insertPos = 1;
            for i, val in ipairs(MRT_RaidLog[raidnum]["Bosskills"]) do
                if (bossTimestamp > val["Date"]) then
                    insertPos = i + 1;
                end
            end
            tinsert(MRT_RaidLog[raidnum]["Bosskills"], insertPos, bossdata);
            -- update data of associated loot
            for i, val in ipairs(MRT_RaidLog[raidnum]["Loot"]) do
                if (insertPos <= val["BossNumber"]) then
                    val["BossNumber"] = val["BossNumber"] + 1;
                end
            end
        else
            tinsert(MRT_RaidLog[raidnum]["Bosskills"], bossdata);
            insertPos = 1;
        end
        -- if current raid was modified, change raid parameters accordingly
        if (MRT_NumOfCurrentRaid and raidnum == MRT_NumOfCurrentRaid) then
            MRT_NumOfLastBoss = #MRT_RaidLog[raidnum]["Bosskills"];
        end
        -- save raid attendees as boss attendees for the new boss
        for key, val in pairs(MRT_RaidLog[raidnum]["Players"]) do
            if (val["Join"] < bossTimestamp and (val["Leave"] == nil or val["Leave"] > bossTimestamp)) then
                tinsert(MRT_RaidLog[raidnum]["Bosskills"][insertPos]["Players"], val["Name"]);
            end
        end
    end
    -- Do a table update, if the displayed raid was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum_selected == raidnum) then
        MRT_GUI_RaidDetailsTableUpdate(raidnum);
    end
end

function MRT_GUI_BossDelete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then
        MRT_Print(MRT_L.GUI["No boss selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    local bossname = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 3);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.text = string.format(MRT_L.GUI["Confirm boss entry deletion"], bossnum, bossname);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.OnAccept = function() MRT_GUI_BossDeleteAccept(raidnum, bossnum); end
    StaticPopup_Show("MRT_GUI_ZeroRowDialog");
end

function MRT_GUI_BossDeleteAccept(raidnum, bossnum)
    table.remove(MRT_RaidLog[raidnum]["Bosskills"], bossnum);
    -- Modify MRT_NumOfLastBoss if active raid was modified
    if (MRT_NumOfCurrentRaid == raidnum) then
        MRT_NumOfLastBoss = #MRT_RaidLog[raidnum]["Bosskills"];
    end
    -- update data of associated loot
    local lootDeleteList = {}
    for i, val in ipairs(MRT_RaidLog[raidnum]["Loot"]) do
        if (bossnum == val["BossNumber"]) then
            tinsert(lootDeleteList, i);
        end
        if (bossnum < val["BossNumber"]) then
            val["BossNumber"] = val["BossNumber"] - 1;
        end
    end
    -- sort table - descending order
    table.sort(lootDeleteList, function(val1, val2) return (val1 > val2); end);
    -- delete loot associated with deleted boss
    for i, num in ipairs(lootDeleteList) do
        tremove(MRT_RaidLog[raidnum]["Loot"], num);
    end
    -- Do a table update, if the displayed raid was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum_selected == raidnum) then
        MRT_GUI_RaidDetailsTableUpdate(raidnum);
    end
end

function MRT_GUI_BossExport()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then
        MRT_Print(MRT_L.GUI["No boss selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    MRT_CreateRaidExport(raidnum, bossnum, nil);
end

function MRT_GUI_RaidAttendeeAdd()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_GUI_ThreeRowDialog_Title:SetText(MRT_L.GUI["Add raid attendee"]);
    MRT_GUI_ThreeRowDialog_EB1_Text:SetText(MRT_L.GUI["Col_Name"]);
    MRT_GUI_ThreeRowDialog_EB1:SetText("");
    MRT_GUI_ThreeRowDialog_EB2_Text:SetText(MRT_L.GUI["Col_Join"]);
    MRT_GUI_ThreeRowDialog_EB2:SetText("");
    MRT_GUI_ThreeRowDialog_EB2:SetScript("OnEnter", function() MRT_GUI_SetTT(MRT_GUI_ThreeRowDialog_EB2, "Attendee_Add_JoinEB"); end);
    MRT_GUI_ThreeRowDialog_EB2:SetScript("OnLeave", function() MRT_GUI_HideTT(); end);
    MRT_GUI_ThreeRowDialog_EB3_Text:SetText(MRT_L.GUI["Col_Leave"]);
    MRT_GUI_ThreeRowDialog_EB3:SetText("");
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnEnter", function() MRT_GUI_SetTT(MRT_GUI_ThreeRowDialog_EB3, "Attendee_Add_LeaveEB"); end);
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnLeave", function() MRT_GUI_HideTT(); end);
    MRT_GUI_ThreeRowDialog_OKButton:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUI_ThreeRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_RaidAttendeeAddAccept(raidnum); end);
    MRT_GUI_ThreeRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_ThreeRowDialog:Show();
end

function MRT_GUI_RaidAttendeeAddAccept(raidnum)
    -- sanity check inputs - if error, print error message (bossname is free text, time has to match HH:MM)
    local currentTime = MRT_GetCurrentTime();
    local playerName = MRT_GUI_ThreeRowDialog_EB1:GetText();
    local joinTime = MRT_GUI_ThreeRowDialog_EB2:GetText();
    local leaveTime = MRT_GUI_ThreeRowDialog_EB3:GetText();
    local joinTimestamp, leaveTimestamp;
    local raidStart = MRT_RaidLog[raidnum]["StartTime"];
    local raidStop;
    if (raidnum == MRT_NumOfCurrentRaid) then
        raidStop = currentTime;
    else
        raidStop = MRT_RaidLog[raidnum]["StopTime"];
    end
    -- check name
    if (playerName == "") then
        MRT_Print(MRT_L.GUI["No name entered"]);
        return;
    end
    -- check format of join time and create join timestamp
    if (joinTime == "") then
        joinTimestamp = MRT_RaidLog[raidnum]["StartTime"] + 1;
    else
        local joinHours, joinMinutes = deformat(joinTime, "%d:%d");
        if (joinHours == nil or joinMinutes == nil or joinHours > 23 or joinHours < 0 or joinMinutes > 59 or joinMinutes < 0) then
            MRT_Print(MRT_L.GUI["No valid time entered"]);
            return;
        end
        -- check timeline of chosen raid
        local raidStartDateTable = date("*t", raidStart);
        raidStartDateTable.hour = joinHours;
        raidStartDateTable.min = joinMinutes;
        joinTimestamp = time(raidStartDateTable);
        -- if joinTimestamp < raidStart, try raidStart + 24 hours (one day - time around 01:25 is next day)
        if (joinTimestamp < raidStart) then
            joinTimestamp = joinTimestamp + 86400;
        end
    end
    -- check format of leave time and create leave timestamp
    if (leaveTime == "") then
        if (raidnum == MRT_NumOfCurrentRaid) then
            leaveTimestamp = currentTime - 1;
        else
            leaveTimestamp = MRT_RaidLog[raidnum]["StopTime"] - 1;
        end
    else
        local leaveHours, leaveMinutes = deformat(leaveTime, "%d:%d");
        if (leaveHours == nil or leaveMinutes == nil or leaveHours > 23 or leaveHours < 0 or leaveMinutes > 59 or leaveMinutes < 0) then
            MRT_Print(MRT_L.GUI["No valid time entered"]);
            return;
        end
        -- check timeline of chosen raid
        local raidStartDateTable = date("*t", raidStart);
        raidStartDateTable.hour = leaveHours;
        raidStartDateTable.min = leaveMinutes;
        leaveTimestamp = time(raidStartDateTable);
        -- if leaveTimestamp < raidStart, try raidStart + 24 hours (one day - time around 01:25 is next day)
        if (leaveTimestamp < raidStart) then
            leaveTimestamp = leaveTimestamp + 86400;
        end
    end
    -- check if timestamps make sense
    if not (raidStart < joinTimestamp and joinTimestamp < raidStop and raidStart < leaveTimestamp and leaveTimestamp < raidStop) then
        MRT_Print(MRT_L.GUI["Entered time is not between start and end of raid"]);
        return;
    end
    if (joinTimestamp > leaveTimestamp) then
        MRT_Print(MRT_L.GUI["Entered join time is not before leave time"]);
        MRT_Debug(tostring(joinTimestamp).." > "..tostring(leaveTimestamp));
        return;
    end
    MRT_GUI_HideDialogs();
    -- if we reach this point, we should have a valid raidnum, playername, join timestamp and leave timestamp - now add them to the raid attendee list...
    local playerInfo = {
        ["Name"] = playerName,
        ["Join"] = joinTimestamp,
        ["Leave"] = leaveTimestamp,
    };
    tinsert(MRT_RaidLog[raidnum]["Players"], playerInfo);
    -- ... and as boss attendee to the relevant bosses
    for i, val in ipairs(MRT_RaidLog[raidnum]["Bosskills"]) do
        if (joinTimestamp < val["Date"] and val["Date"] < leaveTimestamp) then
            local playerList = {};
            for j, val2 in ipairs(val["Players"]) do
                playerList[val2] = true;
            end
            if (not playerList[playerName]) then
                tinsert(val["Players"], playerName);
            end
        end
    end
    -- Do a table update, if the displayed raid was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum_selected == raidnum) then
        MRT_GUI_RaidAttendeesTableUpdate(raidnum);
    else
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then return; end
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    MRT_GUI_BossAttendeesTableUpdate(bossnum);
end

function MRT_GUI_RaidAttendeeDelete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local attendee_select = MRT_GUI_RaidAttendeesTable:GetSelection();
    if (attendee_select == nil) then
        MRT_Print(MRT_L.GUI["No raid attendee selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local attendee = MRT_GUI_RaidAttendeesTable:GetCell(attendee_select, 1);
    local attendeeName = MRT_GUI_RaidAttendeesTable:GetCell(attendee_select, 2);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.text = string.format(MRT_L.GUI["Confirm raid attendee entry deletion"], attendeeName);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.OnAccept = function() MRT_GUI_RaidAttendeeDeleteAccept(raidnum, attendee); end
    StaticPopup_Show("MRT_GUI_ZeroRowDialog");
end

function MRT_GUI_RaidAttendeeDeleteAccept(raidnum, attendee)
    local playerInfo = MRT_RaidLog[raidnum]["Players"][attendee];
    if (not playerInfo["Leave"]) then
        playerInfo["Leave"] = MRT_GetCurrentTime();
    end
    -- Delete player from the boss attendees lists...
    for i, val in ipairs(MRT_RaidLog[raidnum]["Bosskills"]) do
        if (playerInfo["Join"] < val["Date"] and val["Date"] < playerInfo["Leave"]) then
            local playerPos;
            for j, val2 in ipairs(val["Players"]) do
                if (val2 == playerInfo["Name"]) then
                    playerPos = j;
                end
            end
            if (playerPos) then
                tremove(val["Players"], playerPos);
            end
        end
    end
    -- ...and raid attendees list
    MRT_RaidLog[raidnum]["Players"][attendee] = nil;
    -- Do a table update, if the displayed raid was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum_selected == raidnum) then
        MRT_GUI_RaidAttendeesTableUpdate(raidnum);
    else
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then return; end
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    MRT_GUI_BossAttendeesTableUpdate(bossnum);
end

function MRT_GUI_LootAdd()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then
        MRT_Print(MRT_L.GUI["No boss selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    -- gather playerdata and fill drop down menu
    local playerData = {};
    for i, val in ipairs(MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"]) do
        playerData[i] = { val };
    end
    table.sort(playerData, function(a, b) return (a[1] < b[1]); end );
    tinsert(playerData, 1, { "disenchanted" } );
    tinsert(playerData, 1, { "bank" } );
    MRT_GUI_PlayerDropDownTable:SetData(playerData, true);
    if (#playerData < 9) then
        MRT_GUI_PlayerDropDownTable:SetDisplayRows(#playerData, 15);
    else
        MRT_GUI_PlayerDropDownTable:SetDisplayRows(9, 15);
    end
    MRT_GUI_PlayerDropDownTable.frame:Hide();
    -- prepare dialog
    MRT_GUI_FourRowDialog_Title:SetText(MRT_L.GUI["Add loot data"]);
    MRT_GUI_FourRowDialog_EB1_Text:SetText(MRT_L.GUI["Itemlink"]);
    MRT_GUI_FourRowDialog_EB1:SetText("");
    MRT_GUI_FourRowDialog_EB2_Text:SetText(MRT_L.GUI["Looter"]);
    MRT_GUI_FourRowDialog_EB2:SetText("");
    MRT_GUI_FourRowDialog_EB3_Text:SetText(MRT_L.GUI["Value"]);
    MRT_GUI_FourRowDialog_EB3:SetText("");
    MRT_GUI_FourRowDialog_EB4_Text:SetText(MRT_L.GUI["Note"]);
    MRT_GUI_FourRowDialog_EB4:SetText("");
    MRT_GUI_FourRowDialog_OKButton:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUI_FourRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_LootModifyAccept(raidnum, bossnum, nil); end);
    MRT_GUI_FourRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_FourRowDialog:Show();
end

function MRT_GUI_LootModify()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local loot_select = MRT_GUI_BossLootTable:GetSelection();
    if (loot_select == nil) then
        MRT_Print(MRT_L.GUI["No loot selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local lootnum = MRT_GUI_BossLootTable:GetCell(loot_select, 1);
    local bossnum = MRT_RaidLog[raidnum]["Loot"][lootnum]["BossNumber"];
    local lootnote = MRT_RaidLog[raidnum]["Loot"][lootnum]["Note"];
    -- Force item into cache:
    GetItemInfo(MRT_RaidLog[raidnum]["Loot"][lootnum]["ItemLink"]);
    -- gather playerdata and fill drop down menu
    local playerData = {};
    for i, val in ipairs(MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"]) do
        playerData[i] = { val };
    end
    table.sort(playerData, function(a, b) return (a[1] < b[1]); end );
    tinsert(playerData, 1, { "disenchanted" } );
    tinsert(playerData, 1, { "bank" } );
    MRT_GUI_PlayerDropDownTable:SetData(playerData, true);
    if (#playerData < 9) then
        MRT_GUI_PlayerDropDownTable:SetDisplayRows(#playerData, 15);
    else
        MRT_GUI_PlayerDropDownTable:SetDisplayRows(9, 15);
    end
    MRT_GUI_PlayerDropDownTable.frame:Hide();
    -- prepare dialog
    MRT_GUI_FourRowDialog_Title:SetText(MRT_L.GUI["Modify loot data"]);
    MRT_GUI_FourRowDialog_EB1_Text:SetText(MRT_L.GUI["Itemlink"]);
    MRT_GUI_FourRowDialog_EB1:SetText(MRT_RaidLog[raidnum]["Loot"][lootnum]["ItemLink"]);
    MRT_GUI_FourRowDialog_EB2_Text:SetText(MRT_L.GUI["Looter"]);
    MRT_GUI_FourRowDialog_EB2:SetText(MRT_GUI_BossLootTable:GetCell(loot_select, 4));
    MRT_GUI_FourRowDialog_EB3_Text:SetText(MRT_L.GUI["Value"]);
    MRT_GUI_FourRowDialog_EB3:SetText(MRT_GUI_BossLootTable:GetCell(loot_select, 5));
    MRT_GUI_FourRowDialog_EB4_Text:SetText(MRT_L.GUI["Note"]);
    if (lootnote == nil or lootnote == "" or lootnote == " ") then
        MRT_GUI_FourRowDialog_EB4:SetText("");
    else
        MRT_GUI_FourRowDialog_EB4:SetText(lootnote);
    end
    MRT_GUI_FourRowDialog_OKButton:SetText(MRT_L.GUI["Button_Modify"]);
    MRT_GUI_FourRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_LootModifyAccept(raidnum, bossnum, lootnum); end);
    MRT_GUI_FourRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_FourRowDialog:Show();
end

function MRT_GUI_PlayerDropDownList_Toggle()
    if (MRT_GUI_PlayerDropDownTable.frame:IsShown()) then
        MRT_GUI_PlayerDropDownTable.frame:Hide();
    else
        MRT_GUI_PlayerDropDownTable.frame:Show();
        MRT_GUI_PlayerDropDownTable.frame:SetPoint("TOPRIGHT", MRT_GUI_FourRowDialog_DropDownButton, "BOTTOMRIGHT", 0, 0);
    end
end

function MRT_GUI_LootModifyAccept(raidnum, bossnum, lootnum)
    local itemLink = MRT_GUI_FourRowDialog_EB1:GetText();
    local looter = MRT_GUI_FourRowDialog_EB2:GetText();
    local cost = MRT_GUI_FourRowDialog_EB3:GetText();
    local lootNote = MRT_GUI_FourRowDialog_EB4:GetText();
    if (cost == "") then cost = 0; end
    cost = tonumber(cost);
    if (lootNote == nil or lootNote == "" or lootNote == " ") then lootNote = nil; end
    -- sanity-check values here - especially the itemlink / looter is free text / cost has to be a number
    local itemName, itemLink, itemId, itemString, itemRarity, itemColor, _, _, _, _, _, _, _, _ = MRT_GetDetailedItemInformation(itemLink);
    if (not itemName) then
        MRT_Print(MRT_L.GUI["No itemLink found"]);
        return;
    end
    if (not cost) then
        MRT_Print(MRT_L.GUI["Item cost invalid"]);
        return;
    end
    MRT_GUI_HideDialogs();
    -- insert new values here / if (lootnum == nil) then treat as a newly added item
    if (looter == "") then looter = "disenchanted"; end
    local MRT_LootInfo = {
        ["ItemLink"] = itemLink,
        ["ItemString"] = itemString,
        ["ItemId"] = itemId,
        ["ItemName"] = itemName,
        ["ItemColor"] = itemColor,
        ["BossNumber"] = bossnum,
        ["Looter"] = looter,
        ["DKPValue"] = cost,
        ["Note"] = lootNote,
    }
    if (lootnum) then
        local oldLootDB = MRT_RaidLog[raidnum]["Loot"][lootnum];
        -- create a copy of the old loot data for the api
        local oldItemInfoTable = {}
        for key, val in pairs(oldLootDB) do
            oldItemInfoTable[key] = val;
        end
        MRT_LootInfo["ItemCount"] = oldLootDB["ItemCount"];
        MRT_LootInfo["Time"] = oldLootDB["Time"];
        MRT_RaidLog[raidnum]["Loot"][lootnum] = MRT_LootInfo;
        -- notify registered, external functions
        if (#MRT_ExternalLootNotifier > 0) then
            local itemInfo = {};
            for key, val in pairs(MRT_RaidLog[raidnum]["Loot"][lootnum]) do
                itemInfo[key] = val;
            end
            if (oldItemInfoTable.Looter == "bank") then
                oldItemInfoTable.Action = MRT_LOOTACTION_BANK;
            elseif (oldItemInfoTable.Looter == "disenchanted") then
                oldItemInfoTable.Action = MRT_LOOTACTION_DISENCHANT;
            elseif (oldItemInfoTable.Looter == "_deleted_") then
                oldItemInfoTable.Action = MRT_LOOTACTION_DELETE;
            else
                oldItemInfoTable.Action = MRT_LOOTACTION_NORMAL;
            end
            if (itemInfo.Looter == "bank") then
                itemInfo.Action = MRT_LOOTACTION_BANK;
            elseif (itemInfo.Looter == "disenchanted") then
                itemInfo.Action = MRT_LOOTACTION_DISENCHANT;
            elseif (itemInfo.Looter == "_deleted_") then
                itemInfo.Action = MRT_LOOTACTION_DELETE;
            else
                itemInfo.Action = MRT_LOOTACTION_NORMAL;
            end
            for i, val in ipairs(MRT_ExternalLootNotifier) do
                pcall(val, itemInfo, MRT_NOTIFYSOURCE_EDIT_GUI, raidnum, lootnum, oldItemInfoTable);
            end
        end
    else
        MRT_LootInfo["ItemCount"] = 1;
        MRT_LootInfo["Time"] = MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Date"] + 15;
        tinsert(MRT_RaidLog[raidnum]["Loot"], MRT_LootInfo);
        -- notify registered, external functions
        if (#MRT_ExternalLootNotifier > 0) then
            local itemNum = #MRT_RaidLog[raidnum]["Loot"];
            local itemInfo = {};
            for key, val in pairs(MRT_RaidLog[raidnum]["Loot"][itemNum]) do
                itemInfo[key] = val;
            end
            if (itemInfo.Looter == "bank") then
                itemInfo.Action = MRT_LOOTACTION_BANK;
            elseif (itemInfo.Looter == "disenchanted") then
                itemInfo.Action = MRT_LOOTACTION_DISENCHANT;
            elseif (itemInfo.Looter == "_deleted_") then
                itemInfo.Action = MRT_LOOTACTION_DELETE;
            else
                itemInfo.Action = MRT_LOOTACTION_NORMAL;
            end
            for i, val in ipairs(MRT_ExternalLootNotifier) do
                pcall(val, itemInfo, MRT_NOTIFYSOURCE_ADD_GUI, raidnum, itemNum);
            end
        end
    end
    -- do table update, if selected loot table was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then 
        if (raidnum_selected == raidnum) then
            MRT_GUI_BossLootTableUpdate(nil);
        end
        return; 
    end
    local bossnum_selected = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    if (raidnum_selected == raidnum and bossnum_selected == bossnum) then
        MRT_GUI_BossLootTableUpdate(bossnum);
    end
end

function MRT_GUI_LootDelete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local loot_select = MRT_GUI_BossLootTable:GetSelection();
    if (loot_select == nil) then
        MRT_Print(MRT_L.GUI["No loot selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local lootnum = MRT_GUI_BossLootTable:GetCell(loot_select, 1);
    local bossnum = MRT_RaidLog[raidnum]["Loot"][lootnum]["BossNumber"];
    local lootName = MRT_GUI_BossLootTable:GetCell(loot_select, 3);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.text = string.format(MRT_L.GUI["Confirm loot entry deletion"], lootName);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.OnAccept = function() MRT_GUI_LootDeleteAccept(raidnum, bossnum, lootnum); end
    StaticPopup_Show("MRT_GUI_ZeroRowDialog");
end

function MRT_GUI_LootDeleteAccept(raidnum, bossnum, lootnum)
    if (#MRT_ExternalLootNotifier > 0) then
        local itemInfo = {};
        for key, val in pairs(MRT_RaidLog[raidnum]["Loot"][lootnum]) do
            itemInfo[key] = val;
        end
        if (itemInfo.Looter == "bank") then
            itemInfo.Action = MRT_LOOTACTION_BANK;
        elseif (itemInfo.Looter == "disenchanted") then
            itemInfo.Action = MRT_LOOTACTION_DISENCHANT;
        elseif (itemInfo.Looter == "_deleted_") then
            itemInfo.Action = MRT_LOOTACTION_DELETE;
        else
            itemInfo.Action = MRT_LOOTACTION_NORMAL;
        end
        for i, val in ipairs(MRT_ExternalLootNotifier) do
            pcall(val, itemInfo, MRT_NOTIFYSOURCE_DELETE_GUI, raidnum, lootnum);
        end
    end
    tremove(MRT_RaidLog[raidnum]["Loot"], lootnum);
    -- do table update, if selected loot table was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then 
        if (raidnum_selected == raidnum) then
            MRT_GUI_BossLootTableUpdate(nil);
        end
        return; 
    end
    local bossnum_selected = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    if (raidnum_selected == raidnum and bossnum_selected == bossnum) then
        MRT_GUI_BossLootTableUpdate(bossnum);
    end
end

function MRT_GUI_BossAttendeeAdd()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then
        MRT_Print(MRT_L.GUI["No boss selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    MRT_GUI_OneRowDialog_Title:SetText(MRT_L.GUI["Add boss attendee"]);
    MRT_GUI_OneRowDialog_EB1_Text:SetText(MRT_L.GUI["Col_Name"]);
    MRT_GUI_OneRowDialog_EB1:SetText("");
    MRT_GUI_OneRowDialog_OKButton:SetText(MRT_L.GUI["Button_Add"]);
    MRT_GUI_OneRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_BossAttendeeAddAccept(raidnum, bossnum); end);
    MRT_GUI_OneRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_OneRowDialog:Show();
end

function MRT_GUI_BossAttendeeAddAccept(raidnum, bossnum)
    MRT_GUI_HideDialogs();
    local attendee = MRT_GUI_OneRowDialog_EB1:GetText();
    tinsert(MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"], attendee);
    -- do table update, if selected attendee table was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then return; end
    local bossnum_selected = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    if (raidnum_selected == raidnum and bossnum_selected == bossnum) then
        MRT_GUI_BossAttendeesTableUpdate(bossnum);
    end
end

function MRT_GUI_BossAttendeeDelete()
    MRT_GUI_HideDialogs();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        MRT_Print(MRT_L.GUI["No raid selected"]);
        return;
    end
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then
        MRT_Print(MRT_L.GUI["No boss selected"]);
        return;
    end
    local attendee_select = MRT_GUI_BossAttendeesTable:GetSelection();
    if (attendee_select == nil) then
        MRT_Print(MRT_L.GUI["No boss attendee selected"]);
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local bossnum = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    local attendeenum = MRT_GUI_BossAttendeesTable:GetCell(attendee_select, 1);
    local attendeeName = MRT_GUI_BossAttendeesTable:GetCell(attendee_select, 2);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.text = string.format(MRT_L.GUI["Confirm boss attendee entry deletion"], attendeeName);
    StaticPopupDialogs.MRT_GUI_ZeroRowDialog.OnAccept = function() MRT_GUI_BossAttendeeDeleteAccept(raidnum, bossnum, attendeenum); end
    StaticPopup_Show("MRT_GUI_ZeroRowDialog");
end

function MRT_GUI_BossAttendeeDeleteAccept(raidnum, bossnum, attendeenum)
    --MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"][attendeenum] = nil;
    tremove(MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"], attendeenum);
    -- do table update, if selected attendee table was modified
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then return; end
    local raidnum_selected = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    local boss_select = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (boss_select == nil) then return; end
    local bossnum_selected = MRT_GUI_RaidBosskillsTable:GetCell(boss_select, 1);
    if (raidnum_selected == raidnum and bossnum_selected == bossnum) then
        MRT_GUI_BossAttendeesTableUpdate(bossnum);
    end
end

function MRT_GUI_TakeSnapshot()
    local status = MRT_TakeSnapshot();
    if (status) then
        MRT_GUI_RaidLogTableUpdate();
    end
end

function MRT_GUI_StartNewRaid()
    if (MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["Active raid found. End current one first."]);
        return;
    end
    if (not MRT_IsInRaid()) then
        MRT_Print(MRT_L.GUI["Player not in raid."]);
        return;
    end
    MRT_GUI_TwoRowDialog_Title:SetText(MRT_L.GUI["Button_StartNewRaid"]);
    MRT_GUI_TwoRowDialog_DDM:Show();
    MRT_GUI_TwoRowDialog_EB1_Text:SetText(MRT_L.GUI["Zone name"]);
    MRT_GUI_TwoRowDialog_EB1:SetText("");
    MRT_GUI_TwoRowDialog_EB1:SetScript("OnEnter", function() MRT_GUI_SetTT(MRT_GUI_TwoRowDialog_EB1, "StartNewRaid_ZoneNameEB"); end);
    MRT_GUI_TwoRowDialog_EB1:SetScript("OnLeave", function() MRT_GUI_HideTT(); end);
    MRT_GUI_TwoRowDialog_EB2:Hide();
    MRT_GUI_TwoRowDialog_OKButton:SetText(MRT_L.Core["MB_Ok"]);
    MRT_GUI_TwoRowDialog_OKButton:SetScript("OnClick", function() MRT_GUI_StartNewRaidAccept(); end);
    MRT_GUI_TwoRowDialog_CancelButton:SetText(MRT_L.Core["MB_Cancel"]);
    MRT_GUI_TwoRowDialog:Show();
end

function MRT_GUI_StartNewRaidAccept()
    local diffIDList = { 16, 15, 14, 17, 9, 4, 3 }
    local zoneName = MRT_GUI_TwoRowDialog_EB1:GetText()
    local diffId = diffIDList[MRT_Lib_UIDropDownMenu_GetSelectedID(MRT_GUI_TwoRowDialog_DDM)]
    local raidSize = mrt.raidSizes[diffId]
    -- Hide dialogs
    MRT_GUI_HideDialogs();
    -- check current raidstatus is ok
    if (MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["Active raid found. End current one first."]);
        return;
    end
    if (not MRT_IsInRaid()) then
        MRT_Print(MRT_L.GUI["Player not in raid."]);
        return;
    end
    -- if no zoneName was entered, use the current zone
    if (zoneName == "" or zoneName == " " or zoneName == nil) then
        zoneName = GetRealZoneText();
    end
    -- create new raid
    MRT_CreateNewRaid(zoneName, raidSize, diffId);
    MRT_GUI_CompleteTableUpdate();
end

function MRT_GUI_MakeAttendanceCheck()
    if (not MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["No active raid"]);
        return;
    end
    MRT_AddBosskill(MRT_L.Core["GuildAttendanceBossEntry"]);
    MRT_StartGuildAttendanceCheck("_attendancecheck_");
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    if (raidnum == MRT_NumOfCurrentRaid) then
        MRT_GUI_RaidDetailsTableUpdate(raidnum);
    end
end

function MRT_GUI_EndCurrentRaid()
    if (not MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["No active raid"]);
        return;
    end
    MRT_EndActiveRaid();
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_GUI_RaidAttendeesTableUpdate(raidnum);
end

function MRT_GUI_ResumeLastRaid()
    if (MRT_NumOfCurrentRaid) then
        MRT_Print(MRT_L.GUI["Active raid in progress."]);
        return;
    end
    if (not MRT_IsInRaid()) then
        MRT_Print(MRT_L.GUI["Player not in raid."]);
        return; 
    end
    local success = MRT_ResumeLastRaid();
    if (not success) then
        MRT_Print(MRT_L.GUI["Resuming last raid failed"]);
        return;
    else
        MRT_Print(MRT_L.GUI["Resuming last raid successful"]);
    end
    local raid_select = MRT_GUI_RaidLogTable:GetSelection();
    if (raid_select == nil) then
        return;
    end
    local raidnum = MRT_GUI_RaidLogTable:GetCell(raid_select, 1);
    MRT_GUI_RaidAttendeesTableUpdate(raidnum);
end


-----------------------
--  ToolTip handler  --
-----------------------
function MRT_GUI_SetTT(frame, button)
    MRT_GUI_TT:SetOwner(frame, "ANCHOR_BOTTOMRIGHT");
    MRT_GUI_TT:SetText(MRT_L.GUI["TT_"..button]);
    MRT_GUI_TT:Show();
end

function MRT_GUI_HideTT()
    MRT_GUI_TT:Hide();
    MRT_GUI_TT:SetOwner(UIParent, "ANCHOR_NONE");
end


------------------------
--  OnUpdate handler  --
------------------------
-- Is there a better way to handle OnClick-Events from each table without overwriting the sort functions?
function MRT_GUI_OnUpdateHandler()
    local raidnum = MRT_GUI_RaidLogTable:GetSelection();
    local bossnum = MRT_GUI_RaidBosskillsTable:GetSelection();
    if (raidnum ~= MRT_GUI_RaidLogTableSelection) then
        MRT_GUI_RaidLogTableSelection = raidnum;
        if (raidnum) then
            MRT_GUI_RaidDetailsTableUpdate(MRT_GUI_RaidLogTable:GetCell(raidnum, 1));
        else
            MRT_GUI_RaidDetailsTableUpdate(nil);
        end
    end
    if (bossnum ~= MRT_GUI_RaidBosskillsTableSelection) then
        MRT_GUI_RaidBosskillsTableSelection = bossnum;
        if (bossnum) then
            MRT_GUI_BossDetailsTableUpdate(MRT_GUI_RaidBosskillsTable:GetCell(bossnum, 1))
        else
            MRT_GUI_BossDetailsTableUpdate(nil);
        end
    end
end


------------------------------
--  table update functions  --
------------------------------
-- update all tables
function MRT_GUI_CompleteTableUpdate()
    MRT_GUI_RaidLogTableUpdate();
    MRT_GUI_RaidDetailsTableUpdate(nil);
    MRT_GUI_BossDetailsTableUpdate(nil);
end

-- update raid details tables
function MRT_GUI_RaidDetailsTableUpdate(raidnum)
    MRT_GUI_RaidAttendeesTableUpdate(raidnum);
    MRT_GUI_RaidBosskillsTableUpdate(raidnum);
    MRT_GUI_BossDetailsTableUpdate(nil);
end

-- update boss details tables
function MRT_GUI_BossDetailsTableUpdate(bossnum)
    MRT_GUI_BossLootTableUpdate(bossnum);
    MRT_GUI_BossAttendeesTableUpdate(bossnum);
end

-- update raid list table
function MRT_GUI_RaidLogTableUpdate()
    if (MRT_RaidLog == nil) then return; end
    local MRT_GUI_RaidLogTableData = {};
    -- insert reverse order
    for i, v in ipairs(MRT_RaidLog) do
        MRT_GUI_RaidLogTableData[i] = {i, date("%m/%d %H:%M", v["StartTime"]), v["RaidZone"], v["RaidSize"]};
    end
    table.sort(MRT_GUI_RaidLogTableData, function(a, b) return (a[1] > b[1]); end);
    MRT_GUI_RaidLogTable:ClearSelection();
    MRT_GUI_RaidLogTable:SetData(MRT_GUI_RaidLogTableData, true);
    lastShownNumOfRaids = #MRT_RaidLog;
end

-- update raid attendees table
function MRT_GUI_RaidAttendeesTableUpdate(raidnum)
    local MRT_GUI_RaidAttendeesTableData = {};
    if (raidnum) then
        local index = 1;
        for k, v in pairs(MRT_RaidLog[raidnum]["Players"]) do
            if (v["Leave"]) then
                MRT_GUI_RaidAttendeesTableData[index] = {k, v["Name"], date("%H:%M", v["Join"]), date("%H:%M", v["Leave"])};
            else
                MRT_GUI_RaidAttendeesTableData[index] = {k, v["Name"], date("%H:%M", v["Join"]), ""};
            end
            index = index + 1;
        end
    end
    table.sort(MRT_GUI_RaidAttendeesTableData, function(a, b) return (a[2] < b[2]); end);
    MRT_GUI_RaidAttendeesTable:ClearSelection();
    MRT_GUI_RaidAttendeesTable:SetData(MRT_GUI_RaidAttendeesTableData, true);
end

-- update bosskill table
function MRT_GUI_RaidBosskillsTableUpdate(raidnum)
    local MRT_GUI_RaidBosskillsTableData = {};
    local MRT_BosskillsCount = nil;
    if (raidnum) then MRT_BosskillsCount = #MRT_RaidLog[raidnum]["Bosskills"]; end;
    if (raidnum and MRT_BosskillsCount) then
        for i, v in ipairs(MRT_RaidLog[raidnum]["Bosskills"]) do
            if (not v["Difficulty"]) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], "-"};
            elseif (tContains(mrt.diffIDsNormal, v["Difficulty"])) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], PLAYER_DIFFICULTY1};
            elseif (tContains(mrt.diffIDsHeroic, v["Difficulty"])) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], PLAYER_DIFFICULTY2};
            elseif (v["Difficulty"] == 8) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], PLAYER_DIFFICULTY5};
            elseif (v["Difficulty"] == 16) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], PLAYER_DIFFICULTY6};
            elseif (tContains(mrt.diffIDsLFR, v["Difficulty"])) then
                MRT_GUI_RaidBosskillsTableData[i] = {i, date("%H:%M", v["Date"]), v["Name"], MRT_L.GUI.Cell_LFR};
            end
        end
    end
    table.sort(MRT_GUI_RaidBosskillsTableData, function(a, b) return (a[1] > b[1]); end);
    MRT_GUI_RaidBosskillsTable:ClearSelection();
    MRT_GUI_RaidBosskillsTable:SetData(MRT_GUI_RaidBosskillsTableData, true);
    lastSelectedRaidNum = raidnum;
    lastShownNumOfBosses = MRT_BosskillsCount;
end

-- update bossloot table
function MRT_GUI_BossLootTableUpdate(bossnum)
    local MRT_GUI_BossLootTableData = {};
    local raidnum;
    -- check if a raid is selected
    if (MRT_GUI_RaidLogTable:GetSelection()) then
        raidnum = MRT_GUI_RaidLogTable:GetCell(MRT_GUI_RaidLogTableSelection, 1);
    end
    -- if a bossnum is given, just list loot of this boss
    if (bossnum) then
        local index = 1;
        for i, v in ipairs(MRT_RaidLog[raidnum]["Loot"]) do
            if (v["BossNumber"] == bossnum) then
                MRT_GUI_BossLootTableData[index] = {i, v["ItemId"], "|c"..v["ItemColor"]..v["ItemName"].."|r", v["Looter"], v["DKPValue"], v["ItemLink"], v["Note"]};
                index = index + 1;
            end
        end
        MRT_GUIFrame_BossLootTitle:SetText(MRT_L.GUI["Tables_BossLootTitle"]);
    -- there is only a raidnum and no bossnum, list raid loot
    elseif (raidnum) then
        local index = 1;
        for i, v in ipairs(MRT_RaidLog[raidnum]["Loot"]) do
            MRT_GUI_BossLootTableData[index] = {i, v["ItemId"], "|c"..v["ItemColor"]..v["ItemName"].."|r", v["Looter"], v["DKPValue"], v["ItemLink"], v["Note"]};
            index = index + 1;
        end
        MRT_GUIFrame_BossLootTitle:SetText(MRT_L.GUI["Tables_RaidLootTitle"]);
    -- if either raidnum nor bossnum, show an empty table
    else
        MRT_GUIFrame_BossLootTitle:SetText(MRT_L.GUI["Tables_RaidLootTitle"]);
    end
    table.sort(MRT_GUI_BossLootTableData, function(a, b) return (a[3] < b[3]); end);
    MRT_GUI_BossLootTable:ClearSelection();
    MRT_GUI_BossLootTable:SetData(MRT_GUI_BossLootTableData, true);
    lastSelectedBossNum = bossnum;
end

-- update bossattendee table
function MRT_GUI_BossAttendeesTableUpdate(bossnum)
    local MRT_GUI_BossAttendeesTableData = {};
    if (bossnum) then
        local raidnum = MRT_GUI_RaidLogTable:GetCell(MRT_GUI_RaidLogTableSelection, 1);
        for i, v in ipairs(MRT_RaidLog[raidnum]["Bosskills"][bossnum]["Players"]) do
            MRT_GUI_BossAttendeesTableData[i] = {i, v};
        end
        MRT_GUIFrame_BossAttendeesTitle:SetText(MRT_L.GUI["Tables_BossAttendeesTitle"].." ("..tostring(#MRT_GUI_BossAttendeesTableData)..")");
    else
        MRT_GUIFrame_BossAttendeesTitle:SetText(MRT_L.GUI["Tables_BossAttendeesTitle"]);
    end
    table.sort(MRT_GUI_BossAttendeesTableData, function(a, b) return (a[2] < b[2]); end);
    MRT_GUI_BossAttendeesTable:ClearSelection();
    MRT_GUI_BossAttendeesTable:SetData(MRT_GUI_BossAttendeesTableData, true);
end


--------------------------------------
--  functions for the dialog boxes  --
--------------------------------------
function MRT_GUI_HideDialogs()
    StaticPopup_Hide("MRT_GUI_ZeroRowDialog");
    MRT_GUI_OneRowDialog_EB1:SetScript("OnEnter", nil);
    MRT_GUI_OneRowDialog_EB1:SetScript("OnLeave", nil);
    MRT_GUI_OneRowDialog:Hide();
    MRT_GUI_TwoRowDialog_DDM:Hide();
    MRT_GUI_TwoRowDialog_EB1:SetScript("OnEnter", nil);
    MRT_GUI_TwoRowDialog_EB1:SetScript("OnLeave", nil);
    MRT_GUI_TwoRowDialog_EB2:SetScript("OnEnter", nil);
    MRT_GUI_TwoRowDialog_EB2:SetScript("OnLeave", nil);
    MRT_GUI_TwoRowDialog_EB2:Show();
    MRT_GUI_TwoRowDialog:Hide();
    MRT_GUI_ThreeRowDialog_EB1:SetScript("OnEnter", nil);
    MRT_GUI_ThreeRowDialog_EB1:SetScript("OnLeave", nil);
    MRT_GUI_ThreeRowDialog_EB2:SetScript("OnEnter", nil);
    MRT_GUI_ThreeRowDialog_EB2:SetScript("OnLeave", nil);
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnEnter", nil);
    MRT_GUI_ThreeRowDialog_EB3:SetScript("OnLeave", nil);
    MRT_GUI_ThreeRowDialog:Hide();
    MRT_GUI_FourRowDialog_EB1:SetScript("OnEnter", nil);
    MRT_GUI_FourRowDialog_EB1:SetScript("OnLeave", nil);
    MRT_GUI_FourRowDialog_EB2:SetScript("OnEnter", nil);
    MRT_GUI_FourRowDialog_EB2:SetScript("OnLeave", nil);
    MRT_GUI_FourRowDialog_EB3:SetScript("OnEnter", nil);
    MRT_GUI_FourRowDialog_EB3:SetScript("OnLeave", nil);
    MRT_GUI_FourRowDialog_EB4:SetScript("OnEnter", nil);
    MRT_GUI_FourRowDialog_EB4:SetScript("OnLeave", nil);
    MRT_GUI_FourRowDialog:Hide();
    MRT_ExportFrame_Hide();
end

-- enable shift-click-parsing of item links
function MRT_GUI_Hook_ChatEdit_InsertLink(link)
    if MRT_GUI_OneRowDialog:IsVisible() then
        if MRT_GUI_OneRowDialog_EB1:HasFocus() then 
            MRT_GUI_OneRowDialog_EB1:SetText(link); 
        end
    end
    if MRT_GUI_TwoRowDialog:IsVisible() then
        if MRT_GUI_TwoRowDialog_EB1:HasFocus() then 
            MRT_GUI_TwoRowDialog_EB1:SetText(link);
        elseif MRT_GUI_TwoRowDialog_EB2:HasFocus() then 
            MRT_GUI_TwoRowDialog_EB2:SetText(link);
        end
    end
    if MRT_GUI_ThreeRowDialog:IsVisible() then
        if MRT_GUI_ThreeRowDialog_EB1:HasFocus() then 
            MRT_GUI_ThreeRowDialog_EB1:SetText(link); 
        elseif MRT_GUI_ThreeRowDialog_EB2:HasFocus() then 
            MRT_GUI_ThreeRowDialog_EB2:SetText(link);
        elseif MRT_GUI_ThreeRowDialog_EB3:HasFocus() then 
            MRT_GUI_ThreeRowDialog_EB3:SetText(link);
        end
    end
    if MRT_GUI_FourRowDialog:IsVisible() then
        if MRT_GUI_FourRowDialog_EB1:HasFocus() then 
            MRT_GUI_FourRowDialog_EB1:SetText(link); 
        elseif MRT_GUI_FourRowDialog_EB2:HasFocus() then 
            MRT_GUI_FourRowDialog_EB2:SetText(link);
        elseif MRT_GUI_FourRowDialog_EB3:HasFocus() then 
            MRT_GUI_FourRowDialog_EB3:SetText(link);
        elseif MRT_GUI_FourRowDialog_EB4:HasFocus() then 
            MRT_GUI_FourRowDialog_EB4:SetText(link);
        end
    end
end
-- Hook on ChatEdit_InsertLink - execute own parsing after standard WoW parsing
hooksecurefunc("ChatEdit_InsertLink", MRT_GUI_Hook_ChatEdit_InsertLink);


-------------------------------------
--  ZeroRowDialog as static popup  --
-------------------------------------
-- To show/hide this dialog: StaticPopup_Show("Popup name") / StaticPopup_Hide("Popup name")
StaticPopupDialogs["MRT_GUI_ZeroRowDialog"] = {
    preferredIndex = 3,
    text = "FIXME!",
    button1 = MRT_L.Core["MB_Yes"],
    button2 = MRT_L.Core["MB_No"],
    OnAccept = nil,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

