//saving level data to a file

with (o_level){
	var str = "";
	var yy = 0; repeat(height_){
		var xx = 0; repeat(width_){
			str += string(grid_[# xx,yy]) + ",";
			xx++;
		}
		str += "\n";
		yy++;
	}
}

var filename = room_data[# rm.name, room] + "_" + string(global.seed) + ".csv";
var file = file_text_open_write(filename);
file_text_write_string(file,str);
file_text_close(file);

global.pause = false;
add_dialog(-1, "file '" + filename + "' saved.");