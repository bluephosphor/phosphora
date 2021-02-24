/// @description return to normal state
switch(playerstate){
	case p_state.hitstun: recovery_frames = 60; break;
	case p_state.spin: spin_cooldown = 15; break;
}
spin_trail = [];
trail_i = 0;
image_blend = c_white;
sprite_index = s_player;
playerstate = p_state.normal;