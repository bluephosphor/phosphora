///@description reset state
if (mystate != mobstate.aggro){ 
	current_anim = passive_frames;
	anim_speed = 5;
	mystate = mobstate.aggro;
}
image_blend = c_white;
xmove = 0;
ymove = 0;
update_movement = true;