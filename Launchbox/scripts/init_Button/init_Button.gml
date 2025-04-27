launchbox_put_instance(obj_Button, function() {
    return {
        x: room_width div 2 - 60,
        y: room_height - 120,
        image_xscale: 2,
        text: "Proceed",
        on_click: room_goto_next,
    };
});
