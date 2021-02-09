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


function move_commit(){
	x_speed_ += xmove * acceleration_;
	y_speed_ += ymove * acceleration_;
	var _speed = point_distance(0, 0, x_speed_, y_speed_);
	var _direction = point_direction(0, 0, x_speed_, y_speed_);
	if (_speed > max_speed_) {
		x_speed_ = lengthdir_x(max_speed_, _direction);
		y_speed_ = lengthdir_y(max_speed_, _direction);
	}
	if (xmove == 0) {
		x_speed_ = lerp(x_speed_, 0, .3);
	}
	if (ymove == 0) {
		y_speed_ = lerp(y_speed_, 0, .3);
	}
}

function move_and_collide() {
	// Move horizontally
	x += x_speed_;

	// Right collisions
	if x_speed_ > 0 {
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			x_speed_ = 0;
		}
	} else if x_speed_ < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			x_speed_ = 0;
		}
	}

	// Move vertically
	y += y_speed_;

	// Vertical collisions
	if y_speed_ > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			y_speed_ = 0;
		}
	} else if y_speed_ < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			y_speed_ = 0;
		}
	}
}

function move_and_collide_inwater() {
	// Move horizontally
	x += x_speed_;

	// Right collisions
	if x_speed_ > 0 {
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			x_speed_ = 0;
		}
	} else if x_speed_ < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			x_speed_ = 0;
		}
	}

	// Move vertically
	y += y_speed_;

	// Vertical collisions
	if y_speed_ > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			y_speed_ = 0;
		}
	} else if y_speed_ < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) or (grid_place_meeting(self, grid_,FLOOR)){
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			y_speed_ = 0;
		}
	}
}


function move_and_bounce() {
	// Move horizontally
	x += x_speed_;

	// Right collisions
	if x_speed_ > 0 {
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_right&~(CELL_WIDTH-1);
			x -= bbox_right-x;
			x_speed_ = -x_speed_ * 0.5;
		}
	} else if x_speed_ < 0 {
		// Left collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			x = bbox_left&~(CELL_WIDTH-1);
			x += CELL_WIDTH+x-bbox_left;
			x_speed_ = -x_speed_ * 0.5;
		}
	}

	// Move vertically
	y += y_speed_;

	// Vertical collisions
	if y_speed_ > 0 {
		// Bottom collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_bottom&~(CELL_HEIGHT-1);
			y -= bbox_bottom-y;
			y_speed_ = -y_speed_ * 0.5;
		}
	} else if y_speed_ < 0 {
		// Top collisions
		if (grid_place_meeting(self, grid_,VOID)) {
			y = bbox_top&~(CELL_HEIGHT-1);
			y += CELL_HEIGHT+y-bbox_top;
			y_speed_ = -y_speed_ * 0.5;
		}
	}
}