function create_macros() {
	//dimensions
#macro CELL_WIDTH 32
#macro CELL_HEIGHT 32
	//floortypes
#macro FLOOR -5
#macro WATER -6
#macro VOID -7
#macro FARM -8
	//directions
#macro NORTH 1
#macro WEST 2
#macro EAST 4
#macro SOUTH 8
	//colors
#macro c_shadow make_color_rgb(35, 28, 53)
#macro c_dkteal merge_color(c_shadow,c_teal,0.5)
#macro c_autumn make_color_rgb(235, 94, 52)
#macro c_winter make_color_rgb(153, 192, 255)
#macro c_pink   make_color_rgb(255, 171, 217)
	//target states
#macro TARGET_DORMANT 0
#macro TARGET_SET 1
#macro TARGET_FOLLOW 2
#macro TARGET_DISMISS 3
	//entity states
#macro NOT_INTERACTABLE 0
#macro INTERACTABLE 1
#macro INTERACTING 2


}
