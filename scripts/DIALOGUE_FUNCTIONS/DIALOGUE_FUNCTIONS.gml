///@description add_dialog(speaker,dialog,[tag])
///@arg speaker
///@arg dialog string
enum tag {
	no_box,
	no_pause,
	no_reset
}

function add_dialog() {
	if (cont_textbox == noone){
		with (instance_create_layer(0,0,"Instances", obj_txtbox1)){
			cont_textbox = id;
			dialog[lines, 0]   = argument[0]; //speaker
			dialog[lines++, 1] = argument[1]; //dialog
			if (argument_count > 2){
				switch(argument[2]){
					case tag.no_box: draw_box = false; break;
					case tag.no_pause: pause_text = false; break;
					case tag.no_reset: reset_state = false;
				}
			}
			event_perform(ev_other,ev_user0);
		}
	} else {
		with (obj_txtbox1){
			dialog[lines, 0]   = argument[0]; //speaker
			dialog[lines++, 1] = argument[1]; //dialog
		}
	}
}

///@description add_dialog_branch
///@arg dialog_array_or_script
function add_dialog_branch(argument0) {

	with (obj_txtbox1){
		branch[branch_index++] = argument0;
	}
}