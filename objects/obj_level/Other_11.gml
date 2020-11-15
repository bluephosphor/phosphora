/// @description distribute key items
key_items = [item.key];
var chest_num	= array_length_1d(chests), 
	curr_chest,
	furthest_chest,
	item_no = key_items[0],
	dist = 0,

i = 0; repeat(chest_num){
	curr_chest = chests[i];
	with (curr_chest){
		var mydist = abs(point_distance(obj_player.x,obj_player.y,x,y));
		if (mydist > dist){
			dist = mydist
			furthest_chest = id;
		}
	}
	i++;
} with (furthest_chest){
	with (instance_create_layer(x,y,"Instances",obj_chest_special)){
		add_item(chest_inventory,item_no,1);
	}
	instance_destroy(id);
}