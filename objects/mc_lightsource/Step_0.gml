draw_strength = wave(light_strength - 0.2, light_strength + 0.2, timer_offset,0);

if (follow != -1){
	if (instance_exists(follow)){
		x = follow.x;
		y = follow.y;
	} else {
		instance_destroy();
	}
}