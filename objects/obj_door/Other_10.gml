var grid_x = x div CELL_WIDTH;
var grid_y = y div CELL_HEIGHT;

grid_[# grid_x,grid_y] = FLOOR;
update_tiles();
screen_shake(32,2);
instance_destroy();