/// @description interacting state

if (interact_state == INTERACTABLE){
	global.actionable = false;
	audio_play_sound(snd_ghostlaugh,10,false);
	var i = 0, curr_line;
	repeat(array_length_1d(mytext)){
		curr_line = mytext[i];
		add_dialog(curr_line[0],curr_line[1]);
		i++;
	}
	interact_state = INTERACTING;
} else {
	if (!instance_exists(obj_txtbox)) {
		mystate = mobstate.passive;
		interact_state = INTERACTABLE;
	}
}