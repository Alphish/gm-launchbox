[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_put

Puts a callback into the main launch box, to be executed on launch. Optionally, an array of arguments may be given to call the callback with; otherwise, the callback function will be called without arguments.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **callback** | **`Function`** | **Required** | The callback to execute on launch. |
| **args** | **`Array`** | Optional | The arguments to execute the callback with. |

### Example

The following code prepares a debug message to be shown upon launch:

```gml
launchbox_put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

Alternatively, an argument array may be used to customise the message:

```gml
launchbox_put(show_debug_message, ["Hello, Launchbox!"]);
```
