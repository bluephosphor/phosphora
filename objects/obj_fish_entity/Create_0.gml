event_inherited();
mob_id = mob.fish;
hp = mob_data[# mob_id,stat.hp];

passive = true;
watertype = true;

attack_type			= PASSIVE;
tangibility_type	= NEVER;

stats_reset();
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

passive_frames = [0,1,2,3,4,5,6,7];
aggro_frames = -1;
hitstun_frames = -1;

current_anim = passive_frames;

anim_speed = 10;

image_speed = 0;