function generate_from_map() {
	//get file
	var i, _submap, _sublist;
	var _string = load_json_from_file("lvltest.map");
	var _json = json_decode(_string);

	//room sizing
	_submap = -1;
	_submap = _json[? "map_data"];
	width_  = _submap[? "width"];
	height_ = _submap[? "height"];

	room_width = width_ * CELL_SIZE;
	room_height = height_ * CELL_SIZE;

	//set up the grid
	globalvar grid_;
	grid_ = ds_grid_create(width_,height_);

	//get map data
	ds_grid_read(grid_,_submap[? "grid"]);

	//get player info
	_submap = -1;
	_submap = _json[? "player_data"];
	var xx = _submap[? "x"];
	var yy = _submap[? "y"];
	var xs = _submap[? "image_xscale"];
	if (instance_exists(obj_player)) {
		obj_player.x = xx;
		obj_player.y = yy;
		image_xscale = xs;
	} else with (instance_create_layer(xx, yy, "Instances", obj_player)){
		player_inst = id;
		image_xscale = xs;
	};

	//get chest info
	_sublist = _json[? "chest_list"];
	i = 0; repeat(ds_list_size(_sublist)){
		_submap = -1;
		_submap = _sublist[| i];
		var xx = _submap[? "x"];
		var yy = _submap[? "y"];
		var obj = obj_chest; 
		if (_submap[? "special"]) obj = obj_chest_special;
		with (instance_create_layer(xx,yy,"Instances",obj)){
			obj_level.chests[obj_level.chest_index++] = id;
			ds_grid_read(chest_inventory,_submap[? "inventory"]);
		}
		i++;
	}

	_sublist = _json[? "tree_list"];
	i = 0; repeat(ds_list_size(_sublist)){
		_submap = -1;
		_submap = _sublist[| i];
		var xx = _submap[? "x"];
		var yy = _submap[? "y"];
		with (instance_create_layer(xx,yy,"Instances",obj_tree)){
			image_xscale = _submap[? "image_xscale"];
		}
		i++;
	}

	_sublist = _json[? "scenery_list"];
	i = 0; repeat(ds_list_size(_sublist)){
		_submap = -1;
		_submap = _sublist[| i];
		var xx = _submap[? "x"];
		var yy = _submap[? "y"];
		with (instance_create_layer(xx,yy,"Instances",obj_scenery_item)){
			frame  = _submap[? "frame"];
			facing = _submap[? "facing"];
			if (color != -1) image_blend = color;
		}
		i++;
	}

	ds_map_destroy(_json);

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_SIZE,CELL_SIZE);

	if (!instance_exists(obj_player)) spawn_player();

	if (layer_exists("Pebbles")){
	var _pebble_map_id = layer_tilemap_get_id("Pebbles");
		var num = min(room_width,room_height) / 2;
		repeat(num){
			var xx = irandom(room_width);
			var yy = irandom(room_height);
			var grid_x = xx div CELL_SIZE;
			var grid_y = yy div CELL_SIZE;
			if (grid_[# grid_x, grid_y] == FLOOR){
				tilemap_set(_pebble_map_id,choose(1,2),xx div 8,yy div 8);
			}
		}
	}

	update_tiles();


}
