/// @description animate

frame_index++;

var len = array_length_1d(current_anim) - 1;

if (frame_index > len){
	frame_index = 0;
}

image_index = current_anim[frame_index];

if (!global.time_pause) alarm[10] = anim_speed;