if (draw_daylight){
	var cx = camera_get_view_x(view_camera[0]);
	var cy = camera_get_view_y(view_camera[0]);
	var c = light_color;
	gpu_set_blendmode(bm_add);
	draw_set_alpha(darkness);
	draw_rectangle_color(cx,cy,cx+global.view_width,cy+global.view_height,c,c,c,c,false);
	gpu_set_blendmode(bm_normal);
	draw_set_alpha(1);
}
