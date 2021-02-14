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
	xspeed += xmove * acceleration;
	yspeed += ymove * acceleration;
	var _speed = point_distance(0, 0, xspeed, yspeed);
	var _direction = point_direction(0, 0, xspeed, yspeed);
	if (_speed > max_speed) {
		xspeed = lengthdir_x(max_speed, _direction);
		yspeed = lengthdir_y(max_speed, _direction);
	}
}

if (xmove == 0) {
	xspeed = lerp(xspeed, 0, .1);
}
if (ymove == 0) {
	yspeed = lerp(yspeed, 0, .1);
}

move_and_collide();