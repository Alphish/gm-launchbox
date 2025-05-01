[Home](/README.md) > [Tutorials](/Docs/Tutorials/TOC.md)

**Previous:** ["Effects Show" demo](/Docs/Tutorials/04-DemoEffectsShow.md)

# Example room setup

Aside from initialisation at the start of the game itself, **Launchbox** also can be used for setting up rooms.

The game initialisation had to deal with the unknown script execution order and the inability to act on instances before the room was created. The room initialisation faces similar challenges - while the instance creation order can be manually specified, it's cumbersome (especially with larger rooms), and some initialisation logic requires all instances to have been created. 

Those room initialisation issues can be circumvented with the **Room Start** event, which can orchestrate specific initialisation steps across objects. A system based around the **Room Start** event may already sufficient, and Launchbox might not add as much value as it does for game initialisation. However, a Launchbox-based room initialisation is still an option; at the same time, the **Room Start** event remains the most natural place for performing the launch.

## Basic initialisation

Suppose there are walls that need to select sprite images based on their neighbours of the same object type. If it's done directly in the Create event, at least some walls will use incomplete information - if wall A is created before a nearby wall B, then it won't use information about wall B properly. However, choosing the images will work if the image selection is delayed until launch, as long as it happens after all room instances are created and ready.

Here's how an example image selection logic may be set up in the wall object **Create** event:

```gml
top_left = 0;
top_right = 0;
bottom_left = 0;
bottom_right = 0;

launchbox_put_into("environment", function() {
    var _rr = place_meeting(x + sprite_width, y, object_index);
    var _ru = place_meeting(x + sprite_width, y - sprite_height, object_index);
    var _uu = place_meeting(x, y - sprite_height, object_index);
    var _lu = place_meeting(x - sprite_width, y - sprite_height, object_index);
    var _ll = place_meeting(x - sprite_width, y, object_index);
    var _ld = place_meeting(x - sprite_width, y + sprite_height, object_index);
    var _dd = place_meeting(x, y + sprite_height, object_index);
    var _rd = place_meeting(x + sprite_width, y + sprite_height, object_index);
    
    top_left = choose_top_left_image(_ll, _uu, _lu);
    top_right = choose_top_right_image(_rr, _uu, _ru);
    bottom_left = choose_bottom_left_image(_ll, _dd, _ld);
    bottom_right = choose_bottom_right_image(_rr, _dd, _rd);
});
```

The game may also have a pathfinding system based around pre-placed waypoint nodes linking to nearby visible nodes. The launch preparation likewise goes into the node's **Create** event:

```gml
links = [];

launchbox_put_method_into("paths", id, function() {
    with (obj_PathNode) {
        if (id == other.id)
            return; // don't add a link with itself
    
        if (instance_exists(collision_line(x, y, other.x, other.y, obj_Wall, true, false))
            return; // don't add a link when the view is obstructed
    
        array_push(other.links, id);
    }
});
```

Similarly to the game initialisation, one may use `launchbox_launch_all` to launch the boxes at the correct time. For example, the following may run in the **Room Start** event of a game controller object:

```gml
launchbox_launch_all("environment", "paths");
```

## Launching optional boxes

Both `launchbox_launch_all` and `launchbox_launch` will throw an error when attempting to launch an undeclared launch box.

The launch box with a given name is *declared* when a callback is put into it (through one of `launchbox_put*` functions). Additionally, one may use a [`launchbox_declare`](/Docs/Reference/Functions/launchbox_declare.md) function to ensure declaration even without any callbacks.

On the other hand, the declaration is removed when the launchbox is explicitly discarded with [`launchbox_discard`](/Docs/Reference/Functions/launchbox_discard.md) or when it's launched. Thanks to removing declarations upon launch one can populate a same set of boxes in a different setting (such as a different room) without re-running previous callbacks.

However, the room might not always contain instances for a specific box. For example, a game could have some void room without any walls or other terrain elements whatsoever, never populating the "environment" launch box. For cases like these, [`launchbox_try_launch_all`](/Docs/Reference/Functions/launchbox_try_launch_all.md) may be used, like so:

```gml
launchbox_try_launch_all("environment", "paths");
```

Now no error will be shown even if the room doesn't have any "environment"-populating instances! At the same time, `launchbox_try_launch_all` will still check for unlaunched boxes and throw an error if some are found, to prevent bugs related to typos.

If having unlaunched boxes remaining is expected in the given scenario, `launchbox_try_launch` can be used instead. Because it ignores all undeclared box names and doesn't check for unlaunched boxes, it's the most lenient of launching functions, but also the most vulnerable to bugs caused by incorrect launch boxes setup.

## Conditional launching

Sometimes, it might be desirable to prevent the launch even with initialisation tasks prepared.

For example, one may have a game with many interconnected levels, with the player spawned at a link they exited the previous level through. The objects connecting levels may prepare player spawning like so:

```gml
launchbox_put_method_into("player", id, function() {
    if (global.last_link_id == link_id)
        instance_create_layer(x, y, layer, obj_Player);
});
```

The game is so large and the between-level links so easy to get wrong that the developer decides to make a room testing system. It would visit each room and ensure all level connections are valid.

However, the testing mode doesn't set the `global.last_link_id` variable, which would lead to an error upon launch. This particular issue is easily fixed by setting the variable to undefined; that way the player never spawns. However, subsequent launch logic might require the player to be present. The room testing would be much easier if no launch logic was executed at all!

One way to solve this issue would be the `launchbox_discard` function mentioned earlier. The following code will prevent and clean up initialisation tasks during room testing, while still performing the launches in the game proper:

```gml
if (instance_exists(obj_RoomTest))
    launchbox_discard("environment", "paths", "player");
else
    launchbox_try_launch_all("environment", "paths", "player");
```

Alternatively, one may use [`launchbox_discard_all`](/Docs/Reference/Functions/launchbox_discard_all.md) to get rid of all launch box declarations without having to list them:

```gml
if (instance_exists(obj_RoomTest))
    launchbox_discard_all();
else
    launchbox_try_launch_all("environment", "paths", "player");
```

 Much like `launchbox_launch_all` and `launchbox_try_launch_all`, `launchbox_discard_all` cannot be used when multiple sets of launch boxes are managed in parallel. It should be suitable most intents and purposes, nevertheless.