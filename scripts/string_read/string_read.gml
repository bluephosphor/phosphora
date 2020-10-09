///@description string_read
///@arg string
function string_read(argument0) {

	/*
	this is a poorly named script but what it essentially does is it iterates through the 
	string and surgically removes the bbcode tags used for formatting scribble text lines 
	so that we can do things like determine the width and find the position of a character 
	seperately while not messing too much with the dark evil magic that is scribble text
	*/

	var str = argument0; var flag = false;

	do {
	
		var str_len = string_length(str);
		var count = 1;
		var range_start = undefined, range_end = undefined;

		repeat(str_len){
			if (string_char_at(str, count) == "[") {range_start = count;}
			if (range_start != undefined){
				if(string_char_at(str, count) == "]") {
					range_end = (count - range_start) + 1; 
					break;
				}
			}
			count++;
		}
	
		if (range_start != undefined)	str  = string_delete(str,range_start,range_end);
		else							flag = true;

	} until (flag == true)

	return str;


}
