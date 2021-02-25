function fill_frametype(arr,type) {
	var i = 0, _img_index; repeat (array_length(arr)){
		_img_index = arr[i];
		frame_type[_img_index] = type;
		i++;
	}
}

function hitbox(x,y,width,height,strength) constructor{
	self.x = x;
	self.y = y;
	self.width  = x+width;
	self.height = y+height;
	self.strength = strength;
	
	self.point_check = function(x,y){
		return (
			x > self.x     and
			x < self.width and
			y > self.y     and
			y < self.height
		);
	}
	
	self.instance_check = function(inst){
		var _list = ds_list_create();
		var _num  = collision_rectangle_list(x,y,width,height,inst,false,false,_list,true);
		
		if (_num <= 0) return noone;
		else return {
			count: _num,
			list:  _list
		}
	}
	
	self.grid_collision = function(_grid, _celltype){
		
		if (_grid[# (width-1) div CELL_SIZE,  y div CELL_SIZE] == _celltype){
			return new vec2(width,y);
		}
		
		if (_grid[# x div CELL_SIZE,  y div CELL_SIZE] == _celltype) {
			return new vec2(x,y);
		}
		
		if (_grid[# (width-1) div CELL_SIZE, (height-1) div CELL_SIZE] == _celltype){
			return new vec2(width-1,height-1);
		}
		
		if (_grid[# x div CELL_SIZE, (height) div CELL_SIZE] == _celltype){
			return new vec2(x,height);
		}

		return undefined;

	}
	
	self.draw = function(color){
		draw_rectangle_color(x,y,width,height,color,color,color,color,false);
	}
}

function create_hitbox(x,y,width,height,strength){
	var _box = new hitbox(x,y,width,height,strength);
	
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