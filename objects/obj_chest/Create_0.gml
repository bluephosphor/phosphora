menu_width = global.view_width - 32;
menu_height = global.view_height - 32;
menu_x = 16;
menu_y = 16;
button_h = 12;
image_speed = 0;
depth = -y;

show_inventory = false;
menu_index = 0;
last_selected = 0;
last_page = 0;
selected_item = 0;

entries = 16;

//loot_table
loot_table = -1;
ltc = 0;

var list = room_data[# rm.chest_loot,room];
var len = array_length_1d(list);
var i = 0; repeat(len){
	var info = list[i];
	loot_table_add(info[0],info[1]);
	i++;
}

//init inv slots
chest_inventory = ds_grid_create(3,entries);

var i = 0; repeat(entries){
	if (i < 15){
		chest_inventory[# ITEM_ID, i] = loot_item_add();
	} else {
		chest_inventory[# ITEM_ID, i] = item.none;
	}
	if (chest_inventory[# ITEM_ID, i] != item.none)	{
		chest_inventory[# COUNT, i] = 1;
		var _item = chest_inventory[# ITEM_ID, i];
		var _obj = item_info[# PROPS, _item];
		if (is_struct(_obj)){
			if (variable_struct_exists(_obj,"effect_table")) {
				chest_inventory[# PROPERTIES, i] = {inflicts : loot_item_effect(_obj.effect_table)};
			}
		}
	}
	else chest_inventory[# COUNT, i] = 0;
	i++;
}

pages = [chest_inventory,inventory];
page = 0;
max_pages = array_length(pages);

alarm[0] = 1;