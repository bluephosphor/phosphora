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
	
	//perameters
	var _wall_percentage = 45;
	var _softness = 4;
	_birth_limit = 4;
	_death_limit = 3;
	
	//generate some noise
	var _xx = 2; repeat(width_-3){
		var _yy = 2; repeat(height_-3){
			if (irandom(100) < _wall_percentage) grid_[# _xx,_yy] = FLOOR;
			_yy++;
		}
		_xx++;
	}
	
	//Returns the number of cells in a ring around (x,y) that are floors.
	count_floor_neighbors = function(grid, xx, yy){
	    var count = 0;
	    for(var i=-1; i<2; i++){
	        for(var j=-1; j<2; j++){
	            var neighbour_x = xx+i;
	            var neighbour_y = yy+j;
	            //If we're looking at the middle point
	            if(i == 0 && j == 0){
	                //Do nothing, we don't want to add ourselves in!
	            }
	            //In case the index we're looking at it off the edge of the map
	            else if(neighbour_x < 0 || neighbour_y < 0 || neighbour_x >= ds_grid_width(grid) || neighbour_y >= ds_grid_height(grid)){
	                count = count + 1;
	            }
	            //Otherwise, a normal check of the neighbour
	            else if(grid[# neighbour_x, neighbour_y] == FLOOR){
	                count = count + 1;
	            }
	        }
	    }
		return count;
	}
	
	//soften the noise using cellular automata
	do_simulation_step = function(grid){
		var _tempgrid = ds_grid_create(width_,height_);
		var _xx,_yy;
		
		ds_grid_clear(_tempgrid,VOID);
		_xx = 2; repeat(width_-3){
			_yy = 2; repeat(height_-3){
				var nbs = count_floor_neighbors(grid, _xx, _yy);
		        //The new value is based on our simulation rules
		        //First, if a cell is a floor but has too few neighbours, kill it.
		        if(grid[# _xx,_yy] == FLOOR){
		            if(nbs < _death_limit){
		                _tempgrid[# _xx,_yy] = VOID;
		            }
		            else{
		                _tempgrid[# _xx,_yy] = FLOOR;
		            }
		        } //Otherwise, if the cell is dead now, check if it has the right number of neighbours to be 'born'
		        else{
		            if(nbs > _birth_limit){
		                _tempgrid[# _xx,_yy] = FLOOR;
		            }
		            else{
		                _tempgrid[# _xx,_yy] = VOID;
		            }
		        }
				_yy++;
			}
			_xx++;
		}
		ds_grid_destroy(grid);
		show_debug_message("did a step")
		return _tempgrid;
	}
	
	repeat(_softness) {
		//var _newgrid = 
		grid_ = do_simulation_step(grid_);
		//ds_grid_destroy(_newgrid);
	}
	
	
	//pebble tiles
	repeat(room_width div 2){
		var xx = irandom(room_width / 8);
		var yy = irandom(room_height / 8);
		tilemap_set(_pebble_map_id,choose(1,2),xx,yy);
	}
	
	spawn_player();
	
	//generate lakes
	repeat (irandom_range(5,10)) generate_lake();
	
	//populate the world
	var _chest_threshhold = 3;
	var _xx = 2; repeat(width_-3){
		var _yy = 2; repeat(height_-3){
			if (grid_[# _xx,_yy] == FLOOR){
				var _place_x = _xx * CELL_SIZE + 16;
				var _place_y = _yy * CELL_SIZE + 16;
				if (place_free(_place_x,_place_y)) {
					if (irandom(_place_object_odds) == _place_object_odds) {
						var _inst = instance_create_layer(_place_x,_place_y,"Instances",obj_scenery_item);
						with (_inst){
							event_perform(ev_other,ev_user0);
						}
					} else {
						var _count = count_floor_neighbors(grid_,_xx,_yy);
						if (_count <= _chest_threshhold and !irandom(3)){
							chests[chest_index++] = instance_create_layer(_place_x,_place_y,"Instances",obj_chest);
						}
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