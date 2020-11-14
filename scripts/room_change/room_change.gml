///@desc room_change(room,[LOAD_MAP])
///@arg room
#macro LOAD_MAP true

function room_change() {

	var t_room = argument[0];

	gamestate = TRANSITION;
	if (argument_count > 1) global.load_map = argument[1];
	check_inv(inventory,item.rift_a,true);
	check_inv(inventory,item.rift_b,true);
	check_inv(inventory,item.rift_c,true);
	obj_game.target_room = t_room;
	obj_game.room_transition = true;
	with(cont_audio){
		var check = room_data[# rm.bgm, t_room];
		if (room_data[# rm.bgm2, t_room] != -1){
			var pha = check_phase();
			if (pha != phase.daytime) {
				check = room_data[# rm.bgm2, t_room];
			}
		}
		if (check != index) audio_sound_gain(bgm,0,1000);
	}
}