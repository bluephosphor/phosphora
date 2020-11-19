alphabet[0] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","<-","[SPACE]"];
alphabet[1] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","<-","[SPACE]"];
alphabet[2] = ["0","1","2","3","4","5","6","7","8","9","!","?",".",",",":",";","<",">","[","]","{","}","*","(",")","@","$","#","%","^","&","*","+","-","=","|","/","`","~","'","<-","[SPACE]"];

alphabet_options = ["Uppercase","Lowercase","Numbers/Other"];

list_options = [
	"They/Them",
	"She/Her",
	"He/Him",
	"Randomize them!",
	"Custom",
];

page = 0;
state = 0;

menu_index = 0;
selecting_options = false;

stored_string = player_data[| stat.name];

menu_width = global.view_width - 32;
menu_height = global.view_height - 32;
menu_x = 16;
menu_y = 16;
text_xo = menu_x + 16;
text_yo = menu_y + 32;

gamestate = DIALOGUE;

test_string = "Hello! this is a sample string! I [c_red]sure[/c] hope all of this [wave]works[/wave] when I'm done!"