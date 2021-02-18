if (item_num == -1){	//draw coin
	var yy = 32 * coin_type;
	draw_sprite_part(spr_coins,-1,0,yy,spr_wid,32,x - (spr_wid / 2),y - 27);
} else {				//draw item
	var yy = 8 + wave(-2,2,1,0);
	
	draw_sprite_ext(spr_entity_shadow,0,x,y,1-(yy*0.02),1-(yy*0.02),0,c_white,0.5);
	
	draw_sprite(spr_items,item_num,x-8,y-8-yy);
}