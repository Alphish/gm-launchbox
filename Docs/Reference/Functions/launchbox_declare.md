[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Global functions](/Docs/Reference/Functions/TOC.md)

# launchbox_declare

Declares a launch box with the given identifier if one already doesn't exist or returns the existing box otherwise. The identifier is case-insensitive.

The function will throw an error when passed something else than a string identifier. This contrasts with `launchbox` which will pass a given launch box instance; `launchbox_declare` will throw an error just like for other non-string identifier.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **name** | **`String`** | Default: `"main"` |  The name of the box to declare. |

###### Returns
**`Struct.LaunchboxBox`**

### Example

The following code declares a launch box with "optional" name before launch, in case it hasn't been declared before (through adding a callback):

```gml
// sometimes no callback is added to the optional launch box
// so it's declared here to prevent undeclared launch box error
launchbox_declare("optional");

launchbox_launch_all("mandatory", "optional");
```

This code launches a launch box declared as "items" instead:
