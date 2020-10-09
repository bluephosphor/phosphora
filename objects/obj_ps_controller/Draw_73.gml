switch(spelltype){
	case item.ps_thunder:
	var show_sprite = (irandom(25) == 25);
	if (show_sprite){
		draw_sprite(spr_ef_thunder,irandom(4),o_player.x,o_player.y);
	}
	if (instance_exists(light_inst)) with (light_inst){
		light_strength = show_sprite;
	}
	break;
}