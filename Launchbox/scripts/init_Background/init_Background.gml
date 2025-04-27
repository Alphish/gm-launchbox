launchbox_put(function() {
    var _layer = layer_get_id("Background");
    var _bg = layer_background_get_id(_layer);
    layer_background_sprite(_bg, bg_LaunchboxDemo);
    layer_background_blend(_bg, c_white);
});
