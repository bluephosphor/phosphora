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

function sh_time(args){
	switch(args[1]){
		case "set":
			var hour = 0;
			switch(args[2]){
				case "day":
					hour = 12;
					break;
				case "night":
					hour = 0;
					break;
				case "morning":
					hour = 7;
					break;
				case "evening":
					hour = 16;
					break;
				case "dusk":
					hour = 18;
					break;
				default:
					hour = string_value(args[2]);
					break;
				
			}
			if (!is_real(hour)){
				return args[2] + " is not a valid subcommand.";
			}
			obj_daycycle.seconds = (hour * 60) * 60;
			return "set hour of the day to: " + args[2];
			break;
		default:
			return args[1] + " is not a valid subcommand.";
	}
	
}

function sh_season(args){
	var set = -1;
	switch(args[1]){
		case "summer":
			set = SUMMER;
			break;
		case "fall":
			set = AUTUMN;
			break;
		case "autumn":
			set = AUTUMN;
			break;
		case "winter":
			set = WINTER;
			break;
		case "spring":
			set = SPRING;
			break;
	}
	if (set != -1){
		season = set;
		with (obj_game) {
			if (room_data[# rm.tree_overcast, room]) init_tree_patterns();
		}
		if (instance_exists(obj_mob_shrubbie)) with (obj_mob_shrubbie) set_colors();
		if (instance_exists(obj_tree)) with (obj_tree) {
			if (surface_exists(my_surface)) surface_free(my_surface);
			event_perform(ev_create,0);
		}
	} else {
		return args[1] + " is not a valid subcommand.";
	}
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
			return "gave " + string(quant) + " " + args[1] + s + " to " + mob_data[# mob.player, stat.name] + ".";
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
						xspeed = random_range(-1,1);
						yspeed = random_range(-1,1);
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

function sh_fps(args) {
	room_speed = string_value(args[1]);
}

function sh_effect(args){
	var _eff = string_replace_all(args[1],"_", " ");
	var i = 0; repeat(array_length(effect_data)){
		if (string_lower(effect_data[i].name) == _eff){
			effect_apply(i,string_value(args[2]),player_inst,string_value(args[3]));
			return "applied " + args[1] + " effect to player for " + args[3] + " seconds";
		}
		i++;
	}
	return "did not find effect named: " + args[1] + "...";
}