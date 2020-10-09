event_inherited();

if (x_speed_ == 0 and y_speed_ == 0) exit;

x_speed_ = lerp(x_speed_, 0, .05);
y_speed_ = lerp(y_speed_, 0, .05);

move_and_bounce();