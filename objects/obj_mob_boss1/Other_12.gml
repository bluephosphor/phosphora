/// @description boss states (aggro)

/* STATES
	0 = walking aimless
	1 = approaching
	2 = attack
	3 = jump
*/

block_override = (obj_player.y < y);

switch(substate){
	case 0: //walking aimless////////////////////////////////////////////////////////////////////////////
		if (update_movement) {
			if (irandom(4) == 4) {
				xmove = random_range(-0.2,0.2);
				ymove = random_range(-0.5,0.5);
				current_anim = (sign(ymove) == 1) ? walking_frames : retreating_frames;
			} else {
				current_anim = passive_frames;
			}
			if (!coord_outside_view(x,y) and instance_exists(obj_player)) {
				with (obj_camera){
					target_2 = other.id;
					state = cam.follow_two;
				}
				targeted = obj_player;
				substate = 1;
			}
			alarm[0] = 30;
			update_movement = false;
		} else {
			move_commit();
			move_and_collide();
		}
		break;
	case 1: //approaching////////////////////////////////////////////////////////////////////////////
		if (targeted == noone) substate = 0;
		
		var _tx = targeted.x;
		var _ty = targeted.y - detection_radius;
		
		var _dir = point_direction(x,y,_tx,_ty);
		var _dist = point_distance(x,y,_tx,_ty);
		
		var _approach_speed = clamp(3 * _dist / (global.view_height div 2),0.5,5);
		
		xspeed = approach(xspeed,lengthdir_x(_approach_speed,_dir),acceleration);
		yspeed = approach(yspeed,lengthdir_y(_approach_speed,_dir),acceleration);
		anim_speed = 10 - clamp(_approach_speed * 3,0,9);
		
		if (y > _ty){ //jump away if we spin fast
			var _pys = abs(obj_player.yspeed) + 1;
			yspeed = approach(yspeed,-_pys,0.5);
			anim_speed = 6 - clamp(_pys,0,5);
			if (yspeed < -3){
				frame_index = 0;
				image_index = jump_frames[0] - 1;
				current_anim = jump_frames;
				yspeed -= 1;
				anim_speed = 2;
				substate = 3;
				event_perform(ev_alarm,10);
				exit;
			}
		}
		
		current_anim = (sign(yspeed) == 1) ? walking_frames : retreating_frames;
		
		if (attack_cooldown > 0){
			attack_cooldown--;
		} else if (collision_rectangle(x-(detection_radius/2),y,x+(detection_radius/2),y+detection_radius,obj_player,false,false)){
			anim_speed = 5;
			current_anim = charge_frames[0];
			charge = irandom_range(15,30);
			yspeed = (obj_player.y_input == -1) ? -4 : 2;
			substate = 2;
		}
		move_and_collide();
		break;
	case 2: //attack////////////////////////////////////////////////////////////////////////////
		
		xspeed = lerp(xspeed, 0, .1);
		yspeed = lerp(yspeed, 0, .1);
		
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
				attack_cooldown = irandom_range(60,120);
				event_perform(ev_alarm,0);
			}
			mask_index = (image_index == 11) ? spr_boss1hitbox1 : sprite_index;
		} 
		
		break;
	case 3: //jump away////////////////////////////////////////////////////////////////////////////
		if (animation_ended) {
			current_anim = walking_frames;
			substate = 1;
			frame_index = 0;
			event_perform(ev_alarm,10);
		} else if (image_index > 29){
			xspeed = 0; yspeed = 0;
		} 
		//if (image_index > 17) 
		move_and_collide();
		break;
}