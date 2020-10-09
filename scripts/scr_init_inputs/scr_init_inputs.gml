function scr_init_inputs() {
	enum key {
		right,
		left,
		up,
		down,
		action,
		select,
		held,
		target,
		pause,
		enter,
		hb_left,
		hb_right,
		hb_use,
	}

	globalvar input;
	input = ds_map_create();

	input[? key.right]		= vk_right;
	input[? key.left]		= vk_left;
	input[? key.up]			= vk_up;
	input[? key.down]		= vk_down;
	input[? key.action]		= ord("Z");
	input[? key.select]		= ord("X");
	input[? key.pause]		= vk_escape;
	input[? key.enter]		= vk_enter;
	input[? key.held]		= vk_space;
	input[? key.target]		= ord("C");
	input[? key.hb_left]	= ord("A");
	input[? key.hb_right]	= ord("D");
	input[? key.hb_use]		= ord("S");


}
