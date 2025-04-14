/// @desc An exception to be thrown due to invalid Launchbox usage.
/// @arg {String} code              The code of the exception to differentiate between different exception causes.
/// @arg {String} description       The detailed description explaining the exception.
function LaunchboxException(_code, _description) constructor {
    /// @desc The code of the exception to differentiate between different exception causes.
    /// @type {String}
    code = _code;
    
    /// @desc The detailed description explaining the exception.
    /// @type {String}
    description = _description;
    
    toString = function() {
        return description;
    }
}

// -------------------
// Creating exceptions
// -------------------

/// @desc Creates a Launchbox invalid identifier exception, caused by passing an invalid identifier to declare a Launchbox box with.
/// @arg {String} name      The identifier used for the attempted Launchbox box declaration.
LaunchboxException.invalid_identifier = function(_name) {
    return new LaunchboxException(
        $"launchbox_invalid_identifier",
        $"The given identifier to declare the Launchbox box with is {typeof(_name)} '{_name}', when it should be a string instead."
        );
}

/// @desc Creates a Launchbox duplicate identifier exception, caused by attempting to create a Launchbox box with already existing identifier.
/// @arg {String} name      The identifier used for the attempted Launchbox box declaration.
LaunchboxException.duplicate_identifier = function(_name) {
    return new LaunchboxException(
        $"launchbox_duplicate_identifier",
        $"Attempting to declare a Launchbox box with '{_name}' identifier, but there's already a box with such identifier."
        );
}

/// @desc Creates a Launchbox undeclared box exception, caused by attempting to retrieve a Launchbox box with a non-existent identifier.
/// @arg {String} name      The identifier used for the attempted Launchbox box retrieval.
LaunchboxException.undeclared_box = function(_name) {
    return new LaunchboxException(
        $"launchbox_undeclared_box",
        $"Attempting to retrieve a Launchbox box with '{_name}' identifier, but no such box exists."
        );
}
