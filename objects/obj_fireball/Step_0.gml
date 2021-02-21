event_inherited();
switch (state){
    case FIREBALL_DORMANT:
        time ++;
	
        x_offset = cos(time*frequency) * amplitude;
        z_offset = sign(x_prev - x_offset);
        y_offset = cos(time*frequency * 2) * amplitude / 4;
        y_offset = y_offset * z_offset;
        y_offset -= 16;
        if (z_offset == -1) y_offset += 8;

        x = follow.x + x_offset;
        y = follow.y + y_offset;

        depth = follow.depth + z_offset;
        
        x_prev = x_offset;
        break;
    case FIREBALL_THROW:
        depth = -y;
		if(instance_exists(target)){
            var xvel = abs(xspeed);
            var yvel = abs(yspeed);
            if (xvel > yvel) {
                y = lerp(y,target.y,0.1);
            } else {
                x = lerp(x,target.x,0.1);
            }
        }
        x += xspeed;
        y += yspeed;
        var xx = irandom_range(-8,8);
        var yy = irandom_range(-8,8);
	    part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
        break;
    case FIREBALL_LAUNCH:
        var _x_input = 0;
		var _y_input = 0;
		
		target = obj_player.current_target;
		if (target != noone){
			if (coord_outside_view(target.x,target.y)) target = noone;
		} else {
			_x_input = keyboard_check(vk_right) - keyboard_check(vk_left);
			_y_input = keyboard_check(vk_down)  - keyboard_check(vk_up);
		}
		if (_x_input == 0) and (_y_input == 0){
			_x_input = obj_player.image_xscale;
		}
		xspeed = 5 * _x_input;
		yspeed = 5 * _y_input;
		alarm[0] = room_speed;
		state = FIREBALL_THROW;
        break;
}

