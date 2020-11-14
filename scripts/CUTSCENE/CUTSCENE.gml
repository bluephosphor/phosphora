///CUTSCENE FUNCTIONS


///@description new_cutscene(scene_info)
///@arg scene_info
function new_cutscene(argument0) {

	if (cont_cutscene != noone) exit;

	with (instance_create_layer(0,0, layer, obj_cutscene)){
		cont_cutscene = id;
		scene_info = argument0;
		event_perform(ev_other, ev_user0);
	}
}

function cs_end_action() {
	scene++;

	if (scene > array_length(scene_info)-1){
		cont_cutscene = noone;
		instance_destroy();
		exit;
	}

	event_perform(ev_other, ev_user0);
}

///@description cs_change_variable
///@arg obj
///@arg var_name_as_string
///@value 
function cs_change_variable(argument0, argument1, argument2) {

	with (argument0){
		variable_instance_set(id,argument1,argument2);
	}

	cs_end_action();

}

///@description cs_change_xscale
///@arg obj_id
///@arg image_xscale
function cs_change_xscale() {

	var arg;
	var i = 0; repeat(argument_count){
		arg[i] = argument[i];
		i++;
	}

	if (argument_count > 1){
		with(arg[0]){
			image_xscale = arg[1];
		}
	} else {
		with(arg[0]){
			image_xscale = -image_xscale;
		}
	}

	cs_end_action();
}

///@description cs_add_dialog
///@arg speaker
///@arg str
function cs_add_dialog() {
	if (argument_count > 2){
		add_dialog(argument[0],argument[1], argument[2]);
	} else {
		add_dialog(argument[0],argument[1]);
	}
	cs_end_action();
}

///@description cs_end_dialog
function cs_end_dialog() {

	if (cont_textbox == noone){
		cs_end_action();
	}

}

///@description cs_instance_create
///@arg x
///@arg y
///@arg layer
///@arg object
function cs_inst_create(argument0, argument1, argument2, argument3) {
	var inst = instance_create_layer(argument0,argument1,argument2,argument3);
	cs_end_action();

	return inst;
}

///@description cs_inst_destroy
///@arg id
function cs_inst_destroy(argument0) {

	with(argument0){
		instance_destroy();
	}

	cs_end_action();
}

///@description cs_inst_destroy_nearest
///@arg x
///@arg y
///@arg id
function cs_inst_destroy_nearest(argument0, argument1, argument2) {

	var inst = instance_nearest(argument0,argument1,argument2);

	with(inst){
		instance_destroy();
	}

	cs_end_action();
}

///@description cs_move_obj
///@arg obj
///@arg x
///@arg y
///@arg relative?
///@arg spd
function cs_move_obj(argument0, argument1, argument2, argument3, argument4) {

	var obj = argument0, relative = argument3, spd = argument4;

	if (x_dest == -1){
		if (!relative){
			x_dest = argument1;
			y_dest = argument2;
		} else {
			x_dest = obj.x + argument1;
			y_dest = obj.y + argument2;
		}
	}

	var xx = x_dest;
	var yy = y_dest;

	with (obj){
		if (point_distance(x,y,xx,yy) >= spd ){
			var direc = point_direction(x,y, xx, yy);
			var ldirx = lengthdir_x(spd,direc);
			var ldiry = lengthdir_x(spd,direc);
		
			if (ldirx != 0) {image_xscale = sign(ldirx); }
		
			x += ldirx;
			y += ldiry;
		} else {
			x = xx;
			y = yy;
			with (other){
				x_dest = -1;
				y_dest = -1;
				cs_end_action();
			}
		}
	}
}

///@description cs_play_sound
///@arg soundid
///@arg priority
///@arg loops
function cs_play_sound(argument0, argument1, argument2) {

	audio_play_sound(argument0,argument1,argument2);
	cs_end_action();
}

///@descripion cutscene_wait
///@arg seconds
function cs_wait(argument0) {

	timer++;

	if(timer >= argument0 * room_speed){
		timer = 0;
		cs_end_action();
	}
}