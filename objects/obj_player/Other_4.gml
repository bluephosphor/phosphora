player_inst = id;

var _obj, _arr = [];
var i = 0; repeat(array_length(affected)){
	
	//if (object_index(affected[i].id) == obj_player) affected[i].id = player_inst;
	
	_obj = affected[i];
	
	if (instance_exists(_obj.id)) {
		array_push(_arr,_obj);
		if (variable_struct_exists(effect_data[_obj.effect],"start_method")) {
			effect_data[_obj.effect].start_method(_obj.id,_obj.lv);
		}
	}
	
	i++;
	
}

affected = _arr;