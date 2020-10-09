var toggle = (keyboard_check_pressed(ord("N"))) and (keyboard_check(vk_shift));

show_menu ^= toggle;

if (!show_menu) exit;

var hinput = keyboard_check_pressed(input[? key.right]) - keyboard_check_pressed(input[? key.left]);
var vinput = keyboard_check_pressed(input[? key.down])  - keyboard_check_pressed(input[? key.up]);
var sinput = keyboard_check_pressed(input[? key.action]);

if (keyboard_check(vk_shift)){
	var len = 2;
	state += vinput;
	if (state > len)	state = 0;
	if (state < 0)		state = len;
}

switch(state){
	case 0: //name entry
	if (hinput != 0) or (vinput != 0){
		if (!selecting_options){
			var len = array_length_1d(current_alphabet) - 1;
			var _width = 11;
			menu_index += hinput;
			menu_index += vinput * _width;
			if (menu_index > len){
				selecting_options = true;
				menu_index = 0;
			}
			if (menu_index < 0) {menu_index = len;}
		} else {
			var len = array_length_1d(alphabet_options) - 1;
			var _width = 4;
			menu_index += hinput;
			menu_index += vinput * _width;
			if (menu_index > len) {menu_index = len;}
			if (menu_index < 0){
				selecting_options = false;
				menu_index = array_length_1d(current_alphabet) - 1;
			}
		}
	}
	if (sinput){
		if (!selecting_options){
			var str = current_alphabet[menu_index];
			switch(str){
				case "<-":		var len			= string_length(stored_string);
								stored_string	= string_copy(stored_string,1,len - 1);
								break;
				case "[SPACE]": stored_string	+= " "; break;
				default:		stored_string	+= str; break;
			}
		} else {
			page = menu_index;
		}
	}
		break;
	case 1: //list options
		var len = array_length_1d(list_options) - 1;
		if (vinput != 0){
			menu_index += vinput;
			if (menu_index > len)	menu_index = 0;
			if (menu_index < 0)		menu_index = len;
		}
		break;
		
	case 2: //test
	
		if (keyboard_check_pressed(ord("M"))) test_string = string_read(test_string);
		break;
}