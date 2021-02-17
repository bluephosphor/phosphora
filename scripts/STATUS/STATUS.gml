enum effect {
	none,
	haste,
	slow,
	poison,
	regen,
	nvision,
	dark,
	glow,
	slip,
	buff,
	weak,
	total
}

globalvar effect_data, affected;
affected = [];

effect_data[effect.none]	= { name: "None" };

effect_data[effect.haste]	= { 
	name: "Haste",		  
	affects: [stat.max_spd, stat.accel],
	overrides: [effect.slow],
	start_method: function(id,level){
		with(id){
			max_speed    = mob_data[# mob_id, stat.max_spd] + level;
			acceleration = mob_data[# mob_id, stat.accel]   + (level / 10);
		}
	}
};

effect_data[effect.slow]	= { 
	name: "Slow" ,		  
	affects: [stat.max_spd, stat.accel],
	overrides: [effect.haste],
	start_method: function(id,level){
		with(id){
			max_speed    = mob_data[# mob_id, stat.max_spd] / (level+1);
			acceleration = mob_data[# mob_id, stat.accel]   / (level+1);
		}
	}
};

effect_data[effect.poison]	= { 
	name: "Poison",		  
	affects: [stat.special],
	overrides: [effect.regen],
	update_method: function(id,level){
		with (id){
			switch(object_index){
				case obj_player:
					var _last_hp = floor(player_health);
					player_health = clamp(player_health - level * 0.01,0,mob_data[# mob_id, stat.hp]);
					if (floor(player_health) != _last_hp){
						if (sign(hp_change) == 1) hp_change = 0;
						hp_change += floor(player_health) - _last_hp;
						show_hp = true;
						alarm[1] = room_speed;
					}
					break;
				default:
					var _last_hp = floor(hp);
					hp = clamp(hp - level * 0.01,0,mob_data[# mob_id, stat.hp]);
					if (floor(hp) != _last_hp){
						if (sign(hp_change) == 1) hp_change = 0;
						hp_change += floor(hp) - _last_hp;
						show_hp = true;
						alarm[1] = room_speed;
					}
					break;
			}
		}
	}
};

effect_data[effect.regen]	= { 
	name: "Regeneration", 
	affects: [stat.special],
	overrides: [effect.poison],
	update_method: function(id,level){
		with (id){
			switch(object_index){
				case obj_player:
					var _last_hp = floor(player_health);
					player_health = clamp(player_health + level * 0.01,0,mob_data[# mob_id, stat.hp]);
					if (floor(player_health) != _last_hp){
						if (sign(hp_change) == -1) hp_change = 0;
						hp_change += floor(player_health) - _last_hp;
						show_hp = true;
						alarm[1] = room_speed;
					}
					break;
				default:
					var _last_hp = floor(hp);
					hp = clamp(hp + level * 0.01,0,mob_data[# mob_id, stat.hp]);
					if (floor(hp) != _last_hp){
						if (sign(hp_change) == -1) hp_change = 0;
						hp_change += floor(hp) - _last_hp;
						show_hp = true;
						alarm[1] = room_speed;
					}
					break;
			}
		}
	}
};

effect_data[effect.nvision] = { 
	name: "Night Vision", 
	affects: [stat.special],
}; 

effect_data[effect.dark]	= { 
	name: "Darkness",	  
	affects: [stat.special],
};

effect_data[effect.glow]	= { 
	name: "Glow",		  
	affects: [stat.special],
	
	start_method: function(id,level){
		with (id) {
			if (my_light != noone) return;
			effect_light = instance_create_layer(x,y,"Instances",mc_lightsource);
			with (effect_light){
				draw_strength = 0;
				light_strength = clamp(level / 2,0.1,1);
				light_size = level;
				follow = id;
				light_offset.y -= sprite_get_height(id.sprite_index) / 2;
			}
		}
	},
	
	end_method: function(id){
		with (id) {
			effect_light.state = light.fade;
			effect_light = noone;
		}
	}
	
};

effect_data[effect.slip]	= { 
	name: "Slip",		  
	affects: [stat.fric],
	start_method: function(id,level){
		with(id){
			frict = mob_data[# mob_id, stat.fric] / (level+1);
		}
	}
};

effect_data[effect.buff]	= { 
	name: "Buff",		  
	affects: [stat.attack,stat.defense],
	overrides: [effect.weak],
	start_method: function(id,level){
		with(id){
			attack  = mob_data[# mob_id, stat.attack]  + level;
			defense = mob_data[# mob_id, stat.defense] + level;
		}
	}
};

effect_data[effect.weak]	= { 
	name: "Weak",		  
	affects: [stat.attack,stat.defense],
	overrides: [effect.buff],
	start_method: function(id,level){
		with(id){
			attack  = mob_data[# mob_id, stat.attack]  - level;
			defense = mob_data[# mob_id, stat.defense] - level;
		}
	}
};

function effects_clear(entity,index){
	if (index == all) {
		entity.stats_reset();
	} else {
		var _obj = effect_data[index]
		var _arr = _obj.affects;
		with (entity) var i = 0; repeat(array_length(_arr)){
			switch(_arr[i]){
				case stat.attack:	 attack		  = mob_data[# mob_id, stat.attack];	break;
				case stat.defense:	 defense	  = mob_data[# mob_id, stat.defense];	break;
				case stat.sp_attack: sp_attack	  = mob_data[# mob_id, stat.sp_attack];	break;
				case stat.max_spd:	 max_speed	  = mob_data[# mob_id, stat.max_spd];	break;
				case stat.fric:		 frict		  = mob_data[# mob_id, stat.fric];		break;
				case stat.accel:	 acceleration = mob_data[# mob_id, stat.accel];		break;
				case stat.special:	 
					status = effect.none;
					if (variable_struct_exists(_obj,"end_method")) _obj.end_method(entity);
					break;
			}
			i++;
		}
	}
}


function time_tostring(seconds){
	var _minutes = ( seconds >= 60) ? floor( seconds / 60) : 0;
	var _hours   = (_minutes >= 60) ? floor(_minutes / 60) : 0;
	var _seczero = ( seconds mod 60 < 10) ? "0":"";
	var _minzero = (_minutes mod 60 < 10) ? "0":"";
	var _hours   = (_minutes > 60) ? string(_hours) + ":" : "" ;
	
	return _hours + _minzero + string(_minutes mod 60) + ":" + _seczero + string(seconds mod 60);
}

function timer(seconds) constructor {
	total_frames = seconds * 60;
	timer_string = "";
	update = function(){
		seconds = floor(total_frames / 60);
		timer_string = time_tostring(seconds);
		 if (!global.time_pause) total_frames--;
		return (total_frames <= 0);
	}
}


function effect_apply(index,level,entity,seconds){
	if (entity.status == index) return;
	
	entity.status = index;
	//              ^ make this into an array of statuseus later, have each entity run their own clock!
	array_push(affected, {id: entity, effect: index, lv: level, duration: new timer(seconds)});
	var _obj = effect_data[index];
	
	//end effects that conflict/overrite
	if (variable_struct_exists(_obj,"overrides")){
		var _change;
		var _array = [];
		var i = 0, j = 0; repeat(array_length(affected)){
			_change = false;
			repeat(array_length(_obj.overrides)){
				if (affected[i].effect == _obj.overrides[j]) {
					_change = true;
					with (affected[i].id){
						status = effect.none;
						effects_clear(entity,_obj.overrides[j]);
					}
				}
				j++;
			}
			if (!_change) array_push(_array,affected[i]);
			i++;
		}
		affected = _array;
	}
	
	with (entity) {
		if (variable_struct_exists(_obj,"start_method")) _obj.start_method(entity,level);
	}
}

function effects_update(){
	var _change = false;
	var _array = [];
	var i = 0, j = 0; repeat(array_length(affected)){
		
		var _obj = effect_data[affected[i].effect];
		if (variable_struct_exists(_obj,"update_method")) _obj.update_method(affected[i].id,affected[i].lv);
		
		var _finished = affected[i].duration.update();
		
		if (_finished) {
			_change = true;
			with (affected[i].id){
				status = effect.none;
				effects_clear(id, affected[i].effect);
			}
			delete affected[i];
		} else _array[j++] = affected[i];
		
		i++;
	}
	if (_change) affected = _array;
}

function dec_to_roman(num){
	//  Returns a string of Roman numerals representing the given integer.
	//
	//  num = positive integer less than 5000, real
	//
	//  GMLscripts.com/license
	var roman;
	if ((num < 1) || (num > 4999)) return "";
	roman  = string_copy("    M   MM  MMM MMMM",4*(num div 1000)+1,4);
	roman += string_copy("    C   CC  CCC CD  D   DC  DCC DCCCCM  ",4*((num mod 1000) div 100)+1,4);
	roman += string_copy("    X   XX  XXX XL  L   LX  LXX LXXXXC  ",4*((num mod 100) div 10)+1,4);
	roman += string_copy("    I   II  III IV  V   VI  VII VIIIIX  ",4*(num mod 10)+1,4);
	roman  = string_replace_all(roman," ","");
	return roman;
}