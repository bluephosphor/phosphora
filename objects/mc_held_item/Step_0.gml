var put_away_item	= keyboard_check_pressed(input[| key.held]);
var use_item		= keyboard_check_pressed(input[| key.action]);

x = user.x;
y = user.y;
facing = user.image_xscale;

depth = obj_player.depth - 1;
if (draw_behind) depth = obj_player.depth + 1;


switch(item_index){
	case item.rod:
		if (using){
			global.gamestate = FISHING;
			lure_hsp = lerp(lure_hsp,0,0.05);
			lure_vsp = lerp(lure_vsp,2,0.05);
			if (lure_hsp != 0)	{lure_x += lure_hsp;}
			if (lure_y <= y)	{lure_y += lure_vsp;}
			else {
				var grid_x  = lure_x div CELL_SIZE;
				var grid_y  = lure_y div CELL_SIZE;
				var in_cell = grid_[# grid_x,grid_y];
				if (in_cell == WATER) at_rest = true;
				if (!at_rest) or (use_item){
					using = false;
					global.gamestate = INGAME;
				}
			}
		} else {
			at_rest   = false;
			lure_x	  = x;
			lure_y	  = y - 8;
			lure_hsp  = 3 * facing;
			lure_vsp  = -4;
			lure_grav = 0.5;
		}
		break;
	case item.b_potion:
		ghost_charm = true;
		break;
	case item.pickaxe:
		if (using){
			var _box = create_hitbox(x + (5 * facing),y-16, 10 * facing, 16);
			using = false;
		}
		break;
	default: using = false; break;
}


if (put_away_item){
	add_item(inventory,item_index,1);
	instance_destroy();
}