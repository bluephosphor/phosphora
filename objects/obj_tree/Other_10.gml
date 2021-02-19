/// @description update frame
var grid_x = x div CELL_SIZE;
var grid_y = y div CELL_SIZE;
var in_cell = grid_[# grid_x,grid_y];

if (in_cell == WATER) instance_destroy();