///@description reset passive
if (mystate != mobstate.passive){ 
	current_anim = passive_frames;
	anim_speed = 25;
	mystate = mobstate.passive;
	substate = 0;
}
image_blend = c_white;
xmove = 0;
ymove = 0;
update_movement = true;