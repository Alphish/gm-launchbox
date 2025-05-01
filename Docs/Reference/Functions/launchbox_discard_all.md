[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_discard_all

Discards all declared launch boxes.

### Example

The following code checks if the game is in testing mode, and discards all the launch boxes if that's the case:

```gml
if (os_get_config() == "Test")
    launchbox_discard_all();
else
    launchbox_launch_all("main", "items", "enemies");
```
