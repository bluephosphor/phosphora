event_inherited();
mob_id = mob.minky;
hp = mob_data[# mob_id,stat.hp];

max_speed_ = 1;
acceleration_ = 0.2;
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

passive_frames = [0,1];
aggro_frames = [2,3];
hitstun_frames = [4];

current_anim = passive_frames;

image_speed = 0;

set_mob_loot();