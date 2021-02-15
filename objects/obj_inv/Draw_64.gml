switch(state){
	case inv_state.inv: ///////////////INVENTORY STATE
		///draw bg
		nine_slice_box_s(spr_9slice1,menu_x,menu_y,menu_x + inv_width, menu_y + inv_height, global.menu_color);
		var c = c_white;
		draw_text_color(18, 4, pages[state] + ": [Z] to use item.",c,c,c,c,1);
	
		//draw inv list
		var i = 0; var xx = 0; var yy = 0; repeat(max_items){
			var x_offset = (cell_size + x_buffer) * xx; 
			var y_offset = (cell_size + y_buffer) * yy; 
			var dx = slots_x + x_offset;
			var dy = slots_y + y_offset;
			//draw items
			draw_sprite(spr_items,inventory[# 0,i],dx,dy);
			//draw cells
			var c = c_white;
			if (i == menu_index) c = c_red;
			draw_sprite_ext(spr_items,0,dx,dy,1,1,0,c,1);
			//draw counts
			if (inventory[# 1,i] > 1) {
				draw_item_count(dx,dy,inventory[# 1, i]);
			}
			i++;
			xx++;
			if (xx >= items_width){
				yy++;
				xx = 0;
			}
		}
		//description box
		nine_slice_box_s(spr_9slice1,desc_x,desc_y,desc_width,desc_height,global.menu_color);
			c = c_white;
			//drawing item img
			draw_sprite_ext(spr_items,0,desc_sx, desc_sy,2,2,0,c_white,1);
			if (selected_item != 0) draw_sprite_ext(spr_items,selected_item,desc_sx, desc_sy,2,2,0,c_white,1);
			//drawing item description
			c = item_info[# 4, selected_item];
			var name = "[" + item_info[# 0,selected_item] + "]";
			var desc = item_info[# 1,selected_item];
			draw_text_ext_color(desc_tx, desc_ty,name,10,232,c,c,c,c,1);
			c = c_white;
			draw_text_ext_color(desc_tx, desc_ty+10,desc,10,232,c,c,c,c,1);
		//info box
		nine_slice_box_s(spr_9slice1,info_x,info_y,info_width,info_y+info_height,global.menu_color);
			//draw rift_count
			c = c_white;
			draw_sprite_ext(spr_rift_matrix,0,info_x + 8,info_y + 8,2,2,0,c,1);
			i = 1; repeat (array_length_1d(has_rift)){
				draw_sprite_ext(spr_rift_matrix,i,info_x + 8,info_y + 8,2,2,0,c,has_rift[i - 1]);
				i++;
			}
			//draw hp and coins
			var str = "HP:" + string(player_health) + "/" + string(mob_data[# mob.player, stat.hp]) + "\nC:" + string(player_coins);
			draw_text(info_width - (string_width(str) + 8), info_y + 8, str);
			break;
	case inv_state.chest: ///////////////CHEST STATE
		///inv bg
		nine_slice_box_s(spr_9slice1,menu_x,menu_y,menu_x + inv_width, menu_y + inv_height,global.menu_color);
		var c = c_white;
		draw_text_color(18, 4,"Inventory:",c,c,c,c,1);
	
		//draw inv list
		var i = 0; var xx = 0; var yy = 0; repeat(max_items){
			var x_offset = (cell_size + x_buffer) * xx; 
			var y_offset = (cell_size + y_buffer) * yy; 
			var dx = slots_x + x_offset;
			var dy = slots_y + y_offset;
			//draw items
			draw_sprite(spr_items,inventory[# 0,i],dx,dy);
			//draw cells
			var c = c_white;
			if (i == menu_index and selecting_grid == inventory) c = c_red;
			draw_sprite_ext(spr_items,0,dx,dy,1,1,0,c,1);
			//draw counts
			if (inventory[# 1,i] > 1) {
				draw_item_count(dx,dy,inventory[# 1, i]);
			}
			i++;
			xx++;
			if (xx >= items_width){
				yy++;
				xx = 0;
			}
		}
		//chest inv box
		var _yo = 24;
		draw_text(18,desc_y+12,"Chest: [Z] to trade item.");
		nine_slice_box_s(spr_9slice1,desc_x,desc_y+_yo,desc_x + inv_width,desc_height,global.menu_color);
			i = 0; xx = 0; yy = 0; repeat(ds_grid_height(chest_inv)){
			var x_offset = (cell_size + x_buffer) * xx; 
			var y_offset = (cell_size + y_buffer) * yy; 
			var dx = desc_sx + x_offset;
			var dy = desc_sy + y_offset + _yo;
			//draw items
			draw_sprite(spr_items,chest_inv[# 0,i],dx,dy);
			//draw cells
			var c = c_white;
			if (i == menu_index and selecting_grid == chest_inv) c = c_red;
			draw_sprite_ext(spr_items,0,dx,dy,1,1,0,c,1);
			//draw counts
			if (chest_inv[# 1,i] > 1) {
				draw_item_count(dx,dy,chest_inv[# 1, i]);
			}
			i++;
			xx++;
			if (xx >= items_width){
				yy++;
				xx = 0;
			}
		}
		//info box
		nine_slice_box_s(spr_9slice1,info_x,info_y,info_width,desc_height,global.menu_color);
			//drawing item img
			c = c_white;
			draw_sprite_ext(spr_items,0,info_x +8, info_y +8,2,2,0,c_white,1);
			if (selected_item != 0) draw_sprite_ext(spr_items,selected_item,info_x +8, info_y +8,2,2,0,c_white,1);
			//drawing item description
			c = item_info[# 4, selected_item];
			var name = "[" + item_info[# 0,selected_item] + "]";
			var desc = item_info[# 1,selected_item];
			draw_text_ext_color(info_x + 41, info_y + 10,name,10,80,c,c,c,c,1);
			c = c_white;
			draw_text_ext_color(info_x + 8, info_y + 48,desc,10,110,c,c,c,c,1);
		
		break;
	case inv_state.hotbar: ///////////////////HOTBAR STATE
		var xx = 0; repeat(cell_count){
			var offset = (cell_size + x_buffer) * xx; 
			//draw cells
			var c = c_white;
			if (xx == menu_index) c = c_red;
			draw_sprite_ext(spr_items,0,x_origin+offset,y_origin,1,1,0,c,1);
			//draw items
			draw_sprite(spr_items,inventory[# 0,xx],x_origin+offset,y_origin);
			//draw counts
			if (inventory[# 1,xx] > 1) {
				draw_item_count(x_origin+offset,y_origin,inventory[# 1, xx]);
			}
			xx++;
		}
		break;
}
