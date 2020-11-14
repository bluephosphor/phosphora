function scr_item_info() {
	//coins data
	enum coin{
		gold, silver, bronze, height,
	}
	globalvar coin_data;
	var _width = 2;
	var _height = coin.height;
	coin_data = ds_grid_create(_width,_height);
	ds_grid_set_region(coin_data,0,0,_width,_height,-1);
	//coin values
	coin_data[# 0, coin.gold]   = 10;
	coin_data[# 0, coin.silver] = 5;
	coin_data[# 0, coin.bronze] = 1;

	//init items enum
	enum item {
		none		= 0,
		r_potion	= 1,
		b_potion	= 2, 
		key			= 3,
		iqueur		= 4,
		note		= 5,
		ears		= 6,
		rift_a		= 7,
		rift_b		= 8,
		rift_c		= 9,
		apple		= 10,
		rubellite	= 11,
		rod			= 12,
		card		= 13,
		ps_fire		= 14,
		ps_thunder	= 15,
		ps_gust		= 16,
		diamond		= 17,
		p_berries	= 18,
		p_leaf		= 19,
		p_shroom	= 20,
		height		= 21,
	}
	globalvar item_info;
	var _width = 5;
	var _height = item.height;
	item_info = ds_grid_create(_width,_height);
	ds_grid_set_region(item_info,0,0,_width,_height,-1);

#macro ITEM 0
#macro INFO 1
#macro SCRIPT 2
#macro STACK_LIMIT 3
#macro COLOR 4

	//item info (names)
	var z = 0;
	item_info[# ITEM,z++] = "-----------";
	item_info[# ITEM,z++] = "Red Potion";
	item_info[# ITEM,z++] = "Blue Potion";
	item_info[# ITEM,z++] = "Key";
	item_info[# ITEM,z++] = "Forbidden Iqueur";
	item_info[# ITEM,z++] = "Note";
	item_info[# ITEM,z++] = "Cat Ears";
	item_info[# ITEM,z++] = "Rift Matrix A";
	item_info[# ITEM,z++] = "Rift Matrix B";
	item_info[# ITEM,z++] = "Rift Matrix C";
	item_info[# ITEM,z++] = "Apple";
	item_info[# ITEM,z++] = "Rubellite";
	item_info[# ITEM,z++] = "Fishing Rod";
	item_info[# ITEM,z++] = "Business Card";
	item_info[# ITEM,z++] = "PS Fire";
	item_info[# ITEM,z++] = "PS Thunder";
	item_info[# ITEM,z++] = "PS Gust";
	item_info[# ITEM,z++] = "Diamond";
	item_info[# ITEM,z++] = "Phosphora Berries";
	item_info[# ITEM,z++] = "Phosphora Leaf";
	item_info[# ITEM,z++] = "Phosphora Shroom";

	//item info (descriptions)
	z = 0;
	item_info[# INFO,z++] = "";
	item_info[# INFO,z++] = "A bottle of concentrated life essence. Restores 10 to 20 HP when consumed.";
	item_info[# INFO,z++] = "A bottle of concentrated life essence that has been tampered with in an unknown way. Slowly restores HP for a duration of 10 to 20 seconds.";
	item_info[# INFO,z++] = "A brightly colored key. It glows with a fantastical light. Will open regular doors once.";
	item_info[# INFO,z++] = "A strange vile containing an unknown essence. Consumption is NOT recommended";
	item_info[# INFO,z++] = "A piece of parchment with a message from unknown origin. If you read it, it will dissapear.";
	item_info[# INFO,z++] = "These don't really have a use save for a very modest defense buff. Can you even be damaged yet? Anyways they're really cute.";
	item_info[# INFO,z++] = "You need this to continue.";
	item_info[# INFO,z++] = "This is important... Better make room for it.";
	item_info[# INFO,z++] = "You were looking for this.";
	item_info[# INFO,z++] = "A modest snack. Restores 5 to 7 HP.";
	item_info[# INFO,z++] = "Incredibly rare gemstone. How lucky!";
	item_info[# INFO,z++] = "You're not much for fishing, but maybe it could come to use someday?";
	item_info[# INFO,z++] = "This is... Admittedly a strange find.";
	item_info[# INFO,z++] = "A fiery Pocket Spell! Cast to summon 3-5 fireballs into the direction you're facing. The ability stores in your Spin Attack when item is used.";
	item_info[# INFO,z++] = "A thunderous Pocket Spell! Cast to strike up to 3 enemies within range with lightning! The ability stores in your Spin Attack when item is used.";
	item_info[# INFO,z++] = "A windy Pocket Spell! Cast to summon a tornado in the direction you're facing. The ability stores in your Spin Attack when item is used.";
	item_info[# INFO,z++] = "A treasure from dungeons that could be worth a pretty penny if sold!";
	item_info[# INFO,z++] = "A forbidden delicacy from the Deep Grove. There isn't much information on these except for reports of... strange occurrences once consumed by non natives.";
	item_info[# INFO,z++] = "A leaf from a Phosphora Tree. Many take these as souvenirs or as proof that they've seen the Sacred Deep Grove.";
	item_info[# INFO,z++] = "These require special tools to be able to harvest safely from the Deep Grove. This requirement, along with the rarity of the grove's appearance, makes these a special find.";

	//item_script
	item_info[# SCRIPT,item.r_potion]	= scr_use_healingitem;
	item_info[# SCRIPT,item.apple]		= scr_use_healingitem;
	item_info[# SCRIPT,item.iqueur]		= scr_use_healingitem;
	item_info[# SCRIPT,item.p_shroom]	= scr_use_healingitem;
	item_info[# SCRIPT,item.note]		= scr_usenote;
	item_info[# SCRIPT,item.card]		= scr_item_inst_create;
	item_info[# SCRIPT,item.rift_a]		= scr_userift;
	item_info[# SCRIPT,item.rift_b]		= scr_userift;
	item_info[# SCRIPT,item.rift_c]		= scr_userift;
	item_info[# SCRIPT,item.ps_thunder]	= scr_cast_spell;
	item_info[# SCRIPT,item.ps_fire]		= scr_cast_spell;
	item_info[# SCRIPT,item.ears]		= scr_test_question;

	//stack limit
	ds_grid_set_region(item_info,STACK_LIMIT,0,STACK_LIMIT,item.height,32);

	//draw color
	ds_grid_set_region(item_info,COLOR,0,COLOR,item.height,c_white);
	item_info[# COLOR,item.iqueur]		= c_red;
	item_info[# COLOR,item.ears]		= c_teal;
	item_info[# COLOR,item.rubellite]	= c_fuchsia;

	var str = "", i = 0; repeat(ds_grid_height(item_info)){
		str += string(item_info[# ITEM,i]) + ";";
		str += string(item_info[# INFO,i]) + ";";
		str += string(item_info[# SCRIPT,i]) + ";";
		str += string(item_info[# STACK_LIMIT,i]) + ";";
		str += string(item_info[# COLOR,i]) + "\n";
		i++;
	}
	var file = file_text_open_write("item_info.csv");
	file_text_write_string(file,str);
	file_text_close(file);


}
