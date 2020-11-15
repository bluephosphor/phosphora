function generate_from_csv() {
	//get file
	var filename = room_data[# rm.level_file, room];
	file_grid = load_csv(filename);

	//resize room
	var ww = ds_grid_width(file_grid);
	var hh = ds_grid_height(file_grid);
	room_width  = max(CELL_WIDTH  * ww, global.view_width)  + CELL_WIDTH  * 2;
	room_height = max(CELL_HEIGHT * hh, global.view_height) + CELL_HEIGHT * 2;

	// Set up the grid
	globalvar grid_;
	width_  = room_width  div CELL_WIDTH;
	height_ = room_height div CELL_HEIGHT;
	grid_ = ds_grid_create(width_, height_);
	ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_WIDTH,CELL_HEIGHT);

	var gx = 0; repeat(ww){
		var gy = 0; repeat(hh){
		    import_cell_from_csv(gx,gy,1,1);
			gy++;
		}
		gx++;
	}

	if (!instance_exists(o_player)) spawn_player();

	ds_grid_destroy(file_grid);
	file_grid = -1;

	if (layer_exists("Pebbles")){
	var _pebble_map_id = layer_tilemap_get_id("Pebbles");
		var num = min(room_width,room_height) / 2;
		repeat(num){
			var xx = irandom(room_width);
			var yy = irandom(room_height);
			var grid_x = xx div CELL_WIDTH;
			var grid_y = yy div CELL_HEIGHT;
			if (grid_[# grid_x, grid_y] == FLOOR){
				tilemap_set(_pebble_map_id,choose(1,2),xx div 8,yy div 8);
			}
		}
	}
	update_tiles();
}
