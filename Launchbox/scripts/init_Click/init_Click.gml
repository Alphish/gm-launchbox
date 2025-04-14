launchbox_put_instance(obj_TestText, {
    x: 16,
    text: "Click anywhere with left mouse button to continue...\nAlso, the y coordinate has been set with post-Create logic, because room_height isn't known at the time of putting the instance into the Launchbox box" 
}, function() {
    y = room_height - 80;
});
