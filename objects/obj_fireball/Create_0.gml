event_inherited();

follow = o_player;
target = noone;

frequency = 0.05;
amplitude = sprite_get_width(s_player) / 2;
timer = 0;

x_prev = x;

x_offset = 0;
y_offset = 0;
z_offset = -1;
throw_ = false;
launch = false;
x_speed_ = 0;
y_speed_ = 0;
stunpower = 30;
damage_mod = 2;

with (instance_create_layer(x,y,layer,mc_lightsource)){
	follow = other.id;
}