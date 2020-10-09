///@description new_cutscene(scene_info)
///@arg scene_info
function new_cutscene(argument0) {

	if (cont_cutscene != noone) exit;

	with (instance_create_layer(0,0, layer, obj_cutscene)){
		cont_cutscene = id;
		scene_info = argument0;
		event_perform(ev_other, ev_user0);
	}


}
