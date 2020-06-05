if (surface_exists(light_surf)) {
	surface_free(light_surf); 
	light_surf = -1;
}

outside = (room_data[# rm.dark_level, room] == -1);

if (!outside) dark_lev = room_data[# rm.dark_level, room];