/// @description distribute key items
key_items = [item.rift_a,item.rift_b,item.rift_c];
var chest_num	= array_length_1d(chests) - 1, 
	item_count	= array_length_1d(key_items),
	curr_chest,
	grid,
	flag,
	item_no,

i = 0; repeat(64){
	curr_chest = chests[irandom(chest_num)]
	grid = curr_chest.chest_inventory;
	item_no = key_items[i];
	var o = 0; repeat(item_count){
		flag = (check_inv(grid,key_items[o],false));
	}
	if (!flag){
		add_item(grid,item_no,1);
		i++;
	}
	if (i > item_count - 1) break;
}