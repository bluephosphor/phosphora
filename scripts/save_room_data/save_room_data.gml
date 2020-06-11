//var filename = room_data[# rm.name, room] + "_" + string(global.seed) + ".map";
var _filename = "lvltest.map";
var _map = ds_map_create();


//saving dimensions and grid
_map[? "mapdata"]	= ds_grid_write(grid_);
_map[? "width"]		= o_level.width_;
_map[? "height"]	= o_level.height_;

var i, _submap;

//saving chests
i = 0; with (obj_chest){
	_submap = -1;
	_submap = ds_map_create();
	_submap[? "x"] = x;
	_submap[? "y"] = y;
	_submap[? "inventory"] = ds_grid_write(chest_inventory);
	_map[? "chest_" + string(i)] = json_encode(_submap);
	ds_map_destroy(_submap);
	i++;
}
_map[? "chest_count"] = i;

//saving trees
i = 0; with (obj_tree){
	_submap = -1;
	_submap = ds_map_create();
	_submap[? "x"] = x;
	_submap[? "y"] = y;
	_submap[? "image_xscale"] = image_xscale;
	_map[? "tree_" + string(i)] = json_encode(_submap);
	ds_map_destroy(_submap);
	i++;
}
_map[? "tree_count"] = i;

//saving scenery
i = 0; with (obj_scenery_item){
	_submap = -1;
	_submap = ds_map_create();
	_submap[? "x"] = x;
	_submap[? "y"] = y;
	_submap[? "frame"] = frame;
	_submap[? "facing"] = facing;
	_map[? "scenery_" + string(i)] = json_encode(_submap);
	ds_map_destroy(_submap);
	i++;
}
_map[? "scenery_count"] = i;

var _json = json_encode(_map);
var _file = file_text_open_write(_filename);
file_text_write_string(_file,_json);
file_text_close(_file);

ds_map_destroy(_map);

global.pause = false;
o_player.spin_cooldown = 1;

add_dialog(-1, "file '" + _filename + "' saved.");
