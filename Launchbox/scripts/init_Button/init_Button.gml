launchbox_put_instance(obj_Button, function() {
    return {
        x: room_width div 2 - 120,
        y: room_height - 180,
        image_xscale: 4,
        text: "Visit example",
        on_click: function() {
            url_open("https://github.com/Alphish/gm-launchbox/blob/feature/ISS-7_megaDocs/Docs/Tutorials/03-DemoInitialRoom.md");
        },
    };
});

launchbox_put_instance(obj_Button, function() {
    return {
        x: room_width div 2 - 120,
        y: room_height - 120,
        image_xscale: 4,
        text: "Proceed",
        on_click: room_goto_next,
    };
});
