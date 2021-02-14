if (draw_alpha > 0){
	var str = (is_string(hp_change)) ? hp_change : string(hp_change);
	var c = draw_color;
	var x_origin = x - (string_width(str) / 2);
	var y_origin = y - hb_offset;
	draw_text_color(x_origin,y_origin,str,c,c,c,c,draw_alpha);

	var max_healthbar_length = 24;
	var max_hp = mob_data[# mob_id, stat.hp];
	var hp_length = max_healthbar_length * hp / max_hp;
	var hp_height = 3;
	var x_origin = x - (max_healthbar_length / 2);
	    y_origin += 20;
	
	hp_length = clamp(hp_length,0,max_healthbar_length);
	c = c_white; 
	if (draw_length > hp_length + 1){
		c = c_red;
		draw_length = lerp(draw_length,hp_length,0.1);
	}
	
	draw_set_alpha(draw_alpha);
	draw_sprite(spr_hb_container,0,x_origin,y_origin);
	draw_rectangle_color(x_origin, y_origin, x_origin + floor(draw_length), y_origin + hp_height, c,c,c,c, false);
	draw_set_alpha(1);
}

if (global.draw_outline){
	shader_set(sh_outline);
	shader_set_uniform_f(upixel_w,texel_w);
	shader_set_uniform_f(upixel_h,texel_h);
	draw_self()
	shader_reset();
}