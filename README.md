<p align="center">
    <img src="Logo.png" alt="Launchbox Logo">
</p>

# Launchbox

**Launchbox** is a library for scheduling and running initialisation tasks.

It can be used directly inside GameMaker scripts to initialise game data or create important instances; a rough ordering of initialisation task groups is also supported.

Additionally, it may be used at the start of levels to gather initialisation tasks from room instances and perform them once everything is in place.

You can read more about the package functionality in its [documentation](/Docs/01%20-%20Overview.md).

## Installation

The Launchbox package has been developed on **GameMaker 2024.11**. It may not work correctly on the older versions!

1. Download the Local Package YYMPS file: [Launchbox.0.9.0.yymps](https://github.com/Alphish/gm-launchbox/releases/download/v0.9.0/Launchbox.0.9.0.yymps)
2. Follow the [GameMaker manual instructions](https://manual.gamemaker.io/monthly/en/#t=IDE_Tools%2FLocal_Asset_Packages.htm) to import the package; import all the assets.
3. The Launchbox functionality should be ready to go!

## Simple Example

Create a new script with the following content:

```gml
launchbox_put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

Then, place the `ctrl_LaunchboxLauncher` instance in the starting room. Alternatively, call the following in s starting room instance or the room Creation Code:

```gml
launchbox_launch();
```

If everything was setup properly, *"Hello, Launchbox!"* message should appear in the output as soon as the first room starts.
