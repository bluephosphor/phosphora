event_inherited();

if (hitlag != 0) hitlag = approach(hitlag, 0, 1);

if (show_hp){
	draw_alpha = approach(draw_alpha,1,0.1);
} else if (draw_alpha > 0) {
	draw_alpha = approach(draw_alpha,0,0.05);
} else {
	hp_change = 0;
	draw_color = c_white;
}

if(global.time_pause) or (hitlag > 0) {alarm[10] = anim_speed; exit;}

switch(mystate){
	case mobstate.passive:
		if (hp <= 0){
			var i = 0; repeat(18){
				part_type_direction(global.p_enemy_death,i,i,0,0);
				part_particles_create(global.p_system,x,y,global.p_enemy_death,1);
				i += 20;
			}
			part_type_direction(global.p_enemy_death,0,0,0,0);
			repeat(irandom(5)){
				with (instance_create_layer(x,y,"Instances",obj_item_entity)){
					coin_type = choose(coin.bronze,coin.silver,coin.gold);
					x_speed_ = random_range(-1,1);
					y_speed_ = random_range(-1,1);
				}
			}
			instance_destroy();
			break;
		}
		event_perform(ev_other,ev_user0);
		break;
	case mobstate.alert:
		event_perform(ev_other,ev_user1);
		break;
	case mobstate.aggro:
		event_perform(ev_other,ev_user2);
		break;
	case mobstate.hitstun:
		event_perform(ev_other,ev_user3);
		break;
	case mobstate.interact:
		event_perform(ev_other,ev_user4);
		break;
}