target_ = obj_player;
width_ = camera_get_view_width(view_camera[0]);
height_ = camera_get_view_height(view_camera[0]);
scale_ = width_ / view_get_wport(0);
debug_log_add("Scale: " + string(scale_));
global.freecam = false;
image_alpha = 0.5;
depth = -room_height - 10;

shake_length = 0;
shake_magnitude = 0;
shake_remain = 0;