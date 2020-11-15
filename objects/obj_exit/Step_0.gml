if (active){
	if (place_meeting(x,y,o_player)){
		room_trans(target_room);
		active = false;
	}
}