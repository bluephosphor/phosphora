/// @description hitstun state

alarm[10] = -1;
anim_speed = 0;
image_alpha -= 0.01;
if (image_alpha <= 0) instance_destroy();