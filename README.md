# DCS-Scripts
Random requested scripts

1. [**Hit Message**](https://github.com/marcos2221/DCS-Scripts/tree/master/hitMessage): Simple script that will display a message on the right side of the screen when a target is hit, Grouped by weapon type.  (WIP) Example mission by Howard Hung.

![Image of Yaktocat](https://github.com/marcos2221/DCS-Scripts/blob/master/hitMessage/a10c.jpg)

2. [**Artillery Script**](https://github.com/marcos2221/DCS-Scripts/tree/master/arty): Script to make all artillery engage helicopters that are in the same position for more than 2 or 3 minutes.
![Image of Yaktocat](https://github.com/marcos2221/DCS-Scripts/blob/master/arty/arty.PNG)
* Parameters: 
    * redArty = true         <-- Red artillery will engage, Set to false to deactivate
    * blueArty = false       <-- Blue artillery won't engage, set to true to activate
    * artyRadius = 200       <-- Target Radius
    * artyExpendQty = 5      <-- Number of rounds to be fired
    * reactionTimemin = 30   <-- Reaction Time Minimum
    * reactionTimeMax = 120  <-- Reaction Time Maximum
    * targetOffset = 50      <-- Distance in meters to offset from target, reduce the probability of impact (kinda)..

3.[**ROE Set On Proximity**](https://github.com/marcos2221/DCS-Scripts/tree/master/RoeSet): Script to make all RED AI Fw to engage only when merged with a Blue one. Training Purposes I guess

4.[**Slot Block When Player dies**](https://github.com/marcos2221/DCS-Scripts/tree/master/SlotBlock): In Multiplyer all slot will get blocked for the players that die, the lock will remain until server restart or mission is changed, lock will work even if player disconnects and changes the name

5.[**Lua Predicate - Complex events (kill)**](https://github.com/marcos2221/DCS-Scripts/tree/master/Lua%20Predicate)
Create conditions in the scripts and trigger it as a Lua predicate.
* Conditions: 
   * unitCoalition  => Coalition Blue, Red or Neutral
   * unitCategory   => Category of the Killer -> Aircraft, ground unit, helicopter, Ship, 
   * unitisHuman   => If the killer is Human or AI or both
   * targetCoalition => Coalition Blue, Red or Neutral 
   * targetCategory  => Category of the Killed -> Aircraft, ground unit, helicopter, Ship, 
   * targetisHuman   => If the killed unit is Human or AI or both 
![Image of Yaktocat](https://github.com/marcos2221/DCS-Scripts/blob/master/Lua%20Predicate/Screenshot%202022-06-17%20132828.png)

6.[**Simple Respawn **](https://github.com/marcos2221/DCS-Scripts/tree/master/simpleRespawn)
Re-spawns dead units from a specific coalition after a predetermined time

7.**What do YOU need?**
