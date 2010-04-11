-- *********************************************************
-- **              Mizus Raid Tracker - GUI               **
-- **            <ENTER URL HERE>            **
-- *********************************************************
--
-- This addon is written and copyrighted by:
--    * Mizukichan @ EU-Thrall
--
-- The localizations are written by:
--    * enGB/enUS: Mizukichan
--    * deDE: Mizukichan
--
--
--    This file is part of Mizus Raid Tracker.
--
--    Mizus Raid Tracker is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as 
--    published by the Free Software Foundation, either version 3 of the 
--    License, or (at your option) any later version.
--
--    Mizus Raid Tracker is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with Mizus Raid Tracker.  
--    If not, see <http://www.gnu.org/licenses/>.


--------------
--  Locals  --
--------------
local ScrollingTable = LibStub("ScrollingTable");
-- table definitions
local MRT_RaidLogTableColDef = { 
    {["name"] = "#", ["width"] = 25, ["defaultsort"] = "dsc"}, 
    {["name"] = "Date", ["width"] = 75}, 
    {["name"] = "Zone", ["width"] = 100},
    {["name"] = "Size", ["width"] = 25},
};
local MRT_RaidAttendeesTableColDef = {
    {["name"] = "Player", ["width"] = 100},
    {["name"] = "Join", ["width"] = 40},
    {["name"] = "Leave", ["width"] = 40},
};
local MRT_RaidBosskillsTableColDef = {
    {["name"] = "#", ["width"] = 25, ["defaultsort"] = "dsc"},
    {["name"] = "Time", ["width"] = 40},
    {["name"] = "Name", ["width"] = 100},
    {["name"] = "Difficulty", ["width"] = 50},
};


---------------------------------------------------------------
--  parse localization and set up tables after ADDON_LOADED  --
---------------------------------------------------------------
function MRT_GUI_ParseValues()
    -- Parse strings
    MRT_GUIFrame_Title:SetText(MRT_L.GUI["Header_Title"]);
    MRT_GUIFrame_RaidLogTitle:SetText(MRT_L.GUI["Tables_RaidLogTitle"]);
    MRT_GUIFrame_RaidAttendeesTitle:SetText(MRT_L.GUI["Tables_RaidAttendeesTitle"]);
    MRT_GUIFrame_RaidBosskillsTitle:SetText(MRT_L.GUI["Tables_RaidBosskillsTitle"]);
    -- Create and anchor tables
    MRT_GUI_RaidLogTable = ScrollingTable:CreateST(MRT_RaidLogTableColDef, 14, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidLogTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidLogTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidLogTable:EnableSelection(true);
    MRT_GUI_RaidLogTable:RegisterEvents( {["OnClick"] = function(rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)
                                                            local raidnum = data[realrow][1];
                                                            MRT_GUI_RaidLogTableOnClick(raidnum);
                                                        end,} );
    MRT_GUI_RaidAttendeesTable = ScrollingTable:CreateST(MRT_RaidAttendeesTableColDef, 14, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidAttendeesTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidAttendeesTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidBosskillsTable = ScrollingTable:CreateST(MRT_RaidBosskillsTableColDef, 14, nil, nil, MRT_GUIFrame);
    MRT_GUI_RaidBosskillsTable.frame:SetPoint("TOPLEFT", MRT_GUIFrame_RaidBosskillsTitle, "BOTTOMLEFT", 0, -15);
    MRT_GUI_RaidBosskillsTable:EnableSelection(true);
    -- Insert table data
    MRT_GUI_CompleteTableUpdate();
end


---------------------
--  Show/Hide GUI  --
---------------------
function MRT_GUI_Toggle()
    if (MRT_GUIFrame:IsShown()) then
        MRT_GUIFrame:Hide();
        
    else
        MRT_GUIFrame:Show();
    end
end


------------------------
--  OnUpdate handler  --
------------------------
function MRT_GUI_RaidLogTableOnClick(raidnum)
    MRT_GUI_RaidDetailsTableUpdate(raidnum);
end


------------------------------
--  table update functions  --
------------------------------
-- update all tables
function MRT_GUI_CompleteTableUpdate()
    MRT_GUI_RaidLogTableUpdate();
    MRT_GUI_RaidDetailsTableUpdate(nil);
end

-- update raid details tables
function MRT_GUI_RaidDetailsTableUpdate(raidnum)
    MRT_GUI_RaidAttendeesTableUpdate(raidnum);
end

-- update raid list table
function MRT_GUI_RaidLogTableUpdate()
    local MRT_GUI_RaidLogTableData = {};
    local MRT_RaidLogSize = #MRT_RaidLog;
    -- insert reverse order
    for i, v in ipairs(MRT_RaidLog) do
        MRT_GUI_RaidLogTableData[(MRT_RaidLogSize-i+1)] = {i, date("%m/%d %H:%M", v["StartTime"]), v["RaidZone"], v["RaidSize"]};
    end
    MRT_GUI_RaidLogTable:SetData(MRT_GUI_RaidLogTableData, true);
    MRT_GUI_RaidLogTable:SortData();
end

-- update raid attendees table
function MRT_GUI_RaidAttendeesTableUpdate(raidnum)
    local MRT_GUI_RaidAttendeesTableData = {};
    if(raidnum) then
        local index = 1;
        for k, v in pairs(MRT_RaidLog[raidnum]["Players"]) do
            MRT_GUI_RaidAttendeesTableData[index] = {k, date("%H:%M", v["Join"]), date("%H:%M", v["Leave"])};
            index = index + 1;
        end
    end
    MRT_GUI_RaidAttendeesTable:SetData(MRT_GUI_RaidAttendeesTableData, true);
    MRT_GUI_RaidAttendeesTable:SortData();
end
