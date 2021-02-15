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
	weak
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
effect_data[effect.glow]	= { name: "Glow",		  affects: [stat.special]};
effect_data[effect.slip]	= { name: "Slip",		  affects: [stat.accel,stat.fric]};
effect_data[effect.buff]	= { name: "Buff",		  affects: [stat.attack,stat.defense]};
effect_data[effect.weak]	= { name: "Weak",		  affects: [stat.attack,stat.defense]};

function effects_clear(entity,index){
	if (index == all) {
		entity.stats_reset();
	} else {
		var _arr = effect_data[index].affects;
		with (entity) var i = 0; repeat(array_length(_arr)){
			switch(_arr[i]){
				case stat.attack:	 attack		  = mob_data[# mob_id, stat.attack];	break;
				case stat.defense:	 defense	  = mob_data[# mob_id, stat.defense];	break;
				case stat.sp_attack: sp_attack	  = mob_data[# mob_id, stat.sp_attack];	break;
				case stat.max_spd:	 max_speed	  = mob_data[# mob_id, stat.max_spd];	break;
				case stat.fric:		 frict		  = mob_data[# mob_id, stat.fric];		break;
				case stat.accel:	 acceleration = mob_data[# mob_id, stat.accel];		break;
				case stat.special:	 status		  = effect.none;						break;
			}
			i++;
		}
	}
}


function timer(seconds) constructor{
	total_frames = seconds * 60;
	timer_string = "";
	update = function(){
		seconds = floor(total_frames / 60);
		minutes = (seconds > 60) ? floor(seconds / 60) : 0;
		hours   = (minutes > 60) ? floor(minutes / 60) : 0;
		var _seczero = (seconds < 10) ? "0":"";
		var _minzero = (minutes < 10) ? "0":"";
		var _hours   = (minutes > 60) ? string(hours) + ":" : "" ;
		timer_string = _hours + _minzero + string(minutes) + ":" + _seczero + string(seconds);
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
		case effect.slow:
			max_speed    = max_speed    / (level+1);
			acceleration = acceleration / (level+1);
			break;
	}
}

function effects_update(){
	var _change = false;
	var _array = [];
	var i = 0, j = 0; repeat(array_length(affected)){
		
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

function dec_to_roman(argument0){
	//  Returns a string of Roman numerals representing the given integer.
	//
	//      num         positive integer less than 5000, real
	//
	/// GMLscripts.com/license
	var roman;
	if ((argument0 < 1) || (argument0 > 4999)) return "";
	roman  = string_copy("    M   MM  MMM MMMM",4*(argument0 div 1000)+1,4);
	roman += string_copy("    C   CC  CCC CD  D   DC  DCC DCCCCM  ",4*((argument0 mod 1000) div 100)+1,4);
	roman += string_copy("    X   XX  XXX XL  L   LX  LXX LXXXXC  ",4*((argument0 mod 100) div 10)+1,4);
	roman += string_copy("    I   II  III IV  V   VI  VII VIIIIX  ",4*(argument0 mod 10)+1,4);
	roman  = string_replace_all(roman," ","");
	return roman;
}