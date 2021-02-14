/// @description passive state
if (update_movement) {
	if (init_attack) {
		alarm[0] = room_speed;
		attack_direction = point_direction(x,y,obj_player.x,obj_player.y);
		current_anim = aggro_frames;
		anim_speed = 10;
		alarm[10] = 1;
		part_type_scale(global.p_gust,image_xscale,1);
		part_particles_create(global.p_system,x,y,global.p_gust,1);
		mystate = mobstate.aggro;
		init_attack = false;
	} else if (irandom(4) = 4) {
		xmove = irandom_range(-1,1);
		ymove = irandom_range(-1,1);
		if (xmove != 0) image_xscale = xmove;
		alarm[0] = 30;
	} else {
		alarm[0] = 30;
	}
	update_movement = false;
} else {
	xspeed += xmove * acceleration;
	yspeed += ymove * acceleration;
	var _speed = point_distance(0, 0, xspeed, yspeed);
	var _direction = point_direction(0, 0, xspeed, yspeed);
	if (_speed > max_speed) {
		xspeed = lengthdir_x(max_speed, _direction);
		yspeed = lengthdir_y(max_speed, _direction);
	}
}

if (xmove == 0) {
	xspeed = lerp(xspeed, 0, .1);
}
if (ymove == 0) {
	yspeed = lerp(yspeed, 0, .1);
}

//mobsight
//if (!coord_outside_view(x,y)){
//	var mob = id;
//	var d = point_direction(
//		x,y, x+detection_radius * image_xscale, 
//		irandom_range(y-detection_radius,y+detection_radius)
//	); 
//	with (instance_create_layer(x,y,"Instances",obj_mobsight)){
//		my_mob = mob;
//		if (irandom(100) < 80) {
//			direction = d;
//			alarm[0] = 15;
//		} else {
//			direction = choose(90,270);
//			alarm[0] = 10;
//		}
//		speed = 7
//	}
//}
move_and_collide_inwater();