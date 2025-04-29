[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Constructors](/Docs/Reference/Constructors/TOC.md)

# LaunchboxBox constructor

A launch box storing callbacks to execute upon launch.

Most of the **Launchbox** functionality can be handled through the [global functions](/Docs/Reference/Functions/TOC.md), which manage the `LaunchboxBox` instances under the hood. However, the constructor is still available if you need more fine-grained control over the launch boxes.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **name** | **`String`** | Optional | The name to declare the launch box with; leave as undefined to omit declaration. |

###### Variables

| Name | Type | Default | Description |
|:---:|:---:|:---:|:---|
| **name** | **`String`** | `name` | The name the box has been declared with (or `undefined`). |
| **name** | **`String`** | Lowercase `name` | The key identifying the box among the declared boxes and a lowercase version of `name`.<br>It's used for registering and finding the declarations, so that access is case-insensitive. |
| **callbacks** | **`Array<Function>`** | `[]` | The callbacks to execute upon launch (managed through the launch box methods). |

###### Instance methods

The following instance methods are available for `LaunchboxBox` instances:

- [put](/Docs/Reference/Constructors/LaunchboxBox_put.md)
- [put_method](/Docs/Reference/Constructors/LaunchboxBox_put_method.md)
- [put_instance](/Docs/Reference/Constructors/LaunchboxBox_put_instance.md)
- [clear](/Docs/Reference/Constructors/LaunchboxBox_clear.md)
- [discard](/Docs/Reference/Constructors/LaunchboxBox_discard.md)
- [launch](/Docs/Reference/Constructors/LaunchboxBox_launch.md)
