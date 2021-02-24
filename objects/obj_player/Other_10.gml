/// @description normal step

//get inputs
x_input = 0; 
y_input = 0;
var _inv = keyboard_check_pressed(input[| key.select]);
var _spin = keyboard_check_pressed(input[| key.action]);
var _boost = keyboard_check(vk_shift) * 0.5;
var _speed_reduction = 0; 


//behold, the swimming state
if (playerstate == p_state.swimming){
	_speed_reduction = 1.5;
	_spin = false;
}

//and here's our 'final' speed
var ms = max_speed - _speed_reduction + _boost;

//calculate movement
if (gamestate == INGAME){
	x_input = keyboard_check(input[| key.right]) - keyboard_check(input[| key.left]);
	y_input = keyboard_check(input[| key.down]) - keyboard_check(input[| key.up]);
	
	xspeed += x_input * acceleration;
	yspeed += y_input * acceleration;
	var _speed		= point_distance (0, 0, xspeed, yspeed);
	var _direction	= point_direction(0, 0, xspeed, yspeed);
	if (_speed > ms) {
		xspeed = lengthdir_x(ms, _direction);
		yspeed = lengthdir_y(ms, _direction);
	}
	
	if (_spin){
		//interaction
		var r = interact_range;
		var interact = collision_rectangle(x-r,y-r,x+r,y+r,mc_entity,0,0);
		var helditem = instance_exists(mc_held_item);
		
		if (interact != noone and interact.interact_state == INTERACTABLE) {
			with (interact) {
				if (cont_textbox == noone) and (can_interact <= 0) {
					if (entity_type == "mob") {
						xmove = 0;
						ymove = 0;
						xspeed = 0;
						yspeed = 0;
						update_movement = false;
						
						if (other.x > x) image_xscale = 1;
						else image_xscale = -1;
						
						alarm[0] = -1;
						mystate = mobstate.interact;
					} else {
						interact_state = INTERACTING;
					}
				}
			}
		} else if (helditem){
			with (mc_held_item){
				using = true;
			}
		} else if (spin_cooldown <= 0) {
			//spin
			ds_list_add(spin_trails,new trail());
			alarm[0] = spin_duration;
			part_system_depth(my_psystem,depth-1);
			part_type_scale(global.p_gust,image_xscale,1);
			part_particles_create(my_psystem,x,y,global.p_gust,1);
			sprite_index = s_player_spin;
			playerstate = p_state.spin;
		}
	}
}

//animate sprite if we're moving
if (x_input == 0 && y_input == 0) {
	image_speed = 0;
	image_index = 0;
} else if (_boost){
	image_speed = 1;	
} else {
	image_speed = .7;
}

//friction when not moving
if (x_input == 0) {
	xspeed = lerp(xspeed, 0, frict);
}
if (y_input == 0) {
	yspeed = lerp(yspeed, 0, frict);
}

//set facing depending on target
if (current_target != noone){
	image_xscale = sign(current_target.x - x);
} else if (xspeed > 0) {
	image_xscale = 1;	
} else if (xspeed < 0) {
	image_xscale = -1;	
}

move_and_collide();

//toggle inventory and also chest logic
if (_inv) and (input_buffer <= 0){
	switch (gamestate){
		case INGAME: 
			gamestate = INV; 
			break;
		case INV:	 
			gamestate = INGAME; 
			cont_inv.hotbar_autoselect();
			break;
		default: break;
	}
	
	var _chest = instance_place(x,y,obj_chest);

	if (_chest != noone){
		
		_chest.image_index = (gamestate == INV);
		
		with (cont_inv) if (gamestate == INV){
			state			= inv_state.chest;
			chest_inv		= _chest.chest_inventory;
			selecting_grid	= chest_inv;
			menu_index		= 0;
		}
	} else {
		with (cont_inv) if (gamestate == INV) state = inv_state.inv;
	}
}
//enemy collision

var inst = (instance_place(x,y,mc_mob)); 
if (inst != noone) and (recovery_frames <= 0){
	var break_out = false;
	switch (inst.tangibility_type){
		case NEVER: break;
		case PER_FRAME:
			switch (inst.frame_type[inst.image_index]){
				case frametype.intangible:
				case frametype.block:
				case frametype.vulnerable: 
					break_out = true;
					break;
				case frametype.attack:
			}
			if (break_out) break;
		case ALWAYS:
			switch(inst.attack_type){
			case PASSIVE: break;
			case VELOCITY:
				with(inst){
					var velocity = max(abs(xspeed),abs(yspeed));
					if (velocity >= 1){
						var vsp = yspeed, hsp = xspeed;
						xspeed = -hsp;
						yspeed = -vsp;
						hitlag = velocity * 5;
					}
				}
				if (velocity >= 1){
					xspeed = hsp * 2;
					yspeed = vsp * 2;
					alarm[0] = velocity * 10;
					image_blend = c_red;
					player_health -= calc_player_damage(inst);
					player_health = clamp(player_health,0,mob_data[# mob.player, stat.hp]);
					sprite_index = s_player_hitstun;
					playerstate = p_state.hitstun;
					hitlag = velocity * 5;
				}
				break;
			case STATIC:
				var _dir = point_direction(x,y,inst.x,inst.y);
				var _len = inst.attack / 2;
				xspeed -= lengthdir_x(_len,_dir);
				yspeed -= lengthdir_y(_len,_dir);
				alarm[0] = 30;
				image_blend = c_red;
				player_health -= calc_player_damage(inst);
				player_health = clamp(player_health,0,mob_data[# mob.player, stat.hp]);
				sprite_index = s_player_hitstun;
				playerstate = p_state.hitstun;
				hitlag = _len;
				break;
		}
		break;
	}
	
	
}

if (spin_cooldown > 0){
	spin_cooldown -=1;
} 



if (in_cell == WATER){
	if (water_buff <= 0){
		playerstate = p_state.swimming;
	} else {
		water_buff -= 1;
	}
} else if (water_buff < 10){
	water_buff += 1;
	if (playerstate == p_state.swimming) {playerstate = p_state.normal;}
}