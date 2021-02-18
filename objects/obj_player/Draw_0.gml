if (_visible){
	if (playerstate == p_state.swimming){
		var xo = -16; 
		if (image_xscale == -1) {
			if (!global.webmode){
				xo = 16;
			} else {
				xo = 10;
			}
		}
		var yo = -16;
		draw_sprite_part_ext(sprite_index,image_index,0,0,32,20,x+xo,y+yo,image_xscale,image_yscale,image_blend,1);
		draw_sprite(s_waterring,image_index mod 2,x,y);
	} else {
		draw_sprite_ext(spr_entity_shadow, 0, x, y+1, 1, -.75, 0, c_white, .5);
		draw_self();
	}
}

//gpu_set_colorwriteenable(false,false,false,true);

//draw_set_alpha(0);
//var x1 = x-sprite_xoffset;
//var y1 = y-sprite_yoffset;
//draw_rectangle(x1,y1,x1+sprite_width,y1+sprite_height,false);
//draw_set_alpha(1);

//gpu_set_colorwriteenable(true,true,true,true);
//gpu_set_blendenable(true);