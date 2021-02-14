///@description reset passive
check_death();

if (mystate != mobstate.aggro){ 
	next_anim = aggro_frames;
	anim_speed = 4;
	if (substate == 2) substate = 0;
	mystate = mobstate.aggro;
} else {
	next_anim = passive_frames;
	anim_speed = 4;
	mystate = mobstate.passive;
}
image_blend = c_white;
xmove = 0;
ymove = 0;