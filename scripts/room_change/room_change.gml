///@arg room

global.actionable = false;
check_inv(inventory,item.rift_a,true);
check_inv(inventory,item.rift_b,true);
check_inv(inventory,item.rift_c,true);
obj_game.target_room = argument0;
obj_game.room_transition = true;
with(cont_audio){
	audio_sound_gain(bgm,0,1000);
}