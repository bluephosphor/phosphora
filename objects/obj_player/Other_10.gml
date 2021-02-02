/// @description normal step

//get inputs
var _x_input = 0; 
var _y_input = 0;
var _inv = keyboard_check_pressed(input[| key.select]);
var _spin = keyboard_check_pressed(input[| key.action]);
var _boost = keyboard_check(vk_shift);
var _speed_reduction = 0; 


//behold, the swimming state
if (playerstate == p_state.swimming){
	_speed_reduction = 1.5;
	_spin = false;
}

//and here's our 'final' speed
var ms = max_speed_ - _speed_reduction;

//calculate movement
if (gamestate == INGAME){
	_x_input = keyboard_check(input[| key.right]) - keyboard_check(input[| key.left]);
	_y_input = keyboard_check(input[| key.down]) - keyboard_check(input[| key.up]);
	
	x_speed_ += _x_input * acceleration_;
	y_speed_ += _y_input * acceleration_;
	var _speed = point_distance(0, 0, x_speed_, y_speed_);
	var _direction = point_direction(0, 0, x_speed_, y_speed_);
	if (_speed > ms + _boost) {
		x_speed_ = lengthdir_x(ms + _boost, _direction);
		y_speed_ = lengthdir_y(ms + _boost, _direction);
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
						x_speed_ = 0;
						y_speed_ = 0;
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
			alarm[0] = spin_duration;
			part_type_scale(global.p_gust,image_xscale,1);
			part_particles_create(global.p_system,x,y,global.p_gust,1);
			sprite_index = s_player_spin;
			playerstate = p_state.spin;
			//if (instance_exists(obj_ps_controller)) obj_ps_controller.cast = true;
		}
	}
}

//animate sprite if we're moving
if (_x_input == 0 && _y_input == 0) {
	image_speed = 0;
	image_index = 0;
} else if (_boost){
	image_speed = 1;	
} else {
	image_speed = .7;
}

//friction when not moving
if (_x_input == 0) {
	x_speed_ = lerp(x_speed_, 0, .3);
}
if (_y_input == 0) {
	y_speed_ = lerp(y_speed_, 0, .3);
}

//set facing depending on target
if (current_target != noone){
	image_xscale = sign(current_target.x - x);
} else if (x_speed_ > 0) {
	image_xscale = 1;	
} else if (x_speed_ < 0) {
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
if (inst != noone) and (!inst.passive) and (inst.hitbox_active) and (recovery_frames <= 0){
	with(inst){
		var velocity = max(abs(x_speed_),abs(y_speed_));
		if (velocity >= 1){
			var vsp = y_speed_, hsp = x_speed_;
			x_speed_ = -hsp;
			y_speed_ = -vsp;
			hitlag = velocity * 5;
		}
	}
	if (velocity >= 1){
		x_speed_ = hsp * 2;
		y_speed_ = vsp * 2;
		alarm[0] = velocity * 10;
		image_blend = c_red;
		player_health -= calc_player_damage(inst);
		player_health = clamp(player_health,0,player_data[| stat.hp]);
		sprite_index = s_player_hitstun;
		playerstate = p_state.hitstun;
		hitlag = velocity * 5;
	} else if (inst.static_attack){
		x_speed_ = random_range(-1,1);
		y_speed_ = random_range(-1,1);
		alarm[0] = 30;
		image_blend = c_red;
		player_health -= calc_player_damage(inst);
		player_health = clamp(player_health,0,player_data[| stat.hp]);
		sprite_index = s_player_hitstun;
		playerstate = p_state.hitstun;
		hitlag = 30;
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