event_inherited();

depth = -y;
grid_x = x div CELL_WIDTH;
grid_y = y div CELL_HEIGHT;
in_cell = grid_[# grid_x, grid_y];

my_light.light_strength = 1 * image_index / 11;

switch(state){
	case 0:
		if (!instance_exists(my_mob) or my_mob.mystate != mobstate.aggro) interrupted = true;
		
		if (interrupted) image_speed = 0.3;
		else image_index = my_mob.frame_index;
		
		my_light.light_offset.y = -20 * image_index / 11;
		
		if (image_index > 10) {
			image_speed = 1;
			target_x = ((interrupted) ? x : obj_player.x) + irandom_range(-64,64);
			target_y = ((interrupted) ? y : obj_player.y) + irandom_range(-64,64);
			total_dist = point_distance(x,y,target_x,target_y);
			state = 1;
		}
		
		break;
	case 1:
		var _xx = random_range(bbox_left,bbox_right);
		var _yy = random_range(bbox_top + y_offset,bbox_bottom + y_offset);
		part_particles_create(global.p_system,_xx,_yy,global.p_spinpixel,1);
		
		var _dir = point_direction(x,y,target_x,target_y);
		var _dist = point_distance(x,y,target_x,target_y);
		y_offset = 20 - (20 * _dist / total_dist);
		my_light.light_offset.y = -20 + y_offset;
		
		xspeed = lerp(xspeed,lengthdir_x(max_sp,_dir),accel);
		yspeed = lerp(yspeed,lengthdir_y(max_sp,_dir),accel);
		x += xspeed;
		y += yspeed;
		
		if (_dist < 8) {
			var i = 0; repeat(50){
				var _xx = random_range(bbox_left,bbox_right);
				var _yy = random_range(bbox_top + y_offset,bbox_bottom + y_offset);
				part_particles_create(global.p_system,_xx,_yy,global.p_spinpixel,1);
				i++;
			}
			var _cloud = instance_create_layer(x,y,"Instances",obj_status_ef_fog);
			with (_cloud) from_bullet = true;
			my_light.follow = _cloud;
			_cloud.my_light = my_light;
			instance_destroy();
		}
		break;
}