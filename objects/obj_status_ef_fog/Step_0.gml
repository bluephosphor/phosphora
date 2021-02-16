switch(state){
	case 0:
		var _inst = instance_place(x,y,obj_player);
		if (_inst != noone) {
			effect_apply(inflicts.index,inflicts.level,_inst,inflicts.duration);
			state = 1;
		}
		
		image_alpha += increment * 2;
		if (image_alpha > 0.9) state = 1;
		break;
	case 1:
		image_alpha -= increment;
		if (image_alpha <= 0) instance_destroy();
		break;
}

if (my_light != noone) my_light.light_strength = (state == 1) ? image_alpha : 1