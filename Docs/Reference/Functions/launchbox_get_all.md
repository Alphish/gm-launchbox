[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_get_all

Retrieves all declared launch boxes.

###### Returns
**`Array<Struct.LaunchboxBox>`**

### Example

The following code prints names of all declared launch boxes to the output:

```gml
array_foreach(launchbox_get_all(), function(_box) {
    show_debug_message(_box.name);
});
```
