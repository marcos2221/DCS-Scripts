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
