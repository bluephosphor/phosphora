if (draw_alpha > 0){
	var max_healthbar_length = 64;
	var max_hp = mob_data[# mob.player, stat.hp];
	var hp_length = max_healthbar_length * player_health / max_hp;
	var hp_height = 3;
	var x_origin = 4;
	var y_origin = 4;
	
	hp_length = clamp(hp_length,0,max_healthbar_length);
	var c = c_white; 
	if (hp_draw_length > hp_length + 1){
		c = c_red;
		hp_draw_length = lerp(hp_draw_length,hp_length,0.1);
	} else if (hp_draw_length < hp_length - 1) {
		c = c_green;
		hp_draw_length = lerp(hp_draw_length,hp_length,0.1);
	}
	
	draw_set_alpha(draw_alpha);
	draw_sprite(spr_hb_container_p,0,x_origin,y_origin);
	draw_rectangle_color(x_origin, y_origin, x_origin + floor(hp_draw_length), y_origin + hp_height, c,c,c,c, false);
	draw_set_alpha(1);
}

if (global.flash_effect and hitlag > 0){
	c = c_white;
	if (playerstate == p_state.hitstun) c = c_red;
	draw_set_alpha(clamp(hitlag * 0.01,0,0.2));
	gpu_set_blendmode(bm_add);
	draw_rectangle_color(0,0,global.view_width,global.view_height,c,c,c,c,false);
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
}