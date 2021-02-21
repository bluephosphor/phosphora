enum spell {
	init,
	standby,
	cast,
	finish
}

spelltype = item.none;

light_inst = -1;
state = spell.init;
item_consume = false;

show_debug_message("my instance_id is: " + string(id));