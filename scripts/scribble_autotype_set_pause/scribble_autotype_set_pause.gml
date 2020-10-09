/// @param textElement   Text element to target. This element must have been created previously by scribble_draw()
/// @param state         Value to set for the pause state, true or false
function scribble_autotype_set_pause(argument0, argument1) {

	var _scribble_array = argument0;
	var _state          = argument1;

	//Check if this array is a relevant text element
	if (!is_array(_scribble_array)
	|| (array_length_1d(_scribble_array) != __SCRIBBLE.__SIZE)
	|| (_scribble_array[__SCRIBBLE.VERSION] != __SCRIBBLE_VERSION))
	{
	    if (SCRIBBLE_VERBOSE) show_debug_message("Scribble: Array passed to scribble_autotype_set_pause() is not a valid Scribble text element");
	    return false;
	}

	if (_scribble_array[__SCRIBBLE.FREED]) return false;

	_scribble_array[@ __SCRIBBLE.AUTOTYPE_PAUSED] = _state;


}
