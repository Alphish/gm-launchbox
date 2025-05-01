randomize();

request_puff = function() {
    launchbox_put_method_into("puffs", obj_EffectOrb, "make_puff");
}

request_firework = function() {
    launchbox_put_method_into("fireworks", obj_EffectOrb, "make_firework");
}

request_color = function(_color) {
    launchbox_put_into("color", function(_color) {
        var _instance = instance_find(obj_EffectOrb, irandom(instance_number(obj_EffectOrb) - 1));
        _instance.image_blend = _color;
    }, [_color]);
}

launch = function() {
    launchbox_try_launch_all("puffs", "color", "fireworks");
}

visit_example = function() {
    url_open("https://github.com/Alphish/gm-launchbox/blob/feature/ISS-7_megaDocs/Docs/Tutorials/04-DemoEffectsShow.md");
};
