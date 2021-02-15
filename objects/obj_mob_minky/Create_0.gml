event_inherited();
mob_id = mob.minky;
hp = mob_data[# mob_id,stat.hp];

stats_reset();

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