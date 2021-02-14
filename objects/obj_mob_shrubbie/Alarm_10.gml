/// @description animate
if (!global.time_pause) alarm[10] = anim_speed;

animation_ended = false;
frame_index++;

var len = array_length(current_anim) - 1;

if (frame_index > len){
	frame_index = 0;
	animation_ended = true;
	
	if (current_anim != next_anim and mystate != mobstate.hitstun) {
		current_anim = next_anim; 
		//image_index  = next_anim[0];
		//exit;
	}
}

image_index = current_anim[frame_index];