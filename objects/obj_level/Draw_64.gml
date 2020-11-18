if (gamestate == INGAME and draw_map){
	var c = -1;
	var yy = 0; repeat(height_){
		var xx = 0; repeat(width_){
			switch(grid_[# xx,yy]){
				case FLOOR: c = c_white; break;
				case WATER: c = c_aqua;  break;
				default: c = -1; break;
			}
			if (c != -1) draw_sprite_ext(
				spr_onepixel,
				0,
				map.x + map_scale * xx,
				map.y + map_scale * yy,
				map_scale,
				map_scale,
				0,
				c,
				1
			);
			xx++;
		}
		yy++;
	}

	xx = map.x + (obj_player.x / CELL_WIDTH);
	yy = map.y + (obj_player.y / CELL_HEIGHT);
	c = c_red;
	draw_circle_color(xx,yy,1,c,c,false);
}

if (temp_string == -1) exit;

draw_set_font(font_small);
draw_text(0,0,temp_string);
draw_set_font(font_main);