var inst = (instance_place(x,y,obj_chest_demon)); if (inst != noone){
	with (inst){
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		instance_destroy();
	}
}

if (strike){
	var _list = ds_list_create();
	var _num = instance_place_list(x, y, mc_mob, _list, false);
	var d_mod = damage_mod;
	if (_num > 0){
		for (var i = 0; i < _num; ++i;){
				with(_list[| i]){
					if (!passive) and (mystate != mobstate.hitstun){
						xspeed = random_range(-2,2);
						yspeed = random_range(-2,2);
						alarm[0] = room_speed;
						alarm[10] = 1;
						current_anim = hitstun_frames;
						hp -= (calc_mob_damage(d_mod,true));
						mystate = mobstate.hitstun;
						image_blend = c_red;
					}
				}
			}
		}
	ds_list_destroy(_list);
	repeat(50){
		var xx = irandom_range(-8,8);
		var yy = irandom_range(-8,8);
		part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
	}
	strike = false;
} else {
	image_alpha -= 0.1;
	if (image_alpha <= 0) instance_destroy();
}