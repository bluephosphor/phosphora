///@arg str
function debug_log_add(argument0) {

	var str = argument0;

	ds_list_add(debug_log,str);

	with (obj_game){
		debug_log_size = ds_list_size(debug_log);
		if (debug_log_size >= debug_log_entries) debug_log_index++;
	
		//this commented stuff is for resizing the width of the logbox which i am not gonna do anymore
		
		//var i = 0, log, wid = 0, count = min(debug_log_size, debug_log_entries); 
		//repeat(count - 1){
		//	log = debug_log[| i + debug_log_index];
		//	wid = max(wid,string_width(log));
		//	i++;
		//}
		//debug_log_w = wid + 4;
	}
	show_debug_message(str);
}
