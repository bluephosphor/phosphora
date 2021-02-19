/// @description aggro state

/*
	SUBSTATES
	0 = look for cell
	1 = run to targetc cell
	2 = shoot projectile
*/

switch(substate){
	case 0: // look for cell
		var _ww = obj_level.width_;
		var _hh = obj_level.height_;
		var _dir = irandom(360);
		cell_candidate.x = clamp((obj_player.x + lengthdir_x(ideal_dist,_dir)) div CELL_SIZE, 1,_ww - 1);
		cell_candidate.y = clamp((obj_player.y + lengthdir_y(ideal_dist,_dir)) div CELL_SIZE,1,_hh - 1);
		if (grid_[# cell_candidate.x,cell_candidate.y] == FLOOR) {
			target_cell = cell_candidate;
			substate = 1;
		}
		break;
	case 1: // run to target cell
		
		var _p_dist = point_distance(x,y,obj_player.x,obj_player.y);
		
		if (coord_outside_view(x,y-24,32)) {
			if (alarm_get(0) == -1) alarm[0] = room_speed;
		} else if (animation_ended) {
			if (in_cell == WATER) part_particles_create(global.p_system,x,y,global.p_water_ring,1);
			image_xscale = (obj_player.x > x) ? 1 : -1;
			animation_ended = false;
			if (_p_dist < ideal_dist - dist_range or _p_dist > ideal_dist + dist_range) {
				if (alarm_get(0) != -1) alarm[0] = -1;
				substate = 0;
			}
		}
		
		var _tx = target_cell.x * CELL_SIZE + 16;
		var _ty = target_cell.y * CELL_SIZE + 16;
		
		var _dir = point_direction(x,y,_tx,_ty);
		var _dist = point_distance(x,y,_tx,_ty);
		
		var _approach_speed = clamp(3 * _dist / ideal_dist, 0, 2.5);
		
		xspeed = approach(xspeed,lengthdir_x(_approach_speed,_dir),acceleration);
		yspeed = approach(yspeed,lengthdir_y(_approach_speed,_dir),acceleration);
		anim_speed = 8 - clamp(_approach_speed * 3,4,6);
		
		if (_dist < (CELL_SIZE / 2)) {
			anim_speed = 8;
			next_anim  = attack_frames;
			substate   = 2;
		}
		
		move_and_collide();
		break;
	case 2: //shoot projectile
		if (current_anim == attack_frames){
			switch(image_index){
				case 36:
					next_anim = aggro_frames;
					substate = 0;
			}
		} else {
			//end animation early so it's transition is smooth
			var len = array_length(current_anim) - 3;
			if (frame_index > len){
				frame_index = 0;
				animation_ended = true;
				current_anim = next_anim; 
				alarm[10] = anim_speed;
				var _list = ds_list_create();
				ds_list_add(_list,0,72,144,216,288);
				ds_list_shuffle(_list);
				var i = 0; repeat(irandom_range(3,5)){
					var _dir = _list[| i++];
					var _xx = x + lengthdir_x(16,_dir);
					var _yy = y + lengthdir_y(16,_dir);
					var _self = id;
					with (instance_create_layer(_xx,_yy,"Instances",obj_shrub_bullet)){
						my_mob = _self;
					}
				}
				ds_list_destroy(_list);
			}
		}
		image_xscale = (obj_player.x > x) ? 1 : -1;
		//parts
		var xx = x + irandom_range(-16,16); 
		var yy = y + irandom_range(-32,8);
		part_particles_create(global.p_system,xx,yy,global.p_spinpixel,1);
		break;
}

if (!global.debug) exit;
var c = c_white;
switch(substate){
	case 1:
		c = c_red;
		break;
		
	case 2:
		c = c_aqua;
		break;
	
}

image_blend = c;