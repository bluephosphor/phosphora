function load_map() {

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
	
	obj_txtbox1.reset_state = false;

	add_dialog_branch([room_trans,r_outside,LOAD_MAP]);
	add_dialog_branch([room_trans,r_dungeon,LOAD_MAP]);
	add_dialog_branch([room_trans,r_deep_grove,LOAD_MAP]);
	add_dialog_branch([room_trans,r_cavern,LOAD_MAP]);
	add_dialog_branch([[-1,"Suit youself."]]);
}