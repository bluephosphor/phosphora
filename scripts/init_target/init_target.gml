function init_target() {
	current_target = noone;
	target_state = TARGET_DORMANT;

	t_spr = spr_target;
	t_anim_len = sprite_get_number(t_spr) - 1;
	t_anim_frame = 0;
	t_anim_alpha = 0;
	t_anim_col = c_white;
	t_anim_rot = 0;
	tar_x = 0;
	tar_y = 0;


}
