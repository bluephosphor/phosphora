init_tree_patterns();

if (instance_exists(obj_tree)) with (obj_tree) {
	if (surface_exists(my_surface)) surface_free(my_surface);
	event_perform(ev_create,0);
}