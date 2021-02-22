/// @description passive state

switch(substate){
	case 0: //determine path
		var _pos_x = (player_inst.grid_x * CELL_SIZE) + CELL_SIZE div 2;
		var _pos_y = (player_inst.grid_y * CELL_SIZE) + CELL_SIZE div 2;
		path_array = pathfind_init(path,_pos_x,_pos_y);
		substate = 1;
		break;
	case 1: //execute path
		if (keyboard_check_pressed(vk_space)) substate = 0;
		break;
}