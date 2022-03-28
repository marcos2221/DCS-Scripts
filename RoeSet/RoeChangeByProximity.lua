local function getDistance(_point1, _point2)

  local xUnit = _point1.x
  local yUnit = _point1.z
  local xZone = _point2.x
  local yZone = _point2.z

  local xDiff = xUnit - xZone
  local yDiff = yUnit - yZone

  return math.sqrt(xDiff * xDiff + yDiff * yDiff)
end

local function setROE( _groupName, ROE )

  local _group = Group.getByName(_groupName)
  if _group ~= nil then
    local _controller = _grp:getController();
    Controller.setOption(_controller, AI.Option.Air.id.ROE, ROE)
  end

end
local function checkMerged()
  timer.scheduleFunction(checkMerged,nil,timer.getTime() + 5)

  local redGroups = coalition.getGroups( coalition.side.RED, Group.Category.AIRPLANE )

  local blueGroups = coalition.getGroups( coalition.side.BLUE, Group.Category.AIRPLANE )

  for key, redGroup in pairs ( redGroups ) do

    local redUnit = redGroup:getUnit(1)

    for key2, blueGroup in pairs (blueGroups) do

      local blueUnits = blueGroup:getUnits()
      for key3, blueUnit in pairs ( blueUnits ) do

        -- Check distance
        if blueUnit ~= nil then
          local dist = getDistance(redUnit:getPoint(), blueUnit:getPoint())
          if dist < 500 then -- Distance in meters
            local redGroupName = redGroup:getName()
            setROE( redGroupName, AI.Option.Air.val.ROE.OPEN_FIRE )  --AI.Option.Air.val.ROE.OPEN_FIRE or  AI.Option.Air.val.ROE.OPEN_FIRE_WEAPON_FREE
          end
        end

      end
    end
  end
end
