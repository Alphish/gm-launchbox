for (var i = 0, _count = array_length(boxes); i < _count; i++) {
    if (allow_missing)
        launchbox_try_launch(boxes[i]);
    else
        launchbox_launch(boxes[i]);
}

instance_destroy();
