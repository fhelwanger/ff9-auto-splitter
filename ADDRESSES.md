# Memory Addresses

This is the list of memory addresses that I found:

## sceneType

- **Type:** `int`
- **Address:** `"FF9.exe", 0x0115BEA8, 0x48, 0x10, 0x98, 0x270, 0x10, 0x140`;

Indicates the type of the current screen. Can be one of the following:

- Bundle = 0
- Field = 1
- World = 2
- Battle = 3
- Title = 4
- QuadMist = 5
- Pure = 6
- Ending = 7
- EndGame = 8
- None = 9

## sceneId

- **Type:** `int`
- **Address:** `"FF9.exe", 0x0115CCC0, 0x48, 0x90, 0xA0, 0x78, 0x120, 0x28, 0x10, 0x10, 0x5C`

The ID of the current scene, can be a battle, field, world map, etc.

## focusedElement

- **Type:** `string`
- **Address:** `"FF9.exe", 0x01116790, 0x10, 0x0, 0x10, 0x58, 0x0;`

It's a kind of "description" of the "current object". It was the way that I found to track if the player selected "New Game" on the title screen to start the timer as soon as the button is pressed.

## buttonPressed

- **Type:** `bool`
- **Address:** `"mono.dll", 0x002635B8, 0x0, 0x38, 0x100, 0xB8, 0x138;`

Indicates if some button on the title screen is pressed.
