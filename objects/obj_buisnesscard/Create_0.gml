card_width = global.view_width / 2;
card_height = global.view_height / 2;
card_x = (global.view_width / 2) - card_width / 2;
card_y = (global.view_height / 2) - card_height / 2;

gamestate = DIALOGUE;

event_perform(ev_other,ev_user0);