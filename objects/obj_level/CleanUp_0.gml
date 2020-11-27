if (ds_exists(grid_,ds_type_grid))ds_grid_destroy(grid_);
if (surface_exists(map.surface)) surface_free(map.surface);
if (surface_exists(grid_surface)) surface_free(grid_surface);

grid_ = -1;
map.surface = noone;
grid_surface = noone;
mp_grid_destroy(path_grid);