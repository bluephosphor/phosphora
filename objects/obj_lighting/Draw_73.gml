if (!surface_exists(light_surf)) {
	light_surf = surface_create(room_width,room_height);
	debug_log_add("light surface?");
} else {
	surface_set_target(light_surf);
	draw_clear(c_black);
	
	with(mc_lightsource){
		gpu_set_blendmode(bm_src_color);
		var sscale = other.surf_scale;
		var spr_scale = light_size * sscale / 4;
		draw_sprite_ext(
			spr_glow,0,
			x*sscale,
			y*sscale,
			spr_scale,
			spr_scale,
			0,c_white,draw_strength
		);
		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target();
	var alpha_reduction = 0;
	if (global.flash_effect) {
		if (instance_exists(obj_thunderbolt)){
			alpha_reduction = obj_thunderbolt.image_alpha;
		} else alpha_reduction = obj_player.hitlag * 0.02;
	}
	draw_surface_ext(light_surf,0,0,1/surf_scale,1/surf_scale,0,c_white,dark_lev - alpha_reduction);
}

if (outside) dark_lev = cont_daycycle.darkness;