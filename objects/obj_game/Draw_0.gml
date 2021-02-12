if (tree_overcast) draw_trees();

var _len = array_length(lines_to_draw);
if (_len > 0){
	var _l;
	var i = 0; repeat(_len){
		_l = lines_to_draw[i];
		draw_set_alpha((_l.color == c_white) ? 0.5 : 0.9);
		draw_line_color(_l.x1,_l.y1,_l.x2,_l.y2,_l.color,_l.color);
		delete _l;
		i++;
	}
	lines_to_draw = [];
	draw_set_alpha(1);
}