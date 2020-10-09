function scr_item_inst_create() {
	show_inventory = false;
	var inst;
	switch(selected_item){
		case item.card: inst = obj_buisnesscard; break;
	}
	instance_create_layer(0,0,"Instances",inst);


}
