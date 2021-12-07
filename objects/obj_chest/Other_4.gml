if (!autogen) exit;

var i = 0, _slot; repeat(entries){
	
	if (i < 15 and chest_inventory[# ITEM_ID,i] == item.none){
		_slot = loot_item_add();
		chest_inventory[# ITEM_ID,	i]	= _slot.item;
		chest_inventory[# COUNT,	i]	= _slot.count;
	} 
	
	var _obj = item_info[# PROPS, _slot.item];
	
	if (is_struct(_obj)){
		if (variable_struct_exists(_obj,"effect_table")) {
			chest_inventory[# PROPERTIES, i] = {inflicts : loot_item_effect(_obj.effect_table)};
		}
	}
	
	i++;
}