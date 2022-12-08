-- Coalition
-- nil -> Check everything
--coalition.side.BLUE
--coalition.side.RED
--coalition.side.NEUTRAL

--Unit and Target Unit Category
-- nil -> Check everything
--Unit.Category.AIRPLANE
--Unit.Category.GROUND_UNIT
--Unit.Category.HELICOPTER
--Unit.Category.SHIP
--Unit.Category.STRUCTURE

-- Human
-- nil -> Check everything
-- true -> Human unit
-- false -> AI unit

-- Unit Name / Target Unit Name
-- nil or UnitName in the Mission Editor

-- Unit Group Name / Target Group Name
-- Group Name on the mission editor

-- Unit Type Name
-- Dcs Internal name of the Unit check C:\Program Files\Eagle Dynamics\DCS World OpenBeta\Scripts\Database\db_countries.lua to see the unit type names

-- Load this file in the Mission start trigger as a Doscriptfile

-- In Condition -> LUA Predicate use (without the --)
--return kill("[NAME OF THE EVENT]")  
--return deadPilot("[NAME OF THE EVENT]")
--return ejection("[NAME OF THE EVENT]")
--return takOff("[NAME OF THE EVENT]")
--return land("[NAME OF THE EVENT]")

local triggeredKillEvents = {}
local triggeredPilotDeadEvents = {}
local triggeredEjectionEvents = {}
local triggeredTakeOffEvents = {}
local triggeredLandEvents = {}
local triggeredDetectionEvents = {}

function kill( event )
  if triggeredKillEvents[event] == nil then return false end
  if #triggeredKillEvents[event] == 0 then return false end
  table.remove(triggeredKillEvents[event])
  return true
end
function deadPilot( event )
  if triggeredPilotDeadEvents[event] == nil then return false end
  if #triggeredPilotDeadEvents[event] == 0 then return false end
  table.remove(triggeredPilotDeadEvents[event])
  return true
end
function ejection( event )
  if triggeredEjectionEvents[event] == nil then return false end
  if #triggeredEjectionEvents[event] == 0 then return false end
  table.remove(triggeredEjectionEvents[event])
  return true
end
function takeOff( event )
  if triggeredTakeOffEvents[event] == nil then return false end
  if #triggeredTakeOffEvents[event] == 0 then return false end
  table.remove(triggeredTakeOffEvents[event])
  return true
end
function land( event )
  if triggeredLandEvents[event] == nil then return false end
  if #triggeredLandEvents[event] == 0 then return false end
  table.remove(triggeredLandEvents[event])
  return true
end
function detection( event )
  if triggeredDetectionEvents[event] == nil then return false end
  if #triggeredDetectionEvents[event] == 0 then return false end
  table.remove(triggeredDetectionEvents[event])
  return true
end

local killEvents = {}
local pilotDeadEvents = {}
local ejectionEvents = {}
local takeOffEvents = {}
local landEvents = {}
local detectEvents = {}

--KILL EVENTS

killEvents["BLUEAIR2AIRKILL"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = Unit.Category.AIRPLANE,
  unitisHuman      = nil,
  unitName         = nil,
  unitGroupName    = nil,
  unitType         = nil,
  targetCoalition  = coalition.side.RED,
  targetCategory   = Unit.Category.AIRPLANE,
  targetisHuman    = nil,
  targetUnitName       = nil,
  targetUnitGroupName  = nil,
  targetType          = nil,
}
killEvents["AZULVSROJO"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = Unit.Category.AIRPLANE,
  unitisHuman      = nil,
  unitName         = nil,
  unitGroupName    = nil,
  unitType         = nil,
  targetCoalition  = coalition.side.RED,
  targetCategory   = Unit.Category.AIRPLANE,
  targetisHuman    = nil,
  targetUnitName       = nil,
  targetUnitGroupName  = nil,
  targetType          = nil,
}
killEvents["REDAIR2AIRKILL"] = {
  unitCoalition    = coalition.side.RED,
  unitCategory     = Unit.Category.AIRPLANE,
  unitisHuman      = nil,
  unitName         = nil,
  unitGroupName    = nil,
  unitType         = nil,
  targetCoalition  = coalition.side.BLUE,
  targetCategory   = Unit.Category.AIRPLANE,
  targetisHuman    = nil,
  targetUnitName       = nil,
  targetUnitGroupName  = nil,
  targetType          = nil,
}
killEvents["BLUEGROUNDKILL"] = {
  unitCoalition        = coalition.side.BLUE,
  unitCategory         = nil,
  unitisHuman          = nil,
  unitName             = nil,
  unitGroupName        = nil,
  unitType             = nil,
  targetCoalition      = coalition.side.RED,
  targetCategory       = Unit.Category.GROUND_UNIT,
  targetisHuman        = nil,
  targetUnitName       = nil,
  targetUnitGroupName  = nil,
  targetType           = nil
}

-- PILOT DEAD EVENT
pilotDeadEvents["BLUEPILOTPLAYERDEAD"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = true,
  unitName         = nil,
  unitType         = nil,
}
pilotDeadEvents["BLUEPILOTDEAD"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = Unit.Category.AIRPLANE,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
pilotDeadEvents["BLUEPILOTDEADHELI"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = Unit.Category.HELICOPTER,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
pilotDeadEvents["REDPILOTDEAD"] = {
  unitCoalition    = coalition.side.RED,
  unitCategory     = Unit.Category.AIRPLANE,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}

-- EJECTION EVENT
ejectionEvents["BLUEEJECTIONS"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
ejectionEvents["REDEJECTIONS"] = {
  unitCoalition    = coalition.side.RED,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}


--TAKE OFF EVENT
takeOffEvents["BLUETAKEOFF"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
takeOffEvents["REDTAKEOFF"] = {
  unitCoalition    = coalition.side.RED,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}

--LAND EVENTS
landEvents["BLUELAND"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
landEvents["BLUELAND2"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}
landEvents["REDLAND"] = {
  unitCoalition    = coalition.side.RED,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}

--Detection 
local enableBlueDetection = true   -- <-- Enable detection
local enableRedDetection = false   -- <-- Enable detection
-- Constant Values Do not change
local VISUAL = 1
local OPTIC  = 2
local RADAR  = 4
local IRST   = 8
local RWR    = 16
local DLINK  = 32
--  ------------------------------
--Detection type Up to 3 ways
local detection1 = RADAR  
local detection2 = OPTIC -- or nil
local detection3 = VISUAL -- or nil

detectEvents["BLUE"] = {
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitGroupName    = "Aerial-8",
  unitType         = nil,
}
detectEvents["RED"] = { 
  unitCoalition    = coalition.side.BLUE,
  unitCategory     = nil,
  unitisHuman      = nil,
  unitName         = nil,
  unitType         = nil,
}

local function getDistance(_point1, _point2)

  local xUnit = _point1.x
  local yUnit = _point1.z
  local xZone = _point2.x
  local yZone = _point2.z
  local xDiff = xUnit - xZone
  local yDiff = yUnit - yZone

  return math.sqrt(xDiff * xDiff + yDiff * yDiff)
end


local _eventHandler = {}
local function isHuman( _unit)
  if  _unit.getPlayerName ~= nil then
    local _playerName = _unit:getPlayerName()
    if _playerName == nil then
      return false
    end
    return true
  end
  return false
end

local function unitCheck(_unit, _eventdetails)
  local _unitDesc = _unit:getDesc()
  if _eventdetails.unitCoalition ~= nil then
    if _unit:getCoalition() ~= _eventdetails.unitCoalition then
      return false
    end
  end
  if _eventdetails.unitCategory ~= nil then
    --env.info("Unit category looking for " .. _eventdetails.unitCategory .. " actually is " .. _unitDesc.category)
    if _unitDesc.category ~= _eventdetails.unitCategory then
      
      return false
    end
  end
  if _eventdetails.unitisHuman ~= nil then
    if isHuman(_unit) ~= _eventdetails.unitisHuman then
      return false
    end
  end
  if _eventdetails.unitName ~= nil then
    if _unit:getName() ~= _eventdetails.unitName then
      return false
    end
  end
  if _eventdetails.unitGroupName ~= nil then
    if _unit.getGroup  ~= nil then
      if _unit:getGroup() ~= nil and _unit:getGroup():getName() ~= _eventdetails.unitGroupName then
        return false
      end
    end
  end
  if _eventdetails.unitType ~= nil then
    if _unit:getTypeName() ~= _eventdetails.unitType then
      return false
    end
  end
  return true
end
local function detect( _coalition, detection1, detection2, detection3 )
  
 timer.scheduleFunction(function()detect(_coalition, detection1,detection2,detection3)  end,nil,timer.getTime() + 5)
 local _coa
 
 if _coalition == coalition.side.BLUE then
  _coa = coalition.side.RED
 else
  _coa = coalition.side.BLUE
 end
 local _allEnemy = coalition.getGroups(_coa,  Group.Category.GROUND)
 for key, _group in pairs( _allEnemy) do
  local _units = _group:getUnits()
  for keyunit, _unit in pairs(_units) do
    local _controller = Unit.getController( _unit )
    local _targets = _controller:getDetectedTargets( detection1, detection2, detection3 )
    for key2, detected in pairs(_targets) do
      local _unitTarget = detected.object
      if _unitTarget ~= nil then
        local TargetIsDetected, TargetIsVisible, TargetLastTime, TargetKnowType, TargetKnowDistance, TargetLastPos, TargetLastVelocity
        = _controller:isTargetDetected( _unitTarget, detection1, detection2, detection3 )
        if TargetIsDetected == true then
          for _trigger, _eventdetails in pairs(detectEvents) do
          local ignore = false
            if unitCheck(_unitTarget, _eventdetails) == false then
               ignore = true
            end
            if ignore == false then
              if triggeredDetectionEvents[_trigger] == nil then 
                triggeredDetectionEvents[_trigger] = {}
              end
              table.insert(triggeredDetectionEvents[_trigger],true)
              return true
            end
          end
        end
      end
    end
  end
 end
 
 return false  
end
function _eventHandler:onEvent(_event)
  local status, err = pcall(function()
    if _event == nil or _event.initiator == nil then
       return
    end
    if _event.id == world.event.S_EVENT_KILL then
      local _unit =_event.initiator
      local _unitDesc = _unit:getDesc()
      local _targetUnit = _event.target
      local _targetDesc = _targetUnit:getDesc()
      for _trigger, _eventdetails in pairs(killEvents) do
        local ignore = false
        if unitCheck(_unit, _eventdetails) == false then
          ignore = true
        end
        -- Target
        if _eventdetails.targetColition ~= nil then
          if _targetUnit:getCoalition() ~= _eventdetails.targetColition then
            ignore = true
            end
        end

        if _eventdetails.targetCategory ~= nil then
          if _targetDesc.category ~= _eventdetails.targetCategory then
            ignore = true
          end
        end
        if _eventdetails.targetisHuman ~= nil then
          if isHuman(_targetUnit) ~= _eventdetails.targetisHuman then
            ignore = true
          end
        end
        if _eventdetails.targetUnitName ~= nil then
          local targetName = _eventdetails.targetUnitName
          if _targetUnit:getName() ~= targetName then
            ignore = true
          end
        end
        if _eventdetails.targetUnitGroupName ~= nil then
          if _targetUnit:getGroup() ~= nil and _targetUnit:getGroup():getName() ~= _eventdetails.targetUnitGroupName then
             ignore = true
          end
        end
        if _eventdetails.targetType ~= nil then
          if _targetUnit:getTypeName() ~= _eventdetails.targetType then
            ignore = true
          end
        end
        if ignore == false then
          if triggeredKillEvents[_trigger] == nil then 
            triggeredKillEvents[_trigger] = {}
          end
          table.insert(triggeredKillEvents[_trigger],true)
        end
      end
    elseif _event.id == world.event.S_EVENT_PILOT_DEAD then
      local _unit =_event.initiator
      local _unitDesc = _unit:getDesc()

      for _trigger, _eventdetails in pairs(pilotDeadEvents) do
        local ignore = false
        --env.info("Checking " .. _trigger)
        if unitCheck(_unit, _eventdetails) == false then
          ignore = true
        end
        
        if ignore == false then
          if triggeredPilotDeadEvents[_trigger] == nil then 
            triggeredPilotDeadEvents[_trigger] = {}
          end
          table.insert(triggeredPilotDeadEvents[_trigger],true)
          --env.info("Added trigger")
        else
          --env.info("Ignored trigger")
        end
      end

    elseif _event.id == world.event.S_EVENT_EJECTION then

      local _unit =_event.initiator
      local _unitDesc = _unit:getDesc()

      for _trigger, _eventdetails in pairs(ejectionEvents) do
        local ignore = false
        if unitCheck(_unit, _eventdetails) == false then
          ignore = true
        end
        if ignore == false then
          if triggeredEjectionEvents[_trigger] == nil then 
            triggeredEjectionEvents[_trigger] = {}
          end
          table.insert(triggeredEjectionEvents[_trigger],true)
        end
      end

    elseif _event.id == world.event.S_EVENT_TAKEOFF then
      local _unit =_event.initiator
      local _unitDesc = _unit:getDesc()

      for _trigger, _eventdetails in pairs(takeOffEvents) do
        local ignore = false
        if unitCheck(_unit, _eventdetails) == false then
          ignore = true
        end
        if ignore == false then
          if  triggeredTakeOffEvents[_trigger] == nil then 
             triggeredTakeOffEvents[_trigger] = {}
          end
          table.insert(triggeredTakeOffEvents[_trigger],true)
        end
      end
    elseif _event.id == world.event.S_EVENT_LAND then
      local _unit =_event.initiator
      local _unitDesc = _unit:getDesc()

      for _trigger, _eventdetails in pairs(landEvents) do
        local ignore = false
        if unitCheck(_unit, _eventdetails) == false then
          ignore = true
        end
        if ignore == false then
          if  triggeredLandEvents[_trigger] == nil then 
             triggeredLandEvents[_trigger] = {}
          end
          table.insert(triggeredLandEvents[_trigger],true)
        end
      end
    end

  end)

  if not status then
    env.error("UnitKillPredicate - " .. err)
  end
end


---Bandera por Proximidad
--@function  name banderaPorProximidad
--@param #string nombreUnidad Unidad contra la que chequear
--@param #int distancia Distancia en metros
--@param #string coalicion 1 o rojo, 2 o azul o -1 para ambos
--@param #boolean checkFw Checkear Aviones
--@param #boolean checkHeli Checkear helicopteros
--@param #boolean soloHumanos solo detectar humanos
--@param #boolean contador Devuelve el numero de unidades envez de un flag true o false
local function banderaPorProximidad( nombreUnidad, distancia , coalicion, checkFw, checkHeli, soloHumanos , contador ) -- Distancia En metros
  
  local _allGroups = {} 
  
  local checkUnit = Unit.getByName(nombreUnidad)
  if checkUnit == nil then return end
  local unitPos = checkUnit:getPoint()
  
  if coalicion == 2 or coalicion == "azul" or coalicion == -1 then
    if checkFw then
      local tempGroupList = coalition.getGroups(coalition.side.BLUE,  Group.Category.AIRPLANE)
      for key, val in pairs ( tempGroupList ) do
        table.insert(_allGroups ,val)
      end
    end
    if checkHeli then
      local tempGroupList = coalition.getGroups(coalition.side.BLUE,  Group.Category.HELICOPTER)
      for key, val in pairs ( tempGroupList ) do
        table.insert(_allGroups ,val)
      end
    end
  end
  if coalicion == 1 or coalicion == "rojo" or coalicion == -1 then
    if checkFw then
      local tempGroupList = coalition.getGroups(coalition.side.RED,  Group.Category.AIRPLANE)
      for key, val in pairs ( tempGroupList ) do
        table.insert(_allGroups ,val)
      end
    end
    if checkHeli then
      local tempGroupList = coalition.getGroups(coalition.side.RED,  Group.Category.HELICOPTER)
      for key, val in pairs ( tempGroupList ) do
        table.insert(_allGroups ,val)
      end
    end
  end
  
  local count = 0
  for key, group in pairs (_allGroups) do
 
    local _units = group:getUnits()
    if _units ~= nil then
      for key2, unit in pairs(_units) do
        if unit ~= nil then      
          local ignore = false
          if soloHumanos == true then 
            if unit.getPlayerName ~= nil and unit:getPlayerName() ~= nil then
              ignore = false
            else
              ignore = true
            end
          end
          if unit:getName() == nombreUnidad then
             ignore = true
          end
          if ignore == false then
            local dist = getDistance(unitPos, unit:getPoint())
            if dist <= distancia then
              if contador == true then
                count = count + 1
              else
                
                return true
              end
            end
          end
        end
      end
    end
  end
  if contador == true then
    return count
  else
    return false
  end
end

function banderaproximidadAll( nombreUnidad, distancia, coalicion )
  return banderaPorProximidad(nombreUnidad,distancia,coalicion,true,true,true)
end
function banderaproximidadContadorAll( nombreUnidad, distancia, coalicion, bandera )
  local contador = banderaPorProximidad(nombreUnidad,distancia,coalicion,true,true,true,true)
  if contador ~= nil then
    trigger.action.setUserFlag(bandera , contador )
    --trigger.action.outText("Debug: Bandera 333 set to " .. tostring(contador),2)
  end
end
function banderaproximidadAviones( nombreUnidad, distancia, coalicion )
  return banderaPorProximidad(nombreUnidad,distancia,coalicion,true,false,true)
end
function banderaproximidadHelis( nombreUnidad, distancia, coalicion )
  return banderaPorProximidad(nombreUnidad,distancia,coalicion,false,true,true)
end

world.addEventHandler(_eventHandler)
env.info("Predicate event Script loaded")

if enableBlueDetection then
  detect( coalition.side.BLUE, detection1, detection2,detection3)
end

if enableRedDetection then
  detect(coalition.side.RED, detection1, detection2,detection3)
end




