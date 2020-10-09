/// @param sender_grid
/// @param recipient_grid
/// @param index
function trade_item(argument0, argument1, argument2) {

	var shift = keyboard_check(vk_shift);
	var count = 1;
	var times = 0;
	if (shift) count = 64;

	repeat(count) {
		var sender_grid		= argument0;
		var recipient_grid	= argument1;
		var index			= argument2;
		var item_num		= sender_grid[# 0, index];
		var stack_limit		= item_info[# 3, item_num];

		if (item_num == item.none) exit;

		var height		= ds_grid_height(recipient_grid);
		var success		= false;

		var i = 0; repeat(height) {
			//check if we already have item
			if (recipient_grid[# 0, i] == item_num) and (recipient_grid[# 1, i] < stack_limit){
				recipient_grid[# 1, i] += 1;
				success = true;
				break;
			}
			i++;
		}
		if (!success) {
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

		if (success) {
			sender_grid[# 1, index] -= 1;
			if (sender_grid[# 1, index] == 0) {
				sender_grid[# 0, index] = item.none;
			}
			with (cont_inv) selected_item = inventory[# 0, menu_index];
		} else {
			debug_log_add("Inventory full!");
		}
		times++;
		if (sender_grid[# 0, index] == item.none) break;
	}

	if (success) {
		var prefix = "Stored ";
		var name = item_info[# ITEM, item_num];
		if (recipient_grid == inventory) prefix = "Recieved ";
		if (count > 1) name += "s";
		debug_log_add(prefix + string(times) + " " + name + ".");
	}

	return success;


}
