[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_put_method_into

Puts a context-bound method into the given launch box, to be executed on launch. Optionally, an array of arguments may be given to call the method with; otherwise, the method will be called without arguments.

If the context is an object asset, the method will be called with each instance present.

The method function may be passed as a raw function, a method or a string name. Given a method, its underlying function will be used and called from within the target context, regardless of what the method was originally bound to. Given a string name, the function or method to call will be retrieved from the context variable matching the name (case-sensitive). A method retrieved from a context variable will be called from its own bound context, unlike a directly passed method.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **box** | **`String`, `Struct.LaunchboxBox`** | **Required** | The box to put the method into. |
| **context** | **`Any`** | **Required** | The context of the method to execute. |
| **func** | **`Function`, `String`** | **Required** | The logic or name of the method to execute. |
| **args** | **`Array`** | Optional | The arguments to execute the callback with. |

### Example

The following code prepares a setup logic to be called upon launch:

```gml
launchbox_put_method_into("finalize", ctrl_Gameplay, function() {
    spawn_player();
    link_walls();
});
```

Alternatively, a method name can be used instead, so that a method stored in the "setup" variable of `ctrl_Gameplay` is called:

```gml
launchbox_put_method_into("finalize", ctrl_Gameplay, "setup");
```
