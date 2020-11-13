function string_value(value){
	var _log = undefined;
	
	if (value == "true") return true;
	else if (value == "false") return false;
	else {
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
	var _id = o_player.id;
	var value = string_value(args[2])
	variable_instance_set(_id,args[1],value);
	return "player." + args[1] + " set to: " + args[2];
}

function sh_fullscreen(args){
	global.fullscreen = string_value(args[1]);
	change_window_mode(global.fullscreen);
	return "fullscreen mode set to: " + args[1];
}

function sh_sethour(args){
	var hour = string_value(args[1]);
	obj_daycycle.seconds = (hour * 60) * 60;
	return "set hour of the day to: " + args[1];
}

function sh_goto(args){
	var i = 0; repeat(ds_grid_height(room_data)){
		if (room_data[# rm.name, i] == args[1]){
			room_change(i);
			return "going to: " + args[1] + "...";
			break;
		}
		i++;
	}
	return "did not find room named: " + args[1] + "...";
}

function sh_give(args){
	var str = args[1];
	var first_letter = string_upper(string_copy(str,1,1));
	var str = first_letter + string_copy(str,2,string_length(str) - 1);
	var quant = 1; 
	var s = "";
	if (array_length(args) > 2) {quant = args[2]; s = "s";}
	var i = 0; repeat (ds_grid_height(item_info)){
		if (item_info[# ITEM, i] == str){
			add_item(inventory,i,quant);
			return "gave " + string(quant) + " " + args[1] + s + " to " + player_data[? stat.name] + ".";
			break;
		}
		i++;
	}
	return "did not find item named: " + args[1] + "...";
}