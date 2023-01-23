 
-- FW Support Script by Tupper 01/20/22023 
fwSupport = {}
fwSupport.menuAdded = {}
fwSupport.Active = {}
local tankerAltitude = 5486
local tankerSpeed = 128.6

local awacsAltitude = 7620
local awacsSpeed = 180.06


local function getMarkers( _playerName )
  local markerList = {}
  local f10marks = world.getMarkPanels()
  for key, _mark in pairs (f10marks) do
    if _mark.author == _playerName then
      table.insert(markerList, { idx = _mark.idx, pos = _mark.pos})
    end
  end
  return markerList
end
function fwSupport.createTankerRoute( wp1, wp2 ) 
local route = {}
route.points = {}
route.points[1] = 
{ 
  ["alt"] = tankerAltitude,
  ["action"] = "Turning Point",
  ["alt_type"] = "BARO",
  ["properties"] = { ["addopt"] = {},},
  ["speed"] = tankerSpeed,
  ["task"] = 
  { 
    ["id"] = "ComboTask",
    ["params"] = 
    { 
      ["tasks"] = 
      { 
        [1] = 
        {
          ["enabled"] = true,
          ["auto"] = true,
          ["id"] = "Tanker",
          ["number"] = 1,
          ["params"] = {},
        }, -- end of [1]
        [2] = 
        {
          ["enabled"] = true,
          ["auto"] = true,
          ["id"] = "WrappedAction",
          ["number"] = 2,
          ["params"] =
          {
            ["action"] = 
            {
              ["id"] = "ActivateBeacon",
              ["params"] = 
              {
                ["type"] = 4,
                ["AA"] = false,
                ["callsign"] = "TKR",
                ["system"] = 4,
                ["channel"] = 1,
                ["modeChannel"] = "X",
                ["bearing"] = true,
                ["frequency"] = 962000000,
              }, -- end of ["params"]
            }, -- end of ["action"]
          }, -- end of ["params"]
        }, -- end of [2]
        [3] = 
        {
          ["number"] = 3,
          ["auto"] = false,
          ["id"] = "WrappedAction",
          ["enabled"] = true,
          ["params"] = 
          {
            ["action"] =
            {
              ["id"] = "Option",
              ["params"] =
              {
                ["value"] = 0,
                ["name"] = 1,
              }, -- end of ["params"]
            }, -- end of ["action"]
          }, -- end of ["params"]
        }, -- end of [3]
        [4] = 
        {
          ["number"] = 4,
          ["auto"] = false,
          ["id"] = "WrappedAction",
          ["enabled"] = true,
          ["params"] = 
          {
            ["action"] = 
            {
              ["id"] = "SetInvisible",
              ["params"] =
              {
                ["value"] = true,
              }, -- end of ["params"]
            }, -- end of ["action"]
          }, -- end of ["params"]
        }, -- end of [4]
      }, -- end of ["tasks"]
    }, -- end of ["params"]
  }, -- end of ["task"]
  ["type"] = "Turning Point",
  ["ETA_locked"] = true,
  ["y"] = wp1.z,
  ["x"] = wp1.x,
  ["formation_template"] = "",
  ["speed_locked"] = true,
}

route.points[2] = 
{
    ["alt"] = tankerAltitude,
    ["action"] = "Turning Point",
    ["alt_type"] = "BARO",
    ["properties"] = 
    {
        ["addopt"] = { }, -- end of ["addopt"]
    }, -- end of ["properties"]
    ["speed"] = tankerSpeed,
    ["task"] = 
    {
        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
                [1] = 
                {
                    ["enabled"] = true,
                    ["auto"] = false,
                    ["id"] = "Orbit",
                    ["number"] = 1,
                    ["params"] = 
                    {
                        ["speedEdited"] = true,
                        ["pattern"] = "Race-Track",
                        ["speed"] = tankerSpeed,
                        ["altitude"] = tankerAltitude,
                        ["altitudeEdited"] = true,
                    }, -- end of ["params"]
                }, -- end of [1]
            }, -- end of ["tasks"]
        }, -- end of ["params"]
    }, -- end of ["task"]
    ["type"] = "Turning Point",
    ["ETA_locked"] = false,
    ["y"] = wp1.z,
    ["x"] = wp1.x,
    ["formation_template"] = "",
    ["speed_locked"] = true,
} -- end of [2]

route.points[3] = 
{
    ["alt"] = tankerAltitude,
    ["action"] = "Turning Point",
    ["alt_type"] = "BARO",
    ["properties"] = 
    {
        ["addopt"] = 
        {
        }, -- end of ["addopt"]
    }, -- end of ["properties"]
    ["speed"] = tankerSpeed,
    ["task"] = 
    {
        ["id"] = "ComboTask",
        ["params"] = 
        {
            ["tasks"] = 
            {
            }, -- end of ["tasks"]
        }, -- end of ["params"]
    }, -- end of ["task"]
    ["type"] = "Turning Point",
    ["ETA_locked"] = false,
    ["y"] = wp2.z,
    ["x"] = wp2.x,
    ["formation_template"] = "",
    ["speed_locked"] = true,
}                                        
return route
end
function fwSupport.createAwacsRoute( wp1, wp2)
local route = 
{
    ["points"] = 
    {
        [1] = 
        {
            ["alt"] = awacsAltitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = {}, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = awacsSpeed,
            ["task"] = 
            {
                ["id"] = "ComboTask",
                ["params"] = 
                {
                    ["tasks"] = 
                    {
                        [1] = 
                        {
                            ["number"] = 1,
                            ["auto"] = true,
                            ["id"] = "AWACS",
                            ["enabled"] = true,
                            ["params"] = 
                            {
                            }, -- end of ["params"]
                        }, -- end of [1]
                        [2] = 
                        {
                            ["number"] = 2,
                            ["auto"] = false,
                            ["id"] = "WrappedAction",
                            ["enabled"] = true,
                            ["params"] = 
                            {
                                ["action"] = 
                                {
                                    ["id"] = "Option",
                                    ["params"] = 
                                    {
                                        ["value"] = 0,
                                        ["name"] = 1,
                                    }, -- end of ["params"]
                                }, -- end of ["action"]
                            }, -- end of ["params"]
                        }, -- end of [2]
                        [3] = 
                        {
                            ["number"] = 3,
                            ["auto"] = false,
                            ["id"] = "WrappedAction",
                            ["enabled"] = true,
                            ["params"] = 
                            {
                                ["action"] = 
                                {
                                    ["id"] = "SetInvisible",
                                    ["params"] = 
                                    {
                                        ["value"] = true,
                                    }, -- end of ["params"]
                                }, -- end of ["action"]
                            }, -- end of ["params"]
                        }, -- end of [3]
                    }, -- end of ["tasks"]
                }, -- end of ["params"]
            }, -- end of ["task"]
            ["type"] = "Turning Point",
            ["ETA"] = 0,
            ["ETA_locked"] = true,
            ["y"] = wp1.z,
            ["x"] = wp1.x,
            ["formation_template"] = "",
            ["speed_locked"] = true,
        }, -- end of [1]
        [2] = 
        {
            ["alt"] = awacsAltitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = 
                {
                }, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = awacsSpeed,
            ["task"] = 
            {
                ["id"] = "ComboTask",
                ["params"] = 
                {
                    ["tasks"] = 
                    {
                        [1] = 
                        {
                            ["enabled"] = true,
                            ["auto"] = false,
                            ["id"] = "Orbit",
                            ["number"] = 1,
                            ["params"] = 
                            {
                                ["speedEdited"] = true,
                                ["pattern"] = "Race-Track",
                                ["speed"] = awacsSpeed,
                                ["altitude"] = awacsAltitude,
                                ["altitudeEdited"] = true,
                            }, -- end of ["params"]
                        }, -- end of [1]
                    }, -- end of ["tasks"]
                }, -- end of ["params"]
            }, -- end of ["task"]
            ["type"] = "Turning Point",
            ["ETA_locked"] = false,
            ["y"] = wp1.z,
            ["x"] = wp1.x,
            ["formation_template"] = "",
            ["speed_locked"] = true,
        }, -- end of [2]
        [3] = 
        {
            ["alt"] = awacsAltitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = 
                {
                }, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = awacsAltitude,
            ["task"] = 
            {
                ["id"] = "ComboTask",
                ["params"] = 
                {
                    ["tasks"] = {}, -- end of ["tasks"]
                }, -- end of ["params"]
            }, -- end of ["task"]
            ["type"] = "Turning Point",
            ["ETA_locked"] = false,
            ["y"] = wp2.z,
            ["x"] = wp2.x,
            ["formation_template"] = "",
            ["speed_locked"] = true,
        }, -- end of [3]
    }, -- end of ["points"]
} -- end of ["route"]
return route
end
function fwSupport.getGroupData( groupName, wp1, wp2, frequency, _task, _route )
local groupData = {}
groupData["modulation"] = 0
groupData["tasks"] = {}
groupData["radioSet"] = false
groupData["task"] = _task
groupData["uncontrolled"] = false
groupData["taskSelected"] = true
groupData["hidden"] = false
groupData["y"] = wp1.z 
groupData["x"] = wp1.x
groupData["name"] = groupName
groupData["communication"] = true
groupData["start_time"] = 0
groupData["frequency"] = frequency or 250
groupData["units"] = {}
groupData["route"] = _route
  return groupData
end
function fwSupport.getUnitKc135( wp1, unitName)
local _unit =  
{
  ["alt"] = tankerAltitude,
  ["alt_type"] = "BARO",
  ["livery_id"] = "Standard USAF",
  ["skill"] = "High",
  ["speed"] = tankerSpeed,
  ["type"] = "KC-135",
  ["psi"] = 0.033579104794468,
  ["y"] = wp1.z,
  ["x"] = wp1.x,
  ["name"] = unitName,
  ["payload"] = 
  {
      ["pylons"] = {}, -- end of ["pylons"]
      ["fuel"] = 90700,
      ["flare"] = 0,
      ["chaff"] = 0,
      ["gun"] = 100,
  }, -- end of ["payload"]
  ["heading"] = -0.033579104794468,
  ["callsign"] = 
  {
      [1] = 1,
      [2] = 1,
      [3] = 1,
      ["name"] = "Texaco11",
  }, -- end of ["callsign"]
  ["onboard_num"] = "010",
}
return _unit
end
function fwSupport.getUnitKc130( wp1, unitName)
local _unit =  
{
  ["alt"] = tankerAltitude,
  ["alt_type"] = "BARO",
  ["livery_id"] = "default",
  ["skill"] = "High",
  ["speed"] = tankerSpeed,
  ["type"] = "KC130",
  ["unitId"] = 103,
  ["psi"] = 0.033579104794468,
  ["y"] = wp1.z,
  ["x"] = wp1.x,
  ["name"] = unitName,
  ["payload"] = 
  {
      ["pylons"] = {}, -- end of ["pylons"]
      ["fuel"] = 30000,
      ["flare"] = 60,
      ["chaff"] = 120,
      ["gun"] = 100,
  }, -- end of ["payload"]
  ["heading"] = -0.033579104794468,
  ["callsign"] = 
  {
      [1] = 2,
      [2] = 1,
      [3] = 1,
      ["name"] = "Arco11",
  }, -- end of ["callsign"]
  ["onboard_num"] = "018",
}
return _unit
end
function fwSupport.getUnitAwacs( wp1, unitName)
local unit =  
    {
      ["alt"] = awacsAltitude,
      ["alt_type"] = "BARO",
      ["livery_id"] = "nato",
      ["skill"] = "High",
      ["speed"] = awacsSpeed,
      ["type"] = "E-3A",
      ["psi"] = 0.033579104794468,
      ["y"] = wp1.z,
      ["x"] = wp1.x,
      ["name"] = unitName,
      ["payload"] = 
      {
          ["pylons"] = {}, -- end of ["pylons"]
          ["fuel"] = "65000",
          ["flare"] = 60,
          ["chaff"] = 120,
          ["gun"] = 100,
      }, -- end of ["payload"]
      ["heading"] = -0.033579104794468,
      ["callsign"] = 
      {
          [1] = 1,
          [2] = 1,
          [3] = 1,
          ["name"] = "Overlord11",
      }, -- end of ["callsign"]
      ["onboard_num"] = "010",
}
return unit
end
function fwSupport.checkActive( unit)
  if fwSupport.Active[unit] ~= nil and fwSupport.Active[unit] > timer.getTime()  then 
    return true, string.format("%.0f",( fwSupport.Active[unit] - timer.getTime()) / 60)   
  end
  return false
end
function fwSupport.unitSpawn( args )
  local _unit =  Unit.getByName(args.unitName)
  if _unit == nil then env.info("fwSupport Tanker Spawn, unit is nil") return end
  local _group = _unit:getGroup()
  if _group == nil then env.info("fwSupport Tanker Spawn, Group is nil") return end
  local groupId = _group:getID()
  -- Check if there is one active
  local active, remaining = fwSupport.checkActive(args.unit)  
  if active then
    trigger.action.outTextForGroup(groupId, "There is an active ".. args.unit .. " already, wait " .. remaining .. " Minutes" , 30, false)
    return
  end
  --Get Waypoints (last 2 markers)
   
  local _groupMarks = getMarkers( _unit:getPlayerName() )
  if #_groupMarks < 2 then 
    trigger.action.outTextForGroup(groupId,  string.format("Set Two F10 markers in the map to set the Orbit of the %s first", args.unit), 20, false)
    return 
  end
  
  local wp2 = table.remove(_groupMarks)
  local wp1 = table.remove(_groupMarks)
  if wp1 == nil or wp2 == nil then
    trigger.action.outTextForGroup(groupId, string.format("Set Two F10 markers in the map to set the Orbit of the %s first", args.unit), 20, false)
    return
  end
  trigger.action.removeMark( wp1.idx )
  trigger.action.removeMark( wp2.idx )
  fwSupport.Active[args.unit] = timer.getTime() + 1200
  local freq = "255"
  if args.unit == "KC130" then
    fwSupport.spawnTanker130(country.id.CJTF_BLUE ,wp1.pos,wp2.pos)
  elseif args.unit == "KC135" then
    fwSupport.spawnTanker135(country.id.CJTF_BLUE ,wp1.pos,wp2.pos)
  elseif args.unit == "AWACS" then
    fwSupport.spawnAwacs(country.id.CJTF_BLUE,wp1.pos,wp2.pos)
    freq = "250"
    
  end
  trigger.action.outTextForGroup(groupId, string.format("%s spawned, Frequency: %s",args.unit, freq), 20, false)
end
function fwSupport.spawnTanker130(_country, wp1, wp2)
  local groupData = fwSupport.getGroupData("fwTanker1",wp1,wp2,255,"Refueling", fwSupport.createTankerRoute(wp1,wp2))
  table.insert( groupData.units, fwSupport.getUnitKc130(wp1,"fwTanker1") )
  local _spawnedGroup = coalition.addGroup(_country, Group.Category.AIRPLANE, groupData)
  return _spawnedGroup
end
function fwSupport.spawnTanker135(_country, wp1, wp2)
  local groupData = fwSupport.getGroupData("fwTanker2",wp1,wp2,255,"Refueling", fwSupport.createTankerRoute(wp1,wp2))
  table.insert( groupData.units, fwSupport.getUnitKc135(wp1,"fwTanker2") )
  local _spawnedGroup = coalition.addGroup(_country, Group.Category.AIRPLANE, groupData)
  return _spawnedGroup
end
function fwSupport.spawnAwacs( _country, wp1, wp2)
  local groupData = fwSupport.getGroupData("fwSupportAwacs1",wp1,wp2,250,"AWACS", fwSupport.createAwacsRoute(wp1,wp2))
  table.insert( groupData.units, fwSupport.getUnitAwacs(wp1,"fwSupportAwacs1") )
  local _spawnedGroup = coalition.addGroup(_country, Group.Category.AIRPLANE, groupData)
  return _spawnedGroup
end

local fwSupportEventHandler = {}

function fwSupportEventHandler:onEvent(_event)
  if _event.id == world.event.S_EVENT_BIRTH then
    if _event.initiator == nil then return end
    if _event.initiator.getPlayerName == nil then return end
    if _event.initiator:getPlayerName() == nil then return end
    
    local unit = _event.initiator
    
   -- local category = unit:getCategory()
    local groupCategory = unit:getGroup():getCategory()
    --env.info("Fwsupport: Birth Event Category " .. tostring(category) .. " Group Category  is " .. tostring(groupCategory))
    
    if groupCategory ~= Group.Category.AIRPLANE then env.info("Category Missmatch looking for " .. Group.Category.AIRPLANE .. " Got " .. groupCategory) return end
    local group = unit:getGroup()
    if group == nil then env.info("FwSupport: Group is nil" ) return end    
    local groupId = group:getID()
    if fwSupport.menuAdded[groupId] ~= nil then env.info("FwSupport: Menu Already added for this group " .. group:getName()) return end      
    
    fwSupport.menuAdded[groupId] = true
    local _rootPath = missionCommands.addSubMenuForGroup(groupId, "FW Support")
    missionCommands.addCommandForGroup(groupId, "Tanker KC130", _rootPath, fwSupport.unitSpawn, { unitName = unit:getName(), unit = "KC130" })
    missionCommands.addCommandForGroup(groupId, "Tanker KC135", _rootPath, fwSupport.unitSpawn, { unitName = unit:getName(), unit = "KC135" })
    missionCommands.addCommandForGroup(groupId, "Awacs", _rootPath, fwSupport.unitSpawn, { unitName = unit:getName(), unit = "AWACS" })
    
          
  end
end

world.addEventHandler(fwSupportEventHandler )
