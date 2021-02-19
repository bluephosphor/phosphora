///@param x
///@param y
function generate_swamp() {

	var flag = false; do {
		var xx = irandom(width_ - 1);
		var yy = irandom(height_ - 1);
		if (grid_[# xx,yy] == FLOOR)
			and grid_[# xx, yy-1] == FLOOR
			and grid_[# xx-1, yy] == FLOOR
			and grid_[# xx+1, yy] == FLOOR
			and grid_[# xx, yy+1] == FLOOR
			{
				var spawn_x = xx;
				var spawn_y = yy;	
				flag = (coord_outside_view(spawn_x * CELL_SIZE + 16,spawn_y * CELL_SIZE + 16));
			}
	} until (flag == true);

	var grid_center_x = spawn_x;
	var grid_center_y = spawn_y;

	var x_range = irandom_range(1,4);
	var y_range = irandom_range(1,4);

	var start_x = grid_center_x - x_range;
	var start_y = grid_center_y - y_range;

	for (var _y = 0; _y < y_range * 2; _y++) {
		for (var _x = 0; _x < x_range * 2; _x++) {
			xx = start_x + _x;
			yy = start_y + _y;
			var dist_from_center_x = abs(grid_center_x + _x);
			var dist_from_center_y = abs(grid_center_y + _y);
			if (irandom(dist_from_center_x) < x_range * 2){
				if (xx > 1) and (xx < width_ - 2) and grid_[# xx,yy] = FLOOR{
					grid_[# xx,yy] = WATER;	
				}
			}
			if (irandom(dist_from_center_y) < y_range * 2){
				if (yy > 1) and (yy < width_ - 2) and grid_[# xx,yy] = FLOOR{
					grid_[# xx,yy] = WATER;	
				}
			}
		}
	}

	//for (var _y = 0; _y < y_range * 2; _y++) {
	//	for (var _x = 0; _x < x_range * 2; _x++) {
	//		xx = start_x + _x;
	//		yy = start_y + _y;
	//		if (grid_[# xx, yy] == WATER) {
	//			var _north_tile = grid_[# xx, yy-1] != WATER;
	//			var _west_tile = grid_[# xx-1, yy] != WATER;
	//			var _east_tile = grid_[# xx+1, yy] != WATER;
	//			var _south_tile = grid_[# xx, yy+1] != WATER;
		
	//			var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
	//			if (_tile_index == 1) {
	//				grid_[# xx, yy] = FLOOR;		
	//			}
	//		}
	//	}
	//}

	debug_log_add("Spawned a swamp?");


}
