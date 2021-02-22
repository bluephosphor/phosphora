function generate_lake() {

	var flag = false; do {
		var xx = irandom(width_  - 1);
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

	var steps = (argument_count > 0) ? argument[0] : irandom(20);
	var i = 0, xo = 0, yo = 0; repeat(steps){
		var change_x = spawn_x + xo; 
		var change_y = spawn_y + yo;
		if (change_x > 2)  and (change_x < width_  - 2)
		and (change_y > 2) and (change_y < height_ - 2){
			grid_[# change_x, change_y] = WATER;
			if ((change_x + 1) < width_ - 2)	grid_[# change_x + 1, change_y] = WATER;
			if ((change_x - 1) > 2)				grid_[# change_x - 1, change_y] = WATER;
			if ((change_y + 1) < height_ - 2)	grid_[# change_x, change_y + 1] = WATER;
			if ((change_y - 1) > 2)				grid_[# change_x, change_y - 1] = WATER;
		}
		xo += irandom_range(-1,1);
		yo += irandom_range(-1,1);
		i++;
	}
	debug_log_add("Generated a lake at grid_x:" + string(spawn_x) + " grid_y: " + string(spawn_y) + ".");
}