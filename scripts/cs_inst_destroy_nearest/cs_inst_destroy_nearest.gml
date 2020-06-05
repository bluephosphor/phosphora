///@description cs_inst_destroy_nearest
///@arg x
///@arg y
///@arg id

var inst = instance_nearest(argument0,argument1,argument2);

with(inst){
	instance_destroy();
}

cs_end_action();