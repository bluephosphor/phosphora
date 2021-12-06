if (global.debug) and (keyboard_check_pressed(ord("T"))) and (keyboard_check(vk_shift)){
	global.time_pause = !global.time_pause;
}

if (global.time_pause) exit;

//increment time
seconds += time_increment;
minutes = seconds / 60; //we're using / instead of div here to get the smooth drawing of
hours	= minutes / 60; //daylight transitions. may look into using seconds for this later

witching_hour = false;
if (hours > 0 and hours < 3) {
	witching_hour = true;
	var spawnpart = (seconds mod 6) == 0;
	with (obj_camera){
		var xx = irandom_range(x - (width_ / 2), x + (width_ / 2));
		var yy = irandom_range(y - (height_ / 2), y + (height_ / 2));
		var gx = xx div CELL_SIZE;
		var gy = yy div CELL_SIZE;
		if (spawnpart) and (grid_[# gx,gy] != VOID){
			part_particles_create(global.p_system,xx,yy,global.p_forestspirit,1);
		}
	}
}

if (draw_daylight){
	var darks, colors, pstart, pend;
	
	if (hours > phase.sunrise and hours <= phase.daytime){			//sunrise
		darks	= [max_darkness,0.2];
		colors	= [night_color, c_orange];
		pstart	= phase.sunrise;
		pend	= phase.daytime;
	} else if (hours > phase.daytime and hours <= phase.sunset) {	//day
		darks	= [0.2,0.1,0,0.1,0.2];
		colors	= [c_orange,c_olive,c_green,c_green,c_green,c_fuchsia,c_red];
		pstart	= phase.daytime;
		pend	= phase.sunset;
	} else if (hours > phase.sunset and hours <= phase.nighttime) {	//sunset
		darks	= [0.2,max_darkness];
		colors	= [c_red,c_navy,night_color];
		pstart	= phase.sunset;
		pend	= phase.nighttime;
	} else {														//night
		darks	= [max_darkness];
		colors	= [night_color];
		pstart	= phase.nighttime;
		pend	= phase.sunrise;
	}
	//light color
	if (pstart == phase.nighttime) {light_color = colors[0];}
	else {
		var cc = ((hours - pstart) / (pend - pstart))*(array_length(colors)-1);
		var c1 = colors[floor(cc)];
		var c2 = colors[ceil(cc)];
		light_color = merge_color(c1,c2, cc - floor(cc));
	}
	//darkness
	if (pstart == phase.nighttime) { darkness = darks[0];} 
	else {
		var dd = ((hours - pstart) / (pend - pstart))*(array_length(darks)-1);
		var d1 = darks[floor(dd)];
		var d2 = darks[ceil(dd)];
		darkness = merge_number(d1,d2, dd - floor(dd));
	}
	if (!day_outline){
		if (darkness > 0.5) global.draw_outline = true;
		else				global.draw_outline = false;
	}
	
	if (global.disable_outline) global.draw_outline = false;
}

#region cycle check
if(hours >= 24){
	seconds = 0;
	day += 1;
	if (day > 30 ){
		day = 1;
		season += 1
		if (season > 4){
			season = 1;
			year += 1;
		}
	}
}
#endregion