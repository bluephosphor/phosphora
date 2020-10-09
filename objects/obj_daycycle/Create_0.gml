depth = -2001

var starting_hour = 5;

seconds = (starting_hour * 60) * 60;
minutes = 0;
hours = 0;

globalvar day, season, year;

day = 1;
season = 1;
year = 1;

time_increment = 1; //seconds per step
witching_hour = false;

draw_daylight = true;
day_outline = true;
max_darkness = 0.7;
darkness = 0;
light_color = c_black;
night_color = merge_color(c_black,c_navy,0.3);

enum phase {
	sunrise = 6,
	daytime = 8.5,
	sunset = 18,
	nighttime = 22,
}

light_surface = -1;