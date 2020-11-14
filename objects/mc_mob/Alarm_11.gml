/// @description check day time
if (!nocturnal) exit; 

alarm[11] = room_speed;

var _phase = check_phase();

if (_phase == phase.daytime and coord_outside_view(x,y)) instance_destroy();