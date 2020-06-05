active = true;

switch(room){
	case r_dungeon: target_room = r_outside; break;
	default: target_room = r_dungeon; break;
}