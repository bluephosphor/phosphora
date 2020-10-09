if (current_string == ""){
	var o = 12; 
	if (global.webmode) o = 16;
	string_wrapped = string_wrap(dialog[line_index, 1],text_max_width);
	tb_width = string_width(string_wrapped) + 16;
	tb_height = string_height(string_wrapped) + o;
}