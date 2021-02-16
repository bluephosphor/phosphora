if (global.draw_outline) and (_visible){
	if playerstate == p_state.swimming{
		var xo = -16; 
		if (image_xscale == -1) {
			if (!global.webmode){
				xo = 16;
			} else {
				xo = 10;
			}
		}
		var yo = -16;
		shader_set(sh_outline);
		shader_set_uniform_f(upixel_w,texel_w);
		shader_set_uniform_f(upixel_h,texel_h);
		draw_sprite_part_ext(sprite_index,image_index,0,0,32,20,x+xo,y+yo,image_xscale,image_yscale,c_white,1);
		shader_reset();
	} else {
		draw_sprite_ext(s_player_shadow, 0, x, y+1, 1, -.75, 0, c_white, .5);
		shader_set(sh_outline);
		shader_set_uniform_f(upixel_w,texel_w);
		shader_set_uniform_f(upixel_h,texel_h);
		draw_self();
		shader_reset();
	}
}

if (hitlag > 0) draw_sprite_ext(spr_spark,0,x,y,1,1,0,c_white,hitlag * 0.1);

if (target_state == TARGET_FOLLOW) or (target_state == TARGET_DISMISS){
	draw_sprite_ext(t_spr, t_anim_frame, tar_x, tar_y, 1, 1, t_anim_rot, t_anim_col, t_anim_alpha);
}

if (draw_alpha > 0){
	var str = "";
	if (hp_change == 0) str = "x";
	else {
		if (sign(hp_change) == 1) {str = "+"}
		str += string(hp_change);
	}
	var c = draw_color;
	var x_origin = x - (string_width(str) / 2);
	var y_origin = y - 32;
	draw_text_color(x_origin,y_origin,str,c,c,c,c,draw_alpha);
}