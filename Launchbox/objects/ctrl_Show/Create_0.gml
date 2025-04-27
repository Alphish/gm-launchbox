randomize();

request_puff = function() {
    launchbox_put_method_into("puffs", obj_EffectOrb, "make_puff");
}

request_color = function(_color) {
    launchbox_put_method_into("color", { color: _color }, function() {
        var _instance = instance_find(obj_EffectOrb, irandom(instance_number(obj_EffectOrb) - 1));
        _instance.image_blend = color;
    });
}

request_firework = function() {
    launchbox_put_method_into("fireworks", obj_EffectOrb, "make_firework");
}

launch = function() {
    launchbox_try_launch_all("puffs", "color", "fireworks");
}
