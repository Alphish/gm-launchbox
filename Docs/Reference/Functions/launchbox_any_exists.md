[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_any_exists

Checks if at least one launch box is declared.

###### Returns
**`Bool`**

### Example

The following code checks if any launch box has been declared, and throws an error otherwise:

```gml
if (!launchbox_any_exists())
    throw "At least one launch action was expected.";

launchbox_launch_all("first", "second", "third");
```
