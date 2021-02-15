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
effect_data[effect.haste]	= { name: "Haste", affects: [stat.max_spd, stat.accel]};
effect_data[effect.slow]	= { name: "Slow" , affects: [stat.max_spd, stat.accel]};
effect_data[effect.poison]	= { name: "Poison" };
effect_data[effect.regen]	= { name: "Regeneration" };
effect_data[effect.nvision] = { name: "Night Vision" };
effect_data[effect.dark]	= { name: "Darkness" };
effect_data[effect.glow]	= { name: "Glow" };
effect_data[effect.slip]	= { name: "Slip" };
effect_data[effect.weak]	= { name: "Weak" };

function timer(seconds) constructor{
	total_frames = seconds * 60;
	timer_string = "";
	update = function(){
		seconds = floor(total_frames mod 60);
		minutes = (seconds > 60) ? floor(seconds mod 60) : 0;
		hours   = (minutes > 60) ? floor(minutes mod 60) : 0;
		timer_string = string(hours) + ":" + string(minutes) + ":" + string(seconds);
		total_frames--;
		return (total_frames <= 0);
	}
}

function effect_apply(index,level,entity,seconds){
	
	array_push(affected, {id: entity, effect: index, duration: new timer(seconds)});
	
	with (entity) switch(index){
		case effect.slow:
			max_speed    = max_speed    / (level+1);
			acceleration = acceleration / (level+1);
			break;
	}
}

function effects_update(entity){
	var _change = false;
		var _array = [];
	var i = 0, j = 0; repeat(array_length(affected)){
		
		var _finished = affected[i].duration.update();
		
		if (_finished) {
			_change = true;
			with (affected[i].id){
				
			}
			delete affected[i];
		} else _array[j++] = affected[i];
		
		i++;
	}
	if (_change) affected = _array;
}