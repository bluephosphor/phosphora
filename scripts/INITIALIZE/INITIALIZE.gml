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

//MACROS//
//dimensions
#macro CELL_WIDTH 32
#macro CELL_HEIGHT 32
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
//target states
#macro TARGET_DORMANT 0
#macro TARGET_SET 1
#macro TARGET_FOLLOW 2
#macro TARGET_DISMISS 3
//entity states
#macro NOT_INTERACTABLE 0
#macro INTERACTABLE 1
#macro INTERACTING 2