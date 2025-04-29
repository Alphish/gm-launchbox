[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_put_instance

Puts an instance into the main launch box, to be created on launch with given pre-Create variables and a post-Create logic. Similarly to Object Variables and Instance Creation Code, pre-Create variables are set before the **Create** event and the post-Create logic is executed after the event.

Sometimes, the pre-Create variables may be unknown at the time of putting the instance, but will be resolvable at the time of launch. For scenarios like these, a function may be passed in place of the pre-Create variables; it will be executed upon launch and the struct it returns will be used as pre-Create variables.

Upon launch, the new instance will be created at the top-left position (X and Y equal to 0), in the "Instances" layer. If no such layer exists, it will be created at the first layer retrieved via `layer_get_all` function. If for some reason there are no layers, an "Instances" layer will be created at a depth of 0 and the new instances will be created there. The `x`/`y`/`layer` values can be overriden with pre-Create variables or the post-Create logic.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **object** | **`Asset.GMObject`** | **Required** | The object to create the instance of. |
| **variables** | **`Struct`, `Function`** | Optional | The variables set on the newly created instance, or a parameterless function generating them. |
| **postcreate** | **`Function`** | Optional | The logic to execute on the newly created instance, after its Create event. |

### Example

The following code prepares an information view instance to be created at the bottom-right area of the screen. A function is used to generate pre-Create variables, because room width and height aren't known at the time of putting the instance.

```gml
launchbox_put_instance(obj_InfoView, function() {
    return {
        x: room_width - 400,
        y: room_height - 200,
        width: 400,
        height: 200,
    };
});
```

The following code prepares an enemy wave with a given duration (provided in pre-Create variables) and a set of enemies (defined in the post-Create function):

```gml
launchbox_put_instance(obj_EnemyWave, { duration: 600 }, function() {
    for (var i = 0; i < 10; i++) {
        add_enemy(obj_EnemyBasic, /* delay */ 15 * i);
        add_enemy(obj_EnemyChampion, 150);
    }
});
```