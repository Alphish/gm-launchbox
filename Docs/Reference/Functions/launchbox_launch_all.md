[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_launch_all

Launches all launch boxes in the given order, executing all their callbacks and discarding them. After the launch, no boxes can remain declared (and therefore unlaunched); otherwise, an error will be thrown.

At least one box must be given, and all of the given boxes must exist. If the function is given an identifier that doesn't match any declared boxes, an error will be thrown.

Because the function ensures no box remains declared after the call, it protects against bugs caused by typos. More specifically, it prevents a situation where a callback is put into a misnamed box and thus never gets executed for no apparent reason. However, it's not suitable for situations when multiple sets of box declarations are managed in parallel - trying to launch boxes from one set will report declarations from the other set as leftovers and vice versa. In such cases, [`launchbox_launch`](/Docs/Reference/Functions/launchbox_launch.md) should be used instead.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **...boxes** | **`String`, `Struct.LaunchboxBox`** | **Required** | One or more boxes to launch. |

### Example

The following code launches all initialization stages on the game start:

```gml
launchbox_launch_all("main", "items", "enemies");
```
