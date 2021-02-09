event_inherited();
mob_id = mob.ent_knight;
hp = mob_data[# mob_id,stat.hp];
z = 0;

max_speed_ = 1;
acceleration_ = 0.2;
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 32;
attack_direction = new vec2(0,5);
hitbox_active = false;
targeted = noone;

passive_frames		= [0];
walking_frames		= [1, 2, 3, 4, 5, 6, 7, 8];
retreating_frames	= [8, 7, 6, 5, 4, 3, 2, 1];
charge_frames[0]	= [9, 10];
attack_frames[0]	= [9,10,11,12,13,14];
hitstun_frames		= [1];
jump_frames  		= [16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37];

current_anim = walking_frames;
mystate = mobstate.aggro;
substate = 0;
image_speed = 0;
anim_speed = 5;
attack_cooldown = 0;

with (instance_create_layer(x,y,layer,mc_lightsource)){
	follow = other.id;
	light_size = 1;
	light_strength = 1;
	light_offset.y = -40;
}

set_mob_loot();