# Animal Village
## Core Concept
This is a game about community. You are a new resident in a village. You are a new resident in a village and you talk to and do activities with the other villagers to build your relationship.
## Setting
The game takes place in a village with the following features:
### Town Center
A clearing for npcs to wander and for players to access the other buildings in the village. Mainly a transitional area where you are likely to find other villagers. Some bugs spawn here too.
### Shop
A building for buying and selling. The player can buy a bugnet, a watering can, seeds, medicine, and one random piece of furniture selected each morning. The player can sell any item. Closes at night.
### NPC Houses
Each npc villager has a house with a few pieces of furniture, including a bed. This is where you will find them in the morning or evening. If they are sick, they will stay in bed all day. The player can only enter a house if the owner is in and not asleep.
### Flower Field
An area with flower beds. The villagers can plant and water flowers here. Weeds will grow periodically and can be weeded out. Flowers have hp and will die if it is drained. Flowers lose hp by being stepped on, being left unwatered for a day, being near a weed. Bugs spawn here.
### Forest
A collection of trees away from the houses. Bugs and artifacts spawn here.
### Waterfront
A beach by the water. Artifacts spawn here.
### Player’s Home
A house similar to the npc houses. The player has the freedom to place furniture here.
## Time
The game has a cycle for day and night. 1 hour in game passes every 90 seconds, and a full day is 36 minutes. The shop is open from 8:00 - 20:00. Time also affects villagers' schedules dependent on their personality, and what bugs are out.
### Rain
Each morning there's a 1/7 chance it will be a rainy day. On rainy days, villagers mostly stay indoors, flowers are automatically watered, weed growth is sped up, and bugs do not spawn.
## Villagers
Villagers are the heart of the game.
### Villager Traits
#### Personality
Villagers can be **chill**, **nerdy**, or **preppy**. Their personality determines their dialog and their schedule.
##### Chill Schedule
- 10:00 Wakes up, wanders their home.
- 14:00 Leaves to do hobby
- 18:00 Wanders randomly.
- 22:00 Returns home.
- 02:00 Asleep
##### Nerdy Schedule
- 08:00 Wakes up, wanders their home.
- 12:00 Leaves to do hobby, or stays indoors on a rainy day.
- 16:00 Returns home.
- 00:00 Asleep
##### Preppy Schedule
- 5:00 Wakes up, wanders their home.
- 6:00 Wanders town center.
- 10:00 Leaves to do hobby
- 14:00 Returns home.
- 18:00 Asleep
#### Hobby
**Bug:** Villagers with the bug hobby will spend most of their time in the forest. They will catch bugs. Many of their interactions will revolve around bugs.

**Flower:** Villagers with the flower hobby will spend most of their time in the flower field. They will water plants and weed. Many of their interactions will revolve around flowers.

**Stroll:** Villagers with the stroll hobby wander anywhere.
#### Relationship Values
Each npc villager has a relationship to player value (RVP) which measures how good friends you are on a scale 0-100. Each interaction has an RVP range it is able to happen in. Many interactions also affect RVP. RVP starts at 10 and degrades by 1 each day.
### Interactions
#### Chatting
Villagers have a few randomized lines of dialog each day based on friendship and recent events.

RPV +1.
#### Ask Favor
Once a day, a villager can ask the player for a favor. This has a random chance to trigger when chatting. This may also be triggered if the player is standing nearby, causing the villager to approach.

Favors can take the following forms:
##### Quiz
Will ask you a question that may relate to:
- Their hobby
- Their feelings on another villager
- Recent events

RVP change depends on how much they like your answer, within a range of (-1,+2)
##### Delivery
Will give the player an item to deliver to another villager.

RVP +3 if successful
##### Request
Will ask for an item related to their hobby, or Medicine if sick

RVP +3

Bonus points for quality of item
#### Gift Giving
Villagers have a chance to gift the player items, usually furniture. The probability and quality depend on RPV. The probability also increases when players pick up trash and plant flowers.
#### Gift Receiving
After chatting with a villager, the player can choose an item from their inventory to gift away.

RVP change depends on how liked the gift is, which depends on personality, hobby, item quality, and if they already own the item.
#### Bother
If the player does something that bothers a villager, they will be bothered and chastise the player.

Actions that bother villagers are:
- hitting with tool - RVP -1
- being pushed - RVP -1
- talking too many times in quick succession - RVP -1
- stepping on flowers (flower hobby only) - RVP -1
- scaring bugs (bug hobby only) - RVP -1
- failing a delivery favor - RVP -2

RVP loss increases exponentially each time bothered in a single day
### Sick
Each villager each morning has a 1/30 chance of waking up sick. On a sick day, they will stay in bed, though the player can still enter their house. They will request medicine.
## Items
### Artifacts
- Cowrie, spawns on waterfront
- Sand Dollar, spawns on waterfront
- Brown Mushroom, spawns in forest
### Bugs
- Ant, spawns anywhere
- Bee, spawns over flowers during day
- Beetle, spawns on trees during day
- Butterfly, spawns anywhere
- Moth, spawns around lights at night
### Furniture
- Bed, villagers start with one
- Table, villagers start with one
- Lamp, villagers start with one
- Flowervase, flower hobby villagers start with one
- Terrarium, bug hobby villagers start with one
- Beanbag, stroll hobby villagers start with one
- Chair
- Radio
- Chest
- Painting
### Gifts
- Medicine, can be bought from the store and gifted to sick villagers.
### Tools
- Bugnet, used to catch bugs. It breaks after 32 uses. Bought from the store.
- Flower Seeds, used to plant flowers. Consumed upon use. Bought from the store.
- Watering Can, used to water flowers. Breaks after 32 uses. Bought from the store.
- Umbrella. Bought from the store.
### Trash
Can be sold, or gifted to reduce RVP.
- Weeds, obtained by weeding the flower fields.

## Assets Needed
- Terrain, including town center, forest, and waterfront
- Shop exterior and interior
- House exterior and interior
- Character models for Player, Shopkeep, and at least 3 villagers
- Character animations for stand, sit, walk, talk, water plant, catch bug, spread seed, open door, sleep, sick
- Bugnet, watering can models
- Furniture models and icons in inventory
- Trees, flowers, weeds (could be models or sprites)
- Bug sprites, animated
- Sprites for other items (artifacts, medicine)

## Future Goals
- More Weather
- Holidays
- Player can get sick
- Option for time to pass in real time
### Personalities
Jock, Goth, Upbeat
### Hobbies
collect furniture, collect shells
### Favors
- retrieve item from another villager
- hide and seek
- ask another villager a question
- offering purchase
- offering sale
### Bugs
- Dragonfly, spawns in forest during day
- Firefly, spawns in forest at night
- Grasshopper, spawns in forest during day
- Isopod, spawns on the waterfront
- Spider, spawns on trees