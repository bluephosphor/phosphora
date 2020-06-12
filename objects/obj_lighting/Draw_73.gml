if (!surface_exists(light_surf)) {
	light_surf = surface_create(room_width,room_height);
	debug_log_add("light surface?");
} else {
	surface_set_target(light_surf);
	draw_clear(c_black);
	
	with(mc_lightsource){
		gpu_set_blendmode(bm_src_color);
		draw_sprite_ext(
			spr_glow,0,
			x*other.surf_scale,
			y*other.surf_scale,
			light_size*other.surf_scale,
			light_size*other.surf_scale,
			0,c_white,draw_strength
		);
		gpu_set_blendmode(bm_normal);
	}
	surface_reset_target();
	var alpha_reduction = o_player.hitlag * 0.01;
	draw_surface_ext(light_surf,0,0,1/surf_scale,1/surf_scale,0,c_white,dark_lev - alpha_reduction);
}

if (outside) dark_lev = cont_daycycle.darkness;