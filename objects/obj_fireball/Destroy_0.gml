repeat(50){
	var xx = irandom_range(-8,8);
	var yy = irandom_range(-8,8);
	part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
}