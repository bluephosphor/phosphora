var i = 0, array_len = array_length_1d(pages);
repeat(array_len){
	ds_grid_destroy(pages[i]);
	i++;
}