function generate_cavern() {
	// Get the tile layer map id
	var _pebble_map_id = layer_tilemap_get_id("Pebbles");

	// Set up the grid
	globalvar grid_;
	width_ = room_width div CELL_SIZE;
	height_ = room_height div CELL_SIZE;
	grid_ = ds_grid_create(width_, height_);
	ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_SIZE,CELL_SIZE);
	var _place_object_odds = 50;
	
	var _wall_percentage = 50,
		_softness = 7;
	//generate some noise
	var _xx = 2; repeat(width_-3){
		var _yy = 2; repeat(height_-3){
			if (irandom(100) < _wall_percentage) grid_[# _xx,_yy] = FLOOR;
			_yy++;
		}
		_xx++;
	}
	
	//soften the noise using cellular automata
	var _void_count, _floor_count;
	repeat(_softness){
		var _xx = 2; repeat(width_-3){
			var _yy = 2; repeat(height_-3){
				_void_count = 0;
				_floor_count = 0;
				//checking neighbors
				for (var _i = -1; _i <= 1; _i++){
					for (var _j = -1; _j <= 1; _j++){
						if (grid_[# _xx + _i, _yy + _j] == VOID  and grid_[# _xx,_yy] == FLOOR)  _void_count++;
						if (grid_[# _xx + _i, _yy + _j] == FLOOR and grid_[# _xx,_yy] == VOID) _floor_count++;
					}
				}
				if (_void_count  >= 5) grid_[# _xx,_yy] = VOID;
				if (_floor_count >= 5) grid_[# _xx,_yy] = FLOOR;
				_yy++;
			}
			_xx++;
		}
	}
	
	//pebble tiles
	repeat(room_width){
		var xx = irandom(room_width / 8);
		var yy = irandom(room_height / 8);
		tilemap_set(_pebble_map_id,choose(1,2),xx,yy);
	}
	
	spawn_player();
	
	//generate lakes
	repeat (irandom_range(5,10)) generate_lake();
	
	//populate the world
	var _xx = 2; repeat(width_-3){
		var _yy = 2; repeat(height_-3){
			if (grid_[# _xx,_yy] == FLOOR){
				var _place_x = _xx * CELL_SIZE + 16;
				var _place_y = _yy * CELL_SIZE + 16;
				if (place_free(_place_x,_place_y) and irandom(_place_object_odds) == _place_object_odds) {
					var _inst = instance_create_layer(_place_x,_place_y,"Instances",obj_scenery_item);
					with (_inst){
						event_perform(ev_other,ev_user0);
					}
				}
			}
			_yy++;
		}
		_xx++;
	}

	update_tiles();

	debug_log_add("Generated a cavern with Seed: " + string(global.seed) + "!");
	
}