[<< Back to home](https://github.com/Alphish/gm-launchbox)

[<< 02 - Launch Boxes >>](/Docs/02%20-%20Launch%20Boxes.md) | **03 - Functions** | [04 - Example Scenarios](/Docs/04%20-%20Example%20Scenarios.md)

-----

# Functions

## Accessing launch boxes

The following functions are available for accessing launch boxes:

- `launchbox(box)` - when given a string name, retrieves or declares a launch box; when given a launch box instance, passes it as-is
- `launchbox_declare(name)` - when given a string name, retrieves or declares a launch box; when given a launch box instance, throws an error (as it's not a valid declaration identifier) 
- `launchbox_require(box)` - when given a string name, retrieves an existing launch box or throws an error if none is found; when given a launch box instance, passes it as-is

Additionally, there is a `launchbox_exists(box)` function. When given a string name, it returns whether a launch box has been declared with a matching name; when given a launch box instance, it returns **true**.

The `box` and `name` arguments are **"main"** by default, for use cases where a single launch box will suffice.

For most intents and purposes, `launchbox(box)` is likely to be preferable. It declares a new launch box if the identifier is missing - common when launch callbacks are defined from multiple places with no specified order. Also, it's easy to chain `LaunchboxBox` methods on top of it, e.g.:

```gml
launchbox("enemies").put(function() {
    // define some enemies
});
```

## Managing launch boxes

The following functions allow adding callbacks to launch boxes:

- `launchbox_put(callback)` - adds a callback to the main launch box (using `put` method of the launch box)
- `launchbox_put_into(box,callback)` - adds a callback to the given launch box (using `put` method of the launch box)
- `launchbox_put_instance(object,[variables],[postcreate])` - adds an instance to the main launch box (using `put_instance` method of the launch box)
- `launchbox_put_instance_into(box,object,[variables],[postcreate])` - adds an instance to the given launch box (using `put_instance` method of the launch box)

These functions mostly wrap accessing a launch box and calling its corresponding method. Whether to use the function call or a method call (such as `launchbox().put(callback)`) is up to the developer's preference.

Additionally, the following methods allow clearing and discarding launch boxes:

- `launchbox_clear([...boxes])` - clears one or more launch boxes; each of the given boxes must exist
- `launchbox_discard([...boxes])` - discards one or more launch boxes; unresolved identifiers are ignored

Both accept an arbitrary number of arguments with box identifiers/instances. When no arguments are given, the main launch box is cleared/discarded.

## Launching boxes

The following functions allow launching the launch boxes:

- `launchbox_launch([...boxes])` - launches one or more launch boxes; each of the given boxes must exist
- `launchbox_try_launch([...boces])` - launches one or more launch boxes; unresolved identifiers are ignored

Similarly to clearing and discarding functions, launching functions accept the arbitrary number of arguments and launch the main box if no arguments are given. 

-----

[<< 02 - Launch Boxes >>](/Docs/02%20-%20Launch%20Boxes.md) | **03 - Functions** | [04 - Example Scenarios](/Docs/04%20-%20Example%20Scenarios.md)
