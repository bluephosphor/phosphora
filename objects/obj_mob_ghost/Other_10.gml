/// @description passive state
if (update_movement) {
	if (irandom(2) == 2) {
		xmove = irandom_range(-1,1);
		ymove = irandom_range(-1,1);
		if (xmove != 0) image_xscale = xmove;
		alarm[0] = 40;
	} else {
		alarm[0] = 40;
	}
	update_movement = false;
} else {
	x_speed_ += xmove * acceleration_;
	y_speed_ += ymove * acceleration_;
	var _speed = point_distance(0, 0, x_speed_, y_speed_);
	var _direction = point_direction(0, 0, x_speed_, y_speed_);
	if (_speed > max_speed_) {
		x_speed_ = lengthdir_x(max_speed_, _direction);
		y_speed_ = lengthdir_y(max_speed_, _direction);
	}
}

if (xmove == 0) {
	x_speed_ = lerp(x_speed_, 0, .1);
}
if (ymove == 0) {
	y_speed_ = lerp(y_speed_, 0, .1);
}

move_and_collide();