event_inherited();

mob_id = mob.player;
hp = player_health;

my_psystem = part_system_create();

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
spin_accel = .2;
spin_trails = ds_list_create();

trail = function() constructor {
	finished = false;
	index = 0;
	list  = [];
	alpha = 0.5;
	update = function() {
		alpha -= 0.007;
		if (!finished){
			list[index++] = new vec2(player_inst.x,player_inst.y);
			if (playerstate != p_state.spin) finished = true;
		}
	}
	draw  = function(){
		var j = 0; repeat(array_length(list)) {
			if (j > 0) {
				draw_set_alpha(alpha);
				draw_line_width_color(
					list[j].x,
					list[j].y,
					list[j-1].x,
					list[j-1].y,
					2,
					c_shadow,
					c_shadow,
				);
				draw_set_alpha(1);
			}
			j++;
		}
	}
}

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