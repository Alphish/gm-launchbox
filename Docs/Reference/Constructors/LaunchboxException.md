[Home](/README.md) > [Reference](/Docs/Reference/Reference.md) > [Constructors](/Docs/Reference/Constructors/TOC.md)

# LaunchboxException constructor

An exception to be thrown due to invalid Launchbox usage. It's primarily used for internal error handling in Launchbox.

###### Arguments

| Argument | Type | Usage | Description |
|:---:|:---:|:---:|:---|
| **code** | **`String`** | **Required** | The code of the exception to differentiate between different exception causes. |
| **description** | **`String`** | **Required** | A detailed description explaining the exception. |

###### Variables

| Name | Type | Default | Description |
|:---:|:---:|:---:|:---|
| **code** | **`String`** | `code` argument | The code of the exception to differentiate between different exception causes. |
| **description** | **`String`** | `description` argument | A detailed description explaining the exception. |

### Exception causes

The `LaunchboxException` can be thrown due to the following causes:

| Code | Cause |
|:---:|:---|
| `invalid_identifier` | Attempting to declare a launch box with a non-string identifier. |
| `duplicate_identifier` | Attempting to declare a launch box when a box with the same identifier already exists. |
| `undeclared_box` | Retrieving a launch box with an identifier that doesn't match any launch box declaration. |
| `no_boxes_given` | Attempting to call a function requiring one or more boxes, but not passing any box.<br>May be caused by `launchbox_launch_all` or `launchbox_try_launch_all`. |
| `leftover_box` | Having leftover (unlaunched) box declarations after attempting to launch all boxes.<br>May be caused by `launchbox_launch_all` or `launchbox_try_launch_all`. |
