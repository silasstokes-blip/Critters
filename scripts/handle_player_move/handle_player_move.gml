function handle_player_move(){
	// reset spear
	spearX = -1;
	spearY = -1;
	
	// reset player chance to eat or sell
	plrChoice = false;
	
	// adjust direction to most recently held directional key
	if(keyboard_check(ord("W"))) {
		plrDir = 1;
	}
	if(keyboard_check_pressed(ord("A"))) {
		plrDir = 2;
	}
	if(keyboard_check_pressed(ord("S"))) {
		plrDir = 3;
	}
	if(keyboard_check_pressed(ord("D"))) {
		plrDir = 0;
	}
	
	// move
	if(keyboard_check_pressed(vk_space)) {
		if(plrDir == 0) {
			plrX += 1;
		}
		if(plrDir == 1) {
			plrY -= 1
		}
		if(plrDir == 2) {
			plrX -= 1;
		}
		if(plrDir == 3) {
			plrY += 1;
		}
	}
	
	// attack
	if(keyboard_check_pressed(ord("J"))) {
		if(plrDir == 0) {
			spearX = plrX + 1;
			spearY = plrY;
		}
		if(plrDir == 1) {
			spearX = plrX;
			spearY = plrY - 1;
		}
		if(plrDir == 2) {
			spearX = plrX - 1;
			spearY = plrY;
		}
		if(plrDir == 3) {
			spearX = plrX;
			spearY = plrY + 1;
		}
	}
}