[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Constructors](/Docs/Reference/Constructors/TOC.md) > [LaunchboxBox constructor](/Docs/Reference/Constructors/LaunchboxBox.md)

# LaunchboxBox.put instance method

Puts the given callback into the box, to be executed on launch. Optionally, an array of arguments may be given to call the callback with; otherwise, the callback function will be called without arguments.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **callback** | **`Function`** | **Required** | The callback to execute on launch. |
| **args** | **`Array`** | Optional | The arguments to execute the callback with. |

### Example

The following code prepares a debug message to be shown upon launch:

```gml
init_launchbox.put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

Alternatively, an argument array may be used to customise the message:

```gml
init_launchbox.put(show_debug_message, ["Hello, Launchbox!"]);
```
