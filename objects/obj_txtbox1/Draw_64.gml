if (textbox == -1) exit;

nine_slice_box_s(spr_9slice2, 
	textbox[SCRIBBLE_BOX.TL_X],
	textbox[SCRIBBLE_BOX.TL_Y],
	textbox[SCRIBBLE_BOX.TR_X],
	textbox[SCRIBBLE_BOX.BR_Y],
	global.menu_color,
);
		
scribble_draw(x_origin, y_origin, scribble_line);

if (question) and (state == 1 or line_skipped){
	var options_x = textbox[SCRIBBLE_BOX.TL_X] + 8;
	var options_y = textbox[SCRIBBLE_BOX.BL_Y] + 8;
	
	nine_slice_box_s(spr_9slice2,
		textbox[SCRIBBLE_BOX.TL_X],	
		textbox[SCRIBBLE_BOX.BL_Y] + 4,
		options_width,
		options_y + 4 + (12 * entries),
		global.menu_color,
	);
	
	var i = 0; repeat(entries){
		var s = ["",""];
		if (i == menu_index) s = ["[c_fuchsia][wobble]","[/wobble][/c]"];
		var draw_yy = options_y + 4 + (12 * i);
		scribble_draw(options_x,draw_yy,s[0]+ line_array[i + 1] + s[1]);
		i++;
	}
}

if (!global.debug) exit;

var str = "state: "			+ string(state)		+ "\n";
	str += "len: "			+ string(len)		+ "\n";
	str += "pos: "			+ string(ceil(pos)) + "\n";
	str += "str_pause: "	+ string(str_pause) + "\n";
	str += "s_autotype_pos" + string(scribble_line[@ __SCRIBBLE.AUTOTYPE_POSITION]);

draw_text(64,64,str);