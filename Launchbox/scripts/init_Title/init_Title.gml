launchbox_put(function() {
    var _layer = layer_create(-200, "Title");
    var _text = layer_text_create(_layer, 0, 300, fnt_Title, "Launchbox Demo");
    layer_text_wrap(_text, true); // required to enable centering
    layer_text_framew(_text, room_width);
    layer_text_frameh(_text, 100);
    layer_text_halign(_text, textalign_center);
});
