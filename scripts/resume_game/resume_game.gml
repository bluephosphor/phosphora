function resume_game() {
	debug_log_add("resume game");
	gamestate = INGAME;
	global.time_pause = false;
	o_player.spin_cooldown = 1;
}