[Home](/README.md) > [Tutorials](/Docs/Tutorials/TOC.md)

**Previous:** [Example game setup](/Docs/Tutorials/02-ExampleGameSetup.md)

# "Initial Room" demo

In the Launchbox demonstration, the initial room entities are created entirely with Launchbox function calls, put directly into scripts. The only thing placed in the starting room is the `ctrl_LaunchboxLauncher` instance to launch the default box.

Of course, setting up the starting room with detailed initialisation tasks is more of an exercise; usually, one would place all of these directly in the room. Nevertheless, it should sufficiently demonstrate the use of simple callbacks and instances.

### Simple callbacks

To create the background, the `init_Background` script is created with the following content:

```gml
launchbox_put(function() {
    var _layer = layer_get_id("Background");
    var _bg = layer_background_get_id(_layer);
    layer_background_sprite(_bg, bg_LaunchboxDemo);
    layer_background_blend(_bg, c_white);
});
```

The logo sprite is placed with `init_Logo` script:

```gml
launchbox_put(function() {
    var _layer = layer_create(-100, "Logo");
    layer_sprite_create(_layer, room_width div 2, 160, spr_Logo);
});
```

Additionally, the `init_Title` and `init_Info` scripts are created to place the title and general explanation:

```gml
launchbox_put(function() {
    var _layer = layer_create(-200, "Title");
    var _text = layer_text_create(_layer, 0, 300, fnt_Title, "Launchbox Demo");
    layer_text_wrap(_text, true); // required to enable centering
    layer_text_framew(_text, room_width);
    layer_text_frameh(_text, 100);
    layer_text_halign(_text, textalign_center);
});
```

```gml
launchbox_put(function() {
    var _layer = layer_create(-150, "Info");
    var _text = layer_text_create(
        _layer, 0, 390, fnt_Info,
        "Welcome to the Launchbox library demo!\nEverything in this room was created using Launchbox calls.\nSee \"Initial Room\" example to learn more!\nClick Proceed to check another showcase."
        );
    layer_text_wrap(_text, true); // required to enable centering
    layer_text_framew(_text, room_width);
    layer_text_frameh(_text, 240);
    layer_text_halign(_text, textalign_center);
});
```

There is not much to be said here. One thing of note is how layers and room dimensions are usable within the callbacks; this would not work if the callback logic was put in the scripts directly.

### Creating instances

Finally, button instances are created to add a link to this example and to proceed to the next room:

```gml
launchbox_put_instance(obj_Button, function() {
    return {
        x: room_width div 2 - 120,
        y: room_height - 180,
        image_xscale: 4,
        text: "Visit example",
        on_click: function() {
            url_open("https://github.com/Alphish/gm-launchbox/blob/main/Docs/Tutorials/03-DemoInitialRoom.md");
        },
    };
});

launchbox_put_instance(obj_Button, function() {
    return {
        x: room_width div 2 - 120,
        y: room_height - 120,
        image_xscale: 4,
        text: "Proceed",
        on_click: room_goto_next,
    };
});
```

While the `launchbox_put_instance` function doesn't provide x/y/layer arguments like `instance_create_layer` does, these can still be specified by passing x/y coordinates to the pre-Create variable structs.

Most of the time, the pre-Create variables argument can be a simple struct, with all values known at the time of putting the instance in the box. However, sometimes the pre-Create variables may depend on values that are only available upon launch. For these cases, a function returning the pre-Create variables struct can be used instead.

In this example, functions are used as opposed to simple struct. That's because positioning the button instances relies on the room width and height, which aren't known at the time of running the script.

**Next:** ["Effects Show" demo](/Docs/Tutorials/04-DemoEffectsShow.md)
