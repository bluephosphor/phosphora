if (throw_){
	if(instance_exists(target)){
		var xvel = abs(x_speed_);
		var yvel = abs(y_speed_);
		if (xvel > yvel) {
			y = lerp(y,target.y,0.1);
		} else {
			x = lerp(x,target.x,0.1);
		}
	}
	x += x_speed_;
	y += y_speed_;
	var xx = irandom_range(-8,8);
	var yy = irandom_range(-8,8);
	part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
} else {
	timer ++;
	
	x_offset = cos(timer*frequency) * amplitude;
	z_offset = sign(x_prev - x_offset);
	y_offset = cos(timer*frequency * 2) * amplitude / 4;
	y_offset = y_offset * z_offset;
	y_offset -= 16;
	if (z_offset == -1) y_offset += 8;

	x = follow.x + x_offset;
	y = follow.y + y_offset;

	depth = follow.depth + z_offset;
	
	x_prev = x_offset;
	
	if (launch){
		var _x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
		var _y_input = keyboard_check(vk_down)  - keyboard_check(vk_up);
		if (_x_input == 0) and (_y_input == 0){
			_x_input = o_player.image_xscale;
		}
		x_speed_ = 5 * _x_input;
		y_speed_ = 5 * _y_input;
		alarm[0] = room_speed;
		target = o_player.current_target;
		if (target != noone){
			if (coord_outside_view(target.x,target.y)) target = noone;
		}
		throw_ = true;
		launch = false;
	}
}

event_inherited();