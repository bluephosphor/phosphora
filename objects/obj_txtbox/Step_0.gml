///get input
in_interact = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);

if (char_index < string_length(dialog[line_index, 1]) + 1){
	if (typebuffer > 0) {typebuffer -= 1;}
	else {
		///pause on punctuation
		switch(string_char_at(string_wrapped, char_index)){
			case ",": typebuffer = 15; playsound = false; break;
			case ".":
			case "?":
			case "!": typebuffer = 25; playsound = false; break;
			default:  
			typebuffer = typespeed; 
			if (!playsound){
				playsound = true;
				voicecounter = (voicemod - 1);
			}
			break;
		}
		///scroll text
		current_string += string_char_at(string_wrapped, char_index++);
	}
	///play sound
	if (voicecounter < voicemod) {voicecounter++;}
	else{
		if (playsound) && (!disablesound){
			//audio_play_sound(current_voice,10,false);
		}
		voicecounter = 0;
	}
	///text skipping
	if (in_interact) && (char_index > 2){
		current_string = string_wrapped;
		char_index = string_length(dialog[line_index, 1]) + 1;
	}
} else {
	///advance to next string or close textbox
	typebuffer = 0;
	if (in_interact) {
		line_index++;
		current_string = "";
		char_index	= 1;
		run_scr = true;
		voicecounter = (voicemod - 1);
		if (line_index == lines){
			instance_destroy(self);
			global.actionable = true;
			o_player.spin_cooldown = 1;
		}
	}
}