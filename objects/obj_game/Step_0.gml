if(keyboard_check_pressed(ord("R"))) {
	game_restart();
}

// center camera on player
camera_set_view_pos(view_camera[0],plrX - camW/2 + 0.5,plrY - camH/2 + 0.5);

// when a move is taken, update board
if(keyboard_check_pressed(ord("J")) || keyboard_check_pressed(vk_space)) {
	// handle player's turn (movement, direction, attacking
	handle_player_move()
	
	// adjust species counts for graphing
	for(f = recordedSteps - 2;f >= 0; f--) {
		grassCount[f + 1] = grassCount[f];
		for(s = 0;s < numbOfSpecies; s++) {
			speciesCount[s][f + 1] = speciesCount[s][f];
		}
	}
	grassCount[0] = 0;
	for(s = 0;s < numbOfSpecies; s++) {
		speciesCount[s][0] = 0;
	}
	
	// run through all grass tiles and update spread and growth level
	simulate_grass_growth();
	
	// run through each critter and simulate their turn
	simulate_creatures();
	
	// remove dead creatures from array and data
	var listShift = 0;
	for(f = 0; f < creaCount; f++) {
		if(crea[f].eaten) {
			listShift += 1;
			speciesCount[crea[f].myType][0] -= 1;
			delete crea[f];
		} else if(listShift > 0) {
			crea[f - listShift] = crea[f];
			crea[f] = noone;
		}
	}
	creaCount -= listShift;
	
	// update all-time maxes for critter populations
	grassMax = max(grassMax,grassCount[0])
	for(s = 0; s < numbOfSpecies; s++) {
		creaMax[s] = max(creaMax[s],speciesCount[s][0])
	}
}

// Give player option or eat or sell after killing an animal
if(plrChoice) {
	if(keyboard_check_pressed(ord("K"))) {
		plrHunger = min(plrHunger + plrFeed, plrHungerMax);
		plrChoice = false;
	}
	if(keyboard_check_pressed(ord("L"))) {
		plrProfit += 1;
		plrChoice = false;
	}
}

// player starves to death
if(plrHunger <= 0) {
	game_restart();
}