var inst = (instance_place(x,y,obj_chest_demon)); if (inst != noone){
	with (inst){
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		instance_destroy();
	}
}

var inst = instance_place(x,y,mc_mob){
	if (inst != noone) and (!inst.passive) and (inst.hitbox_active){
		var xvel = x_speed_;
		var yvel = y_speed_;
		var stun = stunpower;
		var d_mod = damage_mod;
		with (inst){
			if (mystate != mobstate.hitstun){
				x_speed_ = xvel
				y_speed_ = yvel
				alarm[0] = stun;
				alarm[10] = 1;
				current_anim = hitstun_frames;
				hp -= calc_mob_damage(d_mod,true);
				mystate = mobstate.hitstun;
				image_blend = c_red;
			}
		}
		instance_destroy(id,true);
	}
}