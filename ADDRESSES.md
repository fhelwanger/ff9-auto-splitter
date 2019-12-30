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
- **Address:** `"FF9.exe", 0x0116FDC0, 0x8, 0x7A0, 0x748, 0x28, 0x10, 0x10, 0x5C;`

The ID of the current scene, can be a battle, field, world map, etc.

## battleId

- **Type:** `int`
- **Address:** `"FF9.exe", 0x0115DDC8, 0x60, 0x20, 0x10, 0x98, 0x7D0, 0x68, 0x7E0, 0x64;`

The ID of the scene of the current battle. Only changes for battles. `sceneId` doesn't change when you get a world map battle, but `battleId` does.

## isRandomEncounter

- **Type:** `bool`
- **Address:** `"FF9.exe", 0x0108CD60, 0x8, 0x18, 0xE0, 0x0, 0x30, 0x208, 0x364;`

Indicates if the current encounter is random or fixed. Ragtime encounters are counted as fixed.

## necronHP

- **Type:** `ushort`
- **Address:** `"FF9.exe", 0x0111A3F0, 0x20, 0x1D8, 0x58, 0x2C8, 0x150, 0x38, 0x48, 0x210, 0x40;`

Necron's current HP. Have 10k extra (so 61400 max) to trigger dialogs after death.

## focusedElement

- **Type:** `string`
- **Address:** `"FF9.exe", 0x01116790, 0x10, 0x0, 0x10, 0x58, 0x0;`

It's a kind of "description" of the "current object". It was the way that I found to track if the player selected "New Game" on the title screen to start the timer as soon as the button is pressed.

## buttonPressed

- **Type:** `bool`
- **Address:** `"mono.dll", 0x002635B8, 0x0, 0x38, 0x100, 0xB8, 0x138;`

Indicates if some button on the title screen is pressed.

## isFmv

- **Type:** `int`
- **Address:** `"MSVCR120.dll", 0xDC518;`

9 if there's some FMV playing. Otherwise 0.

## textboxIndex

- **Type:** `int`
- **Address:** `"FF9.exe", 0x0115BEA8, 0x400, 0xE0, 0x98, 0x5E0, 0x10, 0x614;`

The index of the textbox being displayed on the current scene.
