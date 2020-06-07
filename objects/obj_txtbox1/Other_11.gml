///@description do different things depending on question choice

var choice = branch[menu_index];

if (!is_array(choice)) {
	branch = -1;
	branch_index = 0;
	menu_index = 0;
	script_execute(choice);
} else {
	var len = array_length_1d(choice);
	var i = 0, line; repeat(len){
		line = choice[i];
		add_dialog(line[0],line[1]);
		i++;
	}
}

event_perform(ev_other,ev_user0);