event_inherited();

mob_id = mob.chest_demon;
hp = mob_data[# mob_id,stat.hp];

attack = 5;
max_speed = 1;
acceleration = 0.2;
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

passive_frames = [0];
aggro_frames = [1,2];
hitstun_frames = [2];

anim_speed = 15;

current_anim = passive_frames;

image_speed = 0;