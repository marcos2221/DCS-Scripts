 -- FW Support Script by Tupper 01/20/22023   -- Added suggestions by Go_rongor
fwSupport = {}
fwSupport.menuAdded = {}
fwSupport.Active = {}

local tankerData = {}
local awacsData = {}
tankerData["KC130"] = {
  name = "fwSupportTanker1",
  altitude = 6096,
  speed    = 180,
  frequency = 230,
  tacan    = { 
    callsign = "ARC",
    channel  = 30,
    modeChannel = "X",
    bearing = true,
    frequency =  991000000
    },
  unit =  
  {
    ["alt"] = 0,
    ["alt_type"] = "BARO",
    ["livery_id"] = "default",
    ["skill"] = "High",
    ["speed"] = 0,
    ["type"] = "KC130",
    ["psi"] = 0.033579104794468,
    ["y"] = 0,
    ["x"] = 0,
    ["name"] = "",
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
 
 }
 tankerData["KC135"] = {
  name = "fwSupportTanker2",
  altitude = 6705.6,
  speed    = 190,
  frequency = 235,
  tacan    = { 
    callsign = "TEX",
    channel  = 35,
    modeChannel = "X",
    bearing = true,
    frequency = 996000000,
     },
  unit =  
  {
    ["alt"] = 0,
    ["alt_type"] = "BARO",
    ["livery_id"] = "Standard USAF",
    ["skill"] = "High",
    ["speed"] = 0,
    ["type"] = "KC-135",
    ["psi"] = 0.033579104794468,
    ["y"] = 0,
    ["x"] = 0,
    ["name"] = "",
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
  }

 awacsData["E3A"] = {
  name = "fwSupportAwacs1",
  altitude = 7620,
  speed    = 205,
  frequency = 225,
  --[[tacan    = { 
    callsign = "TEX",
    channel  = 35,
    modeChannel = "X",
    bearing = true,
    frequency = 996000000,
     } ]]
  }


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
function fwSupport.createTankerRoute( wp1, wp2, _tankerData ) 
local route = {}
route.points = {}
route.points[1] = 
{ 
  ["alt"] = _tankerData.altitude,
  ["action"] = "Turning Point",
  ["alt_type"] = "BARO",
  ["properties"] = { ["addopt"] = {},},
  ["speed"] = _tankerData.speed,
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
                ["callsign"] = _tankerData.tacan.callsign,
                ["system"] = 4,
                ["channel"] = _tankerData.tacan.channel,
                ["modeChannel"] = _tankerData.tacan.modeChannel,
                ["bearing"] = _tankerData.tacan.bearing,
                ["frequency"] = _tankerData.tacan.frequency,
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
    ["alt"] = _tankerData.altitude,
    ["action"] = "Turning Point",
    ["alt_type"] = "BARO",
    ["properties"] = 
    {
        ["addopt"] = { }, -- end of ["addopt"]
    }, -- end of ["properties"]
    ["speed"] = _tankerData.speed,
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
                        ["speed"] = _tankerData.speed,
                        ["altitude"] = _tankerData.altitude,
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
    ["alt"] = _tankerData.altitude,
    ["action"] = "Turning Point",
    ["alt_type"] = "BARO",
    ["properties"] = 
    {
        ["addopt"] = 
        {
        }, -- end of ["addopt"]
    }, -- end of ["properties"]
    ["speed"] = _tankerData.speed,
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
function fwSupport.createAwacsRoute( wp1, wp2, _awacsData)
local route = 
{
    ["points"] = 
    {
        [1] = 
        {
            ["alt"] = _awacsData.altitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = {}, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = _awacsData.speed,
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
                                    ["id"] = "EPLRS",
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
            ["ETA"] = 0,
            ["ETA_locked"] = true,
            ["y"] = wp1.z,
            ["x"] = wp1.x,
            ["formation_template"] = "",
            ["speed_locked"] = true,
        }, -- end of [1]
        [2] = 
        {
            ["alt"] = _awacsData.altitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = 
                {
                }, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = _awacsData.speed,
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
                                ["speed"] = _awacsData.speed,
                                ["altitude"] = _awacsData.altitude,
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
            ["alt"] = _awacsData.altitude,
            ["action"] = "Turning Point",
            ["alt_type"] = "BARO",
            ["properties"] = 
            {
                ["addopt"] = 
                {
                }, -- end of ["addopt"]
            }, -- end of ["properties"]
            ["speed"] = _awacsData.speed,
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

function fwSupport.getTankerUnit ( wp1, unitName, _tankerData)
local _unit =  _tankerData.unit
_unit.alt   = _tankerData.altitude
_unit.speed = _tankerData.speed
_unit.y = wp1.z
_unit.x = wp1.x
_unit.name = _tankerData.name
return _unit
end

function fwSupport.getUnitAwacs( wp1, _awacsData)
local unit =  
    {
      ["alt"] = _awacsData.altitude,
      ["alt_type"] = "BARO",
      ["livery_id"] = "nato",
      ["skill"] = "High",
      ["speed"] = _awacsData.speed,
      ["type"] = "E-3A",
      ["psi"] = 0.033579104794468,
      ["y"] = wp1.z,
      ["x"] = wp1.x,
      ["name"] = _awacsData.name,
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
  local freq 
  if args.unit == "KC130" then
    freq = tankerData.KC130.frequency
    fwSupport.spawnTanker( country.id.CJTF_BLUE,wp1.pos,wp2.pos,tankerData.KC130)
  elseif args.unit == "KC135" then
    freq = tankerData.KC135.frequency
    fwSupport.spawnTanker( country.id.CJTF_BLUE,wp1.pos,wp2.pos,tankerData.KC135)
  elseif args.unit == "AWACS" then
    freq = awacsData.E3A.frequency
    fwSupport.spawnAwacs(country.id.CJTF_BLUE,wp1.pos,wp2.pos, awacsData.E3A)
  end
  trigger.action.outTextForGroup(groupId, string.format("%s spawned, Frequency: %s",args.unit, freq), 20, false)
end
function fwSupport.spawnTanker( _country,wp1,wp2,_tankerData)

  local groupData = fwSupport.getGroupData(_tankerData.name,wp1,wp2,_tankerData.frequency,"Refueling", fwSupport.createTankerRoute(wp1,wp2,_tankerData))
  table.insert( groupData.units, fwSupport.getTankerUnit(wp1,_tankerData) )
  local _spawnedGroup = coalition.addGroup(_country, Group.Category.AIRPLANE, groupData)
  return _spawnedGroup

end

function fwSupport.spawnAwacs( _country, wp1, wp2, _awacsData)
  local groupData = fwSupport.getGroupData(_awacsData.name,wp1,wp2,_awacsData.frequency,"AWACS", fwSupport.createAwacsRoute(wp1,wp2, _awacsData))
  table.insert( groupData.units, fwSupport.getUnitAwacs(wp1,_awacsData) )
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
