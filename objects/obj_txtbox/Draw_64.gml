draw_set_color(c_shadow);
if (tb_height != 0) nine_slice_box_s(spr_9slice2, x_origin,y_origin,x_origin + tb_width, y_origin + tb_height,global.menu_color);

draw_set_font(font);
draw_set_color(text_color);
		
scribble_draw(text_xo, text_yo, current_string);
	
if (char_index == string_length(string_wrapped) + 1){
	var frame = 0; if (line_index >= lines - 1) frame = 1;
	draw_sprite(spr_blinker,frame,x_origin + 445, y_origin + 80);
}

draw_set_color(c_white);
