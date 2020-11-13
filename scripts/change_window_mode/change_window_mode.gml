///@description change_window_mode
///@param value
function change_window_mode(argument0) {

	global.fullscreen = argument0;
	
	window_set_fullscreen(global.fullscreen);

	var res = global.fullscreen ? [display_get_width(),display_get_height()] : global.resolution;

	surface_resize(application_surface,res[0],res[1]);
}