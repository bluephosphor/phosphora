var ww = o_level.width_;
var hh = o_level.height_;

overcast_surface = noone;

tree_overcast = room_data[# rm.tree_overcast,room]; if (!tree_overcast) exit;
spr = spr_tree;

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

pattern_ct = 16;
var i = 0; repeat(pattern_ct) + 1{
	var list = -1, steps = 64, 
	c_len = array_length_1d(colors) - 1,
	cc, c1, c2, o = 0; repeat(steps){
		//set colors
		cc		= o / steps * c_len
		c1		= colors[floor(cc)];
		c2		= colors[ceil (cc)];
		
		list[o] = [
			irandom(CELL_WIDTH),				// x
			irandom(CELL_HEIGHT),				// y
			choose(0,90,180,270),				// angle
			choose(1,2),						// frame
			merge_color(c1,c2, cc - floor(cc))  // color
		];
		o++;
	}
	pattern[i] = list;
	i++;
}

pattern_grid = ds_grid_create(ww,hh);
for (var _y = 1; _y < hh-1; _y++) {
	for (var _x = 1; _x < ww-1; _x++) {
		if (grid_[# _x, _y] == VOID) pattern_grid[# _x,_y] = irandom(pattern_ct);
		else pattern_grid[# _x,_y] = -1;
	}
}