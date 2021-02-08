function string_value(value){
	var _log = undefined;
	switch (value){
		case "true":
			return true;
		case "false":
			return false;
		default:
			try {
				value = real(value);
			} catch(_log) {
				debug_log_add(_log.message);
				return undefined;
			}
			if (_log == undefined) return value;
	}
}

function sh_helloworld(args){
	return "Hello " + args[1] + "!";
}

function sh_setglobal(args){
	var value = string_value(args[2])
	variable_global_set(args[1],value);
	return "global." + args[1] + " set to: " + args[2];
}

function sh_setplayer(args){
	var _id = obj_player.id;
	var value = string_value(args[2])
	variable_instance_set(_id,args[1],value);
	return "player." + args[1] + " set to: " + args[2];
}

function sh_fullscreen(args){
	global.fullscreen = (array_length(args) <= 1) ? !global.fullscreen : string_value(args[1]);
	change_window_mode(global.fullscreen);
	return "fullscreen mode toggled";
}

function sh_sethour(args){
	var hour = string_value(args[1]);
	obj_daycycle.seconds = (hour * 60) * 60;
	return "set hour of the day to: " + args[1];
}

function sh_goto(args){
	var i = 0; repeat(ds_grid_height(room_data)){
		if (string_lower(room_data[# rm.name, i]) == args[1]){
			room_trans(i);
			return "going to: " + args[1] + "...";
			break;
		}
		i++;
	}
	return "did not find room named: " + args[1] + "...";
}

function sh_reload(args){
	room_trans(room);
	gamestate = SHELL;
	return "regenerating current room...";
}

function sh_give(args){
	var str = string_replace_all(args[1],"_"," ");
	var quant = 1; 
	var s = "";
	if (array_length(args) > 2) {quant = args[2]; s = "s";}
	var i = 0; repeat (ds_grid_height(item_info)){
		if (string_lower(item_info[# ITEM, i]) == str){
			add_item(inventory,i,quant);
			return "gave " + string(quant) + " " + args[1] + s + " to " + player_data[| stat.name] + ".";
			break;
		}
		i++;
	}
	return "did not find item named: " + args[1] + "...";
}

function sh_spawn(args){
	var _spawn = string_replace_all(args[2],"_"," ");
	switch(args[1]){
		case "mob":
			var i = 0, curr_name; repeat(ds_grid_height(mob_data)){
				curr_name = mob_data[# i, stat.name];
				if ((is_string(curr_name)) and (string_lower(curr_name) == _spawn)){
					instance_create_layer(
						obj_player.x + (CELL_WIDTH * obj_player.image_xscale),
						obj_player.y,
						"Instances",
						mob_data[# i, stat.object]
					);
					return "spawned a " + args[2];
					break;
				}
				i++;
			}
			return "did not find mob named: " + args[2] + "...";
			break;
		case "item":
			var i = 0; repeat(ds_grid_height(item_info)){
				if (string_lower(item_info[# ITEM, i]) == _spawn){
					with (instance_create_layer(
						obj_player.x + (CELL_WIDTH * obj_player.image_xscale),
						obj_player.y,
						"Instances",
						obj_item_entity)){
						item_num = i;
						x_speed_ = random_range(-1,1);
						y_speed_ = random_range(-1,1);
					}
					return "spawned a " + args[2];
					break;
				}
				i++;
			}
			return "did not find item named: " + args[2] + "...";
			break;
		default:
			return "invalid type";
			break;
	}
}