/// @description interacting state

switch(interact_state){
	case INTERACTABLE:
		global.actionable = false;
		var i = 0, curr_line;
		repeat(array_length_1d(mytext)){
			curr_line = mytext[i];
			add_dialog(curr_line[0],curr_line[1]);
			i++;
		}
		interact_state = INTERACTING;
	break;
	case INTERACTING:
		if (cont_textbox == noone){
			mystate = mobstate.passive;
			interact_state = INTERACTABLE;
			alarm[0] = 40;
		}
	break;
}
