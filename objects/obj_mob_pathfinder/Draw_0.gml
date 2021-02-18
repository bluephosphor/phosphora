draw_sprite_ext(spr_entity_shadow, 0, x, y+1, 1, -.75, 0, c_white, .5);
draw_self();
if (in_cell == WATER) draw_sprite(spr_minky,5 + frame_index,x,y+1);

draw_path(path,x,y,true);