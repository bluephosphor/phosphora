event_inherited();

mob_id = mob.player;
hp = player_health;

xspeed = 0;
yspeed = 0;

stats_reset();

recovery_frames = 0;
_visible = true;
water_buff = 10;
input_buffer = 10;

show_hp = false;
hp_change = 0;
draw_alpha = 0;
draw_color = c_white;

hitlag = 0;
item_list = ds_list_create();

interact_range = 20;

spin_duration = room_speed / 2;
spin_cooldown = 0;
spin_speed = 4;
spin_accel = .2;
instance_create_layer(x, y, "Instances", obj_camera);

init_target();

player_check_collisions = function(){
	//item entities
	var _num  = instance_place_list(x,y,obj_item_entity,item_list,true);
	if (_num > 0) {
			var i = 0; repeat(_num){
			with (item_list[| i]){
				if (item_num == -1){
					var value = coin_data[# 0, coin_type];
					global.player_coins += value;
				} else {
					add_item(inventory,item_num,1);
				}
				instance_destroy();
			}
			i++;
		}
		ds_list_clear(item_list);
	}	
	///mobsights
	var _marker = instance_place(x,y,obj_mobsight);
	if (_marker != noone) with (_marker){
		if (place_meeting(x,y,obj_player)){
			with (my_mob) {init_attack = true;}
			instance_destroy(obj_mobsight);
		}
	}
}