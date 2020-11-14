event_inherited();

entity_type = "mob";

grid_x = x div CELL_WIDTH;
grid_y = y div CELL_HEIGHT;
in_cell = grid_[# grid_x, grid_y];

passive = false;
watertype = false;
nocturnal = false;
hitlag = 0;

x_speed_ = 0;
y_speed_ = 0;
mystate = mobstate.passive;
mob_id = -1;

hp = 100;
show_hp = false;
hp_change = 0;
draw_alpha = 0;
draw_color = c_white;
draw_length = 24;

passive_frames = -1;
aggro_frames = -1;
hitstun_frames = -1;
current_anim = passive_frames;
anim_speed = 25;
frame_index = 0;
init_attack = false;

hitbox_active = true;
static_attack = false;

alarm[10] = anim_speed;
alarm[11] = room_speed;