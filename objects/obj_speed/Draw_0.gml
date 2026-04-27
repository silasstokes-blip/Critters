draw_set_font(Font3)
draw_text_ext(100,100,"Click on your perferred game speed",30,room_width-20);
var button = 0;
if(mouse_x > 100 && mouse_x < 100 + (string_width("Normal") * 2) && mouse_y > 250 && mouse_y < 250 + (string_height("Normal") * 2)) {
	button = 1;
}

if(mouse_x > 700 && mouse_x < 700 + (string_width("Normal") * 2) && mouse_y > 250 && mouse_y < 250 + (string_height("Normal") * 2)) {
	button = 2;
}
draw_text_ext_transformed(100,250,"Normal",30,room_width-20,2 + ((button == 1) * 1),2 + ((button == 1) * 1),0);
draw_text_ext_transformed(700,250,"Fast",30,room_width-20,2 + ((button == 2) * 1),2 + ((button == 2) * 1),0);
if(mouse_check_button_pressed(mb_left)) {
	if(button == 1) {
		global.gameSpeed = 4
		room_goto(roomGame);
	}
	if(button == 2) {
		global.gameSpeed = 2;
		room_goto(roomGame);
	}
}
draw_sprite_ext(spr_mouse,0,mouse_x,mouse_y,2,2,0,c_white,1);