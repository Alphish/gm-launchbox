[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Constructors](/Docs/Reference/Constructors/TOC.md) > [LaunchboxBox constructor](/Docs/Reference/Constructors/LaunchboxBox.md)

# LaunchboxBox.discard instance method

Discards the box along with its callbacks, so it's no longer declared.

### Example

The following code checks if the game is in testing mode, and discards the launch box if that's the case:

```gml
if (os_get_config() == "Test")
    init_launchbox.discard();
else
    init_launchbox.launch();
```
