
local respawnTime = 10 -- In Minutes
local _debug = false
local resPawningList = {}
local unitGroupMapping = {}
local function respawnRed( _groupName )
  
  --local group = Group.getByName(_groupName)
  --if group == nil then return end
  if _debug == true then
    trigger.action.outTextForCoalition( 1, "DEBUG: Respawning group " .. _groupName, 10, true) -- TODO Delete
  end
  mist.respawnGroup(_groupName, true ) 
  resPawningList[_groupName] = nil

end

local function getRedUnits()
  local redGroups = coalition.getGroups(1,  Group.Category.GROUND)
  for key, group in pairs (redGroups) do 
    local _units = group:getUnits()
    for key2, _unit in pairs (_units) do 
       
      if _unit ~= nil then
        
          
          unitGroupMapping[_unit:getName()] = group:getName()
            
        
      end
    end
  end
end


local respawn_eventHandler = {}

function respawn_eventHandler:onEvent(_event)

  local status, err = pcall(function(_event)
  if _event == nil or _event.initiator == nil then
    return false
  end
  
  local _unit 
  if _event.id == world.event.S_EVENT_DEAD then
    _unit = _event.initiator
    
    if _unit == nil then
     return
    end
        
    if _unit:getCoalition() ~= 1 then -- only red side
      return
     end      
     if _debug == true then
      env.info("Event Red Unit Dead")
     end
     local groupName
     if _unit.getGroup ~= nil then
        local group = _unit:getGroup()
        if group ~= nil then
          groupName = group:getName()
        end 
     end
     if groupName == nil then
        groupName = unitGroupMapping[_unit:getName()]
     end
     if groupName == nil then 
        env.info("DEBUG: Couldn't Determine the group name of the dead unit")
        return
     end
     if _debug == true then
     trigger.action.outTextForCoalition( 1, "DEBUG: Red unit dead " .. groupName, 10, true) -- TODO Delete
     end
     
        if resPawningList[groupName] == nil then
          resPawningList[groupName] = true
          timer.scheduleFunction(respawnRed, groupName,timer.getTime() + respawnTime * 60 )
        end
     
    end
    if _event.id == world.event.S_EVENT_BIRTH then
     
      local _unit = _event.initiator
      if _unit ~= nil then
        if _unit.getGroup ~= nil then
          local _group = _unit:getGroup()
          unitGroupMapping[_unit:getName()] = _group:getName()
            
        end
      end
    
    end

  end, _event)
  if (not status) then
    env.error(string.format("Error while handling event %s", err), false)
  end
  
end
world.addEventHandler(respawn_eventHandler)
getRedUnits()
