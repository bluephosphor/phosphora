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
