event_inherited();
mob_id = mob.ghost;
hp = mob_data[# mob_id,stat.hp];
passive = true;
attack_type = PASSIVE;
nocturnal = true;

stats_reset();
update_movement = true;
xmove = 0;
ymove = 0;
detection_radius = 64;
attack_direction = 0;

interact_state = INTERACTABLE;

passive_frames = [0,1,2,3,4,5,6,7];
aggro_frames = [0];
hitstun_frames = [0];

target_alpha = 0;

current_anim = passive_frames;
anim_speed = 10;

image_alpha = 0;
image_speed = 0;

with (instance_create_layer(x,y,layer,mc_lightsource)){
	follow = other.id;
	light_strength = 1;
}

var message = choose(
	["[sound,laugh][wave]Eee hee hee![/wave] are you lost?"],
	["It's okay if you die in here. I'll be here to show you around.","[sound,laugh][wave]Eee hee hee![/wave]"],
	["I've been told that I don't need this lantern because I am my own lightsource, but what if I like the aesthetics?!"],
	["You remind me of my first time in the forest.","I was just a terrified as you look now! [sound,laugh][wave]Eee hee hee![/wave]"],
	["Don't stress too much if you feel lost. You'll get used to it! [sound,laugh][wave]Eee hee hee![/wave]"],
	["How long have I been dead? Well, didn't you know that it's rude to ask a ghost their age? [sound,laugh][wave]Eee hee hee![/wave]"],
	["[shake][wave]Boooooooooo!!!![/wave][/shake]","Oh, well you're no fun, now are you?"]
);

var i = 0; repeat(array_length(message)){
	mytext[i] = [-1,message[i]];
	i++;
}