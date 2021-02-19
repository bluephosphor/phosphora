globalvar mob_data, player_health, player_coins, hp_draw_length;

player_coins = 0;
hp_draw_length = 64;


enum stat{
	object,
	name,
	info,
	hp,
	attack,
	defense,
	sp_attack,
	max_spd,
	fric,
	accel,
	spawn_cell,
	loot,
	special,
	enum_height,
}

enum mob{
	player,
	minky,
	chest_demon,
	void_demon,
	fish,
	ghost,
	ent_knight,
	shrubbie,
	pathfinder,
	enum_length,
}

enum dir {up,right,down,left}

enum mobstate {passive,alert,aggro,hitstun,interact,block}


var _width = mob.enum_length;
var _height = stat.enum_height;
mob_data = ds_grid_create(_width,_height);
ds_collector_add(mob_data);
ds_grid_set_region(mob_data,0,0,_width,_height,-1);

//player
mob_data[# mob.player, stat.name]		= "Taako";
mob_data[# mob.player, stat.hp]			= 50;
mob_data[# mob.player, stat.attack]		= 2;
mob_data[# mob.player, stat.defense]	= 1;
mob_data[# mob.player, stat.sp_attack]	= 10;
mob_data[# mob.player, stat.max_spd]	= 2;
mob_data[# mob.player, stat.fric]		= 0.3;
mob_data[# mob.player, stat.accel]		= 0.5;
mob_data[# mob.player, stat.spawn_cell]	= FLOOR;

player_health = mob_data[# mob.player, stat.hp];

//Minky
mob_data[# mob.minky, stat.object]		= obj_mob_minky;
mob_data[# mob.minky, stat.name]		= "Minky";
mob_data[# mob.minky, stat.info]		= "";
mob_data[# mob.minky, stat.hp]			= 25;
mob_data[# mob.minky, stat.attack]		= 5;
mob_data[# mob.minky, stat.defense]		= 1;
mob_data[# mob.minky, stat.sp_attack]	= 0;
mob_data[# mob.minky, stat.max_spd]		= 1;
mob_data[# mob.minky, stat.accel]		= 0.2;
mob_data[# mob.minky, stat.fric]		= 0.3;
mob_data[# mob.minky, stat.spawn_cell]	= FLOOR;
mob_data[# mob.minky, stat.loot]		= [
	//item              //chance in percent
	[item.apple,		30],
	[item.r_potion,		15],
	[item.b_potion,		3],
	[item.note,			1],
	[item.rubellite,	0.05]
];


//Chest Demon
mob_data[# mob.chest_demon, stat.object]		= obj_chest_demon;
mob_data[# mob.chest_demon, stat.name]			= "Jinx";
mob_data[# mob.chest_demon, stat.info]			= "";
mob_data[# mob.chest_demon, stat.hp]			= 30;
mob_data[# mob.chest_demon, stat.attack]		= 10;
mob_data[# mob.chest_demon, stat.defense]		= 3;
mob_data[# mob.chest_demon, stat.sp_attack]		= 0;
mob_data[# mob.chest_demon, stat.max_spd]		= 1;
mob_data[# mob.chest_demon, stat.accel]			= 0.2;
mob_data[# mob.chest_demon, stat.fric]			= 0.3;
mob_data[# mob.chest_demon, stat.spawn_cell]	= FLOOR;
mob_data[# mob.chest_demon, stat.loot]			= [
	//item              //chance in percent
	[item.r_potion,		25],
	[item.b_potion,		15],
	[item.ps_fire,		2],
	[item.ps_gust,		1],
	[item.note,			1],
	[item.rubellite,	0.05]
];

//Void Demon
mob_data[# mob.void_demon, stat.object]			= obj_mob_voiddemon;
mob_data[# mob.void_demon, stat.name]			= "Wally";
mob_data[# mob.void_demon, stat.info]			= "";
mob_data[# mob.void_demon, stat.hp]				= 1;
mob_data[# mob.void_demon, stat.attack]			= 100;
mob_data[# mob.void_demon, stat.defense]		= 0;
mob_data[# mob.void_demon, stat.sp_attack]		= 0;
mob_data[# mob.void_demon, stat.max_spd]		= 1;
mob_data[# mob.void_demon, stat.accel]			= 0.2;
mob_data[# mob.void_demon, stat.fric]			= 0.3;
mob_data[# mob.void_demon, stat.spawn_cell]		= VOID;
mob_data[# mob.void_demon, stat.loot]			= [
	//item              //chance in percent
	[item.diamond,		25],
	[item.ps_thunder,	5]
];

//Fish (passive)
mob_data[# mob.fish, stat.object]			= obj_fish_entity;
mob_data[# mob.fish, stat.name]				= "Fish";
mob_data[# mob.fish, stat.info]				= "";
mob_data[# mob.fish, stat.hp]				= 10;
mob_data[# mob.fish, stat.attack]			= 0;
mob_data[# mob.fish, stat.defense]			= 0;
mob_data[# mob.fish, stat.sp_attack]		= 0;
mob_data[# mob.fish, stat.max_spd]			= 0.5;
mob_data[# mob.fish, stat.accel]			= 0.1;
mob_data[# mob.fish, stat.fric]				= 0.1;
mob_data[# mob.fish, stat.spawn_cell]		= WATER;


//ghost
mob_data[# mob.ghost, stat.object]			= obj_mob_ghost;
mob_data[# mob.ghost, stat.name]			= "Ghost";
mob_data[# mob.ghost, stat.info]			= "";
mob_data[# mob.ghost, stat.hp]				= 50;
mob_data[# mob.ghost, stat.attack]			= 15;
mob_data[# mob.ghost, stat.defense]			= 0;
mob_data[# mob.ghost, stat.sp_attack]		= 10;
mob_data[# mob.ghost, stat.max_spd]			= 0.5;
mob_data[# mob.ghost, stat.accel]			= 0.01;
mob_data[# mob.ghost, stat.fric]			= 0.3;
mob_data[# mob.ghost, stat.spawn_cell]		= FLOOR;



//ent_knight
mob_data[# mob.ent_knight, stat.object]		= obj_mob_boss1;
mob_data[# mob.ent_knight, stat.name]		= "Knight";
mob_data[# mob.ent_knight, stat.info]		= "";
mob_data[# mob.ent_knight, stat.hp]			= 100;
mob_data[# mob.ent_knight, stat.attack]		= 20;
mob_data[# mob.ent_knight, stat.defense]	= 3;
mob_data[# mob.ent_knight, stat.sp_attack]	= 0;
mob_data[# mob.ent_knight, stat.max_spd]	= 1;
mob_data[# mob.ent_knight, stat.accel]		= 0.2;
mob_data[# mob.ent_knight, stat.fric]		= 0.3;
mob_data[# mob.ent_knight, stat.spawn_cell]	= FLOOR;
mob_data[# mob.ent_knight, stat.loot]		= [
	//item              //chance in percent
	[item.diamond,		50],
];


//shrubbie
mob_data[# mob.shrubbie, stat.object]		= obj_mob_shrubbie;
mob_data[# mob.shrubbie, stat.name]			= "Shrubbie";
mob_data[# mob.shrubbie, stat.info]			= "";
mob_data[# mob.shrubbie, stat.hp]			= 30;
mob_data[# mob.shrubbie, stat.attack]		= 5;
mob_data[# mob.shrubbie, stat.defense]		= 3;
mob_data[# mob.shrubbie, stat.sp_attack]	= 0;
mob_data[# mob.shrubbie, stat.max_spd]		= 3;
mob_data[# mob.shrubbie, stat.accel]		= 0.2;
mob_data[# mob.shrubbie, stat.fric]			= 0.3;
mob_data[# mob.shrubbie, stat.spawn_cell]	= FLOOR;
mob_data[# mob.shrubbie, stat.loot]			= [
	//item              //chance in percent
	[item.s_leaf,		25],
];

//pathfinder
mob_data[# mob.pathfinder, stat.object]		= obj_mob_pathfinder;
mob_data[# mob.pathfinder, stat.name]		= "Pathfinder";
mob_data[# mob.pathfinder, stat.info]		= "";
mob_data[# mob.pathfinder, stat.hp]			= 25;
mob_data[# mob.pathfinder, stat.attack]		= 5;
mob_data[# mob.pathfinder, stat.defense]		= 1;
mob_data[# mob.pathfinder, stat.sp_attack]	= 0;
mob_data[# mob.pathfinder, stat.max_spd]		= 1;
mob_data[# mob.pathfinder, stat.accel]		= 0.2;
mob_data[# mob.pathfinder, stat.fric]		= 0.3;
mob_data[# mob.pathfinder, stat.spawn_cell]	= FLOOR;
mob_data[# mob.pathfinder, stat.loot]		= [
	//item              //chance in percent
	[item.apple,		30],
	[item.r_potion,		15],
	[item.b_potion,		3],
	[item.note,			1],
	[item.rubellite,	0.05]
];