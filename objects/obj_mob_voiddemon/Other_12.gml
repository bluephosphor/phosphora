/// @description aggro state
switch(player_at){
	case dir.up: 
		image_angle = 90;
		x = lerp(x,o_player.x,0.1);
	break;
	case dir.right: 
		image_angle = 0;
		y = lerp(y,o_player.y-4,0.1);
	break;
	case dir.down: 
		image_angle = 270;
		x = lerp(x,o_player.x,0.1);
	break;
	case dir.left: 
		image_angle = 180;
		y = lerp(y,o_player.y-4,0.1);
	break;
}

hitbox_active = (image_index > 11)

if (image_index > 12) {
	alarm[10] = -1;
	anim_speed = 0;
	image_alpha -= 0.01;
	if (image_alpha <= 0) instance_destroy();
}
