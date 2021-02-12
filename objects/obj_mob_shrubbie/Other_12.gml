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
		
		if (animation_ended) {
			image_xscale = (obj_player.x > x) ? 1 : -1;
			animation_ended = false;
			if (_p_dist < 80) substate = 0;
		}
		
		var _tx = target_cell.x * CELL_WIDTH + 16;
		var _ty = target_cell.y * CELL_HEIGHT + 16;
		
		var _dir = point_direction(x,y,_tx,_ty);
		var _dist = point_distance(x,y,_tx,_ty);
		
		var _approach_speed = clamp(3 * _dist / ideal_dist, 0, 2.5);
		
		x_speed_ = approach(x_speed_,lengthdir_x(_approach_speed,_dir),acceleration_);
		y_speed_ = approach(y_speed_,lengthdir_y(_approach_speed,_dir),acceleration_);
		anim_speed = 8 - clamp(_approach_speed * 3,2,6);
		
		if (coord_outside_view(x,y)) {
			next_anim	= passive_frames;
			substate	= 0;
			mystate		= mobstate.passive;
		}
		
		//move_commit();
		move_and_collide();
}