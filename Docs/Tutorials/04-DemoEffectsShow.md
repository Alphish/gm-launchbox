[Home](/README.md) > [Tutorials](/Docs/Tutorials/TOC.md)

**Previous:** ["Initial Room" demo](/Docs/Tutorials/03-DemoInitialRoom.md)

# "Effects Show" demo

Launchbox demonstration also has an Effects Show room, in which several orbs bounce around, while showing special effects and changing colours. It uses methods functionality and ordering of multiple launch boxes.

The following actions can be scheduled for launch:

- making all orbs emit a puff of smoke, each matching the orb's colour
- making all orbs emit a firework, each matching the orb's colour
- changing a random orb to the given colour

### Effect methods

Each instance of the orb object (`obj_EffectOrb`) defines following methods to create specific effects:

```gml
make_puff = function() {
    effect_create_depth(depth + 1, ef_smokeup, x, y, random_range(0.5, 3), image_blend);
}

make_firework = function() {
    effect_create_depth(depth + 1, ef_firework, x, y, random_range(0.5, 2), image_blend);
}
```

These methods are scheduled for launch, using [`launchbox_put_method_into`](/Docs/Reference/Functions/launchbox_put_method_into.md) calls. The effects show controller defines the following methods, which are linked to the corresponding buttons:

```gml
request_puff = function() {
    launchbox_put_method_into("puffs", obj_EffectOrb, "make_puff");
}

request_firework = function() {
    launchbox_put_method_into("fireworks", obj_EffectOrb, "make_firework");
}
```

When putting methods into a launch box, the context and the method logic must be given. The context may be a struct, an object instance or the object itself.

Here, the `obj_EffectOrb` is used as the context. Because it's an object asset, the method will be called for all its instances present during launch.

The logic might be given as a function, a bound method or a string name. The function and the method are simply called from the context instance (the original method binding is ignored). Given a string name, a context variable with that string name will be retrieved and used as the method to call.

Here, the logic is given as string names matching the names of `obj_EffectOrb` method variables.

### Callback and method arguments

Sometimes, it's useful to have initialisation tasks reuse the same functions, but call them with different arguments. By default, `launchbox_put` and `launchbox_put_method` functions are called without any arguments. However, an array of arguments may be optionally provided to both.

Here is an example of passing arguments in the effects show controller:

```gml
request_color = function(_color) {
    launchbox_put_into("color", function(_color) {
        var _instance = instance_find(obj_EffectOrb, irandom(instance_number(obj_EffectOrb) - 1));
        _instance.image_blend = _color;
    }, [_color]);
}
```

The callback finds a random effect orb to change the colour of, and sets it to the colour passed as the first and only argument in the array.

### Action ordering

Upon launch, the effects show controller runs the following method:

```gml
launch = function() {
    launchbox_try_launch_all("puffs", "color", "fireworks");
}
```

First it runs all prepared smoke puffs actions, then all prepared colour-switching actions, and finally all prepared fireworks actions.

The effects created match the colours of their respective orbs at the time. With this launch order, it means if an orb switches a colour upon launch, then any smoke puff it creates will match the previous colour and any firework it creates will match the new colour. Changing the launch order will change the expected effect colours accordingly.
