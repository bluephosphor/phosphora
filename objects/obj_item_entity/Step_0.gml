event_inherited();

if (xspeed == 0 and yspeed == 0) exit;

xspeed = lerp(xspeed, 0, .05);
yspeed = lerp(yspeed, 0, .05);

move_and_bounce();