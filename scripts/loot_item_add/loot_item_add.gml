function loot_item_add() {
	var len		= array_length_2d(loot_table,0) - 1;
	var die		= irandom(len);
	var itm		= loot_table[0,die];
	var chance	= loot_table[1,die];

	if (random(100) <= chance){
		if (chance <= 5) {
			debug_log_add("Spawned a " + item_info[# 0,itm] + "!");
		}
		return itm;
	} else {
		return item.none;
	}


}
