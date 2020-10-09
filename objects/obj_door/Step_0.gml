event_inherited();

if (!global.actionable) exit;

if (interact_state == INTERACTING){
	open = check_inv(inventory,item.key,true);
	if (!open){
		global.actionable = false;
		add_dialog(-1,"You do not have a [c_fuchsia]key[/c] for this door.");
	}
	interact_state = INTERACTABLE;
}

if (open){
	var ident = identifier;
	with(obj_door){
		if (identifier == ident) event_perform(ev_other,ev_user0); 
	}
}