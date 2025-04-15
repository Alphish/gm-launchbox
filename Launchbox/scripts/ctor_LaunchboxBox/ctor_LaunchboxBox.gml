/// @desc A launch box storing callbacks to execute upon launch.
/// @arg {String,Undefined} [name]      The name to declare the launch box with; leave as undefined to omit declaration.
function LaunchboxBox(_name = undefined) constructor {
    /// @ignore
    static declared_boxes = {};
    
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
    
    /// @desc Puts the given callback into the box, to be executed on launch.
    /// @arg {Function} callback        The callback to execute on launch.
    static put = function(_callback) {
        array_push(callbacks, _callback);
    }
    
    /// @desc Puts the given instance into the box, to be created on launch with given pre-Create variables and post-Create logic.
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
