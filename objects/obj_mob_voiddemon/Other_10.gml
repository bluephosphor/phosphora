/// @description passive state
if (update_movement){
	var north_cell	= grid_[# grid_x,grid_y - 1];
	var east_cell	= grid_[# grid_x + 1,grid_y];
	var south_cell	= grid_[# grid_x,grid_y + 1];
	var west_cell	= grid_[# grid_x - 1,grid_y];
	
	var north_free	= (north_cell == VOID) and ((grid_y - 1) > 2);
	var east_free	= (east_cell  == VOID) and ((grid_x + 1) < (o_level.width_ - 2));
	var south_free	= (south_cell == VOID) and ((grid_y + 1) < (o_level.height_ - 2));
	var west_free	= (west_cell  == VOID) and ((grid_x - 1) > 2);
	
	//look for player
	var px = o_player.grid_x;
	var py = o_player.grid_y;
	
	if ((grid_y - 1) == py and grid_x == px) player_at = dir.up;
	if ((grid_x + 1) == px and grid_y == py) player_at = dir.right;
	if ((grid_y + 1) == py and grid_x == px) player_at = dir.down;
	if ((grid_x - 1) == px and grid_y == py) player_at = dir.left;
	
	if (player_at != -1){
		current_anim = aggro_frames;
		mystate = mobstate.aggro;
		exit;
	}
	
	if (change_direction){
		var list	= [north_free,east_free,south_free,west_free];
		var num		= irandom(3);
		if (list[num] == true){
			direc = num;
			switch(num){
				case 0: y_to -= 1; break;
				case 1: x_to += 1; break;
				case 2: y_to += 1; break;
				case 3: x_to -= 1; break;
			}
			update_movement = false;
			change_direction = false;
			alarm[0] = 30;
		}
	} else {
		//check if we're not near floors
		var list = [north_free,east_free,south_free,west_free];
		if (list[0] and list[1] and list[2] and list[3]) {
			//if so, roll a die and change direction if true
			change_direction = (irandom(3) == 3);
		} 
		if (list[direc] == true){
			//otherwise, coast along wall until we have to turn
			switch(direc){
				case 0: y_to -= 1; break;
				case 1: x_to += 1; break;
				case 2: y_to += 1; break;
				case 3: x_to -= 1; break;
			}
			update_movement = false;
			alarm[0] = 30;
		} else {change_direction = true;}
	}
} else {
	x = lerp(x,(x_to * CELL_WIDTH)  + 16,0.2);
	y = lerp(y,(y_to * CELL_HEIGHT) + 16,0.2);
}