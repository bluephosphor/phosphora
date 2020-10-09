image_speed  = 0;
image_xscale = choose(-1,1);
spr		 = spr_tree;
x_origin = sprite_get_xoffset(spr);
y_origin = sprite_get_yoffset(spr);
width	 = sprite_get_width(spr);
height	 = sprite_get_height(spr);
depth	 = -y - 4;

if (room_data[# rm.tree_col_sp,room] == -1){
	var c = choose(c_red,c_fuchsia,c_aqua,c_lime,c_green);
	var autumn_colors = [c_shadow,c_autumn,c_orange,c_yellow];
	var summer_colors = [c_shadow,c_teal,c];
	var spring_colors = [c_shadow,c_pink,c_white,c];
	var winter_colors = [c_shadow,c_winter,c_white];
	var array = [summer_colors,autumn_colors,winter_colors,spring_colors]
	colors = array[season - 1];
} else {
	colors = room_data[# rm.tree_col_sp,room];
}

my_surface = noone;