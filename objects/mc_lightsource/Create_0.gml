enum light {
	normal,
	flash,
	fade,
}

follow = noone;
state = light.normal;
light_size = 2;
light_strength = 0.7;
light_offset = new vec2(0,0);
draw_strength = light_strength;

timer_offset = random_range(1,2);