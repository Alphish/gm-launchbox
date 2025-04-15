#region Accessing boxes

/// @desc Retrieves or declares a box with the given identifier. When given a launch box instance, passes it as-is.
/// @arg {String,Struct.LaunchboxBox} [box]     The box to pass or retrieve; "main" by default.
/// @returns {Struct.LaunchboxBox}
function launchbox(_box = "main") {
    static box_static = static_get(LaunchboxBox);
    
    if (is_instanceof(_box, LaunchboxBox))
        return _box;
    
    if (!struct_exists(box_static, "declared_boxes"))
        return new LaunchboxBox(_box);
    
    var _key = string_lower(_box);
    return box_static.declared_boxes[$ _key] ?? new LaunchboxBox(_box);
}

/// @desc Declares a launch box with the given identifier if one already doesn't exist ("main" by default).
/// @arg {String} [name]        The name of the box to declare; "main" by default.
/// @returns {Struct.LaunchboxBox}
function launchbox_declare(_name = "main") {
    if (!is_string(_name))
        throw LaunchboxException.invalid_identifier(_name);
    
    return launchbox(_name);
}

/// @desc Passes a launch box instance, or retrieves a box with the given identifier; throws an exception if such a box doesn't exist.
/// @arg {String,Struct.LaunchboxBox} [box]     The box to pass or retrieve; "main" by default.
/// @returns {Struct.LaunchboxBox}
function launchbox_require(_box = "main") {
    if (!launchbox_exists(_box))
        throw LaunchboxException.undeclared_box(_box);
    
    return launchbox(_box);
}

/// @desc Checks if a launch box with the given identifier has been declared. Returns true for launch box instances.
/// @arg {String,Struct.LaunchboxBox} [box]     The box to pass or check; "main" by default.
/// @returns {Bool}
function launchbox_exists(_box = "main") {
    static box_static = static_get(LaunchboxBox);
    
    if (is_instanceof(_box, LaunchboxBox))
        return true;
    
    if (!struct_exists(box_static, "declared_boxes"))
        return false;
    
    var _key = string_lower(_box);
    return struct_exists(box_static.declared_boxes, _key);
}

#endregion

#region Managing boxes

/// @desc Puts a callback into the main launch box, to be executed on launch.
/// @arg {Function} callback        The callback to execute on launch.
function launchbox_put(_callback) {
    launchbox().put(_callback);
}

/// @desc Puts a callback into the given launch box, to be executed on launch.
/// @arg {String,Struct.LaunchboxBox} box       The box to put the callback into.
/// @arg {Function} callback                    The callback to execute on launch.
function launchbox_put_into(_box, _callback) {
    launchbox(_box).put(_callback);
}

/// @desc Puts an instance into the main launch box, to be created on launch with given pre-Create variables and post-Create logic.
/// @arg {Asset.GMObject} object                The object to create the instance of.
/// @arg {Struct,Function} [variables]          The variables set on the newly created instance, or a parameterless function generating them.
/// @arg {Function} [postcreate]                The logic to execute on the newly created instance, after its Create event.
function launchbox_put_instance(_object, _variables = undefined, _postcreate = undefined) {
    launchbox().put_instance(_object, _variables, _postcreate);
}

/// @desc Puts an instance into the given launch box, to be created on launch with given pre-Create variables and post-Create logic.
/// @arg {String,Struct.LaunchboxBox} box       The box to put the callback into.
/// @arg {Asset.GMObject} object                The object to create the instance of.
/// @arg {Struct,Function} [variables]          The variables set on the newly created instance, or a parameterless function generating them.
/// @arg {Function} postcreate                  The logic to execute on the newly created instance, after its Create event.
function launchbox_put_instance_into(_box, _object, _variables = undefined, _postcreate = undefined) {
    launchbox(_box).put_instance(_object, _variables, _postcreate);
}

/// @desc Clears all callbacks from one or more launch boxes, while keeping them declared. If no boxes are given, the "main" box is cleared.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to clear.
function launchbox_clear() {
    if (argument_count == 0) {
        launchbox_clear("main");
        return;
    }
    
    for (var i = 0; i < argument_count; i++) {
        launchbox_require(argument[i]).clear();
    }
}

/// @desc Discards one or more launch boxes along with their callbacks, so they're no longer declared. If no boxes are given, the "main" box is discarded.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to discard.
function launchbox_discard() {
    if (argument_count == 0) {
        launchbox_discard("main");
        return;
    }
    
    for (var i = 0; i < argument_count; i++) {
        launchbox(argument[i]).discard();
    }
}

#endregion

#region Launching boxes

/// @desc Launches one or more launch boxes, executing all their callbacks and discarding them. Missing declarations will throw errors. If no boxes are given, the "main" box is launched.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to launch.
function launchbox_launch() {
    if (argument_count == 0) {
        launchbox_launch("main");
        return;
    }
    
    for (var i = 0; i < argument_count; i++) {
        launchbox_require(argument[i]).launch();
    }
}

/// @desc Attempts to launch one or more launch boxes, executing all their callbacks and discarding them. Missing declarations are ignored. If no boxes are given, the "main" box launch is attempted.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to attempt the launch of.
function launchbox_try_launch() {
    if (argument_count == 0) {
        launchbox_try_launch("main");
        return;
    }
    
    for (var i = 0; i < argument_count; i++) {
        launchbox(argument[i]).launch();
    }
}

#endregion
