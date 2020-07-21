
local wpeventHandler = {}
local hitlist = {}

function wpeventHandler:onEvent(_event)

    local status, err = pcall( function(_event)
  
      if _event == nil or _event.initiator == nil then
            return false
      end    
        
      if _event.id == world.event.S_EVENT_HIT then    
           local _unitTarget = _event.target
           local _unit = _event.initiator
           
           if _unitTarget ~= nil then
           
              local _weapon = _event.weapon:getDesc().displayName
              local _unitTypeName = _unitTarget:getTypeName()
              
              if hitlist[_weapon] == nil then
                  hitlist[_weapon] = {}
                  hitlist[_weapon][_unitTypeName] = 1
              else
                  
                  hitlist[_weapon][_unitTypeName] =  hitlist[_weapon][_unitTypeName] or 0   
                  hitlist[_weapon][_unitTypeName] =  hitlist[_weapon][_unitTypeName] + 1  
                  
              end
              
              if sendingMessage ~= true then
                sendingMessage = true
                
                timer.scheduleFunction(function()
                local text = ""
                for key, val in pairs(hitlist) do
                  text = text .. "Weapon: " .. key .. "\n"
                  for key2, val2 in pairs(val) do
                    if val2 == 1 then
                        text =  text .. " - " ..  key2 .. "\n"
                    else
                      text = text .. " - " ..  key2 .. " (" .. tostring(val2) .. " Hits)" .. "\n"
                    end
                  end
                end
                trigger.action.outTextForCoalition(_unit:getCoalition(), text, 30)
                sendingMessage = false
                
                hitlist = {}
                end,nil,timer.getTime() + 5)
              end
          end
 
       end
       
   end, _event)
   if (not status) then
       env.error(string.format("Error while handling event %s", err), false)
   end

end

world.addEventHandler(wpeventHandler)

