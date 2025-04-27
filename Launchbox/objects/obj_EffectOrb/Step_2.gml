var _min_dir = -90;
var _max_dir = 360;
var _bounce = false;

if (x < 360) {
    _min_dir = max(_min_dir, -75);
    _max_dir = min(_max_dir, 75);
    _bounce = true;
} else if (x > room_width) {
    _min_dir = max(_min_dir, 105);
    _max_dir = min(_max_dir, 255);
    _bounce = true;
}

if (y < 0) {
    _min_dir = max(_min_dir, 195);
    _max_dir = min(_max_dir, 345);
    _bounce = true;
} else if (y > room_height) {
    _min_dir = max(_min_dir, 15);
    _max_dir = min(_max_dir, 165);
    _bounce = true;
}

if (_bounce && alarm[0] <= 0) {
    direction = random_range(_min_dir, _max_dir);
    angle_speed = random_range(2, 6) * choose(-1, 1);
    alarm[0] = 3;
}

image_angle += angle_speed;
