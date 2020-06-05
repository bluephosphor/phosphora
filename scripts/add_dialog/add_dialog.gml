///@description add_dialog
///@arg speaker
///@arg dialog string
if !instance_exists(obj_txtbox1){
	with (instance_create_layer(0,0,"Instances", obj_txtbox1)){
		dialog[lines, 0]   = argument0; //speaker
		dialog[lines++, 1] = argument1; //dialog
		event_perform(ev_other,ev_user0);
	}
} else {
	with (obj_txtbox1){
		dialog[lines, 0]   = argument0; //speaker
		dialog[lines++, 1] = argument1; //dialog
	}
}