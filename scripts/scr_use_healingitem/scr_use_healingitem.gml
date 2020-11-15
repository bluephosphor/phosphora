function use_healingitem() {
	gamestate = INGAME;

	switch(selected_item){
		case item.r_potion: var heal_amt = irandom_range(10,20); break;
		case item.apple:	var heal_amt = irandom_range(5,7); break;
		case item.iqueur:	var heal_amt = irandom_range(-25,25); break;
		case item.p_shroom:	var heal_amt = irandom_range(5,40); break;
		default:			var heal_amt = 5; break;
	}

	var max_hp = player_data[| stat.hp];

	with (o_player){
		player_health += heal_amt;
		player_health = clamp(player_health,0,max_hp);
		hp_change = heal_amt;
		show_hp = true;
		alarm[1] = room_speed;
	}

}