if (active){
	if (place_meeting(x,y,o_player)){
		global.actionable = false;
		obj_game.target_room = target_room;
		obj_game.room_transition = true;
		with(cont_audio){
			audio_sound_gain(bgm,0,1000);
		}
		active = false;
	}
}