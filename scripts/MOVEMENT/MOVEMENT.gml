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

function grid_collision_point(grid,celltype,x,y) {
	 return (grid[# x div CELL_WIDTH, y div CELL_HEIGHT] == celltype);
}


function move_commit(){
	xspeed += xmove * acceleration;
	yspeed += ymove * acceleration;
	var _speed = point_distance(0, 0, xspeed, yspeed);
	var _direction = point_direction(0, 0, xspeed, yspeed);
	if (_speed > max_speed) {
		xspeed = lengthdir_x(max_speed, _direction);
		yspeed = lengthdir_y(max_speed, _direction);
	}
	if (xmove == 0) {
		xspeed = lerp(xspeed, 0, frict);
	}
	if (ymove == 0) {
		yspeed = lerp(yspeed, 0, frict);
	}
}

function move_and_collide() {
	// Move horizontally
	x += xspeed;

	// Right collisions
	if xspeed > 0 {
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			xspeed = 0;
		}
	} else if xspeed < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			xspeed = 0;
		}
	}

	// Move vertically
	y += yspeed;

	// Vertical collisions
	if yspeed > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			yspeed = 0;
		}
	} else if yspeed < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			yspeed = 0;
		}
	}
}

function move_and_collide_inwater() {
	// Move horizontally
	x += xspeed;

	// Right collisions
	if xspeed > 0 {
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			xspeed = 0;
		}
	} else if xspeed < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			xspeed = 0;
		}
	}

	// Move vertically
	y += yspeed;

	// Vertical collisions
	if yspeed > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			yspeed = 0;
		}
	} else if yspeed < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			yspeed = 0;
		}
	}
}


function move_and_bounce() {
	// Move horizontally
	x += xspeed;

	// Right collisions
	if xspeed > 0 {
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			xspeed = -xspeed * 0.5;
		}
	} else if xspeed < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			xspeed = -xspeed * 0.5;
		}
	}

	// Move vertically
	y += yspeed;

	// Vertical collisions
	if yspeed > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			yspeed = -yspeed * 0.5;
		}
	} else if yspeed < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			yspeed = -yspeed * 0.5;
		}
	}
}