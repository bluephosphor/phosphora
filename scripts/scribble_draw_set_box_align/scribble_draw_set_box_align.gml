/// Sets Scribble's box alignment state
/// 
/// @param boxHAlign   Horizontal alignment of the text element relative to the text element's origin. Accepts fa_left, fa_right, and fa_center
/// @param boxVAlign   Vertical alignment of the text element relative to the text element's origin. Accepts fa_top, fa_bottom, and fa_middle
/// 
/// This script sets Scribble's draw state. All text drawn with scribble_draw() will use these settings until they're overwritten, either by
/// calling this script again or by calling scribble_draw_reset() or scribble_draw_set_state().
function scribble_draw_set_box_align(argument0, argument1) {

	global.scribble_state_box_halign = argument0;
	global.scribble_state_box_valign = argument1;


}
