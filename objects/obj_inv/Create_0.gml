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
inventory = ds_grid_create(3,max_items);
ds_collector_add(inventory);
ds_grid_set_region(inventory,0,0,2,max_items,0);

#macro ITEM_ID 0
#macro COUNT 1
#macro PROPERTIES 2

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

draw_item_effect_data = function(grid,x,y){
	var props = grid[# PROPERTIES, menu_index];
	if (!is_struct(props)) return;
	draw_set_font(font_status);
	
	var _str =  "Effects:\n" 
	+ effect_data[props.inflicts.index].name + " " 
	+ dec_to_roman(props.inflicts.level) + "\n(" 
	+ time_tostring(props.inflicts.duration) + ")";
	var _ww = string_width(_str);
	var _hh = string_height(_str);
	var _buf = 4;
	var _c = c_shadow; 
	draw_rectangle_color(x,y,x + _ww + (_buf * 2), y + _hh + (_buf * 2),_c,_c,_c,_c,false);
	_c = c_white;
	draw_text_color(x+_buf,y+_buf,_str,_c,_c,_c,_c,1);
	draw_set_font(font_main);
}

selecting_grid = inventory;
selected_item  = inventory[# ITEM_ID, menu_index];