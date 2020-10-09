spr = s_scenery;

land_frames		= room_data[# rm.land_scenery_f,room];
water_frames	= room_data[# rm.water_scenery_f,room];
void_frames		= room_data[# rm.void_scenery_f,room];

color = room_data[# rm.scenery_c,room]; 

current_frames = land_frames;
frame = 0;
facing = choose(-1,1);
depth = -y;

