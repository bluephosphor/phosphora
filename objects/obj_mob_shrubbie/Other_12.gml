/// @description aggro state

switch(substate){
	case 0: // look for cell
		var _ww = obj_level.width_;
		var _hh = obj_level.height_;
		var _dir = irandom(360);
		cell_candidate.x = clamp((obj_player.x + lengthdir_x(ideal_dist,_dir)) div CELL_WIDTH, 1,_ww - 1);
		cell_candidate.y = clamp((obj_player.y + lengthdir_y(ideal_dist,_dir)) div CELL_HEIGHT,1,_hh - 1);
		if (grid_[# cell_candidate.x,cell_candidate.y] == FLOOR) {
			target_cell = cell_candidate;
			substate = 1;
		}
		break;
	case 1: // run to target cell
		
		var _p_dist = point_distance(x,y,obj_player.x,obj_player.y);
		
		if (coord_outside_view(x,y-24,32)) {
			if (alarm_get(0) == -1) alarm[0] = room_speed;
			//next_anim	= passive_frames;
			//substate	= 0;
			//mystate		= mobstate.passive;
		} else if (animation_ended) {
			if (in_cell == WATER) part_particles_create(global.p_system,x,y,global.p_water_ring,1);
			image_xscale = (obj_player.x > x) ? 1 : -1;
			animation_ended = false;
			if (_p_dist < ideal_dist - dist_range or _p_dist > ideal_dist + dist_range) {
				if (alarm_get(0) != -1) alarm[0] = -1;
				substate = 0;
			}
		}
		
		var _tx = target_cell.x * CELL_WIDTH + 16;
		var _ty = target_cell.y * CELL_HEIGHT + 16;
		
		var _dir = point_direction(x,y,_tx,_ty);
		var _dist = point_distance(x,y,_tx,_ty);
		
		var _approach_speed = clamp(3 * _dist / ideal_dist, 0, 2.5);
		
		x_speed_ = approach(x_speed_,lengthdir_x(_approach_speed,_dir),acceleration_);
		y_speed_ = approach(y_speed_,lengthdir_y(_approach_speed,_dir),acceleration_);
		anim_speed = 8 - clamp(_approach_speed * 3,4,6);
		
		
		//move_commit();
		move_and_collide();
}