if (scribble_line == -1) exit;

var in = keyboard_check_pressed(input[? key.action]);
var vinput = keyboard_check_pressed(input[? key.down]) - keyboard_check_pressed(input[? key.up]);

state = scribble_autotype_get(scribble_line);
pos   = 1 * len * state;

var curr_char = string_char_at(raw_str,ceil(pos));

switch(curr_char){
	case ",": str_pause = 15; scribble_line[@ __SCRIBBLE.AUTOTYPE_POSITION] += autotype_spd; break;
	case "!":
	case "?":
	case ".": str_pause = 20; scribble_line[@ __SCRIBBLE.AUTOTYPE_POSITION] += autotype_spd; break;
}

if (str_pause > 0) {
	str_pause -= 1;
	scribble_line[@ __SCRIBBLE.AUTOTYPE_POSITION] -= autotype_spd;
}

if (in) {
	if (!line_skipped) and (state < 1){
		line_skipped = true;
		scribble_autotype_fade_in(scribble_line,SCRIBBLE_AUTOTYPE_NONE,1,0);
	} else if (line_skipped) or (state >= 0.9){
		if (question) event_perform(ev_other,ev_user1);
		else event_perform(ev_other,ev_user0); 
	}
}

if (!question) and (state < 1 or !line_skipped) exit;

if (vinput != 0){
	menu_index += vinput;
	if (menu_index > entries - 1) menu_index = 0;
	if (menu_index < 0) menu_index = entries - 1;
}