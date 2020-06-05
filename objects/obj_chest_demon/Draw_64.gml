if (show_inventory){
	image_index = 1;
	///draw bg
	var c = c_shadow;
	draw_set_alpha(0.7);
	draw_rectangle_color(menu_x,menu_y,menu_x + menu_width, menu_y + menu_height,c,c,c,c,false);
	draw_set_alpha(1);
	c = c_white;
	draw_text_color(18, 4, "Chest:",c,c,c,c,1); draw_text_color(menu_width / 2 + 4, 4, "Inventory:",c,c,c,c,1); 
	
	//draw inv list
	var i, name, desc;
		i = 0; repeat(8){
			//drawing chest contents
			c = c_white;
			name = my_text[0,i];
			draw_text_color(menu_x + 4, menu_y + 4 + button_h * i, name,c,c,c,c,1);
			
			//drawing inv contents
			c = c_white;
			name = my_text[1,i];
			draw_text_color(menu_width / 2 + 4, menu_y + 4 + button_h * i, name,c,c,c,c,1);
			i++;
		}
		
		//drawing item img
		draw_sprite_ext(spr_items,0,menu_width - 16, menu_height - 16,2,2,0,c_white,1);
		draw_sprite_ext(spr_item_demon,0,menu_width - 16, menu_height - 16,2,2,0,c_white,1);
		
		//drawing item description
		c = c_white; desc = "hehe hehe hehe hehe hehe hehe hehe hehe :)";
		var sh = string_height_ext(desc,10,menu_width - 32);
		draw_text_ext_color(menu_x + 4, menu_y + menu_height - sh,desc,10,menu_width - 32,c,c,c,c,1);
} else {
	image_index = 0;
}