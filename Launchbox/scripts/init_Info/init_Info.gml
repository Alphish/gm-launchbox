launchbox_put(function() {
    var _layer = layer_create(-150, "Info");
    var _text = layer_text_create(
        _layer, 0, 390, fnt_Info,
        "Welcome to the Launchbox library demo!\nEverything in this room was created using Launchbox calls.\nSee \"Initial Room\" example to learn more!\nClick Proceed to check another showcase."
        );
    layer_text_wrap(_text, true); // required to enable centering
    layer_text_framew(_text, room_width);
    layer_text_frameh(_text, 240);
    layer_text_halign(_text, textalign_center);
});
