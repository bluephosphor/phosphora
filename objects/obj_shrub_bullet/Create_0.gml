event_inherited();
y_offset = 0;
state = 0;
image_speed = 0;
image_xscale = choose(-1,1)

target_x = -1;
target_y = -1;

inflicts = {index: effect.slow, level: 2, duration: 10}

xspeed = 0;
yspeed = 0;
max_sp = 4;
accel = 0.1;
total_dist = 0;

my_mob = noone;
interrupted = false;

my_light = instance_create_layer(x,y,layer,mc_lightsource);
with (my_light){
	follow = other.id;
	light_strength = 0;
	draw_strength = light_strength;
	light_size = 1;
}