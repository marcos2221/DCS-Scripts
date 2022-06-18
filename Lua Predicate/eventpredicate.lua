-- Kill Events to report
-- Add a kill event to check 
-- 

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
--return killPredicate("[NAME OF THE EVENT]")

local triggeredEvents = {}

function killPredicate( event )

  if triggeredEvents[event] == true then
     env.info("Trigger " .. event .. " is true")
    triggeredEvents[event] = false
    return true
  else
   -- env.info("Trigger is false")
    return false
  end

end

local events = {
                    ["BLUEFWKILL"] = { unitCoalition    = coalition.side.BLUE, 
                                       unitCategory     = Unit.Category.AIRPLANE, 
                                       unitisHuman      = nil,
                                       unitName         = nil,
                                       unitGroupName    = nil,
                                       unitType         = nil,
                                       targetCoalition  = coalition.side.RED, 
                                       targetCategory   = Unit.Category.AIRPLANE, 
                                       targetisHuman    = nil,
                                       targetUnitName       = "Aerial-2-1",
                                       targetUnitGroupName  = nil,
                                       targetType          = nil,
                                       
                                     },
                ["BLUEGROUNDKILL"] = { unitCoalition        = coalition.side.BLUE, 
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
                
               } 



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
        for _trigger, _eventdetails in pairs(events) do
          local ignore = false
          if _eventdetails.unitColition ~= nil then
            if _unit:getCoalition() ~= _eventdetails.unitCoalition then
              ignore = true
              env.info(_trigger .. " ignoring due Unit Coalition")
            end
          end
          
          if _eventdetails.unitCategory ~= nil then
            if _unitDesc.category ~= _eventdetails.unitCategory then
              env.info(_trigger .." ignoring Unit category")
              ignore = true
            end
          end
          if _eventdetails.unitisHuman ~= nil then
              if isHuman(_unit) ~= _eventdetails.unitisHuman then
                env.info(_trigger .. " ignoring Unit Human")
                ignore = true
              end
          end
          
          if _eventdetails.unitName ~= nil then
            if _unit:getName() ~= _eventdetails.unitName then
              env.info(_trigger .." ignoring Unit Name")
              ignore = true
            end
          end
          
          if _eventdetails.unitGroupName ~= nil then
            if _unit:getGroup() ~= nil and _unit:getGroup():getName() ~= _eventdetails.unitGroupName then
              env.info(_trigger .." ignoring Group name")
              ignore = true
            end
          end
          if _eventdetails.unitType ~= nil then
            if _unit:getTypeName() ~= _eventdetails.unitType then
              env.info(_trigger .." ignoring unitType")
              ignore = true
            end
          end         
        
-- Target
          if _eventdetails.targetColition ~= nil then
            if _targetUnit:getCoalition() ~= _eventdetails.targetColition then
              ignore = true
              env.info(_trigger .. " ignoring Target Coalition")
            end
          end
          
          if _eventdetails.targetCategory ~= nil then
            if _targetDesc.category ~= _eventdetails.targetCategory then
              env.info(_trigger .. " ignoring Target Category")
              ignore = true
            end
          end
           if _eventdetails.targetisHuman ~= nil then
              if isHuman(_targetUnit) ~= _eventdetails.targetisHuman then
                 env.info(_trigger .." ignoring target unit human")
                ignore = true
              end
          end
          if _eventdetails.targetUnitName ~= nil then
            if _targetUnit:getName() ~= _eventdetails.targetUnitName then
              env.info(_trigger .." ignoring Unit Name")
              ignore = true
            end
          end
          if _eventdetails.targetUnitGroupName ~= nil then
            if _targetUnit:getGroup() ~= nil and _targetUnit:getGroup():getName() ~= _eventdetails.targetUnitGroupName then
              env.info(_trigger .." ignoring Group name")
              ignore = true
            end
          end 
          if _eventdetails.targetType ~= nil then
            if _targetUnit:getTypeName() ~= _eventdetails.targetType then
              env.info(_trigger .." ignoring unitType")
              ignore = true
            end
          end         
          
          
          
          if ignore == false then
            triggeredEvents[_trigger] = true
            env.info("Trigger " .. _trigger .. " Added")
          end
          
        end
    end

  end)

  if not status then
    env.error("UnitKillPredicate - " .. err)
  end
end
world.addEventHandler(_eventHandler)
env.info("Kill event Script loaded")
