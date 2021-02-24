/// @param mob
function spawn_mob(argument0) {

	var obj		 = mob_data[# argument0, stat.object];
	var celltype = mob_data[# argument0, stat.spawn_cell];
	var name	 = mob_data[# argument0, stat.name];

	switch(celltype){
		case FLOOR: var cellstr = "floor "; break;
		case WATER: var cellstr = "water "; break;
		case VOID:  var cellstr = "void ";  break;
	}

	var flag = false; repeat(100) {
		var xx = irandom_range(2, width_ - 2);
		var yy = irandom_range(2, height_ - 2);
		if (grid_[# xx,yy] == celltype){
			var spawn_x = xx * CELL_SIZE + 16;
			var spawn_y = yy * CELL_SIZE + 16;
			flag = (coord_outside_view(spawn_x,spawn_y));
			if (flag == true) break;
		}
	}

	if (!flag) {
		debug_log_add("Couldn't find a " + cellstr + "space to spawn a " + name + "!");
		exit;
	}

	instance_create_layer(spawn_x,spawn_y,"Instances",obj);
	debug_log_add("Spawned a " + name + "!");


}

globalvar lines_to_draw; lines_to_draw = [];

function check_sight(x,y,min_dir,max_dir,max_dist){
	var _d = global.debug;
	var _inc = 8;
	var _len = _inc;
	var _check_pos, _line;
	while (min_dir < max_dir){
		_line = false;
		_check_pos = {};
		_len = _inc;
		
		var i = 0; repeat(max_dist){
			_check_pos.x = x + lengthdir_x(_len,min_dir);
			_check_pos.y = y + lengthdir_y(_len,min_dir);
			
			if (grid_collision_point(grid_,VOID,_check_pos.x,_check_pos.y)) {
				_line = true;
				if (_d) array_push(lines_to_draw,{x1: x, y1: y, x2: _check_pos.x, y2: _check_pos.y, color: c_aqua});
				break;
			} else if (collision_point(_check_pos.x,_check_pos.y,obj_player,false,false)){
				if (_d) array_push(lines_to_draw,{x1: x, y1: y, x2: _check_pos.x, y2: _check_pos.y, color: c_red});
				return true;
			}
			
			_len += _inc;
			i++;
		}
		if (_d and !_line) array_push(lines_to_draw,{x1: x, y1: y, x2: _check_pos.x, y2: _check_pos.y, color: c_white});
		min_dir += 2;
	}
}