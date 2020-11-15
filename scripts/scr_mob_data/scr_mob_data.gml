globalvar mob_data;

enum mob{
	minky,
	chest_demon,
	void_demon,
	fish,
	ghost,
	enum_length,
}

enum dir {up,right,down,left}

enum mobstate {passive,alert,aggro,hitstun,interact}


var _width = mob.enum_length;
var _height = stat.enum_height;
mob_data = ds_grid_create(_width,_height);
ds_collector_add(mob_data);
ds_grid_set_region(mob_data,0,0,_width,_height,-1);

//Minky
mob_data[# mob.minky, stat.object]		= obj_mob_minky;
mob_data[# mob.minky, stat.name]		= "Minky";
mob_data[# mob.minky, stat.info]		= "";
mob_data[# mob.minky, stat.hp]			= 25;
mob_data[# mob.minky, stat.attack]		= 5;
mob_data[# mob.minky, stat.defense]		= 1;
mob_data[# mob.minky, stat.sp_attack]	= 0;
mob_data[# mob.minky, stat.spawn_cell]	= FLOOR;

//Chest Demon
mob_data[# mob.chest_demon, stat.object]		= obj_chest_demon;
mob_data[# mob.chest_demon, stat.name]			= "Jinx";
mob_data[# mob.chest_demon, stat.info]			= "";
mob_data[# mob.chest_demon, stat.hp]			= 30;
mob_data[# mob.chest_demon, stat.attack]		= 10;
mob_data[# mob.chest_demon, stat.defense]		= 3;
mob_data[# mob.chest_demon, stat.sp_attack]		= 0;
mob_data[# mob.chest_demon, stat.spawn_cell]	= FLOOR;

//Void Demon
mob_data[# mob.void_demon, stat.object]			= obj_mob_voiddemon;
mob_data[# mob.void_demon, stat.name]			= "Wally";
mob_data[# mob.void_demon, stat.info]			= "";
mob_data[# mob.void_demon, stat.hp]				= 1;
mob_data[# mob.void_demon, stat.attack]			= 100;
mob_data[# mob.void_demon, stat.defense]		= 0;
mob_data[# mob.void_demon, stat.sp_attack]		= 0;
mob_data[# mob.void_demon, stat.spawn_cell]		= VOID;

//Fish (passive)
mob_data[# mob.fish, stat.object]			= obj_fish_entity;
mob_data[# mob.fish, stat.name]				= "Fish";
mob_data[# mob.fish, stat.info]				= "";
mob_data[# mob.fish, stat.hp]				= 10;
mob_data[# mob.fish, stat.attack]			= 0;
mob_data[# mob.fish, stat.defense]			= 0;
mob_data[# mob.fish, stat.sp_attack]		= 0;
mob_data[# mob.fish, stat.spawn_cell]		= WATER;

//ghost
mob_data[# mob.ghost, stat.object]			= obj_mob_ghost;
mob_data[# mob.ghost, stat.name]			= "Ghost";
mob_data[# mob.ghost, stat.info]			= "";
mob_data[# mob.ghost, stat.hp]				= 50;
mob_data[# mob.ghost, stat.attack]			= 15;
mob_data[# mob.ghost, stat.defense]			= 0;
mob_data[# mob.ghost, stat.sp_attack]		= 10;
mob_data[# mob.ghost, stat.spawn_cell]		= FLOOR;