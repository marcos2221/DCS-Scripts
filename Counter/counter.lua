--assert(loadfile("C:\\Users\\mrome\\OneDrive\\Documentos\\Lua Scripts\\MAIN\\counter.lua"))()
--define zones / Config

zones = {"ALPHA","BRAVO","CHARLIE", "DELTA"}
flagId = "TEST1"
local alreadyCounted = {}
local function showTable(_table, ident)
  if type(_table) == "table" then
    for key, value in pairs (_table) do
      local text = ""
      for i=1, ident do
        text = text .. " "
      end
      text = text .. tostring(key) .. " - " .. tostring(value)
      env.info(text)
      if type(value) == "table" then
        showTable(value,ident + 1)
      end    
    end  
  end
end
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
local function getVertices(zoneName)

    local zoneData 
    for _, value in ipairs(env.mission.triggers.zones) do
      if value.name == zoneName then
        zoneData = value
        break
      end
    end
    if zoneData.type == 2 and zoneData.verticies ~= nil then
      local polyTable =  {}
      for key, val in ipairs (zoneData.verticies) do
        table.insert(polyTable,{x = val.x, y = val.y})
      end
      return polyTable
    
    end
    
end
local function getZoneDetails()
  for key, zoneName in pairs(zones) do
    local _triggerZone = trigger.misc.getZone(zoneName)
    if _triggerZone ~= nil then
        env.info("Checking zone " .. zoneName)
      local vertices = getVertices(zoneName)
      if vertices == nil then
        --trigger.action.outText("Zone added " .. zoneName .. " Radius = " .. tostring(_triggerZone.radius),20)
        zoneDetails[zoneName] = { pos = _triggerZone.point, radius = _triggerZone.radius }
      else
        zoneDetails[zoneName] = { pos = _triggerZone.point, poly = vertices }
        --trigger.action.outText("Zone added " .. zoneName .. " Quad-Point ",20)
      end
      
    end
  end
end
local function isPointInPolygon(point, polygon)
  local inside = false
  local j = #polygon
  for i = 1, #polygon do
    if ((polygon[i].y > point.z) ~= (polygon[j].y > point.z)) and
      (point.x < (polygon[j].x - polygon[i].x) * (point.z - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x) then
      inside = not inside
    end
    j = i
  end
  return inside
end
local function countUnitInPolyZone(poly, _coalition)
  local count = 0
  local allGroups = coalition.getGroups(_coalition, Group.Category.AIRPLANE)
  for key, group in pairs ( coalition.getGroups(_coalition, Group.Category.HELICOPTER)) do
    table.insert(allGroups,group)
  end
  for key, group in pairs ( allGroups) do
    local units = group:getUnits()
    if units ~= nil then
      for ku, unit in pairs(units) do
        if unit:isActive() and unit:isExist() then
            if isPointInPolygon(unit:getPoint(),poly) then
              -- In poly check overlaping
              if alreadyCounted[unit:getName()] == nil then
                alreadyCounted[unit:getName()] = true
                count = count + 1
              end  
            end        
        end
      end
    
    end 
  
  end
  return count
end
--count Units in zone
local function countUnitsInZone( _pos, _radius, _coalition)

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
            
            if alreadyCounted[_unit:getName()] == nil then
               alreadyCounted[_unit:getName()] = true
              _unitList = _unitList + 1
            end  
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
  alreadyCounted = {}
  for key, zoneData in pairs(zoneDetails) do
    if zoneData.radius ~= nil then
      local result =  countUnitsInZone(zoneData.pos,zoneData.radius,coalition.side.BLUE)
      if result ~= nil and type(result) == "number" then
        totalBlueCount = totalBlueCount + result
      end
    else
      local result =  countUnitInPolyZone(zoneData.poly,coalition.side.BLUE)
      if result ~= nil and type(result) == "number" then
        totalBlueCount = totalBlueCount + result
      end
    end
    
  end
  --trigger.action.outText("Count = " .. tostring(totalBlueCount),10)
  if totalBlueCount ~=  lastTotalCount  then
    -- Update flag
    trigger.action.setUserFlag(flagId , totalBlueCount )
    --trigger.action.outText("Flag Updated " .. tostring(totalBlueCount),10)
    lastTotalCount = totalBlueCount
  end


end
getZoneDetails()
timer.scheduleFunction( continuoscheck,nil,timer.getTime() + 10)  -- <-- will execute 10 seconds after mission start





