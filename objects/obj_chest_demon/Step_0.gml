in_trade_item = keyboard_check_pressed(ord("Z"));

if (show_inventory){
	if (in_trade_item) or (keyboard_check_pressed(ord("X"))){
		show_inventory = false;
		instance_create_layer(x,y,"Instances",obj_mob_chest);
		input_buffer = 10;
		instance_destroy();
	}
}

