/// @description hitstun state

image_xscale = (obj_player.x > x) ? 1 : -1;

var _last_frame = current_anim[array_length(current_anim)-1];

if (image_index == _last_frame) alarm[10] = anim_speed;

xspeed = lerp(xspeed, 0, .1);
yspeed = lerp(yspeed, 0, .1);

move_and_bounce();