if (item_num == -1){	//draw coin
	var yy = 32 * coin_type;
	draw_sprite_part(spr_coins,-1,0,yy,spr_wid,32,x - (spr_wid / 2),y - 27);
} else {				//draw item
	draw_sprite(spr_items,item_num,x,y);
}