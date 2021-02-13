/// @description hitstun state
//anim_speed = 8;

image_xscale = (obj_player.x > x) ? 1 : -1;

x_speed_ = lerp(x_speed_, 0, .1);
y_speed_ = lerp(y_speed_, 0, .1);

move_and_bounce();