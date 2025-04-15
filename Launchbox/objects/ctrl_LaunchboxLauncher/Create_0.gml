array_foreach(boxes, function(_box) {
    if (allow_missing)
        launchbox_try_launch(_box);
    else
        launchbox_launch(_box);
});

instance_destroy();
