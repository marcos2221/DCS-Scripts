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
                                       unitCategory     = nil, 
                                       unitisHuman      = true,
                                       targetCoalition  = coalition.side.RED, 
                                       targetCategory   = Unit.Category.AIRPLANE, 
                                       targetisHuman    = nil 
                                     },
                ["BLUEGROUNDKILL"] = { unitCoalition    = coalition.side.BLUE, 
                                       unitCategory     = nil, 
                                       unitisHuman      = nil,
                                       targetCoalition  = coalition.side.RED, 
                                       targetCategory   = Unit.Category.GROUND_UNIT, 
                                       targetisHuman    = nil 
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
