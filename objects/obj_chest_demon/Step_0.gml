in_trade_item = keyboard_check_pressed(ord("Z"));

if (show_inventory){
	if (in_trade_item) or (keyboard_check_pressed(ord("X"))){
		global.actionable = true;
		show_inventory = false;
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		with(o_player) inv_buffer = 10;
		instance_destroy();
	}
}

