if (!global.debug) exit;

draw_y = 0;

var plus8 = function(){
	draw_y += 8;
	return draw_y;
}

if (fireballs != noone) {
	draw_text(8, plus8(), "time: "		 + string(fireballs.time));
	draw_text(8, plus8(), "maxcount: "	 + string(fireballs.maxcount));
	draw_text(8, plus8(), "spawncount: " + string(fireballs.spawncount));
	draw_text(8, plus8(), "truecount: "	 + string(fireballs.truecount));
	draw_text(8, plus8(), "final: "		 + string(final));
}