entity_type = -1;
mytext = [
	[-1,"This is a test message."],
]

upixel_h = shader_get_uniform(sh_outline,"pixel_h");
upixel_w = shader_get_uniform(sh_outline,"pixel_w");
texel_w = texture_get_texel_width(sprite_get_texture(sprite_index,0));
texel_h = texture_get_texel_height(sprite_get_texture(sprite_index,0));

interact_state = NOT_INTERACTABLE;
can_interact = 0;