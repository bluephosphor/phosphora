switch(state){
	case 0:
		image_alpha += increment * 2;
		if (image_alpha > 0.9) state = 1;
		break;
	case 1:
		image_alpha -= increment;
		if (image_alpha <= 0) instance_destroy();
		break;
}

if (my_light != noone) my_light.light_strength = (state == 1) ? image_alpha : 1