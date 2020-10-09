function scr_room_change() {
	show_inventory = false;
	global.actionable = false;

	add_dialog(-1,
		[
			"Go to another room?",
			"CSV Test.",
			"Forest.",
			"Dungeon.",
			"Grove.",
			"Cavern",
			"No thanks.",
		]
	);

	add_dialog_branch([room_change,r_csv_test]);
	add_dialog_branch([room_change,r_outside]);
	add_dialog_branch([room_change,r_dungeon]);
	add_dialog_branch([room_change,r_deep_grove]);
	add_dialog_branch([room_change,r_cavern]);
	add_dialog_branch(
		[
			[-1,"Suit youself."],	
		]
	);


}
