depth = -bbox_bottom;
grid_x = x div CELL_WIDTH;
grid_y = y div CELL_HEIGHT;
in_cell = grid_[# grid_x, grid_y];

if (global.pause) exit;

switch(interact_state){
	case NOT_INTERACTABLE: 
	break;
	case INTERACTABLE: 
		if (can_interact > 0) and (!instance_exists(obj_txtbox1)) {
			can_interact -= 1;
		}
	break;
	case INTERACTING: 
		can_interact = room_speed;
	break;
}