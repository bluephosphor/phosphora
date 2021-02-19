var grid_x = x div CELL_SIZE;
var grid_y = y div CELL_SIZE;

grid_[# grid_x,grid_y] = FLOOR;
update_tiles();
screen_shake(32,2);
instance_destroy();