///@description cs_change_variable
///@arg obj
///@arg var_name_as_string
///@value 
function cs_change_variable(argument0, argument1, argument2) {

	with (argument0){
		variable_instance_set(id,argument1,argument2);
	}

	cs_end_action();


}
