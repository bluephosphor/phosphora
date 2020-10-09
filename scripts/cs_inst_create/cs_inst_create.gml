///@description cs_instance_create
///@arg x
///@arg y
///@arg layer
///@arg object
function cs_inst_create(argument0, argument1, argument2, argument3) {
	var inst = instance_create_layer(argument0,argument1,argument2,argument3);
	cs_end_action();

	return inst;


}
