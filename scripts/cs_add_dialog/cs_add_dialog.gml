///@description cs_add_dialog
///@arg speaker
///@arg str
function cs_add_dialog() {
	if (argument_count > 2){
		add_dialog(argument[0],argument[1], argument[2]);
	} else {
		add_dialog(argument[0],argument[1]);
	}
	cs_end_action();


}
