[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_launch

Launches one or more launch boxes, executing all their callbacks and discarding them. If no boxes are given, the "main" box is launched.

All of the given boxes must exist. If the function is given an identifier that doesn't match any declared boxes, an error will be thrown.

If named launch boxes are used (as opposed to the default "main" box), the use of [`launchbox_launch_all`](/Docs/Reference/Functions/launchbox_launch_all.md) is recommended instead, unless multiple sets of box declarations are managed in parallel. These functions protect against typos when putting callbacks into boxes.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **...boxes** | **`String`, `Struct.LaunchboxBox`** | Optional | One or more boxes to launch. |

### Example

The following code launches the main launch box at the start:

```gml
launchbox_launch();
```
