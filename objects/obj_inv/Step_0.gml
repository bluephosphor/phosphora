switch(gamestate){
	case INGAME:
		state = inv_state.hotbar;
		break;
	case INV: 
		//let player object handle this
		break;
	default:
		state = inv_state.inactive;
		break;
}

switch(state){
	case inv_state.inv:///INVENTORY STATE
		//get input
		var hinput   = keyboard_check_pressed(input[? key.right]) - keyboard_check_pressed(input[? key.left]);
		var vinput   = keyboard_check_pressed(input[? key.down])  - keyboard_check_pressed(input[? key.up]);
		var in_use   = keyboard_check_pressed(input[? key.action]);
		var in_equip = keyboard_check_pressed(input[? key.held]);
		
		selected_item = inventory[# 0, menu_index];
		
		if (hinput != 0){
			var _len = max_items - 1;
			menu_index += hinput;
			if (menu_index > _len) {menu_index = 0;}
			if (menu_index < 0)	   {menu_index = _len;}
		} else if (vinput != 0){
			var _len = max_items - 1;
			menu_index += vinput* items_width;
			if (menu_index > _len) {menu_index -= items_width * items_rows;}
			if (menu_index < 0)	   {menu_index += items_width * items_rows;}
		}
	 
		//use items
		if (in_use) and (item_info[# 2,selected_item] != -1){
			script_execute(item_info[# 2,selected_item]);
			inventory[# 1, menu_index] -= 1;
			if (inventory[# 1, menu_index] == 0){
				inventory[# 0, menu_index] = item.none;
			}
		}
		//equip items
		if (in_equip) and (instance_exists(o_player)) and (!instance_exists(mc_held_item)){
			var num = selected_item;
			if (num != item.none){
				with (instance_create_layer(o_player.x,o_player.y,"Instances",mc_held_item)){
					item_index = num;
				}
				inventory[# 1, menu_index] -= 1;
				if (inventory[# 1, menu_index] == 0){
					inventory[# 0, menu_index] = item.none;
				}
				gamestate = INGAME;
			}
		}
		break;
	case inv_state.chest: ///CHEST STATE
		//get input
		var hinput = keyboard_check_pressed(input[? key.right]) - keyboard_check_pressed(input[? key.left]);
		var vinput = keyboard_check_pressed(input[? key.down]) - keyboard_check_pressed(input[? key.up]);
		var in_trade = keyboard_check_pressed(input[? key.action]);
		
		selected_item = selecting_grid[# 0, menu_index];
		
		if (hinput != 0){
			var _len = ds_grid_height(selecting_grid) - 1;
			menu_index += hinput;
			if (menu_index > _len){menu_index -= items_width;}
			if (menu_index < 0){menu_index += items_width;}
		} else if (vinput != 0){
			var _len = ds_grid_height(selecting_grid) - 1;
			menu_index += vinput* items_width;
			if (menu_index > _len) {
				switch(selecting_grid){
					case inventory: 
						selecting_grid = chest_inv; 
						menu_index -= items_width * (items_rows);
						break;
					case chest_inv: 
						selecting_grid = inventory; 
						menu_index -= items_width*2;
						break;
				}
			}
			if (menu_index < 0){
				switch(selecting_grid){
					case inventory: 
						selecting_grid = chest_inv; 
						menu_index += items_width*2;
						break;
					case chest_inv: 
						selecting_grid = inventory; 
						menu_index += items_width * (items_rows);
						break;
				}
			}
		}
		//use items
		if (in_trade){
			if (selecting_grid == chest_inv){
				trade_item(chest_inv,inventory,menu_index);
			} else {
				trade_item(inventory,chest_inv,menu_index);
			}
		}
		break;
	case inv_state.hotbar:///HOTBAR STATE
		var hinput = keyboard_check_pressed(input[? key.hb_right]) - keyboard_check_pressed(input[? key.hb_left]);
		var in_use = keyboard_check_pressed(input[? key.hb_use]);
		var in_equip = keyboard_check_pressed(input[? key.held]);

		if (in_use) and (item_info[# 2,selected_item] != -1){
			script_execute(item_info[# 2,selected_item]);
			inventory[# 1, menu_index] -= 1;
			if (inventory[# 1, menu_index] == 0){
				inventory[# 0, menu_index] = item.none;
				hinput = 1;
			}
		}
		if (hinput != 0){
			repeat(cell_count){
				menu_index += hinput;
				if (menu_index > cell_count - 1) menu_index = 0;
				if (menu_index < 0) menu_index = cell_count - 1;
				selected_item = inventory[# 0, menu_index];
				if (selected_item != item.none) break;
			}
		}
		//equip items
		if (in_equip) and (instance_exists(o_player)) and (!instance_exists(mc_held_item)){
			var num = selected_item;
			if (num != item.none){
				with (instance_create_layer(o_player.x,o_player.y,"Instances",mc_held_item)){
					item_index = num;
				}
				inventory[# 1, menu_index] -= 1;
				if (inventory[# 1, menu_index] == 0){
					inventory[# 0, menu_index] = item.none;
				}
			}
		}
		break;
}