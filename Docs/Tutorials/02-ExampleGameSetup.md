[Home](/README.md) > [Tutorials](/Docs/Tutorials/TOC.md)

**Previous:** [Getting started](/Docs/Tutorials/01-GettingStarted.md)

# Example game setup

One of the main **Launchbox** applications is preparing some initialisation logic at the very start of the game.

Scripts seem like a natural place for such a basic setup - any code that's outside a function definition is executed at the very start, before the first room is created!

However, precisely because they're executed before any room, they can't be used to directly manage instances. What's more, the order in which individual scripts will be processed is unknown, further limiting the use of scripts for a code that requires another to run first.

As demonstrated below, the Launchbox library can address both of these problems while keeping all the initialisation setup in the raw script content.

## Configuring instances

Suppose you have an audio manager system that relies on a persistent instance to manage playback, which uses methods for configuration.

The Launchbox library provides the [`launchbox_put_instance`](/Docs/Reference/Functions/launchbox_put_instance.md) function for preparing instances to be created on launch. Aside from the object asset, it accepts a pre-Create variables struct (set before the Create event runs) and a post-Create logic (running after Create event has finished). In this example, pre-Create variables won't be used.

```gml
launchbox_put_instance(ctrl_AudioManager, /* no pre-Create variables */ undefined, function() {
    define_sfx("victory", sfx_Victory);
    define_sfx("loss", sfx_Loss);
    define_sfx("step", [sfx_Step1, sfx_Step2, sfx_Step3, sfx_Step4, sfx_Step5]);
    define_sfx("swing", sfx_Swing);
    // and so on
});
```

Upon launch in the initial room, the audio manager instance will be created, configured and ready to go!

The `launchbox_put_instance` function adds the audio manager instance to the default launch box. It can be sufficient for simple use-cases, but when some ordering is required, multiple launch boxes will be needed.

## Ordered initialisation

While the Launchbox library doesn't provide means to prioritise individual calls within a single launch box, it allows rough ordering by the use of multiple launch boxes.

The simple preparation methods - `launchbox_put`, `launchbox_put_method` and `launchbox_put_instance` - all add initialisation tasks to the "main" launch box. To use different launch boxes, the `*_into` variations are available: `launchbox_put_into`, `launchbox_put_method_into` and `launchbox_put_instance_into`.

Suppose the game needs to define items and enemies and store them in global variables. The enemies may drop items, so the items must be defined first. But initialising of both in a single script would be way too much clutter!

Here is how separate launch boxes can be used to ensure the correct order. First, the item definitions are put in the "items" box:

```gml
launchbox_put_into("items", function() {
    global.items = {
        sword: new Weapon("Sword", "A plain iron sword", /* ATK */ 5),
        potion: new Consumable("Potion", "Restores a little bit of health", "HP", +10),
        // and so on
    };
});
```

Then, the enemies definitions are put in the "enemies" box, using the items to define loot:

```gml
launchbox_put_into("eneimes" /* sic! */, function() {
    global.enemies = {
        slime: new Enemy("Slime", /* HP */ 20, /* ATK */ 2, /* no loot drops */ undefined, /* drop rate */ 0),
        goblin: new Enemy("Goblin", /* HP */ 30, /* ATK */ 5, global.items.potion, /* drop rate */ 0.3),
        hobgoblin: new Enemy("Hobgoblin", /* HP */ 50, /* ATK */ 12, global.items.sword, /* drop rate */ 0.1),
        // and so on
    };
});
```

Finally, to perform the initialisation in the correct order, `launchbox_launch` is called with the "items" box preceding "enemies":

```gml
launchbox_launch("items", "enemies");
```

The game runs... and an error shows up, claiming that "enemies" launch box hasn't been declared! What happened?

## Preventing typos

As you may have noticed, the example above "accidentally" puts enemy definitions in the *"eneimes"* box, not *"enemies"*. In this example the typo can be found relatively easily because of an error showing the missing box.

But what if enemy definitions were spread across multiple `launchbox_put_into` calls? If only one of these has a typo, it would lead to an easily missed bug where only some of enemy definitions are missing.

To handle cases like these, [`launchbox_launch_all`](/Docs/Reference/Functions/launchbox_launch_all.md) function is available. It launches the boxes in a given order and checks if there are no unlaunched boxes left. If some are still around, it throws an error with the name of one such box, so it can be easily found.

The typo in enemies definitions is fixed, and with a call like that we can be sure no eneimes can sneak past now!

```gml
launchbox_launch_all("items", "enemies");
```

...and the game shows an error reminding of some leftover "main" box. Of course, the audio manager needs to be created too!

```gml
launchbox_launch_all("items", "enemies", "main");
```

Thanks to `launchbox_launch_all`, both typos and forgotten launch boxes are accounted for early, saving time otherwise spent narrowing down the bugs!

Broadly speaking, whenever multiple launch boxes are involved, `launchbox_launch_all` should be preferred over `launchbox_launch` for most use cases. An exception would be a situation when multiple sets of named launch boxes are prepared and launched in parallel, because launching one set would report the other sets as leftovers and vice versa. However, most games shouldn't need such a complex initialisation setup.

**Next:** ["Initial Room" demo](/Docs/Tutorials/03-DemoInitialRoom.md)
