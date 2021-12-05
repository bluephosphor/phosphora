enum spell {
	init,
	standby,
	cast,
	finish
}

globalvar Spell; Spell = noone;

function cast_spell() {
	var _consumed_item = false;
	var _num = selected_item;
	
	if (Spell != noone) {
		with (Spell){
			if (spelltype == _num) {
				state = spell.cast;
				if (final) {
					_consumed_item = true;
					final = false;
				}
			}
		}
	} else {
		Spell = instance_create_layer(0,0,"Instances",obj_ps_controller); 
		with (Spell){
			spelltype = _num;
			state = spell.init;
		}
	}
	
	obj_player.spin_cooldown = 5;
	gamestate = INGAME;
	return _consumed_item;
}