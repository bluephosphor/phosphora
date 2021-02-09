/// @description boss states (aggro)

/* STATES
	0 = walking aimless
	1 = approaching
	2 = attack
	3 = jump
*/

switch(substate){
	case 0: //walking aimless
		if (update_movement) {
			if (irandom(4) == 4) {
				xmove = random_range(-0.2,0.2);
				ymove = random_range(-0.5,0.5);
				current_anim = (sign(ymove) == 1) ? walking_frames : retreating_frames;
			} else {
				current_anim = passive_frames;
			}
			if (!coord_outside_view(x,y)) substate = 1;
			alarm[0] = 30;
			update_movement = false;
		} else {
			move_commit();
			move_and_collide();
		}
		break;
	case 1: //approaching
		if (targeted == noone) substate = 0;
		
		var _tx = targeted.x;
		var _ty = targeted.y - detection_radius;
		
		var _dir = point_direction(x,y,_tx,_ty);
		var _dist = point_distance(x,y,_tx,_ty);
		var _approach_speed = 2;
		
		var _approach_speed = clamp(2 * _dist / (global.view_height div 2),0.5,2);
		
		x_speed_ = lengthdir_x(_approach_speed,_dir);
		y_speed_ = lengthdir_y(_approach_speed,_dir);
		anim_speed = 10 - clamp(_approach_speed * 3,0,9);
		
		if (y > _ty){
			var _pys = abs(obj_player.y_speed_) + 0.5;
			y_speed_ = -_pys;
			anim_speed = 6 - clamp(_pys,0,5);
		}
		
		current_anim = (sign(y_speed_) == 1) ? walking_frames : retreating_frames;
		
		if (attack_cooldown > 0){
			attack_cooldown--;
		} else if (collision_rectangle(
			x-(detection_radius/2),
			y,
			x+(detection_radius/2),
			y+ detection_radius,
			obj_player,
			false,
			false )) {
				anim_speed = 5;
				current_anim = charge_frames[0];
				charge = 25;
				substate = 2;
		}
		move_and_collide();
		break;
	case 2: //attack
		
		x_speed_ = lerp(x_speed_, 0, .1);
		y_speed_ = lerp(y_speed_, 0, .1);
		
		if (charge > 0){
			charge--;
			move_and_collide();
		} else if (current_anim != attack_frames[0]){
			current_anim = attack_frames[0];
			frame_index = 0;
			event_perform(ev_alarm,10);
		} else {
			if (animation_ended) {
				substate = 0; 
				attack_cooldown = 60;
				event_perform(ev_alarm,0);
			}
			if (image_index == 11){
				hitbox_active = true;
				static_attack = true;
				mask_index = spr_boss1hitbox1;
			} else if (image_index >= 12){
				hitbox_active = false;
				static_attack = false;
				mask_index = sprite_index;
			}
		} 
		
		break;
}