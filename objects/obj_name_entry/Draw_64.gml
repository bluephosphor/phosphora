if (!show_menu) exit;

///draw bg
nine_slice_box_s(spr_9slice1,menu_x,menu_y,menu_x + menu_width, menu_y + menu_height,global.menu_color);

switch(state){
	case 0: // name entry
		//draw name
		draw_text((global.view_width / 2) - (string_width(stored_string) / 2),text_yo-24,stored_string);
		
		current_alphabet = alphabet[page];
		var len = array_length_1d(current_alphabet);
		var i = 0; var xx = 0; var yy = 0; repeat(len){
			
			//draw letters?
			var tx = text_xo + (24 * xx);
			var ty = text_yo + (24 * yy);
			c = c_white;
			if (menu_index = i) and (!selecting_options) {c = c_red;}
			draw_text_color(tx,ty,current_alphabet[i],c,c,c,c,1);
			
			//draw letter options
			if (i < array_length_1d(alphabet_options)){
				var str = alphabet_options[i];
				tx = text_xo + (70 * i);
				ty = text_yo + 90;
				c = c_white;
				if (menu_index = i) and (selecting_options) {c = c_red;}
				draw_text_color(tx,ty,str,c,c,c,c,1);
			}
			
			i++;
			xx++; if (xx > 10){
				xx = 0;
				yy++;
			}
		}
		break;
	case 1: // list options
		var str = "How would you like to be referred?", select;
		draw_text((global.view_width / 2) - (string_width(str) / 2), text_yo-16,str);
		
		var yy = 0; repeat(array_length_1d(list_options)){
			c = c_white;
			select = "";
			if (yy == menu_index){
				c = c_red;
				select = " <<";
			}
			var ty = text_yo + 16 + (16 * yy);
			str = list_options[yy];
			draw_text_color(text_xo, ty,str+select,c,c,c,c,1);
			yy++;
		}
		break;
	case 2:
		draw_text_ext(32,32,test_string,8,150);
}