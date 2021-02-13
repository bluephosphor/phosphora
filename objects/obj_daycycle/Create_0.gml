depth = -2001

var starting_hour = 7;

seconds = (starting_hour * 60) * 60;
minutes = 0;
hours = 0;

#macro SUMMER 1
#macro AUTUMN 2
#macro WINTER 3
#macro SPRING 4

globalvar day, season, year;

day = 1;
season = SPRING;
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