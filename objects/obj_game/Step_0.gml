if(keyboard_check_pressed(ord("R"))) {
	game_restart();
}

if(keyboard_check(ord("1"))) {
	game_set_speed(5, gamespeed_fps);
}
if(keyboard_check(ord("2"))) {
	game_set_speed(15, gamespeed_fps);
}
if(keyboard_check(ord("3"))) {
	game_set_speed(60, gamespeed_fps);
}
if(keyboard_check_pressed(ord("4"))) {
	envView = !envView
}

if(stepCounter > 0) {
	stepCounter -= 1;
}
if(!graphView){
	if(!envView) {
		if((keyboard_check(ord("W")) || keyboard_check(ord("A")) || keyboard_check(ord("S")) || keyboard_check(ord("D"))) && stepCounter == 0) {
			handle_player_move();
			stepCounter = 1;
		}
	
		plrHunger -= 0.05;
	}
	gameTime += 1;
}
if(clamp(round(plrX),chartX - 1,chartX + 2) == round(plrX) && clamp(round(plrY),chartY - 1,chartY + 2) == round(plrY)) {
	if(!viewClosed && !graphView) {
		graphView = true;
		envView = true;
	}
} else if(clamp(round(plrX),teleX - 1,teleX + 2) == round(plrX) && clamp(round(plrY),teleY - 1,teleY + 2) == round(plrY)) {
	if(!viewClosed && !envView) {
		envView = true;
	}
} else {
	viewClosed = false;
}
if((graphView || envView) && keyboard_check_pressed(vk_escape)) {
	envView = false;
	graphView = false;
	viewClosed = true;
}
if(spearTime > -1) {
	spearTime += 1;
	spearLength -= 0.2 * (1 - spearLength) + 0.02;
	
	spearX = plrX + lengthdir_x(spearLength * 0.15 * 32,spearDir);
	spearY = plrY + lengthdir_y(spearLength * 0.15 * 32,spearDir);
	if(spearTime > 12) {
		spearTime = -1;
		spearLength = 0;
	}
} else {
	spearX = -100;
	spearY = -100;
}
if(mouse_check_button(mb_left) && spearTime = -1) {
	spearTime += 1;
	spearDir = point_direction(plrX + 0.5,plrY + 0.5, mouse_x, mouse_y);
	spearLength = 1;
}

plrHunger = min(plrHunger,plrHungerMax);
// when a move is taken, update board
if(!graphView) {//keyboard_check_pressed(ord("J")) || keyboard_check_pressed(vk_space) || keyboard_check(ord("1")) || keyboard_check(ord("2")) || keyboard_check(ord("3"))) {
	// handle player's turn (movement, direction, attacking
	
	
	// adjust species counts for graphing
	if(gameTime%4 == 0) {
		for(f = recordedSteps - 2;f >= 0; f--) {
			grassCount[f + 1] = grassCount[f];
			profitCount[f + 1] = profitCount[f];
			for(s = 0;s < numbOfSpecies; s++) {
				speciesCount[s][f + 1] = speciesCount[s][f];
			}
		}
	
		for(s = 0;s < numbOfSpecies; s++) {
			speciesCount[s][0] = 0;
		}
		
		profitCount[0] = plrProfit;
		profitMax = plrProfit;
	}
	
	// run through all grass tiles and update spread and growth level
	if(gameTime%2 == 0) { 
		grassCount[0] = 0;
		simulate_grass_growth(); 
	}
	
	// run through each critter and simulate their turn
	simulate_creatures(gameTime%2 == 0);
	
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
if(plrHunger <= 0 && deathAnim == -1) {
	deathAnim = 120;
	part_particles_create(partSys,plrX,plrY,partTypePlr,200);
	plrX = -1000;
	plrY = -1000;
}

// Death anim done
if(deathAnim = 0) {
	if(plrLives > 0) {
		plrHunger = plrHungerMax;
		plrLives -= 1;
		plrX = respawnX;
		plrY = respawnY;
	} else {
		persistent = true;
		room_goto(roomEnd);
		obj_end.recordedSteps = recordedSteps;
		obj_end. = recordedSteps;
	}
}

// count down death anim

if(deathAnim >= 0) {
	deathAnim -= 1;
	if(plrHunger > 0) {
		plrHunger = plrHungerMax;
	}
}

// center camera on player

if(envView) {
	camX = 0;
	camY = 0;
	camW = room_width;
	camH = room_height;
} else if(deathAnim == -1) {
	camX = plrX - camW/2 + 0.5;
	camY = plrY - camH/2 + 0.5;
	camW = 64;
	camH = 36;
}

camera_set_view_pos(view_camera[0],camX,camY);
camera_set_view_size(view_camera[0],camW,camH);