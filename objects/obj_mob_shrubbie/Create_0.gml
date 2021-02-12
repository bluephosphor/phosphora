event_inherited();

image_speed		 = 0;
mob_id			 = mob.shrubbie;
hp				 = mob_data[# mob_id,stat.hp];

max_speed_		 = 3;
acceleration_	 = 0.2;
update_movement  = true;
xmove			 = 0;
ymove			 = 0;
detection_radius = 64;
attack_direction = 0;

passive_frames	 = [16,17,18,19,20,21,22,23,24,13,14,15];
aggro_frames	 = array_range(0,11);
hitstun_frames	 = [12];
attack_frames	 = array_range(25,37);

current_anim	 = passive_frames;
next_anim		 = current_anim;
anim_speed		 = 4;

substate		 = 0;
cell_candidate	 = new vec2(1,1);
target_cell		 = new vec2(0,0);
ideal_dist		 = 96;

//shader colors

color = function(r,g,b) constructor{
	red	  = r;
	green = g;
	blue  = b;
	
	static to_shader_value = function(value) {
		return value / 255;
	}
}

sh_handle_range   = shader_get_uniform(sh_replace_colors, "range");
sh_handle_match   = shader_get_uniform(sh_replace_colors, "color_match");
sh_handle_replace = shader_get_uniform(sh_replace_colors, "color_replace");

var _len	= array_length    (colors) - 1;

var red1	= color_get_red	  (colors[0]);
var green1	= color_get_green (colors[0]);
var blue1	= color_get_blue  (colors[0]);

var red2	= color_get_red	  (colors[_len div 2]);
var green2	= color_get_green (colors[_len div 2]);
var blue2	= color_get_blue  (colors[_len div 2]);

var red3	= color_get_red	  (colors[_len]);
var green3	= color_get_green (colors[_len]);
var blue3	= color_get_blue  (colors[_len]);

color_replace_1 = new color(red1,green1,blue1);
color_replace_2 = new color(red2,green2,blue2);
color_replace_3 = new color(red3,green3,blue3);
color_match_1	= new color(50, 60, 57);
color_match_2	= new color(75, 105, 47);
color_match_3	= new color(106, 190, 48);

set_mob_loot();