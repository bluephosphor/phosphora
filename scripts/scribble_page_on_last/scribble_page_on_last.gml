/// Returns: Boolean; whether the page that is being drawn is the last page for the text element
/// @param element   Text element to target. This element must have been created previously by scribble_draw()
function scribble_page_on_last(argument0) {

	return (argument0[__SCRIBBLE.AUTOTYPE_PAGE] >= (argument0[__SCRIBBLE.PAGES]-1));


}
