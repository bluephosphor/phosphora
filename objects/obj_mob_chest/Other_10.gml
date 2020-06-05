/// @description passive state
if (update_movement) {
	if (init_attack) {
		alarm[0] = room_speed;
		attack_direction = point_direction(x,y,o_player.x,o_player.y);
		current_anim = aggro_frames;
		anim_speed = 10;
		alarm[10] = 1;
		part_type_scale(global.p_gust,image_xscale,1);
		part_particles_create(global.p_system,x,y,global.p_gust,1);
		mystate = mobstate.aggro;
		init_attack = false;
	} else {
		alarm[0] = 15;
	}
	update_movement = false;
} else {
	x_speed_ += xmove * acceleration_;
	y_speed_ += ymove * acceleration_;
	var _speed = point_distance(0, 0, x_speed_, y_speed_);
	var _direction = point_direction(0, 0, x_speed_, y_speed_);
	if (_speed > max_speed_) {
		x_speed_ = lengthdir_x(max_speed_, _direction);
		y_speed_ = lengthdir_y(max_speed_, _direction);
	}
}

if (xmove == 0) {
	x_speed_ = lerp(x_speed_, 0, .3);
}
if (ymove == 0) {
	y_speed_ = lerp(y_speed_, 0, .3);
}

//mobsight
if (!coord_outside_view(x,y)){
	var mob = id;
	with (instance_create_layer(x,y-8,"Instances",obj_mobsight)){
		my_mob = mob;
		direction = random(360);
		alarm[0] = 10;
		speed = 7
	}
}
move_and_collide();