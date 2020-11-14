function scr_player_data() {
	globalvar player_data;
	globalvar player_health;
	globalvar player_coins;
	globalvar hp_draw_length;

	enum stat{
		object,
		name,
		info,
		hp,
		attack,
		defense,
		sp_attack,
		spawn_cell,
		enum_height,
	}

	player_data = ds_list_create();
	ds_collector_add(player_data);

	player_data[| stat.name]		= "Taako";
	player_data[| stat.hp]			= 50;
	player_data[| stat.attack]		= 2;
	player_data[| stat.defense]		= 1;
	player_data[| stat.sp_attack]	= 10;

	player_health = player_data[| stat.hp];
	player_coins = 0;
	hp_draw_length = 64;

}
