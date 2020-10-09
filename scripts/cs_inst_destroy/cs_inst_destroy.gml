///@description cs_inst_destroy
///@arg id
function cs_inst_destroy(argument0) {

	with(argument0){
		instance_destroy();
	}

	cs_end_action();


}
