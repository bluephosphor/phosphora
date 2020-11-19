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

function change_menu_col(val) {
	switch(val){
		case 0: global.menu_color = merge_color(c_white,c_fuchsia,0.8);		break; //FUSCHIA
		case 1: global.menu_color = merge_color(c_white,c_green,0.8);		break; //MOSS
		case 2: global.menu_color = merge_color(c_gray,c_blue,0.7);			break; //COBALT
		case 3: global.menu_color = merge_color(c_white,c_aqua,0.8);		break; //TEAL
		case 4: global.menu_color = merge_color(c_red,c_purple,0.5);		break; //MAROON
		case 5: global.menu_color = merge_color(c_white,c_blue,0.3);		break; //ICE
		case 6: global.menu_color = c_autumn;								break; //AMBER
		case 7: global.menu_color = c_brown;								break; //COFFEE
	}

	inputting_c = global.menu_color;
}

function change_accessibility(val) {
	var ds_grid = pages[page];
	switch (ds_grid[# 0, menu_option[page]]){
		case "DIFFICULTY":										break;	
		case "SCREENSHAKE":			global.screen_shake = val;	break;	
		case "FLASH EFFECT":		global.flash_effect = val;	break;	
		case "CONTENT WARNINGS":	global.content_warn = val;	break;	
	}
}

function change_resolution(val) {
	switch(val){
		case 0: global.resolution = [320,180]; break;
		case 1: global.resolution = [640,360]; break;
		case 2: global.resolution = [960,540]; break;
	}

	window_set_size(global.resolution[0],global.resolution[1]);
	surface_resize(application_surface,global.resolution[0],global.resolution[1]);

	alarm[0] = 1;
}


function change_volume(val) {
	var type = menu_option[page];

	switch(type){
		case 0: audio_master_gain(val); break;
		case 1: audio_group_set_gain(audiogroup_music, val, 0); break;
		case 2: audio_group_set_gain(audiogroup_soundeffects, val, 0); break;
	}
}

///@description change_window_mode
function change_window_mode(arg) {
	global.fullscreen = arg;
	
	window_set_fullscreen(global.fullscreen);

	var max_dim = max(display_get_width(),display_get_height());
	
	var res = global.fullscreen ? [max_dim,round((max_dim/16)*9)] : global.resolution;
	
	surface_resize(application_surface,res[0],res[1]);
}

function close_game() {
	add_dialog(-1,[
		"Exit game? Unsaved changes may be lost.",
		"Exit game.",
		"Resume game."
	],tag.no_pause);
	add_dialog_branch(game_end);
	add_dialog_branch(resume_game);
}

function resume_game() {
	debug_log_add("resume game");
	gamestate = INGAME;
	global.time_pause = false;
	obj_player.spin_cooldown = 1;
}