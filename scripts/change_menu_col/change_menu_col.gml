function change_menu_col(argument0) {
	switch(argument0){
		case 0: global.menu_color = c_red; break;
		case 1: global.menu_color = c_green; break;
		case 2: global.menu_color = c_blue; break;
		case 3: global.menu_color = c_aqua; break;
		case 4: global.menu_color = c_fuchsia; break;
		case 5: global.menu_color = merge_color(c_white,c_blue,0.3);
	}

	inputting_c = global.menu_color;


}
