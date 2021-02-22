///@description reset state
if (hp <= 0) {
	mystate = mobstate.passive; exit;
}

switch (mystate){
	case mobstate.block:
		mystate = mobstate.aggro;
		anim_speed = 5;
		current_anim = charge_frames[0];
		charge = 0;
		yspeed = 2;
		substate = 2;
	default:
		if (mystate != mobstate.aggro){ 
			current_anim = passive_frames;
			anim_speed = 5;
			mystate = mobstate.aggro;
		}
	break;
}


path_array = [];
curr_node = 0;
pathfinding = false;
image_blend = c_white;
xmove = 0;
ymove = 0;
update_movement = true;