repeat(50){
	var xx = irandom_range(-8,8);
	var yy = irandom_range(-8,8);
	part_particles_create(global.p_system,x+xx,y+yy,global.p_spinpixel,1);
}

switch(state){
	case FIREBALL_DORMANT:
	case FIREBALL_LAUNCH:
		var _id = id;
		with(my_controller){
			with (fireballs){
				ids = array_remove(ids, _id);
				truecount = array_length(ids);
				Spell.final = (truecount == 1 and spawncount == maxcount);
				
				if (truecount == 0 and spawncount == maxcount){
					check_inv(inventory, item.ps_fire, true);
					instance_destroy(Spell);
					Spell = noone;
				}
			}
		}
		break;
}