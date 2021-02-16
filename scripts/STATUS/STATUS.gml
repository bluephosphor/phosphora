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
effect_data[effect.haste]	= { name: "Haste",		  affects: [stat.max_spd, stat.accel]};
effect_data[effect.slow]	= { name: "Slow" ,		  affects: [stat.max_spd, stat.accel]};
effect_data[effect.poison]	= { name: "Poison",		  affects: [stat.special]};

effect_data[effect.regen]	= { name: "Regeneration", affects: [stat.special]};

effect_data[effect.nvision] = { name: "Night Vision", affects: [stat.special]}; 

effect_data[effect.dark]	= { name: "Darkness",	  affects: [stat.special]};

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

effect_data[effect.slip]	= { name: "Slip",		  affects: [stat.fric]};

effect_data[effect.buff]	= { name: "Buff",		  affects: [stat.attack,stat.defense]};

effect_data[effect.weak]	= { name: "Weak",		  affects: [stat.attack,stat.defense]};

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

function timer(seconds) constructor{
	total_frames = seconds * 60;
	timer_string = "";
	update = function(){
		seconds = floor(total_frames / 60);
		timer_string = time_tostring(seconds);
		total_frames--;
		return (total_frames <= 0);
	}
}


function effect_apply(index,level,entity,seconds){
	if (entity.status == index) return;
	
	entity.status = index;
	//              ^ make this into an array of statuseus later, have each entity run their own clock!
	array_push(affected, {id: entity, effect: index, lv: level, duration: new timer(seconds)});
	
	with (entity) switch(index){
		case effect.haste:
			max_speed    += level;
			acceleration += (level / 10);
			break;
		case effect.slow:
			max_speed    = max_speed    / (level+1);
			acceleration = acceleration / (level+1);
			break;
		case effect.buff:
			attack  += level;
			defense += level;
			break;
		case effect.weak:
			attack  -= level;
			defense -= level;
			break;
		case effect.slip:
			frict = frict / (level+1);
			break;
		default:
			var _obj = effect_data[index];
			if (variable_struct_exists(_obj,"start_method")) _obj.start_method(entity,level);
			break;
	}
}

function effects_update(){
	var _change = false;
	var _array = [];
	var i = 0, j = 0; repeat(array_length(affected)){
		
		var _obj = effect_data[affected[i].effect];
		if (variable_struct_exists(_obj,"update_method")) _obj.update_method(affected[i].id);
		
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
	//      num = positive integer less than 5000, real
	//
	/// GMLscripts.com/license
	var roman;
	if ((num < 1) || (num > 4999)) return "";
	roman  = string_copy("    M   MM  MMM MMMM",4*(num div 1000)+1,4);
	roman += string_copy("    C   CC  CCC CD  D   DC  DCC DCCCCM  ",4*((num mod 1000) div 100)+1,4);
	roman += string_copy("    X   XX  XXX XL  L   LX  LXX LXXXXC  ",4*((num mod 100) div 10)+1,4);
	roman += string_copy("    I   II  III IV  V   VI  VII VIIIIX  ",4*(num mod 10)+1,4);
	roman  = string_replace_all(roman," ","");
	return roman;
}