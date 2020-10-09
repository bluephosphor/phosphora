/// Returns: Page that is currently being drawn, starting at 0 for the first page
/// @param element   Text element to target. This element must have been created previously by scribble_draw()
/// 
/// This function is intended for use with scribble_page_set().
function scribble_page_get(argument0) {

	return argument0[__SCRIBBLE.AUTOTYPE_PAGE];


}
