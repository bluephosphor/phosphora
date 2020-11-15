function update_tiles() {
	with (o_level){
		// Get the tile layer map id
		if (layer_exists("WallTiles")) var _wall_map_id = layer_tilemap_get_id("WallTiles");
		if (layer_exists("waterTiles")) var _water_map_id = layer_tilemap_get_id("WaterTiles");

		// Create the tiles
		for (var _y = 1; _y < height_-1; _y++) {
			for (var _x = 1; _x < width_-1; _x++) {
				switch(grid_[# _x, _y]){
					case VOID:
						//wall tiles
						var _north_tile = grid_[# _x, _y-1] == VOID;
						var _west_tile = grid_[# _x-1, _y] == VOID;
						var _east_tile = grid_[# _x+1, _y] == VOID;
						var _south_tile = grid_[# _x, _y+1] == VOID;
		
						var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
						tilemap_set(_wall_map_id, _tile_index, _x, _y);
			
						//stump tiles
						if (layer_exists("StumpTiles")) {
							var _stump_map_id = layer_tilemap_get_id("StumpTiles");
							var t = irandom_range(1,7);
							tilemap_set(_stump_map_id, t, _x,_y);
						}
					
						//motion plannig grid
						mp_grid_add_cell(path_grid,_x,_y);
						break;
					case WATER:
						//water tiles
						var _north_tile = grid_[# _x, _y-1] != WATER;
						var _west_tile = grid_[# _x-1, _y] != WATER;
						var _east_tile = grid_[# _x+1, _y] != WATER;
						var _south_tile = grid_[# _x, _y+1] != WATER;
		
						var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
						tilemap_set(_water_map_id, _tile_index, _x, _y);
						break;
					default:
						tilemap_set(_wall_map_id, 0, _x, _y);
						tilemap_set(_water_map_id, 0, _x, _y);
						break;
				}
			}
		}
	}
	debug_log_add("Updated Tiles!");

}
