///@description advance textbox, set question state if applicable

line_index++;
line_skipped = false;
str_pause = 0;

if (line_index == lines){
	///if we have no more lines, finish up and exit
	cont_textbox = noone;
	instance_destroy(self);
	global.actionable = true;
	if (instance_exists(o_player)) o_player.spin_cooldown = 1;
	exit;
}

question = is_array(dialog[line_index, 1]);

if (question){
	line_array = dialog[line_index,1];
	entries = array_length_1d(line_array) - 1;
	line_to_draw = line_array[0];
	///get the longest line
	var i = 0, str, wid; repeat(entries){
		str = string_read(line_array[i + 1]);
		wid[i] = string_width(str);
		longest_line = max(longest_line,wid[i]);
		i++;
	}
} else {
	line_array = -1;
	entries = 0;
	longest_line = 0;
	line_to_draw = dialog[line_index,1];
}

raw_str = string_read(line_to_draw);
var _wrapped = string_wrap(raw_str,text_max_width);

				x_origin = (global.view_width / 2)  - (string_width(_wrapped) / 2);
if (!draw_box)  y_origin = (global.view_height / 2) - (string_height(raw_str) / 2);

scribble_line = scribble_draw(x_origin,y_origin,line_to_draw);
textbox_dims = scribble_get_bbox(scribble_line,x_origin,y_origin,8,8,8,8);

options_width = max(
	textbox_dims[SCRIBBLE_BBOX.R],
	textbox_dims[SCRIBBLE_BBOX.L] + longest_line + 16,
);

scribble_autotype_fade_in(scribble_line,SCRIBBLE_AUTOTYPE_PER_CHARACTER,autotype_spd,0);