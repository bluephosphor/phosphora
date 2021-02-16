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
var list = room_data[# rm.special_loot,room];
if (list != -1){
	var len = array_length_1d(list)
	var i = 0; repeat(len){
		var info = list[i];
		loot_table_add(info[0],info[1]);
		i++;
	}
}

//init inv slots
chest_inventory = ds_grid_create(3,entries);

if (list != -1){
	var i = 0; repeat(entries){
		if (i < 15){
			chest_inventory[# 0, i] = loot_item_add();
		} else {
			chest_inventory[# 0, i] = item.none;
		}
		if (chest_inventory[# 0, i] != item.none)	chest_inventory[# 1, i] = 1;
		else										chest_inventory[# 1, i] = 0;
		i++;
	}
}

pages = [chest_inventory,inventory];
page = 0;
max_pages = array_length_1d(pages);

alarm[0] = 1;