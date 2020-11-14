/// @desc nine_slice_box(sprite, x1,y1, x2,y2);
/// @arg sprite
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
/// @arg color
function nine_slice_box_s(argument0, argument1, argument2, argument3, argument4, argument5) {

	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	var col = argument5;

	//MIDDLE//
	draw_sprite_part_ext(argument0, 0, _size, _size, 1, 1, _x1+_size, _y1+_size, _w-(_size*2), _h-(_size*2),col,1);

	//CORNERS//
	//top left
	draw_sprite_part_ext(argument0, 0, 0, 0, _size, _size, _x1, _y1,1,1,col,1);
	//top right
	draw_sprite_part_ext(argument0, 0, _size*2, 0, _size, _size, _x1+_w-_size, _y1,1,1,col,1);
	//bottom left
	draw_sprite_part_ext(argument0, 0, 0, _size*2, _size, _size, _x1, _y1+_h-_size,1,1,col,1);
	//bottom right
	draw_sprite_part_ext(argument0, 0, _size*2, _size*2, _size, _size, _x1+_w-_size, _y1+_h-_size,1,1,col,1);
	
	//EDGES//
	//left edge
	draw_sprite_part_ext(argument0, 0, 0, _size, _size, 1, _x1, _y1+_size, 1, _h-(_size*2), col,1);
	//right edge
	draw_sprite_part_ext(argument0, 0, _size*2, _size, _size, 1, _x1+_w-_size, _y1 +_size, 1, _h-(_size*2), col,1);
	//top edge
	draw_sprite_part_ext(argument0, 0, _size, 0, 1, _size, _x1+_size, _y1, _w-(_size*2), 1, col,1);
	//bottom edge
	draw_sprite_part_ext(argument0, 0, _size, _size*2, 1, _size, _x1+_size, _y1+_h-(_size), _w-(_size*2), 1 ,col,1);

}


///SAME FUNCTION BUT WITH TILED INNER-SPRITES

/// @desc nine_slice_box(sprite, x1,y1, x2,y2);
/// @arg sprite
/// @arg x1
/// @arg y1
/// @arg x2
/// @arg y2
function nine_slice_box(argument0, argument1, argument2, argument3, argument4) {

	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	var _columns = _w div _size;
	var _rows = _h div _size;

	//corners
	//top left
	draw_sprite_part(argument0, 0, 0, 0, _size, _size, _x1, _y1,);
	//top right
	draw_sprite_part(argument0, 0, _size*2, 0, _size, _size, _x1+(_columns * _size), _y1);
	//bottom left
	draw_sprite_part(argument0, 0, 0, _size*2, _size, _size, _x1, _y1 + (_rows * _size));
	//bottom right
	draw_sprite_part(argument0, 0, _size*2, _size*2, _size, _size, _x1+(_columns * _size), _y1 + (_rows * _size));
	//edges
	for (var i = 1; i < (_rows); i++;){
		//left edge
		draw_sprite_part(argument0, 0, 0, _size, _size, _size, _x1, _y1+(i*_size));
		//right edge
		draw_sprite_part(argument0, 0, _size*2, _size, _size, _size, _x1+(_columns*_size), _y1 + (i * _size));
	}

	for (var i = 1; i < (_columns); i++;){
		//top
		draw_sprite_part(argument0, 0, _size, 0, _size, _size, _x1+(i*_size), _y1);
		//bottom
		draw_sprite_part(argument0, 0, _size, _size*2, _size, _size, _x1+(i*_size), _y1 + (_rows * _size));
	}
	//middle
	for (var i = 1; i < (_columns); i++;){
		for (var j = 1; j < (_rows); j++;){
			draw_sprite_part(argument0, 0, _size, _size, _size, _size, _x1+(i*_size), _y1+(j*_size));
		}
	}
}