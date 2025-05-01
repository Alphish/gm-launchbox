[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_exists

Checks if a launch box with the given identifier has been declared. Returns `true` for launch box instances.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **box** | **`String`, `Struct.LaunchboxBox`** | Default: `"main"` | The box to check. |

###### Returns
**`Bool`**

### Example

The following code checks if a "player" launch box has been declared, and if not, prevents testing an editor level:

```gml
if (!launchbox_exists("player")) {
    array_push(global.editor_errors, "Place at least one player entity in the level.");
    launchbox_discard_all();
}

if (array_length(global.editor_errors) == 0)
    room_goto(rm_EditorTest);
```
