/// @description aggro state

var maxsp = 3.5;
x_speed_ += lengthdir_x(acceleration_,attack_direction);
y_speed_ += lengthdir_y(acceleration_,attack_direction);

var _speed = point_distance(0, 0, x_speed_, y_speed_);
var _direction = point_direction(0, 0, x_speed_, y_speed_);
if (_speed > maxsp) {
	x_speed_ = lengthdir_x(maxsp, _direction);
	y_speed_ = lengthdir_y(maxsp, _direction);
}

var px = o_player.x;
if (px > x) image_xscale = 1;
else image_xscale = -1;

move_and_bounce();