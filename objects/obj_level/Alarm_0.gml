/// @description spawn mobs
alarm[0] = room_speed * 5;

if (!global.pause){
	var mob_count = instance_number(mc_mob) + instance_number(obj_chest_demon);

	if (mob_count < mob_cap) {
		var list = room_data[# rm.mob_types,room];
		var len = array_length_1d(list) - 1;
		var num = irandom(len);
		var _mob = list[num];
		
		if (_mob == mob.ghost and room_data[# rm.draw_daylight,room] == true){
			var pha = check_phase();
			if (pha == phase.daytime){
				debug_log_add("didn't spawn a ghost because it was daytime");
				exit;
			}
		}
		spawn_mob(_mob);
	}
}