/// @description check time of day

alarm[0] = room_speed;

if (!global.playmusic) exit;

index = room_data[# rm.bgm, room];

if (room_data[# rm.bgm2, room] != -1){
	var pha = check_phase();
	if (pha != phase.daytime) {
		index = room_data[# rm.bgm2, room];
	}
}

if (current_song != index) {

	if (bgm != -1) audio_sound_gain(bgm,0,5000);

	current_song	= index;
	intro_len		= music_data[# current_song, track.intro_length];
	loop_len		= music_data[# current_song, track.loop_length];
	
	do_transition = true;
}

if (!do_transition) exit;

if (bgm == -1) or (audio_sound_get_gain(bgm) == 0){
	if (intro_len != -1){
		special_loop = true;
		total_length = intro_len + loop_len;
		bgm = audio_play_sound(current_song,10,false);
		audio_sound_gain(bgm,1,1);
	} else {
		special_loop = false;
		bgm = audio_play_sound(current_song,10,true);
		audio_sound_gain(bgm,1,1);
	}
	do_transition = false;
}