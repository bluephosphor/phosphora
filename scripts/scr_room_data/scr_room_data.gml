function scr_room_data() {
	enum rm {
		name,
		script,
		level_file,
		chest_loot,
		special_loot,
		mob_cap,
		mob_types,
		bgm,
		bgm2,
		draw_daylight,
		dark_level,
		day_outline,
		tree_overcast,
		tree_col_sp,
		land_scenery_f,
		water_scenery_f,
		void_scenery_f,
		scenery_c,
		scenery_glow,
		width,
	}

	var room_counter = 0; do { room_counter++; } until (!room_exists(room_counter))  
	// getting the number of rooms bc game maker
	// makes me do everything myself around here :/

	globalvar room_data;
	var _width = rm.width;
	var _height = room_counter;
	room_data = ds_grid_create(_width,_height);
	ds_grid_set_region(room_data,0,0,_width,_height,-1);



	//----------------------------------------OUTSIDE--------------------------------------------------//
	room_data[# rm.name,			r_outside] = "forest";
	room_data[# rm.script,			r_outside] = generate_room_outside;
	room_data[# rm.mob_cap,			r_outside] = 7;
	room_data[# rm.mob_types,		r_outside] = [mob.fish,mob.minky,mob.ghost];
	room_data[# rm.bgm,				r_outside] = snd_forest;
	room_data[# rm.bgm2,			r_outside] = snd_forest_night;
	room_data[# rm.draw_daylight,	r_outside] = true;
	room_data[# rm.day_outline,		r_outside] = false;
	room_data[# rm.land_scenery_f,	r_outside] = [0,1,2,3,4];
	room_data[# rm.water_scenery_f,	r_outside] = [5,6];
	room_data[# rm.scenery_c,		r_outside] = c_shadow;
	room_data[# rm.tree_overcast,	r_outside] = true;

	           //chest loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.chest_loot,		r_outside] = [
		[item.apple,		75],
		[item.r_potion,		50],
		[item.b_potion,		30],
		[item.note,			20],
		[item.rod,			10],
		[item.card,			6],
		[item.ps_gust,		5],
		[item.ps_fire,		4],
		[item.ps_thunder,	3],
		[item.ears,			1],
		[item.rubellite,	0.05],
	];
	//----------------------------------------DEEP_GROVE--------------------------------------------------//
	room_data[# rm.name,			r_deep_grove] = "grove";
	room_data[# rm.script,			r_deep_grove] = generate_grove;
	room_data[# rm.mob_cap,			r_deep_grove] = 5;
	room_data[# rm.mob_types,		r_deep_grove] = [mob.ghost];
	room_data[# rm.bgm,				r_deep_grove] = snd_time;
	room_data[# rm.draw_daylight,	r_deep_grove] = false;
	room_data[# rm.day_outline,		r_deep_grove] = false;
	room_data[# rm.dark_level,		r_deep_grove] = 0.8;
	room_data[# rm.land_scenery_f,	r_deep_grove] = [0,0,0,3,3,3,4];
	room_data[# rm.water_scenery_f,	r_deep_grove] = [0,5,6];
	room_data[# rm.void_scenery_f,	r_deep_grove] = [0];
	room_data[# rm.scenery_c,		r_deep_grove] = c_aqua;
	room_data[# rm.scenery_glow,	r_deep_grove] = true;
	room_data[# rm.tree_overcast,	r_deep_grove] = true;
	room_data[# rm.tree_col_sp,		r_deep_grove] = [c_shadow,c_aqua];

	           //chest loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.chest_loot,		r_deep_grove] = [
		[item.note,			8],
		[item.p_leaf,		7],
		[item.p_berries,	5],
		[item.p_shroom,		3],
		[item.r_potion,		2],
		[item.b_potion,		1],
		[item.rubellite,	0.05],
	];
	//----------------------------------------DUNGEON---------------------------------------------------//

	room_data[# rm.name,			r_dungeon] = "dungeon";
	room_data[# rm.script,			r_dungeon] = generate_dungeon;
	room_data[# rm.mob_cap,			r_dungeon] = 7;
	room_data[# rm.mob_types,		r_dungeon] = [mob.void_demon,mob.minky,mob.chest_demon];
	room_data[# rm.bgm,				r_dungeon] = snd_dungeon1;
	room_data[# rm.draw_daylight,	r_dungeon] = false;
	room_data[# rm.day_outline,		r_dungeon] = true;
	room_data[# rm.dark_level,		r_dungeon] = 0.5;
	room_data[# rm.void_scenery_f,	r_dungeon] = [7,8,9,10];
	room_data[# rm.tree_overcast,	r_dungeon] = false;

	        //chest loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.chest_loot,		r_dungeon] = [
		[item.r_potion,		75],
		[item.b_potion,		75],
		[item.note,			40],
		[item.ps_gust,		40],
		[item.ps_fire,		30],
		[item.ps_thunder,	20],
		[item.diamond,		10],
		[item.ears,			1],
		[item.iqueur,		0.50],
		[item.rubellite,	0.05],
	];

	      //special loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.special_loot,	r_dungeon] = [
		[item.ps_gust,		75],
		[item.ps_fire,		75],
		[item.ps_thunder,	50],
		[item.diamond,		25],
		[item.ears,			10],
		[item.iqueur,		1],
		[item.rubellite,	0.05],
	];
	//----------------------------------------CSVTEST--------------------------------------------------//
	room_data[# rm.name,			r_csv_test] = "csv_test";
	room_data[# rm.script,			r_csv_test] = generate_from_csv;
	room_data[# rm.level_file,		r_csv_test] = "LEVEL.csv";
	room_data[# rm.mob_cap,			r_csv_test]	= 3;
	room_data[# rm.mob_types,		r_csv_test]	= [mob.fish];
	room_data[# rm.bgm,				r_csv_test] = snd_forest;
	room_data[# rm.bgm2,			r_csv_test]	= snd_forest_night;
	room_data[# rm.draw_daylight,	r_csv_test]	= true;
	room_data[# rm.day_outline,		r_csv_test]	= false;
	room_data[# rm.land_scenery_f,	r_csv_test]	= [0,1,2,3,4];
	room_data[# rm.water_scenery_f,	r_csv_test]	= [5,6];
	room_data[# rm.scenery_c,		r_csv_test] = c_shadow;
	room_data[# rm.tree_overcast,	r_csv_test]	= true;

	           //chest loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.chest_loot,		r_csv_test] = [
		[item.apple,		75],
		[item.r_potion,		50],
		[item.b_potion,		30],
		[item.note,			20],
		[item.rod,			10],
		[item.card,			6],
		[item.ps_gust,		5],
		[item.ps_fire,		4],
		[item.ps_thunder,	3],
		[item.ears,			1],
		[item.rubellite,	0.05],
	];

	      //special loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.special_loot,	r_csv_test] = [
		[item.diamond,		75],
		[item.iqueur,		50],
		[item.rubellite,	25],
	];

	//----------------------------------------CAVERN--------------------------------------------------//
	room_data[# rm.name,			r_cavern]	= "cavern";
	room_data[# rm.script,			r_cavern]	= generate_cavern;
	room_data[# rm.mob_cap,			r_cavern]	= 8;
	room_data[# rm.mob_types,		r_cavern]	= [mob.fish,mob.minky];
	room_data[# rm.bgm,				r_cavern]	= snd_forest_night;
	room_data[# rm.draw_daylight,	r_cavern]	= false;
	room_data[# rm.day_outline,		r_cavern]	= false;
	room_data[# rm.dark_level,		r_cavern]	= 0.95;
	room_data[# rm.land_scenery_f,	r_cavern]	= [0,3,4,11,12,13];
	room_data[# rm.water_scenery_f,	r_cavern]	= [6];
	room_data[# rm.scenery_c,		r_cavern]	= c_fuchsia;
	room_data[# rm.scenery_glow,	r_cavern]	= true;
	room_data[# rm.tree_overcast,	r_cavern]	= false;

	           //chest loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.chest_loot,		r_cavern] = [
		[item.apple,		50],
		[item.r_potion,		30],
		[item.note,			25],
		[item.rod,			10],
		[item.ps_gust,		5],
		[item.ps_fire,		10],
		[item.ps_thunder,	3],
		[item.ears,			1],
		[item.rubellite,	0.05],
	];

	      //special loot table//
	//--Item----------------Chance(in percent)//
	room_data[# rm.special_loot,	r_cavern] = [
		[item.diamond,		10],
		[item.iqueur,		5],
		[item.rubellite,	0.05],
	];


}
