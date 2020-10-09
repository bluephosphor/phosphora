function change_resolution(argument0) {
	switch(argument0){
		case 0: global.resolution = [320,180]; break;
		case 1: global.resolution = [640,360]; break;
		case 2: global.resolution = [960,540]; break;
	}

	window_set_size(global.resolution[0],global.resolution[1]);
	surface_resize(application_surface,global.resolution[0],global.resolution[1]);

	alarm[0] = 1;


}
