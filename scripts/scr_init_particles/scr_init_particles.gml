global.p_system		= part_system_create();
ds_collector_add(global.p_system);

part_system_depth(global.p_system,-room_height - 1);

global.p_spinpixel	= part_type_create();
ds_collector_add(global.p_spinpixel);

part_type_color1	(global.p_spinpixel,c_white);
part_type_alpha2	(global.p_spinpixel,0.5,0);
part_type_life		(global.p_spinpixel,60,120);
part_type_direction	(global.p_spinpixel,80,100,0,0);
part_type_speed		(global.p_spinpixel,0.1,0.3,0,0);

global.p_gust = part_type_create();
ds_collector_add(global.p_gust);

var len = sprite_get_number(spr_ef_3) * 2;
part_type_life		(global.p_gust,len,len);
part_type_sprite	(global.p_gust,spr_ef_3,1,1,0);
part_type_alpha1	(global.p_gust,0.2);

global.p_wind = part_type_create();
ds_collector_add(global.p_wind);

var len = sprite_get_number(spr_ef_4) * 1.5;
part_type_life		(global.p_wind,len,len);
part_type_sprite	(global.p_wind,spr_ef_4,1,1,0);
part_type_alpha1	(global.p_wind,0.7);

global.p_water_ring = part_type_create();
ds_collector_add(global.p_water_ring);

var len = sprite_get_number(spr_ef_6) * 5;
part_type_life		(global.p_water_ring,len,len);
part_type_sprite	(global.p_water_ring,spr_ef_6,1,1,0);
part_type_alpha1	(global.p_water_ring,0.5);

global.p_forestspirit = part_type_create();
ds_collector_add(global.p_forestspirit);

part_type_sprite	(global.p_forestspirit,spr_forest_spirit,1,1,0);
part_type_alpha2	(global.p_forestspirit,0.5,0);
part_type_life		(global.p_forestspirit,60,120);
part_type_direction	(global.p_forestspirit,80,100,0,0);
part_type_speed		(global.p_forestspirit,0.1,0.2,0,0);

global.p_enemy_death = part_type_create();
ds_collector_add(global.p_enemy_death);

part_type_sprite	(global.p_enemy_death,spr_enemypart,1,1,0);
part_type_alpha2	(global.p_enemy_death,1,0);
part_type_life		(global.p_enemy_death,60,60);
part_type_direction	(global.p_enemy_death,0,0,0,0);
part_type_speed		(global.p_enemy_death,1,1,0,0);

global.p_fog = part_type_create();
ds_collector_add(global.p_fog);

part_type_sprite	(global.p_fog,spr_fog,0,0,0);
part_type_alpha3	(global.p_fog,0,1,0);
part_type_life		(global.p_fog,room_speed * 4,room_speed * 5);
part_type_blend		(global.p_fog,true);