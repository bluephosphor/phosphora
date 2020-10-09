///@param inventory_grid
///@param item
///@param remove_item
function check_inv(argument0, argument1, argument2) {

	var grid		= argument0;
	var item_no		= argument1;  
	var remove_item = argument2;
	var height		= ds_grid_height(grid);
	var flag		= false;

	var i = 0; repeat(height){
		if (grid[# 0, i] == item_no) {
			flag = true;
			if (remove_item) {
				grid[# 1, i] -= 1;
				if (grid[# 1, i] == 0) grid[# 0, i] = item.none;
			}
			debug_log_add("Removed a " + item_info[# 0, item_no]);
			break;
		}
		i++;
	}

	return flag;


}
