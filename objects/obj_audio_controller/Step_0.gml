if (!special_loop) exit; 

var pos = audio_sound_get_track_position(bgm);

if (pos > total_length){
	audio_pause_sound(bgm);
	audio_sound_set_track_position(bgm,pos - loop_len);
	audio_resume_sound(bgm);
}