/// @param recipient_grid
/// @param index
/// @param quantity

var count = argument2;

repeat(count){
	var recipient_grid	= argument0;
	var item_num		= argument1;
	var stack_limit		= item_info[# 3, item_num];

	if (item_num == item.none) exit;

	var height		= ds_grid_height(recipient_grid);
	var success		= false;

	var i = 0; repeat(height){
		//check if we already have item
		if (recipient_grid[# 0, i] == item_num) and (recipient_grid[# 1, i] < stack_limit){
			recipient_grid[# 1, i] += 1;
			success = true;
			break;
		}
		i++;
	}
	if (!success){
		var i = 0; repeat(height){
			//if not, see if there's an empty slot
			if (recipient_grid[# 0, i] == item.none){
				recipient_grid[# 0, i] = item_num;
				recipient_grid[# 1, i] += 1;
				success = true;
				break;
			}
			i++;
		}
	}

	if (success){
		with (cont_inv) selected_item = inventory[# 0, menu_index];
		debug_log_add("Added a " + item_info[# 0, item_num]);
	} else {
		debug_log_add("Inventory full!");
	}
}

return success;