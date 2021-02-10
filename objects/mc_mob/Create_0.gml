event_inherited();

entity_type = "mob";

grid_x = x div CELL_WIDTH;
grid_y = y div CELL_HEIGHT;
in_cell = grid_[# grid_x, grid_y];

passive		= false;
watertype	= false;
nocturnal	= false;
hitlag		= 0;

x_speed_	= 0;
y_speed_	= 0;
mystate		= mobstate.passive;
mob_id		= -1;

loot_table	= -1;
ltc			= 0;

hp			= 100;
show_hp		= false;
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