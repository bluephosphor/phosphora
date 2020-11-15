globalvar	max_items;
max_items	= 24;
items_width = 8;
items_rows	= max_items div items_width;

menu_x		= 16;
menu_y		= 16;
slots_x		= menu_x + 8;
slots_y		= menu_y + 8;
cell_size	= 16;
x_buffer	= 2;
y_buffer	= 2;

inv_width		= ((cell_size + x_buffer) * items_width) + 16;
inv_height		= ((cell_size + y_buffer) * items_rows) + 16;
info_x			= inv_width + 20;
info_y			= menu_y;
info_width		= global.view_width - 16;
info_height		= inv_height;
desc_x			= menu_x;
desc_y			= inv_height + 20;
desc_width		= info_width;
desc_height		= global.view_height - 16;
desc_sx			= desc_x + 8;
desc_sy			= desc_y + 8;
desc_tx			= desc_sx + (sprite_get_width(spr_items) * 2) + 8;
desc_ty			= desc_sy + 4;
chest_inv_y		= desc_y + 16;

has_rift = [false,false,false];

show_inventory	= false;
menu_index		= 0;
last_selected	= 0;
last_page		= 0;

entries		= max_items;
pages		= ["Inventory"];
max_pages	= array_length(pages);

//init inv slots
globalvar inventory;
inventory = ds_grid_create(2,max_items);
ds_collector_add(inventory);
ds_grid_set_region(inventory,0,0,2,max_items,0);

inventory[# 0,0] = item.ps_fire;
inventory[# 1,0] = 10;

enum inv_state {
	inv,
	chest,
	hotbar,
	inactive
}

state = inv_state.hotbar;

cell_count	 = 8;
total_length = (cell_size + x_buffer) * cell_count;
x_origin	 = (global.view_width / 2) - (total_length / 2);
y_origin	 = global.view_height - cell_size;

hotbar_autoselect = function(){
	repeat(cell_count){
		if (selected_item != item.none) break;
		menu_index += 1;
		if (menu_index > cell_count - 1) menu_index = 0;
		selected_item = inventory[# 0, menu_index];
	}
}

selecting_grid = inventory;
selected_item  = inventory[# 0, menu_index];