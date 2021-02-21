function generate_dungeon() {
	// Set up the grid
	globalvar grid_;
	width_ = room_width div CELL_SIZE;
	height_ = room_height div CELL_SIZE;
	grid_ = ds_grid_create(width_, height_);
	ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_SIZE,CELL_SIZE);

	// Create the controller
	var _controller_x = choose(2,width_ - 3);
	var _controller_y = choose(2,height_ - 3);
	var _controller_direction = irandom(3);
	var _steps = 400;
	var _place_object_odds = 20;

	var exit_x = 1; if (_controller_x == width_ - 3) exit_x = width_ - 2;
	grid_[# exit_x, _controller_y] = FLOOR;
	instance_create_layer(exit_x * CELL_SIZE,_controller_y * CELL_SIZE,"Instances", obj_exit);

	var _player_start_x = _controller_x * CELL_SIZE + CELL_SIZE/2;
	var _player_start_y = _controller_y * CELL_SIZE + CELL_SIZE/2;
	if (instance_exists(obj_player)) {
		obj_player.x = _player_start_x;
		obj_player.y = _player_start_y;
	} else instance_create_layer(_player_start_x, _player_start_y, "Instances", obj_player);


	// Choose the direction change odds
	var _direction_change_countdown = 10;

	// Generate the level
	repeat (_steps) {
		grid_[# _controller_x, _controller_y] = FLOOR;
		//place_objects
		var place_x = _controller_x * CELL_SIZE + 16;
		var place_y = _controller_y * CELL_SIZE + 16;
		// Rnadomize the direction, place objects
		_direction_change_countdown--;
		if (_direction_change_countdown <= 0) {
			_controller_direction = irandom(3);	
			if (irandom(_place_object_odds) = _place_object_odds){
				var chest = obj_chest;
				if (irandom(15) == 15) chest = obj_chest_special;
				if (!instance_position(place_x,place_y,chest)){
					chests[chest_index++] = instance_create_layer(place_x,place_y,"Instances", chest);
				}
			}
			_direction_change_countdown = irandom_range(5,20);
		}
	
		// Move the controller
		var _x_direction = lengthdir_x(1, _controller_direction * 90);
		var _y_direction = lengthdir_y(1, _controller_direction * 90);
		_controller_x += _x_direction;
		_controller_y += _y_direction;
	
		// Make sure we don't move outside the room
		var spawn_exit = (irandom(100) == 100);
		if (_controller_x < 2 || _controller_x >= width_ - 2) {
			if (spawn_exit) {
				grid_[# _controller_x,_controller_y] = FLOOR;
				place_x = _controller_x * CELL_SIZE + _x_direction;
				place_y = _controller_y * CELL_SIZE;
				instance_create_layer(place_x,place_y,"Instances", obj_exit);
				debug_log_add("Spawned an exit!");
				spawn_exit = false;
			}
			_controller_x += -_x_direction * 2;
		}
		if (_controller_y < 2 || _controller_y >= height_ - 2) {
			if (spawn_exit) {
				grid_[# _controller_x,_controller_y] = FLOOR;
				place_x = _controller_x * CELL_SIZE;
				place_y = _controller_y * CELL_SIZE + _y_direction;
				instance_create_layer(place_x,place_y,"Instances", obj_exit);
				debug_log_add("Spawned an exit!");
				spawn_exit = false;
			}
			_controller_y += -_y_direction * 2;
		}
	}

	///make sure we spawn at least one special chest minimum

	if (chest_index == 0){
		place_x = (_controller_x + -_x_direction) * CELL_SIZE + 16;
		place_y = (_controller_y  + - _y_direction) * CELL_SIZE + 16;
		chests[chest_index++] = instance_create_layer(place_x,place_y,"Instances", obj_chest);
		debug_log_add("lone chest :(");
	}

	event_perform(ev_other,ev_user1);

	//get rid of isolated void cells
	for (var _y = 1; _y < height_-1; _y++) {
		for (var _x = 1; _x < width_-1; _x++) {
			if (grid_[# _x, _y] != FLOOR) {
				var _north_tile = grid_[# _x, _y-1] == VOID;
				var _west_tile = grid_[# _x-1, _y] == VOID;
				var _east_tile = grid_[# _x+1, _y] == VOID;
				var _south_tile = grid_[# _x, _y+1] == VOID;
		
				var _tile_index = NORTH*_north_tile + WEST*_west_tile + EAST*_east_tile + SOUTH*_south_tile + 1;
				if (_tile_index == 1) {
					grid_[# _x, _y] = FLOOR;
				}
			}
		}
	}


	repeat(irandom_range(5,10)){
		var r = choose("ROOM1.csv","ROOM2.csv","ROOM3.csv","ROOM4.csv","ROOM5.csv");
		place_dungeon_room(r);
	}

	if (instance_exists(obj_scenery_item)) with(obj_scenery_item){
		event_perform(ev_other,ev_user0);
	}

	update_tiles();

	debug_log_add("Generated a dungeon with Seed: " + string(global.seed) + "!");


}
