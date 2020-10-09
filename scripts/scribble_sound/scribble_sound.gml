function scribble_sound(argument0, argument1) {
	// @description scribble_sound
	/// @param element
	/// @param parameterArray
    
	var _element = argument0; //Not used but good practice to label it
	var _parameter_array = argument1;
	var _str = _parameter_array[0];
	var _sound = undefined;

	switch(_str){
		case "laugh": _sound = snd_ghostlaugh; break;
		case "secret": _sound = snd_secret; break;
	}

	if (_sound == undefined) exit;
	audio_play_sound(_sound,10,false);


}
