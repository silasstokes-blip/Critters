function handle_player_move(){
	// reset spear
	spearX = -1;
	spearY = -1;
	
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
	plrX = clamp(plrX, 0, gridWidth - 1);
	plrY = clamp(plrY, 0, gridHeight - 1);
	
}