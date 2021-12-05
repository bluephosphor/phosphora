switch(spelltype){
	case item.ps_thunder:
		var show_sprite = (irandom(15) == 15);
		if (show_sprite){
			draw_sprite(spr_ef_thunder,irandom(4),obj_player.x,obj_player.y);
		}
		if (light_inst != noone and global.flash_effect) with (light_inst){
			light_strength = show_sprite * 0.7;
		}
		break;
}