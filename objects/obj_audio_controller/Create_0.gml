enum track{
	intro_length,
	loop_length,
	height,
}

var _width = 4; //change this for how many tracks i have
var _height = track.height;

globalvar music_data;
music_data = ds_grid_create(_width,_height);
ds_grid_set_region(music_data,0,0,_width,_height,-1);

music_data[# snd_forest,	track.intro_length] = 5.168;
music_data[# snd_forest,	track.loop_length]	= 61.719;

music_data[# snd_time,		track.intro_length] = 16.713;
music_data[# snd_time,		track.loop_length]	= 116.872;

current_song = -1;
total_length = -1;
special_loop = false;
bgm = -1;
index = -1;
do_transition = false;