event_inherited();

#macro FIREBALL_DORMANT 0
#macro FIREBALL_THROW 1
#macro FIREBALL_LAUNCH 2

state = FIREBALL_DORMANT;
my_controller = noone;

follow = obj_player;
target = noone;

frequency = 0.05;
amplitude = sprite_get_width(s_player) / 2;
time = 0;

x_prev = x;

x_offset = 0;
y_offset = 0;
z_offset = -1;
throw_ = false;
launch = false;
xspeed = 0;
yspeed = 0;
stunpower = 30;
damage_mod = 2;

with (instance_create_layer(x,y,layer,mc_lightsource)) follow = other.id;