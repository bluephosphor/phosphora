///@param duration
///@param magnitude
function screen_shake(argument0, argument1) {
	if (!global.screen_shake) exit;
	with(obj_camera){
		shake_length = argument0;
		shake_magnitude = argument1;
		shake_remain = argument1;
	}
}