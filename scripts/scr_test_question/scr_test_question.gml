function scr_test_question() {


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

	add_dialog_branch(scr_test_answer1);

	add_dialog_branch( 
		[
			[-1,"[shake]YES!!! [spr_chars,0][/shake]"],
			[-1,"ahem, I mean..."],
			[-1,"Yes, the correct answer."],
		]
	);


}
