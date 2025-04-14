launchbox_put_instance(obj_TestText, {
    x: 16,
    y: 160,
    color: c_orange,
}, function() {
    text = "The order of executing GML scripts at the start is undetermined\nso use different Launchbox boxes if you need initialisation ordering between them.\nAlso, this instance uses post-Create logic to set up its text, just because it can."
});
