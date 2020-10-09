///@description reset passive
if (mystate != mobstate.passive){ 
	current_anim = passive_frames;
	anim_speed = 10;
	mystate = mobstate.passive;
}
image_blend = c_white;
xmove = 0;
ymove = 0;
update_movement = true;