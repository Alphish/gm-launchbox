[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Constructors](/Docs/Reference/Constructors/TOC.md) > [LaunchboxBox constructor](/Docs/Reference/Constructors/LaunchboxBox.md)

# LaunchboxBox.clear instance method

Clears all callbacks from the box while keeping it declared.

### Example

The following code checks if the level is cleared, and clears the enemy-related box if that's the case:

```gml
if (level_is_cleared(room))
    enemies_launchbox.clear();

launchbox_launch_all(environment_launchbox, player_launchbox, enemies_launchbox);
```
