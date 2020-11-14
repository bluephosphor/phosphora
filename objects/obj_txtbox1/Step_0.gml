if (scribble_line == -1) exit;

var in = keyboard_check_pressed(input[| key.action]);
var vinput = keyboard_check_pressed(input[| key.down]) - keyboard_check_pressed(input[| key.up]);

state = scribble_autotype_get(scribble_line);
//pausing

if (str_pause > 0){
	str_pause--;
} else if (pause_text){
	if (scribble_autotype_is_paused(scribble_line)){
		scribble_autotype_set_pause(scribble_line, false);
	} else {
		var pos = round(scribble_line[@ __SCRIBBLE.AUTOTYPE_HEAD_POSITION]);
		switch(string_char_at(raw_str,pos)){
			case ",": 
				str_pause = 5; 
				scribble_autotype_set_pause(scribble_line, true);
			break;
			case ".": 
			case "!": 
			case "?": 
				str_pause = 10; 
				scribble_autotype_set_pause(scribble_line, true);
			break;
		}
	}
}


if (in) {
	if (!line_skipped) and (state < 1){
		line_skipped = true;
		scribble_autotype_skip(scribble_line);
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