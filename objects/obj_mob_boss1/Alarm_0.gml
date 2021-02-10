///@description reset state
switch (mystate){
	case mobstate.block:
		mystate = mobstate.aggro;
		anim_speed = 5;
		current_anim = charge_frames[0];
		charge = 0;
		y_speed_ = 2;
		substate = 2;
	default:
		if (mystate != mobstate.aggro){ 
			current_anim = passive_frames;
			anim_speed = 5;
			mystate = mobstate.aggro;
		}
	break;
}


image_blend = c_white;
xmove = 0;
ymove = 0;
update_movement = true;