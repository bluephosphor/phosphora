draw_sprite_ext(spr_entity_shadow,0,x,y+6,2,1,0,c_white,0.5);
draw_sprite_ext(
	sprite_index,
	image_index,
	x, y-z,
	image_xscale,
	image_yscale,
	image_angle,
	image_blend,
	image_alpha
);

if (!global.debug) exit;

if (hitbox_active) draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,false);
draw_path(path,x,y,true);
pathfind_draw_points(path_array);