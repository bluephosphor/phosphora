var in_pause = keyboard_check_pressed(input[? key.pause]); 


if (in_pause and input_buffer <= 0) switch (gamestate){
	case INGAME: 
		gamestate = PAUSE;
		global.time_pause = true;
		break;
	case PAUSE: 
		gamestate = INGAME;
		global.time_pause = false;
		break;
	default: break;
}

if(gamestate != PAUSE) exit;

var in_up		= keyboard_check_pressed(input[? key.up]);
var in_down		= keyboard_check_pressed(input[? key.down]);
var in_enter	= keyboard_check_pressed(input[? key.action]);

var ds_grid = pages[page], ds_height = ds_grid_height(ds_grid);

if(inputting){
	switch(ds_grid[# 1, menu_option[page]]){
		case menu_element_type.shift:
			var hinput = keyboard_check_pressed(input[? key.right]) - keyboard_check_pressed(input[? key.left]); 
			if(hinput != 0){
				//audio
				ds_grid[# 3, menu_option[page]] += hinput;
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]],0,array_length_1d(ds_grid[# 4, menu_option[page]]) - 1);
			}
		break;
		case menu_element_type.slider:
			var hinput = keyboard_check(input[? key.right]) - keyboard_check(input[? key.left]); 
			if(hinput != 0){
				ds_grid[# 3, menu_option[page]] += hinput*0.01;
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]],0,1);
				script_execute(ds_grid[# 2, menu_option[page]],ds_grid[# 3, menu_option[page]]);
			}
		break;
		case menu_element_type.toggle:
			var hinput = keyboard_check_pressed(input[? key.right]) - keyboard_check_pressed(input[? key.left]); 
			if(hinput != 0){
				//audio
				ds_grid[# 3, menu_option[page]] += hinput;
				ds_grid[# 3, menu_option[page]] = clamp(ds_grid[# 3, menu_option[page]],0,1);
			}
		break;
		case menu_element_type.input:
			var kk = keyboard_lastkey;
			if (kk != input[? key.action]){
				ds_grid[# 3, menu_option[page]] = kk;
				input[? ds_grid[# 2, menu_option[page]]] = kk;
			}
		break;
	}
} else {
	var ochange = in_down - in_up;
	if (ochange != 0){
		menu_option[page] += ochange;
		if(menu_option[page] > ds_height-1) {menu_option[page] = 0;}
		if(menu_option[page] < 0) {menu_option[page] = ds_height - 1;}
	}
	
}

if(in_enter){
	switch(ds_grid[# 1, menu_option[page]]){
		case menu_element_type.script_runner: script_execute(ds_grid[# 2, menu_option[page]]) break;
		case menu_element_type.page_transfer: page = ds_grid[# 2, menu_option[page]]; break;
		case menu_element_type.shift:
		case menu_element_type.slider:
		case menu_element_type.toggle: if (inputting) {script_execute(ds_grid[# 2, menu_option[page]],ds_grid[# 3, menu_option[page]]);}
		case menu_element_type.input:
			inputting = !inputting;
			break;
	}
	//audio
}