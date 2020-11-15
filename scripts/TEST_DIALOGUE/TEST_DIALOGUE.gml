function test_question() {

	add_dialog(-1,
		[
			"What's your favorite color?",
			"Red.",
			"Green!",
			"Purple! [spr_chars,0]",
		]
	);

	add_dialog_branch( 
		[
			[-1,"Really?"],
			[-1,"That's... okay I guess."],
		]
	);

	add_dialog_branch(test_answer1);

	add_dialog_branch( 
		[
			[-1,"[shake]YES!!! [spr_chars,0][/shake]"],
			[-1,"ahem, I mean..."],
			[-1,"Yes, the correct answer."],
		]
	);
}

function test_answer1() {
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