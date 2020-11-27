function init_tree_patterns() {
	var ww = obj_level.width_;
	var hh = obj_level.height_;

	overcast_surface = noone;

	tree_overcast = room_data[# rm.tree_overcast,room]; if (!tree_overcast) exit;
	spr = spr_tree;

	//here we're gonna pick a color array depending on the season, or if we have special colors for the room
	if (room_data[# rm.tree_col_sp,room] == -1){
		var autumn_colors = [c_shadow,c_autumn,c_orange,c_yellow];
		var summer_colors = [c_shadow,c_teal,c_dkteal];
		var spring_colors = [c_shadow,c_pink,c_white];
		var winter_colors = [c_shadow,c_winter,c_white];
		var array = [summer_colors,autumn_colors,winter_colors,spring_colors]
		colors = array[season - 1];
	} else {
		colors = room_data[# rm.tree_col_sp,room];
	}

	//lord forgive me for this was all done pre 2.3.........
	//first we procedurally create (pattern_ct) number of leaf patterns
	pattern_ct = 16;
	//now we loop and loop
	var i = 0; repeat(pattern_ct) + 1{
		var list = -1, steps = 64, 
		c_len = array_length(colors) - 1,
		cc, c1, c2, o = 0; repeat(steps){
			//working out where we are in our colors array relative how far into our subloop we are!
			cc		= o / steps * c_len 
			c1		= colors[floor(cc)];
			c2		= colors[ceil (cc)];
		
			//generating some numbers and storing all of this info inside of nested arrays bc again, pre 2.3
			list[o] = [
				irandom(CELL_WIDTH),				// x
				irandom(CELL_HEIGHT),				// y
				choose(0,90,180,270),				// angle
				choose(1,2),						// frame
				merge_color(c1,c2, cc - floor(cc))  // color (blending colors together depending on the c1, c2 values we worked out earler. brain!)
			];
			o++;
		}
		//save each individual pattern array in this here array (lol)
		pattern[i] = list;
		i++;
	}

	//now we make a grid, compare it to our level, and randomly assign a pattern from the list if it's a void cell
	pattern_grid = ds_grid_create(ww,hh);
	ds_collector_add(pattern_grid);
	for (var _y = 1; _y < hh-1; _y++) {
		for (var _x = 1; _x < ww-1; _x++) {
			if (grid_[# _x, _y] == VOID) pattern_grid[# _x,_y] = irandom(pattern_ct);
			else pattern_grid[# _x,_y] = -1;
		}
	}
}

function draw_trees() {
	// pulling all of that lovely nested tree data out and drawing it to a surface, 
	// saving that surface and then simply drawing it once it exists!
	
	if (tree_overcast) and (!surface_exists(overcast_surface)) {
		
		overcast_surface = surface_create(room_width, room_height);
		surface_set_target(overcast_surface);
		draw_clear_alpha(c_black, 0);
	
		var ww = obj_level.width_;
		var hh = obj_level.height_;
	
		for (var _y = 1; _y < hh-1; _y++) {
			for (var _x = 1; _x < ww-1; _x++) {
				if (pattern_grid[# _x,_y] != -1){
					var num = pattern_grid[# _x,_y];
					var curr_array = pattern[num];
					var len = array_length(curr_array) - 1;
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
	} else draw_surface(overcast_surface, 0, 0);
}