function generate_from_tiled(){
	//get file
	var _data = json_parse(load_json_from_file("world/testlevel.json"));
	
	//room sizing
	width_  = _data.width;
	height_ = _data.height;
	
	room_width  = (width_ + 4)  * CELL_SIZE;
	room_height = (height_ + 4) * CELL_SIZE;
	
	//set up the grid
	globalvar grid_;
	grid_ = ds_grid_create(width_+4,height_+4);
	ds_grid_clear(grid_,VOID);
	var _list = _data.layers[0].data;
	var i = 0; repeat(array_length(_list)){
		var _gx = i mod width_;
		var _gy = i div width_;
		grid_[# _gx+1,_gy+1] = _list[i]-1;
		//show_debug_message("writing to " + string(grid_) + ": x: " + string(_gx+1) + " y: " + string(_gy+1));
		i++;
	}
	
	//get object info
	_list = _data.layers[1].objects;
	var i = 0; repeat(array_length(_list)){
		var _px = _list[i].x + CELL_SIZE + 16;
		var _py = _list[i].y + CELL_SIZE + 16;
		switch(_list[i].name){
			case "PLAYER": 
				if (instance_exists(obj_player)) {
					obj_player.x = _px;
					obj_player.y = _py;
				} else instance_create_layer(_px, _py, "Instances", obj_player);
				break;
			case "CHEST": 
				var _sublist = _list[i].properties;
				var j = 0; repeat(array_length(_sublist)){
						switch(_sublist[j].name){
							case "inventory": 
								var _inventory_data = _sublist[j].value; 
								show_debug_message(_inventory_data);
								break;
						}
					j++;
				}
				chests[chest_index++] = instance_create_layer(_px,_py,"Instances", obj_chest);
				break;
		}
		i++;
	}
	
	//properties
	_list = _data.layers[1].properties;
	var i = 0; repeat(array_length(_list)){
		switch(_list[i].name){
			case "place_scenery":
				if (_list[i].value){
					var _xx, _yy, _place_object_odds = 50;
					_xx = 0; repeat(width_){
						_yy= 0; repeat(height_){
							if (grid_[# _xx,_yy] != VOID and !irandom((_place_object_odds))) {
								var _px = _xx * CELL_SIZE + 16;
								var _py = _yy * CELL_SIZE + 16;
								with (instance_create_layer(_px,_py,"Instances",obj_scenery_item)){
									event_perform(ev_other,ev_user0);
								}
							}
							_yy++;
						}
						_xx++;
					}
				}
				break;
		}
		i++;
	}

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_SIZE,CELL_SIZE);

	//pebbs
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