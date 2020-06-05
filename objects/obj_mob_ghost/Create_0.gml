event_inherited();
mob_id = mob.ghost;
hp = mob_data[# mob_id,stat.hp];
passive = true;

max_speed_ = 0.5;
acceleration_ = 0.01;
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

interact_state = INTERACTABLE;

passive_frames = [0,1,2,3,4,5,6,7];
aggro_frames = [0];
hitstun_frames = [0];

target_alpha = 0;

current_anim = passive_frames;
anim_speed = 10;

image_alpha = 0;
image_speed = 0;

with (instance_create_layer(x,y,layer,mc_lightsource)){
	follow = other.id;
	light_strength = 1;
}