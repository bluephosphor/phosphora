///@param attacker
function calc_player_damage(argument0) {
	var attacker		= argument0;
	var attack_power	= mob_data[# attacker.mob_id, stat.attack];
	var defense_power	= player_data[| stat.defense];
	var damage;

	damage = ceil(attack_power) - ceil(defense_power);
	damage = clamp(damage,0,100);

	var shake_mag = clamp(damage,2,8);
	var shake_dur = clamp(damage,2,60);
	screen_shake(shake_dur,shake_mag);

	hp_change = -damage;
	show_hp = true;
	alarm[1] = room_speed;

	return damage;


}
