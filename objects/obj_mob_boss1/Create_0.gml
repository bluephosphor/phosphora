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
attack_direction = 0;
hitbox_active = false;
if (instance_exists(obj_player)) targeted = obj_player;

passive_frames		= [0];
walking_frames		= [1, 2, 3, 4, 5, 6, 7, 8];
retreating_frames	= [8, 7, 6, 5, 4, 3, 2, 1];
charge_frames[0]	= [9, 10];
attack_frames[0]	= [9,10,11,12,13,14];
hitstun_frames		= [1];

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

with (obj_camera){
	target_2 = other.id;
	state = cam.follow_two;
}

set_mob_loot();