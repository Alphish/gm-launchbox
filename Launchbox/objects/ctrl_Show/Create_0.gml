effect_color = c_red;

schedule_ring = function() {
    launchbox_put_method_into("rings", id, "launch_ring");
}

launch_ring = function() {
    effect_create_below(ef_ring, irandom(room_width), irandom(room_height), random_range(0.5, 2), effect_color);
}

schedule_color = function(_color) {
    launchbox_put_method_into("color", id, launch_color, [_color]);
}

launch_color = function(_color) {
    effect_color = _color;
}

schedule_firework = function() {
    launchbox_put_method_into("fireworks", id, launch_firework);
}

launch_firework = function() {
    effect_create_below(ef_firework, irandom(room_width), irandom(room_height), random_range(0.5, 2), effect_color);
}

launch = function() {
    launchbox_try_launch_all("rings", "color", "fireworks");
}
