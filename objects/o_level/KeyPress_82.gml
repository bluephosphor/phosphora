if (!global.debug) exit;
if (keyboard_check(vk_shift)) {
	audio_stop_all();
	game_restart();
}