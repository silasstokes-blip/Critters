if(keyboard_check_pressed(vk_space)) {
	instance_destroy(obj_game);
	room_goto(roomTut);
}