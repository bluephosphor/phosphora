function check_phase() {
	with (cont_daycycle){
		var pstart, pend;
		if (hours > phase.sunrise and hours <= phase.daytime){			//sunrise
			pstart	= phase.sunrise;
			pend	= phase.daytime;
		} else if (hours > phase.daytime and hours <= phase.sunset) {	//day
			pstart	= phase.daytime;
			pend	= phase.sunset;
		} else if (hours > phase.sunset and hours <= phase.nighttime) {	//sunset
			pstart	= phase.sunset;
			pend	= phase.nighttime;
		} else {														//night
			pstart	= phase.nighttime;
			pend	= phase.sunrise;
		}
	}

	return pstart;


}
