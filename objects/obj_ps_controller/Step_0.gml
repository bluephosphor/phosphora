depth = obj_player.depth - 1;

switch(spelltype){
	case item.ps_thunder:///////////////////////////////////////////////////////////////////////////////////
		switch(state){
			case spell.init:
				if (light_inst == noone) light_inst = instance_create_layer(x,y,"Instances",mc_lightsource);
				
				final = true;
				
				with (light_inst){
					state = light.flash;
					follow = obj_player;
					light_strength = 0;
					light_size = 7;
				}
				
				state = spell.standby;
				break;
			case spell.standby:
				
				break;
			case spell.cast:
				with(obj_camera){
					var _list = ds_list_create();
					var _num = instance_place_list(x, y, mc_mob, _list, false);
					var _success = 0;
					if (_num > 0){
						for (var i = 0; i < _num; ++i;){
						    if (!_list[| i].passive){
								var xx = _list[| i].x;
								var yy = _list[| i].y;
								instance_create_layer(xx,yy,"Instances",obj_thunderbolt);
								_success++;
							    if (_success >= 2) break;
							}
						}
					}
					ds_list_clear(_list);
					if (_success < 3){
					var _num = instance_place_list(x, y, obj_chest_demon, _list, false);
						if (_num > 0){
							for (var i = 0; i < _num; ++i;){
							    var xx = _list[| i].x;
								var yy = _list[| i].y;
								instance_create_layer(xx,yy,"Instances",obj_thunderbolt);
								_success++
							    if (_success >= 2) break;
							}
						}
					}
					ds_list_destroy(_list);
					
					if (_success == 0) {
						screen_shake(5,5);
						instance_create_layer(x,y,"Instances",obj_thunderbolt);
					}
				}
				if (light_inst != noone){
					instance_destroy(light_inst);
					light_inst = noone;
				}
				with (player_inst) {
					alarm[0] = 15;
					part_particles_create(global.p_system,x,y,global.p_wind,1);
					sprite_index = s_player_spin;
					playerstate = p_state.spin;
				}
				Spell = noone;
				instance_destroy();
				break;
		}
		break;
	case item.ps_fire://////////////////////////////////////////////////////////////////////////////////
		switch(state){
			case spell.init://------------------------------------------------------
				fireballs = {
					ids: [],
					time: 50,
					maxcount: 3,
					spawncount: 0,
					truecount: 0,
				}
				state = spell.standby;
				break;
			case spell.standby://----------------------------------------------------
				with (fireballs){
					if (time > 0) {
						time -=1;
						//Spell.final = false;
					} else {
						if (spawncount < maxcount){
							var _inst = instance_create_layer(0,0,"Instances",obj_fireball);
							_inst.my_controller = other.id;
							array_push(ids,_inst);
							truecount = array_length(ids); 
							spawncount ++;
							time = (spawncount == 3) ? -1 : 50;
							Spell.final = (truecount == 1 and spawncount == maxcount);
						} else {
							time = -1;
						}
					}
				}
				break;
			case spell.cast://------------------------------------------------------
				var _launched = false;
				with (fireballs){
					if (truecount > 0){
						var _inst = array_pop(ids);
						truecount = array_length(ids); 
						_inst.state = FIREBALL_LAUNCH;
						_launched = true;
						Spell.final = (truecount == 1 and spawncount == maxcount);

					}
				}
				
				if (_launched) with (player_inst) {
					alarm[0] = 10;
					part_particles_create(global.p_system,x,y,global.p_wind,1);
					sprite_index = s_player_spin;
					playerstate = p_state.spin;
				}
				
				state = spell.finish;
				break;
			case spell.finish://----------------------------------------------------
				with (fireballs) { 
					
					if (spawncount >= maxcount) {
					
						switch(truecount) {
							case 0: 
								fireballs = noone;
								Spell = noone;
								instance_destroy(other);
								break;
						}
					}
				}
				
				state = spell.standby;
				break;
		}
		break;
}