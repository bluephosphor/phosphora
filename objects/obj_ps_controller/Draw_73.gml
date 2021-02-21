switch(spelltype){
	case item.ps_thunder:
		var show_sprite = (irandom(25) == 25);
		if (show_sprite){
			draw_sprite(spr_ef_thunder,irandom(4),obj_player.x,obj_player.y);
		}
		if (instance_exists(light_inst) and global.flash_effect) with (light_inst){
			light_strength = show_sprite;
		}
		break;
}