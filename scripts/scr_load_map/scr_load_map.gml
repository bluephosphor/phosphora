function scr_load_map() {
	show_inventory = false;
	global.actionable = false;

	add_dialog(-1,
		[
			"Load .map as?",
			room_data[# rm.name, r_outside],
			room_data[# rm.name, r_dungeon],
			room_data[# rm.name, r_deep_grove],
			room_data[# rm.name, r_cavern],
			"No thanks.",
		],
		tag.no_pause
	);

	add_dialog_branch([room_change,r_outside,LOAD_MAP]);
	add_dialog_branch([room_change,r_dungeon,LOAD_MAP]);
	add_dialog_branch([room_change,r_deep_grove,LOAD_MAP]);
	add_dialog_branch([room_change,r_cavern,LOAD_MAP]);
	add_dialog_branch(
		[
			[-1,"Suit youself."],
		]
	);


}
