event_inherited();
mob_id = mob.pathfinder;
hp = mob_data[# mob_id,stat.hp];

stats_reset();

update_movement = true;

path = path_add();
path_array = [];

substate = 1;
alarm[0] = 1;

passive_frames = [0];
hitstun_frames = [0];
current_anim = passive_frames;
image_speed = 0;

set_mob_loot();