///arg object
///arg grid
///arg celltype
function grid_place_meeting(argument0, argument1, argument2) {
	var _object = argument0;
	var _grid = argument1;
	var _celltype = argument2;

	var _top_right = _grid[# (_object.bbox_right-1) div CELL_WIDTH, _object.bbox_top div CELL_HEIGHT] == _celltype;
	var _top_left = _grid[# _object.bbox_left div CELL_WIDTH, _object.bbox_top div CELL_HEIGHT] == _celltype;
	var _bottom_right = _grid[# (_object.bbox_right-1) div CELL_WIDTH, (_object.bbox_bottom-1) div CELL_HEIGHT] == _celltype;
	var _bottom_left = _grid[# _object.bbox_left div CELL_WIDTH, (_object.bbox_bottom-1) div CELL_HEIGHT] == _celltype;

	return _top_right || _top_left || _bottom_right || _bottom_left;


}
