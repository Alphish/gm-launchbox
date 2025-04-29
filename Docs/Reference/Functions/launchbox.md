[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox

Retrieves or declares a box with the given identifier; the identifier is case-insensitive. When given a launch box instance, passes it as-is.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **box** | **`String`, `Struct.LaunchboxBox`** | Default: `"main"` | The box to pass or retrieve. |

###### Returns
**`Struct.LaunchboxBox`**

### Example

The following code launches the default ("main") launch box:

```gml
launchbox().launch();
```

This code launches a launch box declared as "items" instead:

```gml
launchbox("items").launch();
```
