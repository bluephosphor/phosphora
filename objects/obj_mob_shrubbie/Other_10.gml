/// @description passive state
if (animation_ended) {
	alarm[10]  = irandom_range(200,500);
	image_xscale = (obj_player.x > x) ? 1 : -1;
	animation_ended = false;
}

if (frame_index > 2 and !coord_outside_view(x,y)){
	var _facing = (image_xscale == 1) ? 0 : 180;
	if (check_sight(x,y-16,_facing-detection_radius,_facing+detection_radius,10)) {
		target_cell = undefined;
		next_anim	= aggro_frames;
		substate	= 0;
		mystate		= mobstate.aggro;
	}
}

move_commit();
move_collide();