enum menu_page {
	main,
	info,
	settings,
	audio,
	difficulty,
	graphics,
	controls,
	height,
}

enum menu_element_type {
	script_runner,
	page_transfer,
	slider,
	shift,
	toggle,
	input,
	info,
}

ds_menu_main = create_menu_page(
	["RESUME",		menu_element_type.script_runner,	resume_game],
	["INFO",		menu_element_type.page_transfer,	menu_page.info],
	["SETTINGS",	menu_element_type.page_transfer,	menu_page.settings],
	["EXIT",		menu_element_type.script_runner,	close_game],
	["SAVE LEVEL",	menu_element_type.script_runner,	save_room_data],
);

ds_menu_info = create_menu_page(
	["BACK",		menu_element_type.page_transfer,	menu_page.main],
	["Name:",		menu_element_type.info,				player_data[| stat.name]],
	["Max HP:",		menu_element_type.info,				player_data[| stat.hp]],
	["Attack:",		menu_element_type.info,				player_data[| stat.attack]],
	["Defense:",	menu_element_type.info,				player_data[| stat.defense]],
	["Sp. Attack:",	menu_element_type.info,				player_data[| stat.sp_attack]],
);

ds_settings = create_menu_page(
	["AUDIO",		menu_element_type.page_transfer,	menu_page.audio],
	["DIFFICULTY",	menu_element_type.page_transfer,	menu_page.difficulty],
	["GRAPHICS",	menu_element_type.page_transfer,	menu_page.graphics],
	["CONTROLS",	menu_element_type.page_transfer,	menu_page.controls],
	["BACK",		menu_element_type.page_transfer,	menu_page.main],
);

ds_menu_audio = create_menu_page(
	["MASTER",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["MUSIC",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["SOUNDS",		menu_element_type.slider,			change_volume,			1,		[0,1]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_difficulty = create_menu_page(
	["ENEMIES",		menu_element_type.shift,			change_difficulty,		0,		["HARMLESS","NORMAL","TERRIBLE"]],
	["ALLIES",		menu_element_type.shift,			change_difficulty,		0,		["DIM-WITTED","NORMAL","HELPFUL"]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_graphics = create_menu_page(
	["RESOLUTION",	menu_element_type.shift,			change_resolution,		2,		["1x","2x","3x"]],
	["WINDOW MODE",	menu_element_type.toggle,			change_window_mode,		0,		["WINDOWED","FULLSCREEN"]],
	["MENU COLOR",	menu_element_type.shift,			change_menu_col,		5,		["RED","GREEN","BLUE","AQUA","FUCHSIA","ICE"]],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_controls = create_menu_page(
	["UP",			menu_element_type.input,			key.up,					vk_up],
	["LEFT",		menu_element_type.input,			key.left,				vk_left],
	["RIGHT",		menu_element_type.input,			key.right,				vk_right],
	["DOWN",		menu_element_type.input,			key.down,				vk_down],
	["ACTION",		menu_element_type.input,			key.down,				ord("Z")],
	["SELECT",		menu_element_type.input,			key.down,				ord("X")],
	["BACK",		menu_element_type.page_transfer,	menu_page.settings],
);

page = 0;
pages = [ds_menu_main,ds_menu_info,ds_settings,ds_menu_audio,ds_menu_difficulty,ds_menu_graphics,ds_menu_controls];

var i = 0, array_len = array_length_1d(pages);
repeat(array_len){
	menu_option[i] = 0;
	i++;
}

inputting = false;
//inputting_c = merge_color(c_red,c_purple,0.5);
inputting_c = global.menu_color;