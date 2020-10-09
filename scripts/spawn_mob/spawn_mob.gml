/// @param mob
function spawn_mob(argument0) {

	var obj		 = mob_data[# argument0, stat.object];
	var celltype = mob_data[# argument0, stat.spawn_cell];
	var name	 = mob_data[# argument0, stat.name];

	switch(celltype){
		case FLOOR: var cellstr = "floor "; break;
		case WATER: var cellstr = "water "; break;
		case VOID:  var cellstr = "void ";  break;
	}

	var flag = false; repeat(100) {
		var xx = irandom_range(2, width_ - 2);
		var yy = irandom_range(2, height_ - 2);
		if (grid_[# xx,yy] == celltype){
			var spawn_x = xx * CELL_WIDTH + 16;
			var spawn_y = yy * CELL_WIDTH + 16;
			flag = (coord_outside_view(spawn_x,spawn_y));
			if (flag == true) break;
		}
	}

	if (!flag) {
		debug_log_add("Couldn't find a " + cellstr + "space to spawn a " + name + "!");
		exit;
	}

	instance_create_layer(spawn_x,spawn_y,"Instances",obj);
	debug_log_add("Spawned a " + name + "!");


}
