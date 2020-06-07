if (textbox_dims == -1) exit;

if (draw_box) {
		nine_slice_box_s(spr_9slice2, 
		textbox_dims[SCRIBBLE_BBOX.L],
		textbox_dims[SCRIBBLE_BBOX.T],
		textbox_dims[SCRIBBLE_BBOX.R],
		textbox_dims[SCRIBBLE_BBOX.B],
		global.menu_color,
	);
}
		
scribble_draw(x_origin, y_origin, scribble_line);

if (question) and (state == 1 or line_skipped){
	var options_x = textbox_dims[SCRIBBLE_BBOX.L] + 8;
	var options_y = textbox_dims[SCRIBBLE_BBOX.B] + 8;
	
	nine_slice_box_s(spr_9slice2,
		textbox_dims[SCRIBBLE_BBOX.L],	
		textbox_dims[SCRIBBLE_BBOX.B] + 4,
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

var _element_pages_array = scribble_line[__SCRIBBLE.PAGES_ARRAY];
var _page_array = _element_pages_array[scribble_line[__SCRIBBLE.AUTOTYPE_PAGE]];
var _typewriter_count = _page_array[__SCRIBBLE_PAGE.CHARACTERS];
var _head_pos = scribble_line[__SCRIBBLE.AUTOTYPE_HEAD_POSITION];
var _typewriter_t = _head_pos / _typewriter_count;

var str =  "_typewriter_count: " + string(_typewriter_count) + "\n";
	str += "_head_pos: " + string(_head_pos) + "\n";
	str += "_typewriter_t: " + string(_typewriter_t) + "\n";
	
draw_text(0,100,str);