/// @description hitstun state
//anim_speed = 8;

image_xscale = (obj_player.x > x) ? 1 : -1;

xspeed = lerp(xspeed, 0, .1);
yspeed = lerp(yspeed, 0, .1);

move_and_bounce();