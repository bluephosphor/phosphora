depth = -2000;

audio_group_load(audiogroup_music);
audio_group_load(audiogroup_soundeffects);

global.webmode = (!os_browser == browser_not_a_browser);

//global vars
globalvar playerstate, debug_log, cont_daycycle, cont_lighting, cont_audio, 
			cont_menu, cont_inv, cont_weather, cont_textbox, cont_cutscene,
			shell, input_buffer;

global.debug		= false;
global.rift_count	= 0;
global.fullscreen	= false;
global.playmusic	= true;
global.time_pause	= false;
global.pause		= false;
global.draw_outline = true;
global.disable_outline = true;
global.menu_color	= merge_color(c_white,c_blue,0.3);
global.show_grid	= false;
global.load_map		= false;

global.screen_shake = true;
global.flash_effect = true;
global.content_warn = false;

global.view_width	= camera_get_view_width(view_camera[0]);
global.view_height	= camera_get_view_height(view_camera[0]);
display_set_gui_size(global.view_width,global.view_height);

global.resolution = [window_get_width(), window_get_height()];


enum p_state {
	normal,
	spin,
	hitstun,
	swimming,
}

playerstate = p_state.normal;

room_transition = false;
black_alpha = 1;
target_room = -1;
tree_overcast = false;
pattern_grid = -1;

live_vars_x = 0

if (!variable_global_exists("__scribble_global_count")){
    scribble_init("","font_main",false);
	scribble_add_font("font_main");
	scribble_draw_set_animation(2,undefined,undefined,1,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	scribble_autotype_add_event("sound",scribble_sound);
}

//create controller objects
cont_daycycle	= instance_create_layer(0,0,"Daycycle",obj_daycycle);
cont_lighting	= instance_create_layer(0,0,"Daycycle",obj_lighting);
cont_audio		= instance_create_layer(0,0,layer,obj_audio_controller);
cont_menu		= instance_create_layer(0,0,layer,obj_menu);
cont_inv		= instance_create_layer(0,0,layer,obj_inv);
cont_weather	= instance_create_layer(0,0,layer,obj_weather);
shell			= instance_create_layer(0,0,layer,obj_shell);
cont_textbox = noone;
cont_cutscene = noone;

//var scene = [
//	[cs_add_dialog,-1,"...",tag.no_box],
//	[cs_add_dialog,-1,"Oh dear!"],
//	[cs_add_dialog,-1,"What do we have here?"],
//	[cs_add_dialog,-1,"It seems another lost child has wandered into my forest."],
//	[cs_add_dialog,-1,"Little friend... Are you lost?"],
//	[cs_end_dialog],
//	[cs_wait,2],
//	[cs_add_dialog,-1,"Please, do not despair... I am here now.",false],
//	[cs_add_dialog,-1,"You will be safe in this place... With me."],
//	[cs_end_dialog]
//];

//new_cutscene(scene);

if (audio_group_is_loaded(audiogroup_music)) {
	room_goto_next();
}