/// @description aggro state

var maxsp = 3.5;
xspeed += lengthdir_x(acceleration,attack_direction);
yspeed += lengthdir_y(acceleration,attack_direction);

var _speed = point_distance(0, 0, xspeed, yspeed);
var _direction = point_direction(0, 0, xspeed, yspeed);
if (_speed > maxsp) {
	xspeed = lengthdir_x(maxsp, _direction);
	yspeed = lengthdir_y(maxsp, _direction);
}

var px = obj_player.x;
if (px > x) image_xscale = 1;
else image_xscale = -1;

move_and_bounce();