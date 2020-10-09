if (cont_inv.state == inv_state.inv){
	///draw the clock
	draw_set_font(font_small);
	var str, drawhour, minzero = "", c = c_yellow, day_half = "AM", hourmod = 0; 
	var cur_min = floor(minutes mod 60);
	var cur_hour = floor(hours);
	if (cur_min < 10) minzero = "0";
	if (cur_hour > 12){
		day_half = "PM"; 
		hourmod = -12;
	}
	drawhour = cur_hour; if (cur_hour == 0) drawhour = 12;
	str = "Year:" + string(year) + " Season:" + string(season) + " Day:" + string(day);
	with (cont_inv){
		draw_text_color(16,global.view_height - (string_height(str)),str,c,c,c,c,1);
		str = string(drawhour + hourmod) + ":" + minzero + string(cur_min) + day_half;
		draw_text_color(global.view_width - (string_width(str) + 16), global.view_height - (string_height(str)),str,c,c,c,c,1);
	}
	draw_set_font(font_main);
}

if (!global.debug) exit;

var str, minzero = "", seczero = "", c = c_yellow;
var cur_sec = seconds mod 60;
var cur_min = floor(minutes mod 60);
var cur_hour = floor(hours);

if (cur_sec < 10) seczero = "0";
if (cur_min < 10) minzero = "0";

str = string(year) + ":" + string(season) + ":" + string(day) + ":" + string(cur_hour) + ":" + minzero + string(cur_min) + ":" + seczero + string(cur_sec);
draw_text_color((global.view_width - string_width(str) - 8),8,str,c,c,c,c,1);