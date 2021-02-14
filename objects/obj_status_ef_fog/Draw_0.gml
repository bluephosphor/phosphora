if (from_bullet) draw_sprite_ext(spr_shrub_bullet,2,xstart,ystart,2,1,0,c_white,(state == 1) ? image_alpha : 1);
gpu_set_blendmode(bm_add);
draw_self();
gpu_set_blendmode(bm_normal);