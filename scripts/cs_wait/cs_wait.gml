///@descripion cutscene_wait
///@arg seconds

timer++;

if(timer >= argument0 * room_speed){
	timer = 0;
	cs_end_action();
}