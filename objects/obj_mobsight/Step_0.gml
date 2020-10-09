if (grid_place_meeting(self, grid_,VOID)) {
	instance_destroy();
}

if (place_meeting(x,y,o_player)){
	with (my_mob) {init_attack = true;}
	instance_destroy(obj_mobsight);
}