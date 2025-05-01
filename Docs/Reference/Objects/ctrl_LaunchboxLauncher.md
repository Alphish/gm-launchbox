[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Objects](/Docs/Reference/Objects/TOC.md)

# LaunchboxLauncher object

**Asset name:** `ctrl_LaunchboxLauncher`

Upon creation, this object launches a given list of boxes and destroys itself, having done its work.

It's also possible to control whether it allows the given box identifier to be undeclared, or for any boxes to remain unlaunched after the launch.

Generally speaking, this object provides a quick and easy way to perform initial launches at the game start, by placing it in the starting room. It may be used in other rooms (e.g. to perform launches related to room initialisation), but a more specialised controller object might be better suited for deciding how and when to perform the launch.

###### Variables

| Name | Type | Default | Description |
|:---:|:---:|:---:|:---|
| **boxes** | **Expression** (array of strings) | `["main"]` | The boxes to launch upon creation. |
| **allow_missing** | **Boolean** | `false` | Whether to throw an error for undeclared box identifiers or to ignore them. |
| **allow_leftovers** | **Boolean** | `false` | Whether to throw an error if any box remains unlaunched after launch. |
