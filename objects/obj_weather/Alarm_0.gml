alarm[0] = fog_freq;

if (instance_exists(o_camera)){
	camera_x = o_camera.x;
	camera_y = o_camera.y;
}

if (draw_fog){
	var xrange = global.view_width;
	var yrange = global.view_height;
	var xx = camera_x + irandom_range(-xrange,xrange);
	var yy = camera_y + irandom_range(-yrange,yrange);
	part_particles_create(global.p_system,xx,yy,global.p_fog,1);
}