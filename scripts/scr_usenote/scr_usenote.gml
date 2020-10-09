function scr_usenote() {
	show_inventory = false;
	global.actionable = false;

	var len = array_length_1d(notes) - 1;
	var index = irandom(len)
	var entry = notes[index];
	var lines = array_length_1d(entry);

	var i = 0; repeat(lines){
		add_dialog(-1,entry[i]);
		i++;
	};


}
