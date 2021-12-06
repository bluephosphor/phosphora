

switch(state){
	case light.normal:
		var resting_strength = wave(light_strength - 0.2, light_strength + 0.2, timer_offset,0);
		draw_strength = lerp(draw_strength,resting_strength,0.3);
		break;
	case light.flash:
		if (draw_strength > light_strength) draw_strength = lerp(draw_strength,light_strength,0.15);
		else draw_strength = light_strength;
		break;
	case light.fade:
		draw_strength -= 0.03;
		if (draw_strength <= 0) instance_destroy();
		break;
}

if (follow != noone){
	if (instance_exists(follow)){
		x = follow.x + light_offset.x;
		y = follow.y + light_offset.y;
	} else {
		follow = noone;
		state = light.fade;
	}
}