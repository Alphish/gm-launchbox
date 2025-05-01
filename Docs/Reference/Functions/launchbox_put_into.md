[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_put_into

Puts a callback into the given launch box, to be executed on launch. Optionally, an array of arguments may be given to call the callback with; otherwise, the callback function will be called without arguments.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **box** | **`String`, `Struct.LaunchboxBox`** | **Required** | The box to put the callback into. |
| **callback** | **`Function`** | **Required** | The callback to execute on launch. |
| **args** | **`Array`** | Optional | The arguments to execute the callback with. |

### Example

The following code prepares a debug message to be shown upon launch:

```gml
launchbox_put_into("hello", function() {
    show_debug_message("Hello, Launchbox!");
});
```

Alternatively, an argument array may be used to customise the message:

```gml
launchbox_put_into("hello", show_debug_message, ["Hello, Launchbox!"]);
```
