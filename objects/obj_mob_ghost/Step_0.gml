event_inherited();

var px = obj_player.x;
var pf = obj_player.image_xscale;
//var charm = instance_exists(mc_held_item) and mc_held_item.ghost_charm == true;

var charm = true;

if (charm) or (px > x and pf == 1) or (px < x and pf == -1) {
	target_alpha = 0.6;
} else { 
	target_alpha = 0;
}

if (image_alpha != target_alpha) image_alpha = lerp(image_alpha,target_alpha,0.05);