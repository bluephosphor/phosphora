///@param x
///@param y
function import_cell_from_csv(argument0, argument1, argument2, argument3) {

	var xx = argument0;
	var yy = argument1;
	var curr_cell = file_grid[# xx,yy];
	var x_offset = argument2; 
	var y_offset = argument3; 
	xx += x_offset; 
	yy += y_offset;
	var place_x = (xx * CELL_SIZE) + 16;
	var place_y = (yy * CELL_SIZE) + 16;


	//custom level
	switch(curr_cell) {
		case "VOID": 
			grid_[# xx,yy] = VOID;
			break;
		case "FLOOR": 
			grid_[# xx,yy] = FLOOR;
			break;
		case "WATER": 
			grid_[# xx,yy] = WATER;
			break;
		case "PLAYER": 
			grid_[# xx,yy] = FLOOR;
			if (instance_exists(obj_player)) {
				obj_player.x = place_x
				obj_player.y = place_y;
			} else instance_create_layer(place_x, place_y, "Instances", obj_player);
			break;
		case "BOSS": 
			grid_[# xx,yy] = FLOOR;
			instance_create_layer(place_x,place_y,"Instances",obj_mob_pathfinder);
			break;
		case "TREE": 
			grid_[# xx,yy] = FLOOR;
			instance_create_layer(place_x,place_y,"Instances",obj_tree);
			break;
		case "EXIT": 
			grid_[# xx,yy] = FLOOR;
			place_x -= 16; place_y -= 16;
			instance_create_layer(place_x,place_y,"Instances",obj_exit);
			break;
		case "STATUE": 
			grid_[# xx,yy] = VOID;
			instance_create_layer(place_x,place_y,"Instances",obj_scenery_item);
			break;
		case "CHEST": 
			grid_[# xx,yy] = FLOOR;
			room_chest[room_chest_index] = instance_create_layer(place_x,place_y,"Instances",obj_chest_special);
			with (room_chest[room_chest_index++]){
				add_item(chest_inventory,item.key,1);
			}
			break;
		case "?CHEST": 
			grid_[# xx,yy] = FLOOR;
			if (!first_chest) {
				room_chest[room_chest_index] = instance_create_layer(place_x,place_y,"Instances",obj_chest);
				with (room_chest[room_chest_index++]){
					add_item(chest_inventory,item.key,1);
				}
				first_chest = true;
			} else if (irandom(3) == 3) instance_create_layer(place_x,place_y,"Instances",obj_chest);
			break;
		default:
			xx -= x_offset; 
			yy -= y_offset;
			grid_[# xx,yy] = curr_cell;
			break;
	}
}