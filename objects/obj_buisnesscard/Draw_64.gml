draw_set_color(c_white);
draw_rectangle(card_x,card_y,card_x + card_width, card_y + card_height,false);
draw_set_color(c_black);
draw_text(card_x + 4, card_y + 4, prefix + firstname + " " + lastname[0] + lastname[1]);
draw_text(card_x + 4, card_y + 32, business[0] + business[1] + " " + business[2]);
draw_set_color(c_white);