-- Requested by a Mission builder Facebook group member
-- -----------------------------------------------------------
-- This File goes in SavedGames folder -> DCS.openbeta_server\Scripts\Hooks\ and will run for any mission that runs in the server, that's why the "enabledfor" mission list
-- Block slot usage once player died until server restart

--Any other mission name separated by , or remove everything between { }  to enable for all missions
local enabledfor = { "Persistent_Syria_TPE_v4_TEST1_RUN2",
                   "Persistent_Syria_TPE_v4_TEST1_RUN1",
                   "XXXXX" 
                 }

-- Chat messages for when the Player gets killed, and when tries to select a slot after being killed
local textWhenKilled = "You Died, you won't be able to use any slot for the rest of the round"
local textForSlotBlock = "You have Died and you can't use any other slot for the rest of the round"
local _callbacks = {}
local _deadUserUCIDS = {}
local enabled = false

function _callbacks.onMissionLoadBegin()
  _deadUserUCIDS = {}
end

function _callbacks.onMissionLoadBegin()
  local stat, err = pcall( function() 
    local current_mission = DCS.getMissionName() 
    net.log( "SlotBlock - Mission Name = " .. current_mission)
    if enabledfor == {} then 
      enabled = true
    else
      for key, val in pairs (enabledfor) do
        if current_mission == val then
          enabled = true
          net.log("SlotBlock - Is Enabled for this Mission" )
          break
        end    
      end
    end
  end)
  if not stat then 
    net.log("SlotBlock -  Error in script " .. err) 
  end
end

function _callbacks.onPlayerChangeSlot(id)

if not  DCS.isServer() and DCS.isMultiplayer() then net.log("Player Change SLot Not a server or Multiplayer Leaving" ) return end
  
local stat, err = pcall( function() 
if enabled == false then return end
      
local slotID = net.get_player_info(id, 'slot')
local _groupName =  DCS.getUnitProperty(slotID, DCS.UNIT_GROUPNAME)
local _unitRole = DCS.getUnitType( slotID )

if _groupName == nil then return end

if string.match(_groupName, "Virtual") then 
-- These are the Combined arms slots for now locks them as well
 --if _unitRole == "forward_observer" or _unitRole == "instructor" or
--          _unitRole == "artillery_commander" or _unitRole == "observer" ) then

end

if _groupName == "" then return end

local _ucid =  net.get_player_info(id, 'ucid') 

 if _deadUserUCIDS[_ucid] == true then
    local _playerName = net.get_player_info(id, 'name')
    if _playerName ~= nil then
      local _chatMessage = string.format("%s - %s ",_playerName, textForSlotBlock)
      net.send_chat_to(_chatMessage, id)
      net.log("SlotBlock - Player " .. _playerName .. " Kicked To spectators" )
    end

    net.force_player_slot(id, 0, '')
 end
end)
if not stat then 
  net.log("SlotBlock -  Error in script " .. err) 
end
end

function _callbacks.onGameEvent(eventName,arg1,arg2,arg3,arg4,arg5,arg6,arg7)
  local status,err = pcall(function() 
    if DCS:isServer() then
      if eventName == "pilot_death" and enabled == true then
        
        local _id = arg1
        local _ucid =  net.get_player_info( _id, 'ucid') 
        _deadUserUCIDS[_ucid] = true
        local _playerName = net.get_player_info(_id, 'name')
        if _playerName ~= nil then
          local _chatMessage = string.format("%s - %s",_playerName, textWhenKilled)
          net.send_chat_to(_chatMessage, _id)
        end
        net.force_player_slot(_id, 0, '')
      
      end
    end
  end)
  if not status then
    net.log( "SlotBlock - Error on event " .. eventName .. " " .. err)
  end
end



net.log("Slot Block Loaded")
DCS.setUserCallbacks( _callbacks )
