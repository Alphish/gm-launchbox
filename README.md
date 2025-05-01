<p align="center">
    <img src="Logo.png" alt="Launchbox Logo">
</p>

# Launchbox

**Launchbox** is a library for scheduling and running initialisation tasks.

In particular, it can be used for preparing the setup at the start of the game, as well as putting things together when visiting individual rooms.

You can read more about it here:

- [Getting started guide](/Docs/Tutorials/01-GettingStarted.md) - a guide explaining the basics
- [Tutorials](/Docs/Tutorials/TOC.md) - the list of all usage guides
- [Reference](/Docs/Reference/Reference.md) - technical descriptions of Launchbox library functions and other entities

A web demo is also available on itch.io: https://alphish-creature.itch.io/gm-launchbox

## Installation

The Launchbox package has been developed on **GameMaker 2024.11**. It may not work correctly on the older versions!

1. Download the Local Package YYMPS file: [Launchbox.GMS2.1.0.0.yymps](https://github.com/Alphish/gm-launchbox/releases/download/GMS2.1.0.0/Launchbox.GMS2.1.0.0.yymps)
2. Follow the [GameMaker manual instructions](https://manual.gamemaker.io/monthly/en/#t=IDE_Tools%2FLocal_Asset_Packages.htm) to import the package; import all the assets.
3. The Launchbox functionality should be ready to go!

## Simple Example

Create a new script with the following content (make sure it's directly in the script, not inside a function!):

```gml
launchbox_put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

Then, place the `ctrl_LaunchboxLauncher` instance in the starting room.

If everything was setup properly, *"Hello, Launchbox!"* message should appear in the output as soon as the initial room starts.
