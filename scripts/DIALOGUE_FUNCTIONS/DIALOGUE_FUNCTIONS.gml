///@description add_dialog(speaker,dialog,[tag])
///@arg speaker
///@arg dialog string
enum tag {
	no_box,
	no_pause,
	no_reset
}

function add_dialog() {
	if (cont_textbox == noone){
		with (instance_create_layer(0,0,"Instances", obj_txtbox1)){
			cont_textbox = id;
			dialog[lines, 0]   = argument[0]; //speaker
			dialog[lines++, 1] = argument[1]; //dialog
			if (argument_count > 2){
				var i = 2; repeat(argument_count - i){
					switch(argument[i]){
						case tag.no_box:	draw_box	= false; break;
						case tag.no_pause:	pause_text	= false; break;
						case tag.no_reset:	reset_state = false; break;
					}
					i++;
				}
			}
			event_perform(ev_other,ev_user0);
		}
	} else {
		with (cont_textbox){
			dialog[lines, 0]   = argument[0]; //speaker
			dialog[lines++, 1] = argument[1]; //dialog
		}
	}
}

///@description add_dialog_branch
///@arg dialog_array_or_script
function add_dialog_branch(argument0) {

	with (cont_textbox){
		branch[branch_index++] = argument0;
	}
}

function load_dialog(file){
	with (instance_create_layer(0,0,"Instances", obj_txtbox1)){
		cont_textbox = id;
		var _data = csv_to_grid(file);
		var _height = ds_grid_height(_data);
		var _arr = undefined;
		var bi = 0;
		var last_id = 0;
		var i = 0; repeat(_height){
			var _type		= _data[# 0, i];
			var _text		= _data[# 1, i];
			var _speaker	= _data[# 2, i];
			var _portrait	= _data[# 3, i];
			var _sound		= _data[# 4, i];
			var _function	= _data[# 5, i];
			var _id			= _data[# 6, i];
		
			switch(_type){
				case "dialogue": 
					if (_id == 0) {
						dialog[lines, 0]	= _speaker;
						dialog[lines++, 1]  = _text; 
						if (lines == 1) event_perform(ev_other,ev_user0);
					} else {
						if (last_id != _id) bi = 0;
						branch[_id-1][bi++] = [_speaker,_text];
						last_id = _id;
					}
					break;
				case "question": 
					var _arr = array_create(1,_text); 
					branch = [];
					break;
				case "choice"  : 
					_arr[_id] = _text;
					if (_data[# 0, i+1] != "choice"){
						dialog[lines, 0]	= _speaker;
						dialog[lines++, 1]  = _arr; 
					}
					break;
			}
			i++;
		}
		ds_grid_destroy(_data);
	}
}