function init_target() {
	current_target = noone;
	target_state = TARGET_DORMANT;

	t_spr = spr_target;
	t_anim_len = sprite_get_number(t_spr) - 1;
	t_anim_frame = 0;
	t_anim_alpha = 0;
	t_anim_col = c_white;
	t_anim_rot = 0;
	tar_x = 0;
	tar_y = 0;
}

function update_target() {
	switch (target_state){
		case TARGET_DORMANT:////////////////////////////////////////////
		if (keyboard_check_pressed(input[| key.target])) and (playerstate == p_state.normal) {
			target_state = TARGET_SET;
			debug_log_add("Target set.");
		}
		break;
		case TARGET_SET: ///////////////////////////////////////////////
			t_anim_frame = 0;
			t_anim_alpha = 0;
			t_anim_rot = 0;
			var _following = current_target;
			var _success = false;
			with(obj_camera){
				var _list = ds_list_create();
				var _num = instance_place_list(x, y, mc_mob, _list, true);
				if (_num > 0){
					var i = 0; repeat(_num){
						if (_list[| i] != _following) and (!_list[| i].passive){ 
							_following = _list[| i]; 
							_success = true;
							break;
						}
						i++;
					}
				} 
				ds_list_destroy(_list);
			}
			if (_success) {
				obj_camera.target_2 = _following;
				obj_camera.state = cam.follow_two;
				current_target = _following;
				target_state = TARGET_FOLLOW;
				debug_log_add("Target followed. Current target is " + mob_data[# current_target.mob_id, stat.name]);
			} else {
				current_target = noone;
				target_state = TARGET_DORMANT;
				debug_log_add("Target dormant.");
			}
		break;
		case TARGET_FOLLOW: ////////////////////////////////////////////
			if (t_anim_frame < t_anim_len) t_anim_frame++;
			t_anim_rot += 1;
			t_anim_alpha = 1 * t_anim_frame / t_anim_len;
			if (instance_exists(current_target)){
				tar_x = current_target.x;
				tar_y = current_target.y;
			}
			if (keyboard_check_pressed(input[| key.target])) {
				target_state = TARGET_DISMISS;
				debug_log_add("Target dismissed");
			}
		break;
		case TARGET_DISMISS: ///////////////////////////////////////////
			if (t_anim_frame > 0) {
				t_anim_frame--;
				t_anim_rot += 1;
				t_anim_alpha = 1 * t_anim_frame / t_anim_len;
				if (instance_exists(current_target)){
					tar_x = current_target.x;
					tar_y = current_target.y;
				}
			} else {
				obj_camera.target_2 = noone
				obj_camera.state = cam.follow_player;
				target_state = TARGET_SET;
				debug_log_add("Target reset.");
			}
		break;
	}
}