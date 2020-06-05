event_inherited();

if (hitlag != 0) hitlag = approach(hitlag, 0, 1);

if(global.pause) or (hitlag > 0) {image_speed = 0; exit;}

switch(playerstate){
	case p_state.normal:
	case p_state.swimming:
		event_perform(ev_other,ev_user0);
		break;
	case p_state.spin:
		event_perform(ev_other,ev_user1);
		break;
	case p_state.hitstun:
		event_perform(ev_other,ev_user2);
		break;
}

if (recovery_frames > 0){
	recovery_frames -=1;
	_visible = recovery_frames mod 4;
} else if (!_visible) _visible = true;

if (show_hp){
	draw_alpha = approach(draw_alpha,1,0.1);
} else if (draw_alpha > 0) {
	draw_alpha = approach(draw_alpha,0,0.05);
} else {
	hp_change = 0;
	draw_color = c_white;
}

var inst = instance_place(x,y,obj_item_entity);
if (inst != noone) with (inst){
	var value = coin_data[# 0, coin_type];
	global.player_coins += value;
	instance_destroy();
}

update_target();