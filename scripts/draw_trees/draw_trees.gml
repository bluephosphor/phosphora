function draw_trees() {
	if (tree_overcast) and (!surface_exists(overcast_surface)) {
		// Create the tree cover surface
		overcast_surface = surface_create(room_width, room_height);
		surface_set_target(overcast_surface);
		draw_clear_alpha(c_black, 0);
	
		var ww = o_level.width_;
		var hh = o_level.height_;
	
		for (var _y = 1; _y < hh-1; _y++) {
			for (var _x = 1; _x < ww-1; _x++) {
				if (pattern_grid[# _x,_y] != -1){
					var num = pattern_grid[# _x,_y];
					var curr_array = pattern[num];
					var len = array_length_1d(curr_array) - 1;
					var i = 0, list, draw_x, draw_y, angle, frame, c; 
					repeat(len){
						list	  = curr_array[i];
						//get pattern data from array
						draw_x	  = _x * CELL_WIDTH  + list[0];
						draw_y	  = _y * CELL_HEIGHT + list[1] - 16;
						angle	  =	list[2];
						frame	  = list[3];
						c		  = list[4];
						//draw sprites
						if (i < (len * 0.25)){
							draw_sprite_general(spr,frame,0,0,16,16,draw_x,draw_y,1,1,angle,c,c,c,c,1);
						} else if (i  < len * 0.4){
							draw_sprite_general(spr,3,0,0,8,8,draw_x,draw_y,1,1,angle,c,c,c,c,1);
						} else {
							draw_sprite_general(spr,4,0,0,8,8,draw_x,draw_y,1,1,angle,c,c,c,c,1);
						}
						i++;
					}
				}
			}
		}
		surface_reset_target();
		debug_log_add("tree surface created");
	} else {draw_surface(overcast_surface, 0, 0);}


}
