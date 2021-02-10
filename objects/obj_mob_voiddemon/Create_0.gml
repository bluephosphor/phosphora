event_inherited();
mob_id = mob.void_demon;
hp = mob_data[# mob_id,stat.hp];

max_speed_ = 1;
acceleration_ = 0.2;
update_movement = true;
change_direction = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

x_to = grid_x
y_to = grid_y

passive_frames = [0,1];
aggro_frames = [2,3,4,5,6,7,8,9,10,11,12,13];
hitstun_frames = [11];

hitbox_active = false;
player_at = -1;
attack_type = STATIC;

current_anim = passive_frames;

anim_speed = 5;

if (global.debug) sprite_index = spr_void_demon_debug;
else sprite_index = spr_void_demon;

image_speed = 0;