/// @description hitstun step

if (gamestate != INGAME) {
	gamestate = INGAME;
	cont_inv.hotbar_autoselect();
}

xspeed = lerp(xspeed, 0, .1);
yspeed = lerp(yspeed, 0, .1);

move_collide();