if (active){
	if (place_meeting(x,y,o_player)){
		room_change(target_room);
		active = false;
	}
}