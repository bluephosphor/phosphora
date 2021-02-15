entity_type = -1;
my_light = noone;
mytext = [
	[-1,"This is a test message."],
]

stats_reset = function(){	
	status		  = effect.none;
	attack		  = mob_data[# mob_id, stat.attack];	
	defense		  = mob_data[# mob_id, stat.defense];	
	sp_attack	  = mob_data[# mob_id, stat.sp_attack];	
	max_speed	  = mob_data[# mob_id, stat.max_spd];	
	frict		  = mob_data[# mob_id, stat.fric];		
	acceleration  = mob_data[# mob_id, stat.accel];		
}

upixel_h = shader_get_uniform(sh_outline,"pixel_h");
upixel_w = shader_get_uniform(sh_outline,"pixel_w");
texel_w = texture_get_texel_width(sprite_get_texture(sprite_index,0));
texel_h = texture_get_texel_height(sprite_get_texture(sprite_index,0));

interact_state = NOT_INTERACTABLE;
can_interact = 0;