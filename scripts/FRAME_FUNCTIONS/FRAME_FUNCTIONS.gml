function fill_frametype(arr,type) {
	var i = 0, _img_index; repeat (array_length(arr)){
		_img_index = arr[i];
		frame_type[_img_index] = type;
		i++;
	}
}

function hitbox(x,y,width,height) constructor{
	self.x = x;
	self.y = y;
	self.width  = x+width;
	self.height = y+height;
	self.point_check = function(x,y){
		return (
			x > self.x     and
			x < self.width and
			y > self.y     and
			y < self.height
		);
	}
	self.grid_collision = function(_grid, _celltype){

		var _top_right		= _grid[# (width-1) div CELL_SIZE,  y div CELL_SIZE] == _celltype;
		var _top_left		= _grid[#  x	    div CELL_SIZE,  y div CELL_SIZE] == _celltype;
		var _bottom_right	= _grid[# (width-1) div CELL_SIZE, (height-1) div CELL_SIZE] == _celltype;
		var _bottom_left	= _grid[#  x	    div CELL_SIZE, (height)   div CELL_SIZE] == _celltype;

		return _top_right || _top_left || _bottom_right || _bottom_left;

	}
	self.draw = function(color){
		draw_rectangle_color(x,y,width,height,color,color,color,color,false);
	}
}

function create_hitbox(x,y,width,height){
	var _box = new hitbox(x,y,width,height);
	
	array_push(hitboxes,_box);
	return _box;
}

function draw_hitboxes(){
	var _len = array_length(hitboxes);
	if (_len <= 0) exit;
	
	draw_set_alpha(0.5);
	var i = 0; repeat(_len){
		hitboxes[i].draw(c_red);
		delete hitboxes[i];
		i++;
	}
	hitboxes = [];
	draw_set_alpha(1);
}