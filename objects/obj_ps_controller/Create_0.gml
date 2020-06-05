spelltype = item.none;

cast = false;

fireball = ds_list_create();
var i = 0; repeat(2){
	fireball[| i] = noone;
	i++;
}
timer = 50;
spawncount = 0;
light_inst = -1;