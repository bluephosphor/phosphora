if (global.debug){
	draw_set_alpha(0.3);
	draw_rectangle(
		cell_candidate.x * CELL_WIDTH, 
		cell_candidate.y * CELL_HEIGHT,
		cell_candidate.x * CELL_WIDTH + CELL_WIDTH, 
		cell_candidate.y * CELL_HEIGHT + CELL_HEIGHT,
		false
	);
}
draw_set_alpha(1);
draw_sprite_ext(s_player_shadow,0,x,y,1,1,0,c_white,0.5);

shader_set(sh_replace_colors);

shader_set_uniform_f(sh_handle_range,1);
//shader_set_uniform_f(sh_handle_match,
//	color_match_3.to_shader_value(color_match_3.red),
//	color_match_3.to_shader_value(color_match_3.green),
//	color_match_3.to_shader_value(color_match_3.blue),
//);
//shader_set_uniform_f(sh_handle_replace,
//	color_replace_3.to_shader_value(color_replace_3.red),
//	color_replace_3.to_shader_value(color_replace_3.green),
//	color_replace_3.to_shader_value(color_replace_3.blue),
//);

shader_set_uniform_f(sh_handle_match,
	color_match_3.red/255,
	color_match_3.green/255,
	color_match_3.blue/255,
);
shader_set_uniform_f(sh_handle_replace,
	color_replace_3.red/255,
	color_replace_3.green/255,
	color_replace_3.blue/255,
);


draw_self();

shader_reset();