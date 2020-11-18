///@description
///@arg ["Name1",type1,entries1...]
///@arg ["Name2",type2,entries2...]
function create_menu_page() {

	var arg, i = 0; 
	repeat(argument_count){
		arg[i] = argument[i];
		i++;
	}

	var ds_grid_id = ds_grid_create(5, argument_count);
	i = 0; repeat(argument_count){
		var array = arg[i];
		var array_len = array_length(array);
	
		var xx = 0; repeat(array_len){
			ds_grid_id[# xx,i] = array[xx];
			xx++;
		}
		i++;
	}

	return ds_grid_id;
}

function change_menu_col(argument0) {
	switch(argument0){
		case 0: global.menu_color = merge_color(c_white,c_red,0.8); break;
		case 1: global.menu_color = merge_color(c_white,c_green,0.8); break;
		case 2: global.menu_color = merge_color(c_white,c_blue,0.8); break;
		case 3: global.menu_color = merge_color(c_white,c_aqua,0.8); break;
		case 4: global.menu_color = merge_color(c_white,c_fuchsia,0.8); break;
		case 5: global.menu_color = merge_color(c_white,c_blue,0.3);
	}

	inputting_c = global.menu_color;
}

function change_difficulty() {



}

function change_resolution(argument0) {
	switch(argument0){
		case 0: global.resolution = [320,180]; break;
		case 1: global.resolution = [640,360]; break;
		case 2: global.resolution = [960,540]; break;
	}

	window_set_size(global.resolution[0],global.resolution[1]);
	surface_resize(application_surface,global.resolution[0],global.resolution[1]);

	alarm[0] = 1;
}


function change_volume(argument0) {
	var type = menu_option[page];

	switch(type){
		case 0: audio_master_gain(argument0); break;
		case 1: audio_group_set_gain(audiogroup_music, argument0, 0); break;
		case 2: audio_group_set_gain(audiogroup_soundeffects, argument0, 0); break;
	}
}

///@description change_window_mode
///@param value
function change_window_mode(argument0) {

	global.fullscreen = argument0;
	
	window_set_fullscreen(global.fullscreen);

	var res = global.fullscreen ? [display_get_width(),round((display_get_width()/16)*9)] : global.resolution;
	
	

	surface_resize(application_surface,res[0],res[1]);
}

function close_game() {
	game_end();
}

function resume_game() {
	debug_log_add("resume game");
	gamestate = INGAME;
	global.time_pause = false;
	obj_player.spin_cooldown = 1;
}