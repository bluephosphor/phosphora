repeat(50){
	var xx = irandom_range(-8,8);
	var yy = irandom_range(-8,8);
	part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
}

switch(state){
	case FIREBALL_DORMANT:
	case FIREBALL_LAUNCH:
		var _id = id;
		with(my_controller){
			var _arr = [];
			var i = 0, j = 0; repeat(array_length(fireballs.ids)){
				if (fireballs.ids[i] != _id) _arr[j++] = _id;
				i++;
			}
			fireballs.ids = _arr;
			state = spell.finish;
		}
}