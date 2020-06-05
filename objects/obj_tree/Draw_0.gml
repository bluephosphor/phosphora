if (!surface_exists(my_surface)) {
	// Create the surface
	my_surface = surface_create(width,height);
	surface_set_target(my_surface);
	draw_clear_alpha(c_black, 0);
	
	///draw_tree_back
	var c = c_shadow;
	draw_sprite_ext(spr,0,x_origin,y_origin,image_xscale,image_yscale,image_angle,c,image_alpha);

	var leaf_origin_x = 32;
	var leaf_origin_y = 72;
	
	var _steps = irandom_range(48,64);
	var i = 0, draw_x, draw_y, angle, frame; 
	repeat(_steps){
		//generate pattern coords
		draw_x[i] = leaf_origin_x + irandom_range(-16,16);
		draw_y[i] = leaf_origin_y + irandom_range(-32,-16);
		angle [i] = choose(0,90,180,270);
		frame [i] = choose(1,2);
	
		//set color
		var c_len	= array_length_1d(colors) - 1;
		var cc		= (i/_steps) * c_len;
		var c1		= colors[floor(cc)];
		var c2		= colors[ceil (cc)];
		
		c = merge_color(c1,c2, cc - floor(cc));
		
		//draw sprites
		if (i < (_steps * 0.25)){
			draw_sprite_general(spr,frame[i],0,0,16,16,draw_x[i],draw_y[i],1,1,angle[i],c,c,c,c,1);
		} else if (i  < _steps * 0.4){
			draw_sprite_general(spr,3,0,0,8,8,draw_x[i],draw_y[i],1,1,angle[i],c,c,c,c,1);
		} else {
			draw_sprite_general(spr,4,0,0,8,8,draw_x[i],draw_y[i],1,1,angle[i],c,c,c,c,1);
		}
		i++;
	}
	surface_reset_target();
} else {
	if (!coord_outside_view(x,y,width)) draw_surface(my_surface, x - x_origin, y - y_origin);
}