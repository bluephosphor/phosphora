function scr_cast_spell() {
	if (instance_exists(obj_ps_controller)) exit;

	var num = selected_item;
	with instance_create_layer(0,0,"Instances",obj_ps_controller){
		spelltype = num;
	}
	o_player.spin_cooldown = 5;
	show_inventory = false;
	global.actionable = true;


}
