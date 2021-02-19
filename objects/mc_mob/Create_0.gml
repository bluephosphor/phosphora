event_inherited();

entity_type = "mob";

grid_x = x div CELL_SIZE;
grid_y = y div CELL_SIZE;
in_cell = grid_[# grid_x, grid_y];

passive		= false;
watertype	= false;
nocturnal	= false;
hitlag		= 0;

xspeed	= 0;
yspeed	= 0;
frict	= 0.3
mystate		= mobstate.passive;
mob_id		= -1;

loot_table	= -1;
ltc			= 0;

hp			= 100;
show_hp		= false;
hb_offset	= 48;
hp_change	= 0;
draw_alpha	= 0;
draw_color	= c_white;
draw_length = 24;

passive_frames	= -1;
aggro_frames	= -1;
hitstun_frames	= -1;
current_anim	= passive_frames;
anim_speed		= 25;
frame_index		= 0;
init_attack		= false;

#macro VELOCITY 0
#macro STATIC	1
#macro PASSIVE  2
attack_type     = VELOCITY;

#macro ALWAYS	 0
#macro NEVER	 1
#macro PER_FRAME 2
tangibility_type = ALWAYS;

enum frametype {
	intangible,
	block,
	vulnerable,
	attack
}

block_override = false;

hitbox_active	= true;
targeted		= noone;
animation_ended = false;

alarm[10] = anim_speed;
alarm[11] = room_speed;

function set_mob_loot(){
	var list = mob_data[# mob_id,stat.loot];
	if (list != -1){
		var len = array_length(list);
		var i = 0; repeat(len){
			var info = list[i];
			loot_table_add(info[0],info[1]);
			i++;
		}
	}
}

function check_death(){
	if (hp <= 0){
		var i = 0; repeat(18){
			part_type_direction(global.p_enemy_death,i,i,0,0);
			part_particles_create(global.p_system,x,y,global.p_enemy_death,1);
			i += 20;
		}
		part_type_direction(global.p_enemy_death,0,0,0,0);
		repeat(irandom(5)){
			with (instance_create_layer(x,y,"Instances",obj_item_entity)){
				var _item = item.none;
				with (other){
					if (loot_table != -1) _item = loot_item_add();
				}
				if (_item == item.none) coin_type = choose(coin.bronze,coin.silver,coin.gold);
				else item_num = _item;
				xspeed = random_range(-1,1);
				yspeed = random_range(-1,1);
			}
		}
		instance_destroy();
	}
}

function pathfind_init(target_x,target_y){
	mp_grid_path(path_grid,path,x,y,target_x,target_y,true);
	var _array = [];
	var _path_num = path_get_number(path);
	var _path_i = 0;
	var i = 0; repeat(_path_num){
		_path_i = (1/_path_num) * i;
		_array[i] = new vec2(
			path_get_point_x(path,i),
			path_get_point_y(path,i),
		);
		i++;
	}
	return _array;
};

function pathfind_draw_points(array){
	var i = 0; repeat(array_length(array)){
		var _str = string(i);
		var _wh = string_width(_str) / 2;
		var _hh = string_height(_str) / 2;
		draw_rectangle_color(array[i].x-_wh,array[i].y-_hh,array[i].x+_wh,array[i].y+_hh,c_black,c_black,c_black,c_black,false)
		draw_text_color(array[i].x-_wh,array[i].y-_hh,_str,c_white,c_white,c_white,c_white,1);
		i++;
	}
}