///@description add_dialog
///@arg speaker
///@arg dialog string
if (cont_textbox == noone){
	with (instance_create_layer(0,0,"Instances", obj_txtbox1)){
		cont_textbox = id;
		dialog[lines, 0]   = argument[0]; //speaker
		dialog[lines++, 1] = argument[1]; //dialog
		if (argument_count > 2){
			draw_box = argument[2];
		}
		event_perform(ev_other,ev_user0);
	}
} else {
	with (obj_txtbox1){
		dialog[lines, 0]   = argument[0]; //speaker
		dialog[lines++, 1] = argument[1]; //dialog
	}
}

