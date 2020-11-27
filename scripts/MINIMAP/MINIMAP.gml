function minimap_init(){
	map = {
		x: 0, 
		y: 0,
		scale: 1,
		active: true,
		surface: noone
	}
	map.x = global.view_width - (width_ * map.scale);
	map.y = global.view_height - (height_ * map.scale);
}

function minimap_draw(){
	if (gamestate == INGAME and map.active){
		if (!surface_exists(map.surface)){
			map.surface = surface_create(width_,height_);
			surface_set_target(map.surface);
			draw_clear_alpha(c_black,0);
			
			var c;
			var yy = 0; repeat(height_){
				var xx = 0; repeat(width_){
					switch(grid_[# xx,yy]){ // set pixel color depending on celltype
						case FLOOR: c = c_white; break;
						case WATER: c = c_aqua;  break;
						default: c = -1; break;
					}
					if (c != -1) draw_sprite_ext(
						spr_onepixel,
						0,
						map.scale * xx,
						map.scale * yy,
						map.scale,
						map.scale,
						0,
						c,
						1
					);
					xx++;
				}
				yy++;
			}
			surface_reset_target();
			debug_log_add("created map surface");
		} else draw_surface(map.surface,map.x,map.y);
		
		//draw little dot for player :3
		xx = map.x + (obj_player.x / CELL_WIDTH);
		yy = map.y + (obj_player.y / CELL_HEIGHT);
		c = c_red;
		draw_circle_color(xx,yy,1,c,c,false);
	}
}