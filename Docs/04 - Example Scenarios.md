[<< Back to home](https://github.com/Alphish/gm-launchbox)

[<< 03 - Functions](/Docs/03%20-%20Functions.md) | **04 - Example Scenarios**

-----

# Example Scenarios

## Simple initialisation

For most basic use cases, the developer can just use the main launch box and don't use anything else. For example, they might put calls like the following around the initialisation script:

```gml
launchbox_put(function() {
    // do some thing
});
```

Then, in the first room, they might place an object with just the following call in its Create event:

```gml
launchbox_launch();
```

Alternatively, the developer may place a `ctrl_LaunchboxLauncher` instance in the starting room, which will launch the main box in its Create event. The built-in launcher additionaly has `boxes` object variable - to specify the list of boxes to launch upon creation - and `allow_missing` variable - to ignore missing declarations instead of throwing an error.

If the launch logic uses data from object instances, make sure the launcher comes after these instances in the instance creation order. This applies to both the built-in launcher and a custom-made launcher. It does not apply if the custom launcher uses another event for launching, e.g. Room Start. The reason the built-in launcher uses the Create event is so that any newly created instances will run their Room Start event, if any (it wouldn't work if Room Start event was already in progress when they were created).

## Multiple initialisation stages

Sometimes, certain initialisation logic might require other logic to execute first. For example, the game defines items and weapons, as well as enemies who can drop them.

For these scenarios, the launch can be split into multiple stages, each using a different box. Item definition scripts would use the **"items"** box like so:

```gml
launchbox_put_into("items", function() {
    // define some items
});
```

Whereas enemy definition scripts would use **"enemies"** box like so:
```gml
launchbox_put_into("enemies", function() {
    // define basic enemy properties
    bandit_definition.add_drop(item_find("potion"), /* drop rate */ 10);
    bandit_definition.add_drop(item_find("iron_knife"), /* drop rate */ 1);
});
```

To run both initialisation stages, run the following in a custom launcher object:

```gml
launchbox_launch("items", "enemies");
```

Alternatively, you can use the built-in launcher with its `boxes` object variable set to **["items", "enemies"]** value.

## Level setup

Suppose there's a game which involves graphs in its levels. In Room editor, the nodes are represented with node objects and links are represented with link objects (which are just long rectangles arranged to roughly point to the correct nodes).

The node objects would add the following initialisation in their Create events:

```gml
launchbox_put("nodes", function() {
    ctrl_Graph.graph.define_node(name);
});
```

Whereas the link objects would add the following initilisation in their Create events:

```gml
var _xoffset = lengthdir_x(sprite_width / 2, image_angle);
var _yoffset = lengthdir_y(sprite_width / 2, image_angle);
name_from = instance_nearest(x - _xoffset, y - _yoffset, obj_Node).name;
name_to = instance_nearest(x + _xoffset, y + _yoffset, obj_Node).name;

launchbox_put("links", function() {
    ctrl_Graph.graph.define_link(name_from, name_to);
});
```

Then, the game controller would have this setup logic in its Room Start event:

```gml
instance_create_layer(0, 0, "Instances", ctrl_Graph);

// using try launch in case there are no nodes or links
// because then there will be no instance to declare "nodes" or "links" box
launchbox_try_launch("nodes", "links");

instance_destroy(obj_Node);
instance_destroy(obj_Link);
```

An alternative approach to handling potentially missing boxes uses explicit declarations instead:

```gml
instance_create_layer(0, 0, "Instances", ctrl_Graph);

// if no node objects exist, the level is broken anyway, so "nodes" box is assumed to exist
launchbox_declare("links"); // make sure "links" box exists even if there are no links
launchbox_launch("nodes", "links");

instance_destroy(obj_Node);
instance_destroy(obj_Link);
```

-----

[<< 03 - Functions](/Docs/03%20-%20Functions.md) | **04 - Example Scenarios**
