///@descripion cutscene_wait
///@arg seconds
function cs_wait(argument0) {

	timer++;

	if(timer >= argument0 * room_speed){
		timer = 0;
		cs_end_action();
	}


}
