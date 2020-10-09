/// @description spin step
var _spin = keyboard_check_pressed(input[? key.action]);


image_speed = 2;

var _x_input = 0; 
var _y_input = 0;

//calculate movement
if (global.actionable){
	_x_input = keyboard_check(input[? key.right]) - keyboard_check(input[? key.left]);
	_y_input = keyboard_check(input[? key.down]) - keyboard_check(input[? key.up]);
	
	x_speed_ += _x_input * spin_accel;
	y_speed_ += _y_input * spin_accel;
	var _speed = point_distance(0, 0, x_speed_, y_speed_);
	var _direction = point_direction(0, 0, x_speed_, y_speed_);
	if (_speed > spin_speed) {
		x_speed_ = lengthdir_x(spin_speed, _direction);
		y_speed_ = lengthdir_y(spin_speed, _direction);
	}
}

if (_x_input == 0) {
	x_speed_ = lerp(x_speed_, 0, .01);
}
if (_y_input == 0) {
	y_speed_ = lerp(y_speed_, 0, .01);
}

move_and_collide();

//enemy collision

var inst = (instance_place(x,y,obj_chest_demon)); if (inst != noone){
	with (inst){
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		instance_destroy();
	}
}

var inst = (instance_place(x,y,mc_mob)); if (inst != noone) and (!inst.passive) and (inst.hitbox_active){
	var velocity = max(abs(x_speed_),abs(y_speed_));
	if (velocity >= 1){
		var vsp = y_speed_, hsp = x_speed_;
		with(inst){
			if (mystate != mobstate.hitstun){
				x_speed_ = hsp * 2;
				y_speed_ = vsp * 2;
				alarm[0] = 5 * velocity;
				alarm[10] = 1;
				hp -= calc_mob_damage(velocity,false);
				current_anim = hitstun_frames;
				mystate = mobstate.hitstun;
				image_blend = c_red;
				hitlag = velocity * 3;
			}
		}
		x_speed_ = -x_speed_;
		y_speed_ = -y_speed_;
		hitlag = velocity * 3;
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