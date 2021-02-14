/// @description spin step
var _spin = keyboard_check_pressed(input[| key.action]);

image_speed = 2;

x_input = 0; 
y_input = 0;

//calculate movement
if (gamestate == INGAME){
	x_input = keyboard_check(input[| key.right]) - keyboard_check(input[| key.left]);
	y_input = keyboard_check(input[| key.down]) - keyboard_check(input[| key.up]);
	
	xspeed += x_input * spin_accel;
	yspeed += y_input * spin_accel;
	var _speed = point_distance(0, 0, xspeed, yspeed);
	var _direction = point_direction(0, 0, xspeed, yspeed);
	if (_speed > spin_speed) {
		xspeed = lengthdir_x(spin_speed, _direction);
		yspeed = lengthdir_y(spin_speed, _direction);
	}
}

if (x_input == 0) {
	xspeed = lerp(xspeed, 0, .01);
}
if (y_input == 0) {
	yspeed = lerp(yspeed, 0, .01);
}

move_and_collide();

//enemy collision

var inst = (instance_place(x,y,obj_chest_demon)); if (inst != noone){
	with (inst){
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		instance_destroy();
	}
}

var inst = (instance_place(x,y,mc_mob)); 

if (inst != noone){
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
			var velocity = max(abs(xspeed),abs(yspeed));
			if (velocity >= 1){
				var vsp = yspeed, hsp = xspeed;
				with(inst){
					if (mystate != mobstate.hitstun){
						xspeed		= hsp * 2;
						yspeed		= vsp * 2;
						alarm[0]		= (attack_blocked) ? 2 * velocity   : 5 * velocity;
						alarm[10]		= 1;
						if (attack_blocked) {
							playerstate = p_state.normal;
							hp_change	= "Parried!";
							show_hp		= true;
							alarm[1]	= room_speed;
						} else hp      -= calc_mob_damage(velocity,false);
						current_anim	= (attack_blocked) ? block_frames   : hitstun_frames;
						mystate			= (attack_blocked) ? mobstate.block : mobstate.hitstun;
						image_blend		= (attack_blocked) ? c_green: c_red;
						hitlag			= velocity * 3;
					}
				}
				xspeed = -xspeed;
				yspeed = -yspeed;
				hitlag = velocity * 3;
			}
			break;
	}
	
}

if (_spin){
	alarm[0] = 1;
}

//parts
var xx = x + irandom_range(-16,16); 
var yy = y + irandom_range(-32,8);
part_particles_create(global.p_system,xx,yy,global.p_spinpixel,1);

if (in_cell == WATER){ 
	if ((alarm[0] mod 4) == 0) part_particles_create(global.p_system,x,y,global.p_water_ring,1);
}