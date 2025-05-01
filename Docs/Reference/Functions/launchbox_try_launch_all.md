[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_try_launch_all

Attempts to launch one or more launch boxes, executing all their callbacks and discarding them. After the launch, no boxes can remain declared (and therefore unlaunched); otherwise, an error will be thrown.

At least one box must be given. Any identifiers that don't match declared launch boxes are ignored.

Because the function ensures no box remains declared after the call, it protects against bugs caused by typos. More specifically, it prevents a situation where a callback is put into a misnamed box and thus never gets executed for no apparent reason. However, it's not suitable for situations when multiple sets of box declarations are managed in parallel - trying to launch boxes from one set will report declarations from the other set as leftovers and vice versa. In such cases, [`launchbox_try_launch`](/Docs/Reference/Functions/launchbox_try_launch.md) should be used instead.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **...boxes** | **`String`, `Struct.LaunchboxBox`** | **Required** | One or more boxes to attempt the launch of. |

### Example

The following code attempts to launch callbacks related to specific in-game entities:

```gml
launchbox_try_launch_all("environment", "player", "enemies");
```
