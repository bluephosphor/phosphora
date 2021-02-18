if (state == 0){
	if (image_index > 0) draw_sprite_ext(
		sprite_index,
		image_index-1,
		x,
		y,
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		0.5
	)
	draw_self();
} else {
	var _xo = 0;
	var _yo = 0;
	
	draw_sprite_ext(spr_entity_shadow,0,x+_xo,y,0.5,1,0,c_white,0.5);

	draw_sprite_ext(
		sprite_index,
		image_index,
		x + _xo,
		y + _yo + y_offset,
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	)
}