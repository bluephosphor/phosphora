///@param modifier
///@param magic_attack?
function calc_mob_damage(argument0, argument1) {
	
	var modifier		= argument0;
	var magic_attack	= argument1;
	var attack_power	= player_inst.attack * modifier;
	var defense_power	= defense;
	var damage;

	if (magic_attack) {
		attack_power = player_inst.sp_attack * modifier;
		if (cont_daycycle.witching_hour) {
			draw_color = c_fuchsia;
			attack_power += attack_power;
		}
	}

	damage = ceil(attack_power) - ceil(defense_power);
	damage = clamp(damage,0,100);

	var shake_mag = clamp(damage,2,8);
	var shake_dur = clamp(damage,2,60);
	screen_shake(shake_dur,shake_mag);

	if (sign(hp_change) == 1) hp_change = 0;
	hp_change += -damage;
	show_hp = true;
	alarm[1] = room_speed;

	return damage;
}

///@param attacker
function calc_player_damage(argument0) {
	
	var attacker		= argument0;
	var attack_power	= attacker.attack;
	var defense_power	= player_inst.defense;
	var damage;

	damage = ceil(attack_power) - ceil(defense_power);
	damage = clamp(damage,0,100);

	var shake_mag = clamp(damage,2,8);
	var shake_dur = clamp(damage,2,60);
	screen_shake(shake_dur,shake_mag);

	if (sign(hp_change) == 1) hp_change = 0;
	hp_change += -damage;
	show_hp = true;
	alarm[1] = room_speed;

	return damage;
}

function apply_damage(inst,strength){
	with (player_inst){
		var break_out = false;
		var attack_blocked = false;
		switch(inst.tangibility_type){
			case NEVER: break;
			case PER_FRAME:
				switch (inst.frame_type[inst.image_index]){
					case frametype.attack:
					case frametype.intangible:
					break_out = true;
					break;
					case frametype.block: 
					if (!inst.block_override) attack_blocked = true;
					case frametype.vulnerable:
				}
				if (break_out) break;
			case ALWAYS:
				var _dist = point_distance(x,y,inst.x,inst.y);
				var _dir  = point_direction(x,y,inst.x,inst.y);
				var _force = new vec2(
					lengthdir_x(_dist/3,_dir),
					lengthdir_y(_dist/3,_dir),
				);
				with(inst){
					if (mystate != mobstate.hitstun){
						xspeed		= _force.x
						yspeed		= _force.y;
						alarm[0]		= (attack_blocked) ? 2 * strength : 5 * strength
						alarm[10]		= 1;
						if (attack_blocked) {
							playerstate = p_state.normal;
							hp_change	= "Parried!";
							show_hp		= true;
							alarm[1]	= room_speed;
						} else hp      -= calc_mob_damage(strength,false);
						current_anim	= (attack_blocked) ? block_frames   : hitstun_frames;
						mystate			= (attack_blocked) ? mobstate.block : mobstate.hitstun;
						image_blend		= (attack_blocked) ? c_green: c_red;
						hitlag			= strength * 3;
					}
				}
				hitlag = strength * 3;
			
				break;
		}
	}
}