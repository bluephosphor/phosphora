if (!autogen) exit;

var i = 0; repeat(entries){
	
	if (i < 15 and chest_inventory[# ITEM_ID,i] == item.none){
		var _slot = loot_item_add();
		chest_inventory[# ITEM_ID,	i]	= _slot.item;
		chest_inventory[# COUNT,	i]	= _slot.count;
		
		// add special properties like potion effects
		
		var _room_properties = room_data[# rm.props, room]
		if (_room_properties != -1) && (variable_struct_exists(_room_properties,"item_pools")) {
			var _j = 0; repeat (array_length(_room_properties.item_pools)){
				var _item_id = _room_properties.item_pools[_j].item_index
				if (_item_id == _slot.item){
					chest_inventory[# PROPERTIES, i] = {inflicts : loot_item_effect(_room_properties.item_pools[_j].effect_table)};
					continue;
				}
				_j++;
			}
		} else {
			var _item_properties = item_info[# PROPS, _slot.item];
			if (is_struct(_item_properties)){
				if (variable_struct_exists(_item_properties,"effect_table")) {
					chest_inventory[# PROPERTIES, i] = {inflicts : loot_item_effect(_item_properties.effect_table)};
				}
			}
		}
	} 
	
	i++;
}