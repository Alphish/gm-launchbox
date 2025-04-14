launchbox_put_instance(obj_TestText, function() { return {
    x: 16,
    y: room_height - 80,
    text: "Click anywhere with left mouse button to continue...\nThis text uses y variable calculated on launch, to use room_height which isn't yet available during initialisation script call."
}});
