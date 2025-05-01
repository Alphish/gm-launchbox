array_foreach(boxes, function(_box) {
    if (allow_missing)
        launchbox_try_launch(_box);
    else
        launchbox_launch(_box);
});

if (!allow_leftovers && launchbox_any_exists()) {
    var _name = array_first(launchbox_get_all()).name;
    throw LaunchboxException.leftover_box(_name);
}

instance_destroy();
