depth = obj_player.depth - 1;

switch(spelltype){
	case item.ps_thunder:
		if (light_inst == -1){
			light_inst = instance_create_layer(x,y,layer,mc_lightsource);
			with (light_inst){
				follow = obj_player;
				light_strength = 0;
			}
		}
		if (cast){
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
			}
			cast = false; 
			if (instance_exists(light_inst)){instance_destroy(light_inst);}
			instance_destroy();
		}
		break;
	case item.ps_fire:
		if (timer > 0) timer -=1;
		if (timer <= 0){
			if (spawncount < 3){
				fireball[| spawncount] = instance_create_layer(0,0,"Instances",obj_fireball);
				spawncount ++;
				timer = 50;
			} else if (!instance_exists(obj_fireball)) {
				instance_destroy();
			}
		}
		if (cast){
			ds_list_sort(fireball,false);
			with (fireball[| 0]) state = FIREBALL_LAUNCH;
			ds_list_set(fireball,0,noone);
		}
		cast = false;
		break;
}
