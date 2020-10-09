event_inherited();

x_speed_ = 0;
y_speed_ = 0;
max_speed_ = 2;
acceleration_ = .5;

recovery_frames = 0;
_visible = true;
water_buff = 10;
inv_buffer = 10;

show_hp = false;
hp_change = 0;
draw_alpha = 0;
draw_color = c_white;

hitlag = 0;

interact_range = 20;

spin_duration = room_speed / 2;
spin_cooldown = 0;
spin_speed = 4;
spin_accel = .2;
instance_create_layer(x, y, "Instances", o_camera);

init_target();