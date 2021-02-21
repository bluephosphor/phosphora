globalvar player_inst,path_grid;
player_inst = noone;

function ds_collector_add(variable){
	if (!variable_global_exists("ds_collector")){
		globalvar ds_collector;
		globalvar ds_index;
		ds_collector = [];
		ds_index = 0;
	} 
	ds_collector[ds_index] = variable;
	ds_index++;
}

function ds_clean(){

	var len = array_length(ds_collector);

	var ds, i = 0; repeat(len){
		ds = ds_collector[i];
		
		if (ds_exists(ds,ds_type_list)){
			ds_list_destroy(ds);
			show_debug_message("ds list destroyed!");
		} else if (ds_exists(ds,ds_type_grid)){
			ds_grid_destroy(ds);
			show_debug_message("ds grid destroyed!");
		} else if (ds_exists(ds,ds_type_map)){
			ds_map_destroy(ds);
			show_debug_message("ds map destroyed!");
		} else if (part_system_exists(ds)){
			part_system_destroy(ds);
			show_debug_message("part system destroyed!");
		} else if (part_type_exists(ds)){
			part_type_destroy(ds);
			show_debug_message("part type destroyed!");
		}
		i++;
	}
}

function debug_log_add(str) {
	ds_list_add(shell.output,"#" + str);
	show_debug_message(str);
}

function vec2(x,y) constructor{
	self.x = x;
	self.y = y;
}

function array_range(min,max){
	//returns a new array filled with a range of numbers
	var _arr = [];
	var i = 0;
	while(min < max) {
		_arr[i++] = min;
		min++;
	}
	return _arr;
}

function array_pull(array,value){
	//look for a specific value from an array, 
	//return that value while removing it from the old array.
	var _arr = [];
	var _return_val = undefined;
	var i = 0, j = 0; repeat(array_length(array)){
		if (array[i] = value) _return_val = value;
		else _arr[j++] = value;
		i++;
	}
	array = _arr;
	return _return_val;
}

//MACROS//
//dimensions
#macro CELL_SIZE 32
//floortypes
#macro FLOOR -5
#macro WATER -6
#macro VOID -7
#macro FARM -8
//directions
#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8
//colors
#macro c_shadow make_color_rgb(35, 28, 53)
#macro c_dkteal merge_color(c_shadow,c_teal,0.5)
#macro c_autumn make_color_rgb(235, 94, 52)
#macro c_winter make_color_rgb(153, 192, 255)
#macro c_pink   make_color_rgb(255, 171, 217)
#macro c_brown  make_color_rgb(100,50,20)
//target states
#macro TARGET_DORMANT 0
#macro TARGET_SET 1
#macro TARGET_FOLLOW 2
#macro TARGET_DISMISS 3
//entity states
#macro NOT_INTERACTABLE 0
#macro INTERACTABLE 1
#macro INTERACTING 2