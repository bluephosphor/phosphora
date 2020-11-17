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
var y_off = 120;
var str = "";
switch(playerstate){
	case p_state.normal: str = "normal"; break;
	case p_state.spin: str = "spin"; break;
	case p_state.hitstun: str = "hitstun"; break;
	case p_state.swimming: str = "swimming"; break;
}
draw_text(live_vars_x,4+y_off,"x:" + string(obj_player.x) + ". y:" + string(obj_player.y));
draw_text(live_vars_x,12+y_off,"grid_x:" + string(obj_player.grid_x) + ". grid_y:" + string(obj_player.grid_y));
var c = c_white;
if (obj_player.spin_cooldown > 0) {
	c = c_red;
	str += (". cooldown: " + string(obj_player.spin_cooldown));
}
if (obj_player.water_buff != 10) {
	c = c_red;
	str += (". water_buff: " + string(obj_player.water_buff));
}
draw_text_color(live_vars_x,20+y_off,"p_state." + str,c,c,c,c,1);
str = "";
switch(obj_player.in_cell){
	case FLOOR: str = "FLOOR "; break;
	case WATER: str = "WATER "; break;
	case VOID: str = "VOID " ; break;
}
if (global.freecam) str += "| freecam enabled ";
if (global.time_pause) str += "| clock stopped ";
str += "\ninstance_count: " + string(instance_count);
draw_text(live_vars_x,28+y_off,"in_cell = " + str);

draw_set_font(font_main);