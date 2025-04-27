speed = 4;
direction = random(360);

image_blend = choose(c_red, c_yellow, c_lime, #0080FF);
angle_speed = random_range(2, 6) * choose(-1, 1);

make_puff = function() {
    effect_create_depth(depth + 1, ef_smokeup, x, y, random_range(0.5, 3), image_blend);
}

make_firework = function() {
    effect_create_depth(depth + 1, ef_firework, x, y, random_range(0.5, 2), image_blend);
}
