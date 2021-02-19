if (obj_player.current_target == id) {
	obj_player.current_target = noone;
	obj_player.target_state = TARGET_DISMISS;
}

if (variable_instance_exists(id,"path")){
	path_delete(path);
}