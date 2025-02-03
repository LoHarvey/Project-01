/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR suites_bear = 1
VAR clothes = 0
VAR health = 0
VAR evan = 1
VAR shotgun = 0
VAR light = 0

-> story_start

== story_start ==
You are attending a New Years party at a ski lodge in the mountains. You are there with your friend Evan.
You are enjoying the night in the ballroom, when all of a sudden there is a massive explosion, shattering the glass roof and killing the power.
As you atempt to find Evan in the Chaos, somthing heavy hits you from behind, knocking you out. 
* [Continue] -> wake_up

== wake_up ==
You wake up some time later undernieth one of the dinning tabels in the same ballroom. It is freezing and your head hurts bad; it doesn't seem like anyone else is around. 
* [Get Up and Look Around The Room] -> wake_up_2

== wake_up_2 ==
The once prestine, ballroom you are in is now covered in glass from the shattered ceiling. The room seems to be devoid of life, with no sign of the people that were in it earlier.
You have no clue what is happening but you know that you need to find Evan and get somewhere safe.
* [Look For a Way Out of The Room] -> ball_room

== ball_room ==
There are there exits out of the ball room: One leading to the entrance of the lodge(if you remeber correctly that is the same direction the explosion came from), annother leading to the hotel suites where you and Evan are staying, and finally there is an exit onto the balcony that overlooks the mountain.
{health == 0:Your head is still hurt from earlier.} {clothes == 1:Your coat is keeping you warm.} {shotgun == 1:You have a shotgun.} {light == 1:You have a flashlight}
+ [Go Towards The Entrance] -> entrance
+ {not hotel_hall}[Go Towards The Suites] -> hotel_hall
+ {hotel_hall}[Go Towards The Suites] -> bear_gone
+ [Go Out On To The Balcony] -> balcony

== entrance ==
{right_suites:The entrance to the lobby that seems to have at one time been on fire, but has now died down, is infront of you.|The entrance to the lobby is in flames. It must have come from whatever caused the explosions. The flames may die down once some time has passed.}
+ {right_suites}[Explore The Lobby] -> lobby
+ [Return To The Ballroom] -> ball_room

== lobby ==
The lobby seems to have taken a lot of damage from the explosion. Half of the ceiling had colapsed, leaving only the halway you walked in from and the reception desk.
+ {not steroids}[Search The Reception Desk] -> desk
+ [Go Back To The Hallway] -> entrance

== desk ==
Begind the desk, the only thing of use you caould find was a first-aid kit that had some steroids in it.
* [Take The Steroids] -> steroids
+ [Go Back] -> lobby

== steroids ==
As soon as you apply the injector, you instantly start to feel alot better, and your head clears of pain.
~ health = 1
* [Go back] -> lobby

== hotel_hall ==
As you walk towards the suiets in a dark, freezing hallway you hear a low growl comming from the center of a fork. As you approch closer, you stop dead in your tracks as you are able to make out the figure of a giant hulking bear at the center of the forking paths, iluminated by the glow of a flashlight on the floor right next to it.
It seems to be distracted by something...or someone laying liflessly on the floor.
* [Wait To See If The Bear Leaves] -> bear_gone
* [Confront The Bear] -> dead

== dead ==
When you try to aproch the bear it turns and jumps at you faster than you can think. 
The world fades to black as it mauls you. 
-> END

== bear_gone ==
{suites_bear == 1:After a few minutes, the bear procedes down the second of three halways that are infront of you, dragging the body along with it.}{suites_bear == 0:The path to the suites forks out into three different hallways.}
The halway to your left is where your room is located. You have not been down the middle hall before but you do know that there is now a bear there. The right hall is where Evan's room is located
{not light_pickup:The flashlight is still sitting in the middle of the room.} {clothes == 1:Your coat is keeping you warm.} {shotgun == 1:You have a shotgun.} {light == 1:You have a flashlight}
~ suites_bear = 0 
{health == 0:Your head is still hurt from earlier.}
+ [Go Down The Left Hall] -> left_suites
* [Go Down The Middle Hall] -> really
+ [Go Down The Right Hall] -> right_suites
* [Pickup The Flashlight] -> light_pickup
+ [Go Back to The Ballroom] -> ball_room

==light_pickup ==
You picked up the flashlight
~ light = 1
* [Go back] -> bear_gone

==left_suites ==
This hallway seems to be in a state of disrepair but you are able to find a way into your room where you are able to get into your room
* [Put On Some Warmer Clothes] -> bundel_up
+ [Go Back] -> bear_gone

== bundel_up ==
You are able to find a large coat and other accesories that will be able to keepm you warm in the mountain's freezing temperatures.
~ clothes = 1
* [Go Back] -> left_suites

== really ==
There is no reason to go this way, unless you wish to die.
* [Go Back] -> bear_gone

==right_suites==
You are able to find your way to Evan's room in the hallway{health == 0:, but his door seems to be jammed and you are still too weak from getting knocked out earlier to kick the door in}.
* {health == 1}[Force Your Way Into The Room] -> evans_room
+ {evan ==  0}[Go Into Evans Room] -> evan_dead
+ [Go Back] -> bear_gone

== evans_room ==
You bust into the room to a terrifying sight. Evan is laying on his bed with a shotgun in one hand, a dead bear on the floor, and his chest covered in blood. He notices you but winces in intense pain before he is able to say anything. You want to do something but you both know that its too late for him. 
He hands you the shotgun saying, "Take this and get to the ski-lift down the mountaint. Call for help"
You are there for him in his last moments.
~ evan = 0
~ shotgun = 1
* [Take That Shotgun and Return To The Halway] -> bear_gone

== evan_dead ==
Evan's body sits lifelessly on the bed.
+ [Go Back To The Hall] -> bear_gone

==balcony ==
As you step out you blasted with freezing wind and, outide of the light of the ski lift that is a few hundred yards down the mountain, you can barely see more than a few inces in front of you.
* {bundel_up && light_pickup} [Jump The Rail and Decend Down The Mountain] -> slope
+ [Go Back] -> ball_room

== slope ==
You turn on your flashlight and carefully make your way down the slope. 
After about 20 or so feet, your flashlight iluminates something big and furry. Another bear. Luckily, it has its back to you.
* {shotgun == 1}[Shoot The Bear] -> win
* [Try and Sneek Past The Bear] -> dead_2

== win ==
With one shot, aimed as well as you can while scared out of your mind, you take the bear down.
It seems as though the shot wasn't too lound as you are then able to safely walk down the rest of the slope and call for help at the ski lift control station. 
You Escaped!...But you were the only survivor. 
-> END

== dead_2 ==
AS you walk to move around the bear, you start to think that it won't notice you, but just bfore your far enough away, you hear a deep, gutteral growl. You hear the sound of paws on snow and before you can even begin to react the bear is on top of you...sinking its teeth in.
->END