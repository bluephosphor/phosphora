///@description cs_play_sound
///@arg soundid
///@arg priority
///@arg loops
function cs_play_sound(argument0, argument1, argument2) {

	audio_play_sound(argument0,argument1,argument2);
	cs_end_action();


}
