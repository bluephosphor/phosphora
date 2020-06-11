//get file
var _file = file_text_open_read("lvltest.map");
var _str = file_text_read_string(_file);
var _json = json_decode(_str);

//room sizing
width_ = _json[? "width"];
height_ = _json[? "height"];

room_width = width_ * CELL_WIDTH;
room_height = height_ * CELL_HEIGHT;

// Set up the grid
globalvar grid_;
grid_ = ds_grid_create(width_,height_);

//get map data
ds_grid_read(grid_,_json[? "mapdata"]);

var i, _submap;
//get chest info
i = 0; repeat(_json[? "chest_count"]){
	_submap = -1;
	_submap = json_decode(_json[? "chest_" + string(i)]);
	var xx = _submap[? "x"];
	var yy = _submap[? "y"];
	with (instance_create_layer(xx,yy,"Instances",obj_chest)){
		o_level.chests[o_level.chest_index++] = id;
		ds_grid_read(chest_inventory,_submap[? "inventory"]);
	}
	ds_map_destroy(_submap);
	i++;
}

i = 0; repeat(_json[? "tree_count"]){
	_submap = -1;
	_submap = json_decode(_json[? "tree_" + string(i)]);
	var xx = _submap[? "x"];
	var yy = _submap[? "y"];
	with (instance_create_layer(xx,yy,"Instances",obj_tree)){
		image_xscale = _submap[? "image_xscale"];
	}
	ds_map_destroy(_submap);
	i++;
}

i = 0; repeat(_json[? "scenery_count"]){
	_submap = -1;
	_submap = json_decode(_json[? "scenery_" + string(i)]);
	var xx = _submap[? "x"];
	var yy = _submap[? "y"];
	with (instance_create_layer(xx,yy,"Instances",obj_scenery_item)){
		frame  = _submap[? "frame"];
		facing = _submap[? "facing"];
		if (color != -1) image_blend = color;
	}
	ds_map_destroy(_submap);
	i++;
}

ds_map_destroy(_json);

//init pathfinding grid
path_grid = mp_grid_create(0,0,width_,height_,CELL_WIDTH,CELL_HEIGHT);

if (!instance_exists(o_player)) spawn_player();

if (layer_exists("Pebbles")){
var _pebble_map_id = layer_tilemap_get_id("Pebbles");
	var num = min(room_width,room_height) / 2;
	repeat(num){
		var xx = irandom(room_width);
		var yy = irandom(room_height);
		var grid_x = xx div CELL_WIDTH;
		var grid_y = yy div CELL_HEIGHT;
		if (grid_[# grid_x, grid_y] == FLOOR){
			tilemap_set(_pebble_map_id,choose(1,2),xx div 8,yy div 8);
		}
	}
}

scr_update_tiles();