///@param modifier
///@param magic_attack?
function calc_mob_damage(argument0, argument1) {
	var modifier		= argument0;
	var magic_attack	= argument1;
	var attack_power	= player_data[? stat.attack] * modifier;
	var defense_power	= mob_data[# mob_id, stat.defense];
	var damage;

	if (magic_attack) {
		attack_power = player_data[? stat.sp_attack] * modifier;
		if (cont_daycycle.witching_hour) {
			draw_color = c_fuchsia;
			attack_power += attack_power;
		}
	}

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
