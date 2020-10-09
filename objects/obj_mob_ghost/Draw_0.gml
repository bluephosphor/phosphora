gpu_set_blendmode(bm_add);
var yo = wave(-1,1,1,0);
draw_sprite_ext(spr_ghost,image_index,x,y+yo,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
gpu_set_blendmode(bm_normal);
draw_sprite_ext(spr_ghost_lantern,image_index,x,y+yo,image_xscale,image_yscale,image_angle,c_white,1);