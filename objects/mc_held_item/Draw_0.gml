switch(item_index){
	case item.none: break;
	case item.rod:
		draw_behind = true;
		var frame = obj_player.image_index;
		var offset = 0;
		if (using) {
			frame = 4;
			offset = 4 * facing;
			draw_behind = false;
			var cutoff = 0;
			if (at_rest){
				cutoff = 3;
				if (irandom(64) == 64) {
					var xx = lure_x + irandom_range(-8,8);
					var yy = lure_y + irandom_range(-8,8);
					part_particles_create(global.p_system,xx,yy,global.p_water_ring,1);
				}
				draw_sprite_ext(s_waterring,1,lure_x,lure_y,1,1,0,c_white,0.3);
			}
			draw_sprite_part(s_fishingrod,0,6,23,5,6-cutoff,lure_x,lure_y);
			draw_line(x + (16 * facing),y - 24,lure_x,lure_y);
		}
		draw_sprite_ext(s_fishingrod,frame,x+offset,y,facing,1,0,c_white,1);
	break;
	default:
		var offset = -4 * facing;
		draw_sprite_ext(spr_items,item_index,x+offset,y-16,facing,1,0,c_white,1);
	break;
}



	
