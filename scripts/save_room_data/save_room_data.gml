function save_room_data() {
	//var _filename = room_data[# rm.name, room] + "_" + string(global.seed) + ".map";
	var _filename = "lvltest.map";
	var _map = ds_map_create();
	var _submap, _sublist;

	//saving dimensions and grid
	_submap = -1;
	_submap = ds_map_create();
	_submap[? "grid"]	= ds_grid_write(grid_);
	_submap[? "width"]	= o_level.width_;
	_submap[? "height"]	= o_level.height_;
	ds_map_add_map(_map,"map_data",_submap);

	//saving player info
	with (o_player){
		_submap = -1;
		_submap = ds_map_create();
	
		_submap[? "x"] = x;
		_submap[? "y"] = y;
		_submap[? "image_xscale"] = image_xscale;
	}
	ds_map_add_map(_map,"player_data",_submap);

	//saving chests
	var _sublist = ds_list_create();
	with (obj_chest){
		_submap = -1;
		_submap = ds_map_create();
		ds_list_add(_sublist,_submap);
		ds_list_mark_as_map(_sublist,ds_list_size(_sublist)-1);
	
		_submap[? "special"] = (object_get_name(object_index) == "obj_chest_special");
		_submap[? "x"] = x;
		_submap[? "y"] = y;
		_submap[? "inventory"] = ds_grid_write(chest_inventory);
	}
	ds_map_add_list(_map,"chest_list",_sublist);

	//saving trees
	var _sublist = ds_list_create();
	with (obj_tree){
		_submap = -1;
		_submap = ds_map_create();
		ds_list_add(_sublist,_submap);
		ds_list_mark_as_map(_sublist,ds_list_size(_sublist)-1);
	
		_submap[? "x"] = x;
		_submap[? "y"] = y;
		_submap[? "image_xscale"] = image_xscale;
	}
	ds_map_add_list(_map,"tree_list",_sublist);

	//saving scenery
	var _sublist = ds_list_create();
	with (obj_scenery_item){
		_submap = -1;
		_submap = ds_map_create();
		ds_list_add(_sublist,_submap);
		ds_list_mark_as_map(_sublist,ds_list_size(_sublist)-1);
	
		_submap[? "x"] = x;
		_submap[? "y"] = y;
		_submap[? "frame"] = frame;
		_submap[? "facing"] = facing;
	}
	ds_map_add_list(_map,"scenery_list",_sublist);

	var _json = json_encode(_map);
	save_string_to_file(_filename,_json);
	ds_map_destroy(_map);

	global.pause = false;
	o_player.spin_cooldown = 1;

	add_dialog(-1, "file '" + _filename + "' saved.",tag.no_pause);



}
