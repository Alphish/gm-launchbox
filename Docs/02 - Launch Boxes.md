[<< Back to home](https://github.com/Alphish/gm-launchbox)

[<< 01 - Overview](/Docs/01%20-%20Overview.md) | **02 - Launch Boxes** | [03 - Functions >>](/Docs/03%20-%20Functions.md)

-----

# Launch Boxes

## Declarations

Each launch box is an instance of `LaunchboxBox` constructor, which accepts a name as an optional argument. When a string name is given, the launch box is **declared** and the name can be used to retrieve the launch box instance. Launch boxes retrieval is case-insensitive. If a launch box with the matching name is already declared, calling the constructor will result in an error.

If the name argument is omitted no declaration is made. Such a launch box cannot be found by name; instead, a direct reference to it should be stored for later use. On the other hand, you can make many undeclared boxes without having to come up with unique names for each of them.

`LaunchboxBox` has two variables related to declarations:

- `name` - the original name the launch box has been created with
- `key` - the key the launch box is registered with; to make declarations case-insensitive, the key is all lowercase

A box can be created or retrieved using `launchbox`, `launchbox_declare` and `launchbox_require` functions. Their exact use is described in more detail in the [Functions page](/Docs/03%20-%20Functions.md).

## Callbacks

Each `LaunchboxBox` stores the functions to execute upon launch in the `callbacks` array.

The most straightforward way to populate it is the `put` method - you simply provide the function to execute like so:

```gml
my_launchbox.put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

You can also use `put_instance` method to add an object instance to create upon launch. You need to specify an object, and you can also provide pre-Create variables and post-Create logic. An example call:

```gml
my_launchbox.put_instance(ctrl_Manager, { managed_entity: "foo" }, function() {
    add_task("Make bar");
    add_task("Prepare FOOd", /* priority */ 100);
});
```

Additionally, you can provide a function returning pre-Create variables as opposed to variables themselves; in such case, the function will resolve the variables on the launch time.

```gml
my_launchbox.put_instance(ctrl_Manager, function() {
    // global.level_data isn't correctly setup at the time of put_instance call
    // but it will be at the time of launch
    return { managed_entity: global.level_data.managed_entity };
});
```

There is also a `clear` method which removes all pending callbacks. The launch box still remains declared after a `clear` call.

## Discarding

A launch box can be discarded with `discard` method call. This removes all callbacks from the launch box and removes its declaration, if any; thus, the declaration name no longer refers to any launch box.

Discarding launch boxes can be useful when the launch execution depends on a condition. For example, various level instances might prepare a launch in their Create events, but the launch won't happen unless a core gameplay controller performs it. At the same time, there might be a validator that creates the instances using `room_get_info` data but cannot execute the launch; such a validator might discard all launch boxes after checking all instances instead.

## Launching

To execute all stored callbacks, simply call the `launch` method. It will perform each callback, and then discard the launch box as its purpose has been fulfilled. If the game involves multiple launches throughout its course (e.g. once for entering each level), the boxes will need to be redeclared after every launch.

-----

[<< 01 - Overview](/Docs/01%20-%20Overview.md) | **02 - Launch Boxes** | [03 - Functions >>](/Docs/03%20-%20Functions.md)
