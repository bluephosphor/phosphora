/// @description update frame
var grid_x = x div CELL_SIZE;
var grid_y = y div CELL_SIZE;
var in_cell = grid_[# grid_x,grid_y];

switch(in_cell){
	case FLOOR: current_frames = land_frames; break;
	case WATER: current_frames = water_frames; break;
	case VOID: current_frames = void_frames; break;
}

var len = array_length_1d(current_frames) - 1;
var i = irandom(len);
frame = current_frames[i];
if (color != -1) image_blend = color;

if (room_data[# rm.scenery_glow, room] == true){
	var size, strength, y_offset = 0;
	switch(frame){
		case 0:  
		case 12: size = 4; strength = 0.9; y_offset = 16; break;
		case 4:  size = 1; strength = 0.5; break;
		case 5:  size = 1; strength = 0.4; y_offset = 16; break;
		case 11: size = 3; strength = 0.6; y_offset = 16; break;
		default: size = 1; strength = 0.4; break;
	}
	with (instance_create_layer(x,y - y_offset,layer,mc_lightsource)){
		light_size = size;
		light_strength = strength;
		draw_strength = light_strength;
	}
}