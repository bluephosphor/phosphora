function room_change() {

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
	
	obj_txtbox1.reset_state = false;

	add_dialog_branch([room_trans,r_csv_test]);
	add_dialog_branch([room_trans,r_outside]);
	add_dialog_branch([room_trans,r_dungeon]);
	add_dialog_branch([room_trans,r_deep_grove]);
	add_dialog_branch([room_trans,r_cavern]);
	add_dialog_branch([[-1,"Suit youself."]]);
}