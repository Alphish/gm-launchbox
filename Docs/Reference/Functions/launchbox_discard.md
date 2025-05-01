[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_discard

Discards one or more launch boxes along with their callbacks, so they're no longer declared. If no boxes are given, the "main" box is discarded.

Any identifiers that don't match declared launch boxes are ignored.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **...boxes** | **`String`, `Struct.LaunchboxBox`** | Optional | One or more boxes to discard. |

### Example

The following code checks if the game is in testing mode, and discards the main launch box if that's the case:

```gml
if (os_get_config() == "Test")
    launchbox_discard();
else
    launchbox_launch();
```
