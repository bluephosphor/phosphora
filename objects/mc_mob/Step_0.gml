event_inherited();

if (hitlag != 0) hitlag = approach(hitlag, 0, 1);

if (show_hp){
	draw_alpha = approach(draw_alpha,1,0.1);
} else if (draw_alpha > 0) {
	draw_alpha = approach(draw_alpha,0,0.05);
} else {
	hp_change = 0;
	draw_color = c_white;
}

if(global.time_pause) or (hitlag > 0) {alarm[10] = anim_speed; exit;}

switch(mystate){
	case mobstate.passive:
		check_death();
		event_perform(ev_other,ev_user0);
		break;
	case mobstate.alert:
		event_perform(ev_other,ev_user1);
		break;
	case mobstate.aggro:
		event_perform(ev_other,ev_user2);
		break;
	case mobstate.hitstun:
		event_perform(ev_other,ev_user3);
		break;
	case mobstate.interact:
		event_perform(ev_other,ev_user4);
		break;
	case mobstate.block:
		event_perform(ev_other,ev_user5);
		break;
}