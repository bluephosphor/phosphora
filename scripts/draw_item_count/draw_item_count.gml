///@arg x
///@arg y
///@arg num
function draw_item_count(argument0, argument1, argument2) {

	var xx = argument0;
	var yy = argument1;
	var num = argument2;

	var t_xo = xx + 8;
	var t_yo = yy + 8;
	var c = c_black;
	var str = string(num);
	var two_didget = 0;
	if (num > 9) two_didget = -5;
	draw_set_alpha(0.6);
	draw_rectangle_color(t_xo-1+two_didget,t_yo-2,t_xo + 4,t_yo + 6,c,c,c,c,false);
	draw_set_alpha(1);
	draw_text(t_xo+two_didget,t_yo,str);


}
