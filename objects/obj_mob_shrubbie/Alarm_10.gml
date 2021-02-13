/// @description animate

animation_ended = false;
frame_index++;

var len = array_length(current_anim) - 1;

if (frame_index > len){
	animation_ended = true;
	frame_index = 0;
	if (current_anim != next_anim and mystate != mobstate.hitstun) current_anim = next_anim;
}

image_index = current_anim[frame_index];

if (!global.time_pause) alarm[10] = anim_speed;