/// @desc An exception to be thrown due to invalid Launchbox usage.
/// @arg {String} code              The code of the exception to differentiate between different exception causes.
/// @arg {String} description       A detailed description explaining the exception.
function LaunchboxException(_code, _description) constructor {
    /// @desc The code of the exception to differentiate between different exception causes.
    /// @type {String}
    code = _code;
    
    /// @desc A detailed description explaining the exception.
    /// @type {String}
    description = _description;
    
    toString = function() {
        return $"Launchbox.{code}: {description}";
    }
}

// -------------------
// Creating exceptions
// -------------------

/// @desc Creates a Launchbox invalid identifier exception, caused by passing an invalid identifier to declare a launch box with.
/// @arg {String} name      The identifier used for the attempted launch box declaration.
LaunchboxException.invalid_identifier = function(_name) {
    return new LaunchboxException(
        $"invalid_identifier",
        $"The given identifier to declare the launch box with is {typeof(_name)} '{_name}', when it should be a string instead."
        );
}

/// @desc Creates a Launchbox duplicate identifier exception, caused by attempting to create a launch box with already existing identifier.
/// @arg {String} name      The identifier used for the attempted launch box declaration.
LaunchboxException.duplicate_identifier = function(_name) {
    return new LaunchboxException(
        $"duplicate_identifier",
        $"Attempting to declare a launch box with '{_name}' identifier, but there's already a box with such identifier."
        );
}

/// @desc Creates a Launchbox undeclared box exception, caused by attempting to retrieve a launch box with a non-existent identifier.
/// @arg {String} name      The identifier used for the attempted launch box retrieval.
LaunchboxException.undeclared_box = function(_name) {
    return new LaunchboxException(
        $"undeclared_box",
        $"Attempting to retrieve a launch box with '{_name}' identifier, but no such box exists."
        );
}

/// @desc Creates a Launchbox no-boxes-given exception, caused by calling a function requiring at least one box argument but receiving none.
/// @arg {String} func      The function requiring at least one box argument.
LaunchboxException.no_boxes_given = function(_func) {
    return new LaunchboxException(
        $"no_boxes_given",
        $"The function '{_func}' requires at least one box argument, but no arguments were given."
        );
}

/// @desc Creates a Launchbox leftover box exception, caused by launch box declarations remaining when none are expected.
/// @arg {String} name      The identifier of a leftover box.
LaunchboxException.leftover_box = function(_name) {
    return new LaunchboxException(
        $"leftover_box",
        $"All launch boxes were supposed to be launched, but a leftover box with '{_name}' identifier remains."
        );
}
