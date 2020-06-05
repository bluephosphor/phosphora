///@param inventory_grid
///@param item
///@param remove_item

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
		break;
	}
	i++;
}

return flag;