///@param level_file
function place_dungeon_room(file) {
	
	file_grid = load_csv(file);
	repeat(irandom_range(1,3)) ds_grid_rotate(file_grid,true,1);
	var ww = ds_grid_width(file_grid);
	var hh = ds_grid_height(file_grid);

	var flag = false; repeat(100){
		var xx = irandom_range(2, width_ - ww - 2);
		var yy = irandom_range(2, height_ - hh - 2);
		var right_exit	= false;
		var left_exit	= false;
		var top_exit	= false;
		var bottom_exit	= false;
		if (ds_grid_get_mean(grid_,xx,yy,xx+ww-1,yy+hh-1) == VOID){
			var x_half = floor(ww / 2);
			var y_half = floor(hh / 2);
			if (grid_[# xx - 1,yy + y_half]	 == FLOOR)	left_exit	= true;
			if (grid_[# xx + ww,yy + y_half] == FLOOR)	right_exit	= true;
			if (grid_[# xx + x_half,yy - 1]	 == FLOOR)	top_exit	= true;
			if (grid_[# xx + x_half,yy + hh] == FLOOR)	bottom_exit = true;
			if (left_exit) or (right_exit) or (top_exit) or (bottom_exit) {
				flag = true;
				break;
			}
		}
	}

	if (!flag) exit;

	first_chest = false;
	var door_x, door_y;

	var gx = 0; repeat(ww){
		var gy = 0; repeat(hh){
	        import_cell_from_csv(gx,gy,xx,yy);
			gy++;
		}
		gx++;
	}
    
	if (left_exit){
		//grid_[# xx,yy + y_half] = FLOOR;
		door_x = xx * CELL_SIZE;
		door_y = (yy + y_half) * CELL_SIZE;
		instance_create_layer(door_x,door_y,"Instances",obj_door);
	}

	if (right_exit){	
		//grid_[# xx + ww - 1,yy + y_half] = FLOOR;
		door_x = (xx + ww - 1) * CELL_SIZE;
		door_y = (yy + y_half) * CELL_SIZE;
		instance_create_layer(door_x,door_y,"Instances",obj_door);
	}

	if (top_exit){
		//grid_[# xx + x_half,yy] = FLOOR;
		door_x = (xx + x_half) * CELL_SIZE;
		door_y = yy * CELL_SIZE;
		instance_create_layer(door_x,door_y,"Instances",obj_door);
	}

	if (bottom_exit){
		//grid_[# xx + x_half,yy + hh - 1] = FLOOR;
		door_x = (xx + x_half) * CELL_SIZE;
		door_y = (yy + hh - 1) * CELL_SIZE;
		instance_create_layer(door_x,door_y,"Instances",obj_door);
	}

	if (ds_exists(file_grid,ds_type_grid)) ds_grid_destroy(file_grid);
	file_grid = -1;

	room_count ++;

	debug_log_add("Placed " + file + " at x:" + string(xx) + " y:" + string(yy) + ".");
}