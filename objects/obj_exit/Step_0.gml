if (active){
	if (place_meeting(x,y,obj_player)){
		room_trans(target_room);
		active = false;
	}
}