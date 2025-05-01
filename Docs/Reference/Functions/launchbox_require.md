[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_require

Retrieves a box with the given identifier or throws an error if it doesn't exist; the identifier is case-insensitive. When given a launch box instance, passes it as-is.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **box** | **`String`, `Struct.LaunchboxBox`** | Default: `"main"` | The box to pass or retrieve. |

###### Returns
**`Struct.LaunchboxBox`**

### Example

The following code launches the default ("main") launch box, expecting at least one callback to have been added earlier:

```gml
launchbox_require().launch();
```
