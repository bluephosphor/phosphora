var resting_strength = wave(light_strength - 0.2, light_strength + 0.2, timer_offset,0);

if (draw_strength < light_strength + 0.2) draw_strength = light_strength;
else draw_strength = lerp(draw_strength,resting_strength,0.3);

if (follow != -1){
	if (instance_exists(follow)){
		x = follow.x + light_offset.x;
		y = follow.y + light_offset.y;
	} else {
		instance_destroy();
	}
}