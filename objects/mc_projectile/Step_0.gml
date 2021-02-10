var inst = (instance_place(x,y,obj_chest_demon)); if (inst != noone){
	with (inst){
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		instance_destroy();
	}
}

inst = instance_place(x,y,mc_mob);
if (inst != noone){
	var attack_blocked = false;
	switch(inst.tangibility_type){
		case NEVER: break;
		case PER_FRAME:
			switch (inst.frame_type[inst.image_index]){
				case frametype.block: 
				if (!inst.block_override) attack_blocked = true;
				case frametype.vulnerable:
				case frametype.attack:
				case frametype.intangible:
			}
		case ALWAYS:
			if (inst != noone){
				var xvel = x_speed_;
				var yvel = y_speed_;
				var stun = stunpower;
				var d_mod = damage_mod;
				with (inst){
					if (mystate != mobstate.hitstun){
						x_speed_		= xvel
						y_speed_		= yvel
						alarm[0]		= (attack_blocked) ? stun div 2 : stun;
						alarm[10]		= 1;
						current_anim	= (attack_blocked) ? block_frames : hitstun_frames;
						if (attack_blocked) {
							hp_change	= "Blocked!";
							show_hp		= true;
							alarm[1]	= room_speed;
						} else hp	   -= calc_mob_damage(d_mod,true);
						mystate			= (attack_blocked) ? mobstate.block : mobstate.hitstun;
						image_blend		= (attack_blocked) ? c_aqua : c_red;
					}
				}
				instance_destroy(id,true);
			}
			break;
	}
}