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
	cell_stack  = ds_stack_create(); //could've used an array but i just wanted to have fun
	
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
						
						if (walls[dir.up]) draw_sprite(spr_onepixel,0,grid_x + _xx,grid_y + _yy);
					
					} else if (_xx == 0 and _yy == 1) { //////////////// left pixel
						
						if (walls[dir.left]) draw_sprite(spr_onepixel,0,grid_x + _xx,grid_y + _yy);
					
					} else if (_xx == 1 and _yy == 1) { //////////////// middle pixel
						
						//draw nothing
					
					} else if (_xx == 2 and _yy == 1) { //////////////// right pixel
						
						if (walls[dir.right]) draw_sprite(spr_onepixel,0,grid_x + _xx,grid_y + _yy);
					
					} else if (_xx == 1 and _yy == 2) { //////////////// bottom pixel
						
						if (walls[dir.down]) draw_sprite(spr_onepixel,0,grid_x + _xx,grid_y + _yy);
					
					} else {                            //////////////// corners
						
						draw_sprite(spr_onepixel,0,grid_x + _xx,grid_y + _yy); //always draw these
					
					}
					_yy++;
				}
				_xx++;
			}
		}
		self.map_cell   = function(x_offset,y_offset){
			var _gx = grid_x + x_offset;
			var _gy = grid_y + y_offset;
			var _xx = 0; repeat(3){
				var _yy = 0; repeat(3){
					if (_xx == 1 and _yy == 0){         //////////////// top pixel;
						
						if (walls[dir.up])	 grid_[# _gx + _xx, _gy + _yy] = VOID;
					
					} else if (_xx == 0 and _yy == 1) { //////////////// left pixel
						
						if (walls[dir.left]) grid_[# _gx + _xx, _gy + _yy] = VOID;
					
					} else if (_xx == 1 and _yy == 1) { //////////////// middle pixel
						
						//draw nothing
					
					} else if (_xx == 2 and _yy == 1) { //////////////// right pixel
						
						if (walls[dir.right])grid_[# _gx + _xx, _gy + _yy] = VOID;
					
					} else if (_xx == 1 and _yy == 2) { //////////////// bottom pixel
						
						if (walls[dir.down]) grid_[# _gx + _xx, _gy + _yy] = VOID;
					
					} else {                            //////////////// corners
						
						grid_[# _gx + _xx, _gy + _yy] = VOID; //always draw these
					
					}
					_yy++;
				}
				_xx++;
			}
		}
	}
	
	//initialize our grid
	var _xx = 0; repeat(_x_units){
		var _yy = 0; repeat(_y_units){
			maze_grid[_xx][_yy] = new _cell(_xx,_yy);
			_yy++;
		}
		_xx++;
	}
	
	//set first unit to visited
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
			a.walls[dir.left]  = false;
			b.walls[dir.right] = false;
		} else if (_x == -1){
			a.walls[dir.right] = false;
			b.walls[dir.left]  = false;
		}
		
		var _y = a.unit_y - b.unit_y;
		if (_y == 1){
			a.walls[dir.up]	  = false;
			b.walls[dir.down] = false;
		} else if (_y == -1){
			a.walls[dir.down] = false;
			b.walls[dir.up]   = false;
		}
	}
	
	do_maze_steps = function(){
		
		var _finished = false;
		var _count = 0;
		
		while (!_finished){
			_count++;
			    //STEP 1
			var _next = check_neighbors(current_cell);
			
			if (_next != undefined){
				_next.visited = true;
				//STEP 2
				ds_stack_push(cell_stack,current_cell);
			
				//STEP 3
				remove_walls(current_cell, _next);
			
				//STEP 4
				current_cell = _next;
			} else if (ds_stack_size(cell_stack) > 0){
				current_cell = ds_stack_pop(cell_stack);
			} else {
				_finished = true;
				show_debug_message("finished mazed in " + string(_count) + " steps!");
			}
		}
	}
	
	do_maze_steps();
	
	ds_stack_destroy(cell_stack);
	cell_stack = -1;
	
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

function generate_from_maze() {
	//get maze obj
	maze = create_maze(16,16);

	//resize room
	var _unit_length = 2;
	var ww = maze.x_units * _unit_length + 1;
	var hh = maze.y_units * _unit_length + 1;
	room_width  = max(CELL_SIZE * ww, global.view_width)  + CELL_SIZE * 2;
	room_height = max(CELL_SIZE * hh, global.view_height) + CELL_SIZE * 2;

	// Set up the grid
	globalvar grid_;
	width_  = room_width  div CELL_SIZE;
	height_ = room_height div CELL_SIZE;
	grid_   = ds_grid_create(width_, height_);
	ds_grid_clear(grid_,VOID);
	ds_grid_set_region(grid_,1,1,width_-2,height_-2,FLOOR);

	//init pathfinding grid
	path_grid = mp_grid_create(0,0,width_,height_,CELL_SIZE,CELL_SIZE);

	//build room from maze data
	var gx = 0; repeat(maze.x_units){
		var gy = 0; repeat(maze.y_units){
		    maze.grid[gx][gy].map_cell(1,1);
			gy++;
		}
		gx++;
	}
	
	delete maze;
	maze = -1;

	spawn_player();
	update_tiles();
}