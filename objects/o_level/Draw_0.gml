if (!global.show_grid) exit;

var xx, yy, c, str;

c = c_red;
xx = 0; repeat(width_){
	draw_line_color(CELL_WIDTH * xx, 0, CELL_WIDTH * xx, room_height,c,c);
	xx++;
}
yy = 0; repeat(height_){
	xx = 0; repeat(width_){
		str = string(grid_[# xx,yy]);
		draw_text_color(
			CELL_WIDTH * xx + 14,
			CELL_HEIGHT * yy + 14,
			str,c,c,c,c,1
		);
		xx++;
	}
	draw_line_color(0, CELL_HEIGHT * yy, room_width, CELL_HEIGHT * yy,c,c);
	yy++;
}