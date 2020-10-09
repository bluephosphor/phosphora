tb_width = global.view_width - 32;
tb_height = 0;
x_origin = 16;
y_origin = 16;

text_xo = x_origin + 8;
text_yo = y_origin + 8;

spr_blinker = spr_txtbox_blinker;

run_scr = true;

dialog[0, 0] = -1; // Speaker
dialog[0, 1] = "" ; // Convo Dialog

voicemod = 4;
voicecounter = (voicemod - 1);
playsound = true;
disablesound = true;
drawbox = true;
font = font_main;
text_color = c_white;
current_voice = -1;

text_max_width = tb_width - 16;

typebuffer = 0;
typespeed = 1;

depth -= 10;

lines = 0; // Number of Lines in a specific conversaion
line_index		 = 0; // Current index towards our lines
current_string  = ""; // Converstion line to display
string_wrapped  = ""; // Wrapped convo line returned from string_wrap
char_index	 = 0; // Current Character Index of string to apply to current_string