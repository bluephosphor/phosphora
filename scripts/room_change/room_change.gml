///@desc room_change(room,[LOAD_MAP])
///@arg room

#macro LOAD_MAP true

global.actionable = false;
if (argument_count > 1) global.load_map = argument[1];
check_inv(inventory,item.rift_a,true);
check_inv(inventory,item.rift_b,true);
check_inv(inventory,item.rift_c,true);
obj_game.target_room = argument[0];
obj_game.room_transition = true;
with(cont_audio){
	audio_sound_gain(bgm,0,1000);
}