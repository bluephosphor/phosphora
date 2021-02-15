event_inherited();
mob_id = mob.void_demon;
hp = mob_data[# mob_id,stat.hp];

stats_reset();
update_movement = true;
change_direction = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

x_to = grid_x
y_to = grid_y

passive_frames = [0,1];							fill_frametype(passive_frames,frametype.intangible);
aggro_frames = [2,3,4,5,6,7,8,9,10,11,12,13];   fill_frametype(aggro_frames,frametype.vulnerable); frame_type[11] = frametype.attack;
hitstun_frames = [11];							fill_frametype(hitstun_frames,frametype.intangible);

hitbox_active = false;
player_at = -1;
attack_type = STATIC;
tangibility_type = PER_FRAME;

current_anim = passive_frames;

anim_speed = 5;

if (global.debug) sprite_index = spr_void_demon_debug;
else sprite_index = spr_void_demon;

image_speed = 0;