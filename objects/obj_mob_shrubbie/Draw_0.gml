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
draw_self();
shader_reset();