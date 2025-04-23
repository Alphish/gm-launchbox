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

/// @desc Checks if at least one launch box is declared.
/// @returns {Bool}
function launchbox_any_exists() {
    static box_static = static_get(LaunchboxBox);
    
    if (!struct_exists(box_static, "any_exists"))
        return [];
    
    return box_static.any_exists();
}

/// @desc Retrieves all declared launch boxes.
/// @returns {Array<Struct.LaunchboxBox>}
function launchbox_get_all() {
    static box_static = static_get(LaunchboxBox);
    
    if (!struct_exists(box_static, "get_all"))
        return [];
    
    return box_static.get_all();
}

#endregion

#region Managing boxes

/// @desc Puts a callback into the main launch box, to be executed on launch. Optionally accepts an array of arguments.
/// @arg {Function} callback        The callback to execute on launch.
/// @arg {Array} [args]             The arguments to execute the callback with.
function launchbox_put(_callback, _args = undefined) {
    launchbox().put(_callback, _args);
}

/// @desc Puts a callback into the given launch box, to be executed on launch. Optionally accepts an array of arguments.
/// @arg {String,Struct.LaunchboxBox} box       The box to put the callback into.
/// @arg {Function} callback                    The callback to execute on launch.
/// @arg {Array} [args]                         The arguments to execute the callback with.
function launchbox_put_into(_box, _callback, _args = undefined) {
    launchbox(_box).put(_callback, _args);
}

/// @desc Puts a context-bound method into the main launch box, to be executed on launch. Optionally accepts an array of arguments.
/// @arg {Any} context              The context of the method to execute.
/// @arg {Function,String} func     The logic or name of the method to execute.
/// @arg {Array} [args]             The arguments to execute the method with.
function launchbox_put_method(_context, _func, _args = undefined) {
    launchbox().put_method(_context, _func, _args);
}

/// @desc Puts a context-bound method into the given launch box, to be executed on launch. Optionally accepts an array of arguments.
/// @arg {String,Struct.LaunchboxBox} box       The box to put the callback into.
/// @arg {Any} context                          The context of the method to execute.
/// @arg {Function,String} func                 The logic or name of the method to execute.
/// @arg {Array} [args]                         The arguments to execute the method with.
function launchbox_put_method_into(_box, _context, _func, _args = undefined) {
    launchbox(_box).put_method(_context, _func, _args);
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

/// @desc Discards all declared launch boxes.
function launchbox_discard_all() {
    var _boxes = launchbox_get_all();
    array_foreach(_boxes, function(_box) { _box.discard(); });
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

/// @desc Attempts to launch one or more launch boxes, executing all their callbacks and discarding them. Missing declarations will be ignored. If no boxes are given, the "main" box launch is attempted.
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

/// @desc Launches all of given launch boxes. Missing declarations will throw errors. If any box remains declared afterwards, an error will be thrown.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to launch.
function launchbox_launch_all() {
    if (argument_count == 0)
        throw LaunchboxException.no_boxes_given(nameof(launchbox_launch_all()));
    
    for (var i = 0; i < argument_count; i++) {
        launchbox_require(argument[i]).launch();
    }
    
    if (launchbox_any_exists()) {
        var _name = array_first(launchbox_get_all()).name;
        throw LaunchboxException.leftover_box(_name);
    }
}

/// @desc Attemps to launch all of given launch boxes. Missing declarations will be ignored. If any box remains declared afterwards, an error will be thrown.
/// @arg {String,Struct.LaunchboxBox} [...boxes]        One or more boxes to launch.
function launchbox_try_launch_all() {
    if (argument_count == 0)
        throw LaunchboxException.no_boxes_given(nameof(launchbox_try_launch_all()));
    
    for (var i = 0; i < argument_count; i++) {
        launchbox(argument[i]).launch();
    }
    
    if (launchbox_any_exists()) {
        var _name = array_first(launchbox_get_all()).name;
        throw LaunchboxException.leftover_box(_name);
    }
}

#endregion
