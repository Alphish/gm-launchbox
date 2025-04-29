[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_clear

Clears all callbacks from one or more launch boxes, while keeping them declared. If no boxes are given, the "main" box is cleared.

All of the given boxes must exist. If the function is given an identifier that doesn't match any declared boxes, an error will be thrown.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **...boxes** | **`String`, `Struct.LaunchboxBox`** | Optional | One or more boxes to clear. |

### Example

The following code checks if the level is cleared, and clears an enemy-related box if that's the case:

```gml
if (level_is_cleared(room))
    launchbox_clear("enemies");

launchbox_launch_all("environment", "player", "enemies");
```
