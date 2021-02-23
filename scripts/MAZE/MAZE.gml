enum dir {
	up,
	right,
	down,
	left
}

function create_maze(_x_units,_y_units) {
	
	maze_width  = _x_units;
	maze_height = _y_units;
	maze_grid   = [];
	
	var _cell = function(unit_x,unit_y) constructor{
		var _unit_length = 2;
		self.unit_x = unit_x;
		self.unit_y = unit_y;
		self.grid_x = _unit_length * unit_x;
		self.grid_y = _unit_length * unit_y;
		self.walls  = [true,true,true,true];
		self.visited = false;
		self.draw   = function(){
			var _xx = 0; repeat(3){
				var _yy = 0; repeat(3){
					if (_xx == 1 and _yy == 0){         //////////////// top pixel;
						
						if (walls[dir.up]) draw_sprite(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy);
					
					} else if (_xx == 0 and _yy == 1) { //////////////// left pixel
						
						if (walls[dir.left]) draw_sprite(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy);
					
					} else if (_xx == 1 and _yy == 1) { //////////////// middle pixel
						
						//if (visited) draw_sprite_ext(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy,1,1,0,c_red,1);
					
					} else if (_xx == 2 and _yy == 1) { //////////////// right pixel
						
						if (walls[dir.right]) draw_sprite(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy);
					
					} else if (_xx == 1 and _yy == 2) { //////////////// bottom pixel
						
						if (walls[dir.down]) draw_sprite(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy);
					
					} else {                            //////////////// corners
						
						draw_sprite(spr_onepixel,0,self.grid_x + _xx,self.grid_y + _yy); //always draw these
					
					}
					_yy++;
				}
				_xx++;
			}
		}
	}
	var _xx = 0; repeat(_x_units){
		var _yy = 0; repeat(_y_units){
			maze_grid[_xx][_yy] = new _cell(_xx,_yy);
			_yy++;
		}
		_xx++;
	}
	
	current_cell = maze_grid[0][0]; current_cell.visited = true;
	
	check_neighbors = function(cell){
		var _neighbors = [];
			
		var _top	= (cell.unit_y > 0)				  ? maze_grid[cell.unit_x]   [cell.unit_y-1] : undefined;
		var _right	= (cell.unit_x < maze_width - 1)  ? maze_grid[cell.unit_x+1] [cell.unit_y]   : undefined;
		var _bottom = (cell.unit_y < maze_height - 1) ? maze_grid[cell.unit_x]   [cell.unit_y+1] : undefined;
		var _left	= (cell.unit_x > 0)				  ? maze_grid[cell.unit_x-1] [cell.unit_y]   : undefined;
			
		if (_top	!= undefined and !_top.visited)		array_push(_neighbors,_top);
		if (_right	!= undefined and !_right.visited)	array_push(_neighbors,_right);
		if (_bottom != undefined and !_bottom.visited)	array_push(_neighbors,_bottom);
		if (_left	!= undefined and !_left.visited)	array_push(_neighbors,_left);
			
		var _len = array_length(_neighbors);
			
		return ( _len > 0) ? _neighbors[irandom(_len-1)] : undefined;
			
	}
	
	remove_walls = function(a,b){
		var _x = a.unit_x - b.unit_x;
		if (_x == 1){
			a.walls[dir.left] = false;
			b.walls[dir.right] = false;
		} else if (_x == -1){
			a.walls[dir.right] = false;
			b.walls[dir.left] = false;
		}
		
		var _y = a.unit_y - b.unit_y;
		if (_y == 1){
			a.walls[dir.up] = false;
			b.walls[dir.down] = false;
		} else if (_y == -1){
			a.walls[dir.down] = false;
			b.walls[dir.up] = false;
		}
	}
	
	do_maze_step = function(){
		//STEP 1
		var _next = check_neighbors(current_cell);
		if (_next != undefined){
			_next.visited = true;
			//STEP 3
			remove_walls(current_cell, _next);
			
			//STEP 4
			current_cell = _next;
		}
	}
	repeat(100) do_maze_step();
	
	return {
		grid: maze_grid,
		x_units: _x_units,
		y_units: _y_units,
		draw: function(){
			var _xx = 0; repeat(self.x_units){
				var _yy = 0; repeat(self.y_units){
					self.grid[_xx][_yy].draw();
					_yy++;
				}
				_xx++;
			}
		}
	}
}