// Get the tile layer map id
var _pebble_map_id = layer_tilemap_get_id("Pebbles");

// Set up the grid
globalvar grid_;
width_ = room_width div CELL_WIDTH;
height_ = room_height div CELL_HEIGHT;
grid_ = ds_grid_create(width_, height_);
ds_grid_set_region(grid_, 0, 0, width_ - 1, height_ - 1, VOID);

//init pathfinding grid
path_grid = mp_grid_create(0,0,width_,height_,CELL_WIDTH,CELL_HEIGHT);

// Create the controller
var _controller_x = width_ div 2;
var _controller_y = height_ div 2;
var _controller_direction = irandom(3);
var _steps = 800;
var _place_object_odds = 50;
var _place_tree_odds = 15;
var _max_exits = 3;
var _exit_count = 0;

//spawn the player
var _player_start_x = _controller_x * CELL_WIDTH + CELL_WIDTH/2;
var _player_start_y = _controller_y * CELL_HEIGHT + CELL_HEIGHT/2;
instance_create_layer(_player_start_x, _player_start_y, "Instances", o_player);


// Choose the direction change odds
var _direction_change_odds = 1;

// Generate the level
repeat (_steps) {
	grid_[# _controller_x, _controller_y] = FLOOR;
	//place_objects
	var place_x = _controller_x * CELL_WIDTH + 16;
	var place_y = _controller_y * CELL_HEIGHT + 16;
	
	if (irandom(_place_object_odds) == _place_object_odds) {
		instance_create_layer(place_x,place_y,"Instances", obj_scenery_item);
	} else if (irandom(_place_tree_odds) == _place_tree_odds){
		instance_create_layer(place_x,place_y,"Instances", obj_tree);
	}
	
	// Rnadomize the direction, place objects
	if (irandom(_direction_change_odds) == _direction_change_odds) {
		_controller_direction = irandom(3);	
		if (irandom(_place_object_odds) = _place_object_odds) and (!instance_position(place_x,place_y,obj_chest)){
			chests[chest_index++] = instance_create_layer(place_x,place_y,"Instances", obj_chest);
		}
	}
	
	// Move the controller
	var _x_direction = lengthdir_x(1, _controller_direction * 90);
	var _y_direction = lengthdir_y(1, _controller_direction * 90);
	_controller_x += _x_direction;
	_controller_y += _y_direction;
	
	// Make sure we don't move outside the room
	var spawn_exit = (irandom(50) == 50);
	if (_exit_count > _max_exits) spawn_exit = false;
	if (_controller_x < 2 || _controller_x >= width_ - 2) {
		if (spawn_exit) {
			grid_[# _controller_x,_controller_y] = FLOOR;
			place_x = _controller_x * CELL_WIDTH + _x_direction;
			place_y = _controller_y * CELL_HEIGHT;
			instance_create_layer(place_x,place_y,"Instances", obj_exit);
			debug_log_add("Spawned an exit!");
			_exit_count ++;
			spawn_exit = false;
		}
		_controller_x += -_x_direction * 2;
	}
	if (_controller_y < 2 || _controller_y >= height_ - 2) {
		if (spawn_exit) {
			grid_[# _controller_x,_controller_y] = FLOOR;
			place_x = _controller_x * CELL_WIDTH;
			place_y = _controller_y * CELL_HEIGHT + _y_direction;
			instance_create_layer(place_x,place_y,"Instances", obj_exit);
			debug_log_add("Spawned an exit!");
			_exit_count++;
			spawn_exit = false;
		}
		_controller_y += -_y_direction * 2;
	}
	//pebble tiles
	repeat(2){
		var xx = irandom(room_width / 8);
		var yy = irandom(room_height / 8);
		tilemap_set(_pebble_map_id,choose(1,2),xx,yy);
	}
}

///make sure we spawn at least one chest minimum
if (chest_index == 0) {
	place_x = _controller_x * CELL_WIDTH + 16;
	place_y = _controller_y * CELL_HEIGHT + 16;
	chests[chest_index++] = instance_create_layer(place_x,place_y,"Instances", obj_chest);
	debug_log_add("Lone chest. :(");
}

event_perform(ev_other,ev_user0); //distribute key items

// remove isolated void cells
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

//generate lakes
repeat(irandom(5)){generate_lake();}

//have scenery objects update their states according to cell position
if (instance_exists(obj_scenery_item)) with(obj_scenery_item){
	event_perform(ev_other,ev_user0);
}
if (instance_exists(obj_tree)) with(obj_tree){
	event_perform(ev_other,ev_user0);
}

scr_update_tiles();

debug_log_add("Generated a room with Seed: " + string(global.seed) + "!");