tb_width	= global.view_width - 32;
tb_height	= 32;
x_origin	= 24;
y_origin	= 24;

dialog[0, 0] = -1;  // Speaker(sprite?)
dialog[0, 1] = "" ; // Dialogue(string)

branch = -1;
branch_index = 0;

text_max_width = tb_width - 16; scribble_draw_set_wrap(8,text_max_width);

lines		= 0;  // Number of Lines in a specific conversaion
line_index	= -1; // Current index towards our lines

depth -= 3000;

draw_box = true;
scribble_line	= -1;
textbox_dims	= -1;
line_skipped	= false;
autotype_spd	= 0.5;
str_pause		= 0;
pause_text		= true;

state	= 0;

line_to_draw	= "";
line_array		= -1;
question		= false;
menu_index		= 0;
entries			= 0;
longest_line	= 0;