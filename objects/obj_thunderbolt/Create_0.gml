spr_len = sprite_get_number(sprite_index);
strike = true;
damage_mod = 3;
image_index = irandom(spr_len);
image_speed = 0;
depth = -(y + 5);

with (instance_create_layer(x,y,layer,mc_lightsource)){
	follow = other.id;
	light_size = 6;
	light_strength = 1;
	state = light.flash;
}