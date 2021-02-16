function cast_spell() {
	var consumed_item = false;
	var num = selected_item;
	if (instance_exists(obj_ps_controller)) {
		with (obj_ps_controller){
			if (spelltype == num) cast = true;
			
		}
		exit;
	}

	with instance_create_layer(0,0,"Instances",obj_ps_controller){
		spelltype = num;
	}
	obj_player.spin_cooldown = 5;
	gamestate = INGAME;
	return consumed_item;
}

function item_inst_create() {
	gamestate = INGAME;
	var inst;
	switch(selected_item){
		case item.card: inst = obj_buisnesscard; break;
	}
	instance_create_layer(0,0,"Instances",inst);

	return false;
}

function use_healingitem() {
	gamestate = INGAME;

	switch(selected_item){
		case item.r_potion: var heal_amt = irandom_range(10,20); break;
		case item.apple:	var heal_amt = irandom_range(5,7); break;
		case item.iqueur:	var heal_amt = irandom_range(-25,25); break;
		case item.p_shroom:	var heal_amt = irandom_range(5,40); break;
		default:			var heal_amt = 5; break;
	}

	var max_hp = mob_data[# mob.player, stat.hp];

	with (obj_player){
		player_health += heal_amt;
		player_health = clamp(player_health,0,max_hp);
		hp_change = heal_amt;
		show_hp = true;
		alarm[1] = room_speed;
	}
	return true;
}

function use_consumeable() {
	gamestate = INGAME;
	var _inflicts = inventory[# PROPERTIES, menu_index].inflicts;
	effect_apply(_inflicts.index, _inflicts.level, player_inst, _inflicts.duration);
	inventory[# PROPERTIES, menu_index] = 0;
	return true;
}

function usenote() {

	var len = array_length(notes) - 1;
	var index = irandom(len)
	var entry = notes[index];
	var lines = array_length(entry);

	var i = 0; repeat(lines){
		add_dialog(-1,entry[i]);
		i++;
	};

	return true;
}

function userift() {
	global.rift_count ++;

	switch(selected_item){
		case item.rift_a: cont_inv.has_rift[0] = true; break;
		case item.rift_b: cont_inv.has_rift[1] = true; break;
		case item.rift_c: cont_inv.has_rift[2] = true; break;
	}

	if (global.rift_count >= 3){
		global.rift_count = 0;
		var i = 0; repeat (3){
			has_rift[i] = false;
			i++;
		}
		room_trans(room);
	}
	return true;
}