enum menu_page {
	main,
	info,
	settings,
	audio,
	accessibility,
	graphics,
	controls,
	height,
}

enum menu_element_type {
	script_runner,
	page_transfer,
	bool_toggle,
	slider,
	shift,
	toggle,
	input,
	info,
}

ds_menu_main =			create_menu_page(
	["RESUME",			menu_element_type.script_runner,	resume_game],
	["INFO",			menu_element_type.page_transfer,	menu_page.info],
	["SETTINGS",		menu_element_type.page_transfer,	menu_page.settings],
	["EXIT",			menu_element_type.script_runner,	close_game],
	["SAVE LEVEL",		menu_element_type.script_runner,	save_room_data],
);

ds_menu_info =			create_menu_page(
	["BACK",			menu_element_type.page_transfer,	menu_page.main],
	["Name:",			menu_element_type.info,				mob_data[# mob.player, stat.name]],
	["Max HP:",			menu_element_type.info,				mob_data[# mob.player, stat.hp]],
	["Attack:",			menu_element_type.info,				mob_data[# mob.player, stat.attack]],
	["Defense:",		menu_element_type.info,				mob_data[# mob.player, stat.defense]],
	["Sp. Attack:",		menu_element_type.info,				mob_data[# mob.player, stat.sp_attack]],
);

ds_settings =			create_menu_page(
	["AUDIO",			menu_element_type.page_transfer,	menu_page.audio],
	["ACCESSIBILITY",	menu_element_type.page_transfer,	menu_page.accessibility],
	["GRAPHICS",		menu_element_type.page_transfer,	menu_page.graphics],
	["CONTROLS",		menu_element_type.page_transfer,	menu_page.controls],
	["BACK",			menu_element_type.page_transfer,	menu_page.main],
);

ds_menu_audio =			create_menu_page(
	["MASTER",			menu_element_type.slider,			change_volume,			1,		[0,1]],
	["MUSIC",			menu_element_type.slider,			change_volume,			1,		[0,1]],
	["SOUNDS",			menu_element_type.slider,			change_volume,			1,		[0,1]],
	["BACK",			menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_accessibility = create_menu_page(
	["DIFFICULTY",		menu_element_type.shift,			change_accessibility,	1,		["CHILL","NORMAL","CHALLENGE","WEARY EMOJI"]],
	["SCREENSHAKE",		menu_element_type.toggle,			change_accessibility,	true,	["OFF","ON"]],
	["FLASH EFFECT",	menu_element_type.toggle,			change_accessibility,	true,	["OFF","ON"]],
	["CONTENT WARNINGS",menu_element_type.toggle,			change_accessibility,	false,	["OFF","ON"]],
	["BACK",			menu_element_type.page_transfer,	menu_page.settings],
);

ds_menu_graphics =		create_menu_page(
	["RESOLUTION",		menu_element_type.shift,			change_resolution,		2,		["1x","2x","3x"]],
	["WINDOW MODE",		menu_element_type.toggle,			change_window_mode,		0,		["WINDOWED","FULLSCREEN"]],
	["MENU COLOR",		menu_element_type.shift,			change_menu_col,		5,		["FUCHSIA","MOSS","COBALT","TEAL","MAROON","ICE","AMBER","COFFEE"]],
	["BACK",			menu_element_type.page_transfer,	menu_page.settings], 
);

ds_menu_controls =		create_menu_page(
	["UP",				menu_element_type.input,			key.up,					vk_up],
	["LEFT",			menu_element_type.input,			key.left,				vk_left],
	["RIGHT",			menu_element_type.input,			key.right,				vk_right],
	["DOWN",			menu_element_type.input,			key.down,				vk_down],
	["ACTION",			menu_element_type.input,			key.down,				ord("Z")],
	["SELECT",			menu_element_type.input,			key.down,				ord("X")],
	["BACK",			menu_element_type.page_transfer,	menu_page.settings],
);

page = 0;
pages = [ds_menu_main,ds_menu_info,ds_settings,ds_menu_audio,ds_menu_accessibility,ds_menu_graphics,ds_menu_controls];

var i = 0, array_len = array_length(pages);
repeat(array_len){
	ds_collector_add(pages[i]);
	menu_option[i] = 0;
	i++;
}

inputting = false;
inputting_c = global.menu_color;