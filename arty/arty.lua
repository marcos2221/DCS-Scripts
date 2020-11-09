
local redArty = true
local blueArty = false
local artyRadius = 200   -- Seems is not working...
local artyExpendQty = 5  -- Number of shots
local reactionTimemin = 30
local reactionTimeMax = 120

local targetOffset = 50 -- Distance in meters to offset from target, reduce the probability of impact..


artyRange = {}
--artyRange[] = { minRange = 0, maxRange = 0} -- IN Meters
artyRange["SAU Msta"] = { minRange = 40, maxRange = 22224} -- IN Meters
artyRange["M-109"] = { minRange = 40, maxRange = 21853.6} -- IN Meters
artyRange["MLRS"] = { minRange = 10000, maxRange = 31484} -- IN Meters
artyRange["SAU 2-C9"] = { minRange = 40, maxRange = 6852.4} -- IN Meters
artyRange["SAU Akatsia"] = { minRange = 40, maxRange = 16668} -- IN Meters
artyRange["SAU Gvozdika"] = { minRange = 40, maxRange = 14816} -- IN Meters
artyRange["Grad-URAL"] = { minRange = 5000, maxRange = 18964} -- IN Meters
artyRange["Uragan_BM-27"] = { minRange = 11445, maxRange = 35558} -- IN Meters
artyRange["Smerch_HE"] = { minRange = 20000, maxRange = 68524} -- IN Meters
artyRange["Smerch"] = { minRange = 20000, maxRange = 68524} -- IN Meters
artyRange["2B11 mortar"] = { minRange = 40, maxRange = 6482} -- IN Meters


local artyList = {}
local redartyList = {}
local blueartyList = {}
local detectedEnemy = {} -- Pos , engaged = false

detectedEnemy[coalition.side.BLUE] = {targets = {}}
detectedEnemy[coalition.side.RED] = {targets = {}}

local function getArty( _coa )
  timer.scheduleFunction(getArty,_coa,timer.getTime() + 300)
  local _GroundGroups = coalition.getGroups(_coa,  Group.Category.GROUND)
  local _artyList = {}
  --Arty Groups
  for key, group in pairs(_GroundGroups) do
    
    local artyGroup = false
    for key2, unit in pairs (group:getUnits()) do
        
        local unitDesc = unit:getDesc()
        if unitDesc.attributes.Artillery ~= nil then
          artyGroup = true
        else
          artyGroup = false
          break
        end
    end 
    
    if artyGroup == true then
      --get unit 1 pos
      local unit = group:getUnit(1)
      if unit ~= nil then
        local _pos = unit:getPoint()
        _artyList[group:getName()] = { type = unit:getTypeName(), pos = _pos, asignedTime = 0}  
      end
   
    end
  end
  
  return _artyList
  
end
local function getArtyGroupAmmo( _groupName )
  
  local _group = Group.getByName(_groupName)
  if _group == nil then return 0 end
  local _units = _group:getUnits()
  if _units == nil then return 0 end
  local ammoCount = 0
  for key, unit in pairs (_units) do
    
    local ammoList = unit:getAmmo()
    if ammoList ~= nil then
      for key2, ammo in pairs(ammoList) do
        if ammo.desc.category == Weapon.Category.ROCKET then 
          ammoCount = ammoCount + ammo.count
        elseif ammo.desc.category == Weapon.Category.SHELL then
          if ammo.desc.warhead ~= nil then
            if ammo.desc.warhead.type ~= 0 then
              ammoCount = ammoCount + ammo.count
            end
          end
        end
        
      end
    
    end
  
  end
  return ammoCount

end
local function getDistancemiles(_point1, _point2, meters)

    local xUnit = _point1.x
    local yUnit = _point1.z
    local xZone = _point2.x
    local yZone = _point2.z
    local xDiff = xUnit - xZone
    local yDiff = yUnit - yZone
    if meters == true then
      return math.sqrt(xDiff * xDiff + yDiff * yDiff) 
    else
      return math.sqrt(xDiff * xDiff + yDiff * yDiff)  / 1852
    end
    
end
local function getGroundSpeed( _vec3 )
  --return (vec.x^2 + vec.y^2 + vec.z^2)^0.5
  return ((_vec3.x^2  + _vec3.z^2)^0.5) * 2.237  -- 3.6  to KM/h
end
local function getArtyInRange(_coalition, pos) 

 for groupName, groupDesc in pairs(artyList[_coalition]) do
    -- check Arty Alive..
    local artyGroup = Group.getByName(groupName)
    if artyGroup ~= nil then
      local artyUnit = artyGroup:getUnit(1)
      if artyUnit ~= nil then
        --At least one arty unit alive
        local _distTotargetmeters = getDistancemiles( groupDesc.pos , pos, true) -- Return Meters
        if _distTotargetmeters < artyRange[groupDesc.type].maxRange and _distTotargetmeters > artyRange[groupDesc.type].minRange then
           local ammo = getArtyGroupAmmo( groupName )
           if ammo > 0 then 
               if artyList[_coalition][groupName].asignedTime < timer.getTime() then
                 artyList[_coalition][groupName].asignedTime = timer.getTime() + 300
                 return groupName
               end
           end
        end
      else
        artyList[_coalition][groupName] = nil  
      end
    else
      artyList[_coalition][groupName] = nil
    end
 
 
 end

  return 
end
local function createTask( _groupName, pos)
local target = {}
target.x = pos.x + targetOffset
target.y = pos.z
target.zoneRadius = artyRadius
target.expendQty = artyExpendQty
target.expendQtyEnabled = true

local FireAtPoint = { id = 'FireAtPoint', params = target }
 
Group.getByName(_groupName):getController():pushTask(FireAtPoint)
     

end
local function engageTarget( _args )
  local _coalition = _args[1]
  local _unitTargetName = _args[2]
  
  -- Check if still detected
  if detectedEnemy[_coalition].targets[_unitTargetName] == nil then
     --trigger.action.outTextForCoalition( 1, "Target Lost ", 10)
    return -- Not detected anymore
  end
  if detectedEnemy[_coalition].targets[_unitTargetName].engaged == nil then
    detectedEnemy[_coalition].targets[_unitTargetName].engaged = false
  end
  if detectedEnemy[_coalition].targets[_unitTargetName].engaged == true then
    --trigger.action.outTextForCoalition( 1, "Target Already engaged ", 10)
    return --Already Engaged
  
  end
-- tHis will execute between min time  and max time..
  -- Check if unit is alive
  local _unit = Unit.getByName(_unitTargetName)
  
  if _unit == nil then 
    detectedEnemy[_coalition].targets[_unitTargetName] = nil
    --trigger.action.outTextForCoalition( 1, "Target Dead ", 10)
    -- Unit is dead
    return
  end
  
  --check if unit remains in same area.
  
  local unitPos = _unit:getPoint()
  local dist =   getDistancemiles(unitPos,detectedEnemy[_coalition].targets[_unitTargetName].pos)
  if dist < 0.3 then
    --trigger.action.outTextForCoalition( 1, "Target Still in area ", 10)
    local artyGroup =  getArtyInRange(_coalition, unitPos)
    if artyGroup ~= nil then 
      --create task for Group 
      --trigger.action.outTextForCoalition( 1, "Creating Task ", 10)
      createTask(artyGroup,unitPos)
      detectedEnemy[_coalition].targets[_unitTargetName].engaged = true
    else
      --trigger.action.outTextForCoalition( 1, "Not Availabe arty ", 10)
      env.info("Arty Not available to engage target")
    end
  else
    --trigger.action.outTextForCoalition( 1, "Target not in area Distance " .. tostring(dist), 10)
    detectedEnemy[_coalition].targets[_unitTargetName] = nil
  end


end
local function checkTargets( _unit, _targets )
  
  local _coalition = _unit:getCoalition()
  
  for key, detected in pairs(_targets) do
    local status, err = pcall(function() 
    
    
    local _unitTargetobject = detected.object
    if _unitTargetobject ~= nil then
      if _unitTargetobject:getName() ~= nil then
        local _unitTarget = Unit.getByName(_unitTargetobject:getName())
          if _unitTarget ~= nil then  
            local _groupTarget = _unitTarget:getGroup()
           if _groupTarget ~= nil then
             --if _groupTarget:getCategory() == Group.Category.AIRPLANE then
            
            if _groupTarget:getCategory() == Group.Category.HELICOPTER then
                --trigger.action.outTextForCoalition( 1, _unitTarget:getTypeName() .. " Detected By " .. _unit:getTypeName(), 5)
                
                local _gspeed = getGroundSpeed(_unitTarget:getVelocity())
                if _gspeed < 2 then 
                  
                  if detectedEnemy[_coalition].targets[_unitTarget:getName()] == nil then
                      detectedEnemy[_coalition].targets[_unitTarget:getName()] =  {pos = _unitTarget:getPoint(), engaged = nil, time = timer.getTime() }    
                      --trigger.action.outTextForCoalition( 1, "Starting Timer to engage ", 20)
                      
                      -- Engage
                        timer.scheduleFunction(engageTarget,{_coalition, _unitTarget:getName()},timer.getTime() + (math.random(reactionTimemin,reactionTimeMax))) --TODO ADD REACTION TIME VARIABLES
                  else
                       
                    detectedEnemy[_coalition].targets[_unitTarget:getName()].pos = _unitTarget:getPoint()
                    detectedEnemy[_coalition].targets[_unitTarget:getName()].time = timer.getTime()
                    if detectedEnemy[_coalition].targets[_unitTarget:getName()].time == false then
                      --trigger.action.outTextForCoalition( 1, "Starting Timer to engage ", 20)
                      timer.scheduleFunction(engageTarget,{_coalition, _unitTarget:getName()},timer.getTime() + (math.random(30,120)))
                    end
                    
                  end
                else
                   if detectedEnemy[_coalition].targets[_unitTarget:getName()] ~= nil then
                      detectedEnemy[_coalition].targets[_unitTarget:getName()] = nil
                      --trigger.action.outTextForCoalition( 1, "Too fast to engage ", 20)
                   end
                    
                end
            elseif _groupTarget:getCategory() == Group.Category.GROUND then
  
  
  
           end
         end
       end
   
      end
     end
   end)
   if not status then
    env.error("Error in Arty Detection " .. err)
     --trigger.action.outTextForCoalition( 1, "Error Caught ", 10)
     end
  end

  for key, val in pairs(detectedEnemy[_coalition].targets) do
    
    if val.time < timer.getTime() - 60 then
      detectedEnemy[_coalition].targets[key] = nil
      --trigger.action.outTextForCoalition( 1, "Target Lost time out ", 10)
      
    end
  
  end

end
local function groupGroups( groupList, all_groups )
  
  for key, group in pairs (groupList) do
    
    table.insert(all_groups, group)
  end
  return all_groups
end

local function detectEnemy( _coa )
  timer.scheduleFunction(detectEnemy,_coa,timer.getTime() + 10)
  local allDetectors = {}
  
  local _GroundDetectors = coalition.getGroups(_coa,  Group.Category.GROUND)
  local _PlaneDetectors = coalition.getGroups(_coa,  Group.Category.AIRPLANE)
  local _heliDetectors = coalition.getGroups(_coa,  Group.Category.HELICOPTER)
  
  allDetectors = groupGroups(_GroundDetectors,allDetectors)
  allDetectors = groupGroups(_PlaneDetectors,allDetectors)
  allDetectors = groupGroups(_heliDetectors,allDetectors)
  
  
  for key, group in pairs (allDetectors) do
    local _units = group:getUnits()
    for keyunit, _unit in pairs(_units) do
      local _controller = _unit:getController()
      local _targets = _controller:getDetectedTargets( Controller.Detection.VISUAL, Controller.Detection.RADAR, Controller.Detection.OPTIC) 
        
      checkTargets( _unit, _targets )
      
  
    end
  end






end

if redArty == true then
  artyList[coalition.side.RED] = getArty(coalition.side.RED)
  detectEnemy(coalition.side.RED)
end
if blueArty == true then
  artyList[coalition.side.BLUE] = getArty(coalition.side.BLUE)
  detectEnemy(coalition.side.BLUE)
end
