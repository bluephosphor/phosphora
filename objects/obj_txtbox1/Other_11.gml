///@description do different things depending on question choice

var choice = branch[menu_index];
var len = array_length(choice);

if (!is_array(choice)) {			///excecute script or function
	branch = -1;
	branch_index = 0;
	menu_index = 0;
	script_execute(choice);
} else if (!is_array(choice[0])) {	///excecute function w/ variable num of args
	branch = -1;
	branch_index = 0;
	menu_index = 0;
	var args = array_create(len,0);
	array_copy(args, 0, choice, 1, len);
	script_execute_alt(choice[0], args);
} else {							///add dialog
	var i = 0, line; repeat(len){
		line = choice[i];
		add_dialog(line[0],line[1]);
		i++;
	}
}

event_perform(ev_other,ev_user0);