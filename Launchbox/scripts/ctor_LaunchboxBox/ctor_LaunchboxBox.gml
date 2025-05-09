/// @desc A launch box storing callbacks to execute upon launch.
/// @arg {String,Undefined} [name]      The name to declare the launch box with; leave as undefined to omit declaration.
function LaunchboxBox(_name = undefined) constructor {
    // --------------
    // Shared members
    // --------------
    
    /// @ignore
    static declared_boxes = {};
    
    /// @ignore
    static any_exists = function() {
        var _boxes = LaunchboxBox.declared_boxes;
        return struct_names_count(_boxes) > 0;
    }
    
    /// @ignore
    static get_all = function() {
        var _boxes = LaunchboxBox.declared_boxes;
        var _keys = struct_get_names(_boxes);
        var _count = array_length(_keys);
        var _result = array_create(_count);
        for (var i = 0; i < _count; i++) {
            _result[i] = _boxes[$ _keys[i]];
        }
        return _result;
    }
    
    // --------
    // Instance
    // --------
    
    // accepting only string identifiers
    if (!is_string(_name) && !is_undefined(_name))
        throw LaunchboxException.invalid_identifier(_name);
    
    /// @desc The name the box has been declared with.
    /// @type {String,Undefined}
    name = _name;
    
    /// @desc The key identifying the box among the declared boxes.
    /// @type {String,Undefined}
    key = !is_undefined(name) ? string_lower(name) : undefined;
    
    if (!is_undefined(key)) {
        if (struct_exists(declared_boxes, key))
            throw LaunchboxBox.duplicate_box;
        else
            declared_boxes[$ key] = self;
    }
    
    /// @desc The callbacks to execute upon launch.
    /// @type {Array<Function>}
    callbacks = [];
    
    /// @desc Puts the given callback into the box, to be executed on launch. Optionally accepts an array of arguments.
    /// @arg {Function} callback        The callback to execute on launch.
    /// @arg {Array} [args]             The arguments to execute the callback with.
    static put = function(_callback, _args = undefined) {
        if (is_undefined(_args)) {
            array_push(callbacks, _callback);
            return;
        }
        
        if (!is_method(_callback))
            _callback = method(undefined, _callback);
        
        array_push(callbacks, method({ callback: _callback, args: _args }, function() {
            method_call(callback, args);
        }));
    }
    
    /// @desc Puts a context-bound method into the main launch box, to be executed on launch. Optionally accepts an array of arguments.
    /// @arg {Any} context              The context of the method to execute.
    /// @arg {Function,String} func     The logic or name of the method to execute.
    /// @arg {Array} [args]             The arguments to execute the method with.
    static put_method = function(_context, _func, _args = undefined) {
        // statics
        static execute_method = function() {
            var _function = func;
            var _arguments = args;
            with (context) {
                var _resolved_function = is_string(_function) ? self[$ _function] : _function;
                script_execute_ext(_resolved_function, _arguments);
            }
        }
        
        // body
        if (is_method(_func))
            _func = method_get_index(_func);
        
        array_push(callbacks, method({ context: _context, func: _func, args: _args ?? [] }, execute_method));
    }
    
    /// @desc Puts the given instance into the box, to be created on launch with given pre-Create variables and a post-Create logic.
    /// @arg {Asset.GMObject} object            The object to create the instance of.
    /// @arg {Struct,Function} [variables]      The variables set on the newly created instance, or a parameterless function generating them.
    /// @arg {Function} [postcreate]            The logic to execute on the newly created instance, after its Create event.
    static put_instance = function(_object, _variables = undefined, _postcreate = undefined) {
        static create_instance = function() {
            var _create_layer;
            if (layer_exists("Instances")) {
                _create_layer = layer_get_id("Instances");
            } else {
                var _all_layers = layer_get_all();
                _create_layer = array_length(_all_layers) > 0 ? _all_layers[0] : layer_create(0, "Instances");
            }
            
            var _create_variables = is_callable(create_variables) ? create_variables() : create_variables;
            var _instance = !is_undefined(_create_variables)
                ? instance_create_layer(0, 0, _create_layer, create_object, _create_variables)
                : instance_create_layer(0, 0, _create_layer, create_object);
        
            if (!is_undefined(postcreate))
                method(_instance, postcreate)();
        }
        
        var _callback = method({ create_object: _object, create_variables: _variables, postcreate: _postcreate }, create_instance);
        put(_callback);
    }
    
    /// @desc Clears all callbacks from the box while keeping it declared.
    static clear = function() {
        array_resize(callbacks, 0);
    }
    
    /// @desc Discards the box along with its callbacks, so it's no longer declared.
    static discard = function() {
        clear();
        if (!is_undefined(key))
            struct_remove(declared_boxes, key);
    }
    
    /// @desc Executes all the callbacks put into the box and discards it afterwards.
    static launch = function() {
        array_foreach(callbacks, function(_callback) { _callback(); });
        discard();
    }
}
