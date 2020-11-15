/// @description hitstun step

if (gamestate != INGAME) {
	gamestate = INGAME;
	cont_inv.hotbar_autoselect();
}

x_speed_ = lerp(x_speed_, 0, .1);
y_speed_ = lerp(y_speed_, 0, .1);

move_and_collide();