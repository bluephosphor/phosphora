if (room == r_init){
	if (cont_cutscene == noone) room_goto_next();
	exit;
}


effects_update();



if (keyboard_check(vk_shift)){
	if (keyboard_check_pressed(ord("D"))){
		global.debug = !global.debug;
		obj_camera.visible = global.debug;
		show_debug_overlay(global.debug);
		
		if (!global.debug) global.show_grid = false;
	} else if (keyboard_check_pressed(ord("R"))){
		room_change();
	} else if (keyboard_check_pressed(ord("M"))){
		load_map();
	} else if (keyboard_check_pressed(ord("N"))){
		if (!instance_exists(obj_name_entry)) instance_create_layer(0,0,"Instances",obj_name_entry);
	}
}

if (room_transition){
	black_alpha = approach(black_alpha, 1, 0.01);
	if (black_alpha >= 1){
		playerstate = p_state.normal;
		var rm = target_room;
		with(obj_level){
			if ds_exists(grid_,ds_type_grid) ds_grid_destroy(grid_);
			if (rm != -1){
				room_goto(rm);
				other.target_room = -1;
			} else { room_restart();}
		}
		room_transition = false;
		gamestate = INGAME;
	}
} else if (black_alpha > 0){
	black_alpha = approach(black_alpha,0,0.01);
}

if (input_buffer > 0){
	input_buffer -=1;
} 

if (!global.debug) exit;

global.show_grid ^= keyboard_check_pressed(ord("G"));
