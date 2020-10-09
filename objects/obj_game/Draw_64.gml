draw_set_font(font_main);

//room transition fade
if (black_alpha > 0){
	var c = c_shadow;
	draw_set_alpha(black_alpha);
	draw_rectangle_color(0,0,global.view_width,global.view_height,c,c,c,c,false);
	draw_set_alpha(1);
}

if (!global.debug) exit;
//live variables
var y_off = (global.view_height / 2);
var str = "";
switch(playerstate){
	case p_state.normal: str = "normal"; break;
	case p_state.spin: str = "spin"; break;
	case p_state.hitstun: str = "hitstun"; break;
	case p_state.swimming: str = "swimming"; break;
}
draw_text(live_vars_x,4+y_off,"x:" + string(o_player.x) + ". y:" + string(o_player.y));
draw_text(live_vars_x,12+y_off,"grid_x:" + string(o_player.grid_x) + ". grid_y:" + string(o_player.grid_y));
var c = c_white;
if (o_player.spin_cooldown > 0) {
	c = c_red;
	str += (". cooldown: " + string(o_player.spin_cooldown));
}
if (o_player.water_buff != 10) {
	c = c_red;
	str += (". water_buff: " + string(o_player.water_buff));
}
draw_text_color(live_vars_x,20+y_off,"p_state." + str,c,c,c,c,1);
str = "";
switch(o_player.in_cell){
	case FLOOR: str = "FLOOR "; break;
	case WATER: str = "WATER "; break;
	case VOID: str = "VOID " ; break;
}
if (global.freecam) str += "| freecam enabled ";
if (global.time_pause) str += "| clock stopped ";
str += "\ninstance_count: " + string(instance_count);
draw_text(live_vars_x,28+y_off,"in_cell = " + str);

//debug log
draw_set_font(font_console);
nine_slice_box_s(spr_9slice2,debug_log_x,debug_log_y,debug_log_x + debug_log_w, debug_log_y + debug_log_h,global.menu_color);

var i = 0, tx, ty, count = min(debug_log_size, debug_log_entries); 
repeat(count - 1){
	tx = debug_log_x + 4;
	ty = debug_log_y + 4 + (6 * i);
	str = debug_log[| i + debug_log_index];
	draw_text(tx,ty,str);
	i++;
}
draw_set_font(font_main);