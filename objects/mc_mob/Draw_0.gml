if (watertype){
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,0,c_white,0.5);
} else {
	draw_sprite_ext(s_player_shadow, 0, x, y+1, 1, -.75, 0, c_white, .5);
	draw_self();
	if (in_cell == WATER) draw_sprite(spr_minky,5 + frame_index,x,y+1);
}

