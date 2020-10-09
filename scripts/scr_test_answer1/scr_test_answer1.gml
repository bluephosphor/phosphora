function scr_test_answer1() {
	add_dialog(-1,
		[
			"Are you sure?",
			"Yeah.",
			"No...",
			"What's it to you, anyway?",
		]
	);

	add_dialog_branch( 
		[
			[-1,"I can't argue with that I guess..."],
		]
	);

	add_dialog_branch(
		[
			[-1,"Yeah I didn't think so."],
			[-1,"Listen, kid, there's way better [rainbow]colors[/rainbow] out there."],
		]
	);

	add_dialog_branch(
		[
			[-1,"I'm just really passionate about this. Let me live."],
		]
	);


}
