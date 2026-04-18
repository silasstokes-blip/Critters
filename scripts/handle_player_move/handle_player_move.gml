function handle_player_move(){
	// reset spear
	spearX = -1;
	spearY = -1;
	
	// reset player chance to eat or sell
	if(plrChoice) {
		plrHunger += 5;
		plrProfit += 5;
	}
	plrChoice = false;
	
	// adjust direction to most recently held directional key
	if(keyboard_check(ord("W"))) {
		plrY -= 0.5
	}
	if(keyboard_check(ord("A"))) {
		plrX -= 0.5;
	}
	if(keyboard_check(ord("S"))) {
		plrY += 0.5;
	}
	if(keyboard_check(ord("D"))) {
		plrX += 0.5;
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