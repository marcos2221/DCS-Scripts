--define zones / Config

zones = {"ALPHA","BRAVO","CHARLIE"}
flagId = 100

local lastTotalCount
local zoneDetails = {}
local function getDistance(_point1, _point2)

  local xUnit = _point1.x
  local yUnit = _point1.z
  local xZone = _point2.x
  local yZone = _point2.z
  local xDiff = xUnit - xZone
  local yDiff = yUnit - yZone

  return math.sqrt(xDiff * xDiff + yDiff * yDiff)
end
local function getZoneDetails()
  for key, zoneName in pairs(zones) do
    local _triggerZone = trigger.misc.getZone(zoneName)
    if _triggerZone ~= nil then
       --trigger.action.outText("Zone added " .. zoneName .. " Radius = " .. tostring(_triggerZone.radius),20)
      zoneDetails[zoneName] = { pos = _triggerZone.point, radius = _triggerZone.radius }
    end
  end
end
--count Units in zone
local function countUnitsInZone( _pos, _radius, _coalition, _category)

  local _volume = {
    id = world.VolumeType.SPHERE,
    params = {
      point = _pos,
      radius = _radius
    }
  }

  local _unitList = 0

  local _search = function(_unit, _coa)


        if _unit ~= nil
          and _unit:getLife() > 0
          and _unit:isActive()
          and _unit:getCoalition() == _coa then
            local unitDesc = _unit:getDesc()
            if unitDesc.category == Unit.Category.AIRPLANE or unitDesc.category == Unit.Category.HELICOPTER then
              local dist = getDistance(_unit:getPoint(), _pos)
              if dist < _radius then
                _unitList = _unitList + 1
              end
            end
        end
    return true
  end

  world.searchObjects(Object.Category.UNIT, _volume, _search, _coalition)
  return _unitList

end

local function continuoscheck() 
  timer.scheduleFunction( continuoscheck,nil,timer.getTime() + 1)  -- <-- will execute every 1 second
  
  local totalBlueCount = 0
  
  for key, zoneData in pairs(zoneDetails) do
    local result =  countUnitsInZone(zoneData.pos,zoneData.radius,coalition.side.BLUE)
    if result ~= nil and type(result) == "number" then
      totalBlueCount = totalBlueCount + result
    end
  end
  
  if totalBlueCount ~=  lastTotalCount  then
    -- Update flag
    trigger.action.setUserFlag(flagId , totalBlueCount )
   -- trigger.action.outText("Flag Updated " .. tostring(totalBlueCount),10)
    lastTotalCount = totalBlueCount
  end


end
getZoneDetails()
timer.scheduleFunction( continuoscheck,nil,timer.getTime() + 10)  -- <-- will execute 10 seconds after mission start





