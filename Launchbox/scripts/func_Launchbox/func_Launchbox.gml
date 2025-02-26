function launchbox_run() {
    static setup_pending_stages = function() {
        var _run_static = static_get(launchbox_run);
        _run_static[$ "pending_stages"] ??= {};
    }
    setup_pending_stages();
    
    if (argument_count == 0) {
        launchbox_run("main");
        return;
    }
    
    for (var i = 0; i < argument_count; i++) {
        var _stage = pending_stages[$ argument[i]];
        if (is_undefined(_stage))
            throw $"Unknown Launchbox stage '{_stage}'.";
        
        array_foreach(_stage, function(_call) { _call(); });
        pending_stages[$ argument[i]] = undefined;
    }
}

function launchbox_add_to(_stage, _callback) {
    if (!is_method(_callback))
        _callback = method(self, _callback);
    
    var _run_static = static_get(launchbox_run);
    _run_static[$ "pending_stages"] ??= {};
    
    var _pending_stages = _run_static[$ "pending_stages"];
    _pending_stages[$ _stage] ??= [];
    
    var _stage_items = _pending_stages[$ _stage];
    array_push(_stage_items, _callback);
}

function launchbox_add(_callback) {
    launchbox_add_to("main", _callback);
}

function launchbox_add_instance_to(_stage, _object, _params = undefined, _postcreate = undefined) {
    static create_instance = function() {
        var _layers = layer_get_all();
        var _create_layer = array_length(_layers) > 0 ? _layers[0] : layer_create(0, "Instances");
        
        var _instance = !is_undefined(create_params)
            ? instance_create_layer(0, 0, _create_layer, create_object, create_params)
            : instance_create_layer(0, 0, _create_layer, create_object);
        
        if (!is_undefined(postcreate))
            method(_instance, postcreate)();
    }
    
    launchbox_add_to(_stage, method({ create_object: _object, create_params: _params, postcreate: _postcreate }, create_instance));
}

function launchbox_add_instance(_object, _params = undefined, _postcreate = undefined) {
    launchbox_add_instance_to("main", _object, _params, _postcreate);
}
