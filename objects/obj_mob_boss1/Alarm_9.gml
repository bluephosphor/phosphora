/// @description check if we're stuck in a wall

if (last_grid_x == grid_x and last_grid_y == grid_y){
	var _pos_x = (player_inst.grid_x * CELL_SIZE) + CELL_SIZE div 2;
	var _pos_y = (player_inst.grid_y * CELL_SIZE) + CELL_SIZE div 2;
	path_array = pathfind_init(path,_pos_x,_pos_y);
	pathfinding = true;
}