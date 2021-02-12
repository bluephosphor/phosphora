///@description reset passive
if (mystate != mobstate.passive){ 
	next_anim = passive_frames;
	anim_speed = 4;
	mystate = mobstate.passive;
}
image_blend = c_white;
xmove = 0;
ymove = 0;