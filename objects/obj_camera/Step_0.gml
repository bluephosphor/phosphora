switch (state) {
    case cam.free:
        var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
		var _y_input = keyboard_check(vk_down) - keyboard_check(vk_up);
		var boost = keyboard_check(vk_shift) * 2;
		x += _x_input * 4 * boost;
		y += _y_input * 4 * boost;
        break;
    case cam.follow_player:
        if (instance_exists(target_)){
			x = lerp(x, target_.x, .1);
			y = lerp(y, target_.y-8, .1);
		}
        break;
	case cam.follow_two:
        if (instance_exists(target_) and instance_exists(target_2)){
			var _dist = point_distance (target_.x,target_.y,target_2.x,target_2.y);
			var _dir  = point_direction(target_.x,target_.y,target_2.x,target_2.y);
			var _x_to = target_.x;
			var _y_to = target_.y;
			if (_dist < global.view_height){
				_x_to = target_.x + lengthdir_x(_dist / 2, _dir);
				_y_to = target_.y + lengthdir_y(_dist / 2, _dir);
			}
			x = lerp(x, _x_to, .1);
			y = lerp(y, _y_to, .1);
		} else {
			state = cam.follow_player;
		}
        break;
}

//rounding and clamp
x = round_n(x, scale_);
y = round_n(y, scale_);
x = clamp(x, width_/2 + CELL_SIZE, room_width-width_/2 - CELL_SIZE);
y = clamp(y, height_/2 + CELL_SIZE, room_height-height_/2 - CELL_SIZE);

camera_x = obj_camera.x;
camera_y = obj_camera.y;

//screenshake
x += random_range(-shake_remain,shake_remain);
y += random_range(-shake_remain,shake_remain);
shake_remain = max(0,shake_remain-((1/shake_length)*shake_magnitude));


camera_set_view_pos(view_camera[0], x-width_/2, y-height_/2);