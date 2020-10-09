///@description coord_outside_view
///@param x
///@param y
///@param [radius]
function coord_outside_view() {

	var xx = argument[0];
	var yy = argument[1];
	var flag = false;
	var xrad = global.view_width / 2;
	var yrad = global.view_height / 2;

	if (argument_count > 2){
		xrad += argument[2];
		yrad += argument[2];
	} 

	with (o_camera) {
		if (xx > x + xrad) flag = true;
		if (xx < x - xrad) flag = true;
		if (yy > y + yrad) flag = true;
		if (yy < y - yrad) flag = true;
	}

	return flag;


}
