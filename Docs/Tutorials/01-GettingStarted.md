[Home](/README.md) > [Tutorials](/Docs/Tutorials/TOC.md)

# Getting started

**Launchbox** is a library designed for organising potentially complex initialisation logic. In particular:

- it can prepare initialisation tasks in advance, and launch them when they're ready
- it can group together similar initialisation tasks and ensure groups are launched in a correct order, when one depends on anoter
- it allows discarding the initialisation tasks in scenarios where the initialisation is not desirable (e.g. during test/debug preview)

The core concepts are pretty simple:

- put initialisation tasks into a launch box to be executed later
- launch the box when ready, to perform the initialisation logic at the right time

## Simple Example

Create a new script with the following content, using [`launchbox_put`](/Docs/Reference/Functions/launchbox_put.md) to prepare an initialisation task. *The script should contain nothing but the content below; in particular, the code cannot be inside a function.*

```gml
launchbox_put(function() {
    show_debug_message("Hello, Launchbox!");
});
```

Then, place a [`ctrl_LaunchboxLauncher`](/Docs/Reference/Objects/ctrl_LaunchboxLauncher.md) instance in the starting room.

Alternatively, call [`launchbox_launch`](/Docs/Reference/Functions/launchbox_launch.md) at the start of the initial room, whether in the Room Creation Code or in an instance event. The launch function should be called without arguments:

```gml
launchbox_launch();
```

If everything was setup properly, *"Hello, Launchbox!"* message should appear in the output as soon as the initial room starts.

**Next:** [Example game setup](/Docs/Tutorials/02-ExampleGameSetup.md)
