effect_color = c_red;

schedule_ring = function() {
    launchbox_put_into("rings", function() {
        effect_create_below(ef_ring, irandom(room_width), irandom(room_height), random_range(0.5, 2), effect_color);
    });
}

schedule_color = function(_color) {
    launchbox_put_into("color", method({ instance: id, color: _color }, function() {
        instance.effect_color = color;
    }));
}

schedule_firework = function() {
    launchbox_put_into("fireworks", function() {
        effect_create_below(ef_firework, irandom(room_width), irandom(room_height), random_range(0.5, 2), effect_color);
    });
}

launch = function() {
    launchbox_try_launch_all("rings", "color", "fireworks");
}
