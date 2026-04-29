if(keyboard_check_pressed(ord("R"))) {
	game_restart();
}

if(keyboard_check_pressed(ord("4"))) {
	envView = !envView
}
stepTime += 1;
if(stepCounter > 0) {
	stepCounter -= 1;
}
moneyPromptAlpha -= 1/40;
if(keyboard_check_pressed(ord("E"))) {
	placeView = !placeView;
}
if(!graphView && !shopView){
	if(!envView) {
		if((keyboard_check(ord("W")) || keyboard_check(ord("A")) || keyboard_check(ord("S")) || keyboard_check(ord("D"))) && stepCounter == 0) {
			handle_player_move();
			stepCounter = 1;
		}
	
		plrHunger -= hungerRate;
	}
	gameTime += 1;
	timeLeft -= 1/60;
}
if(creaCount <= 0) {
	hungerRate *= 1.001
}
if(keyboard_check_pressed(ord("F"))) {
	miniFoodChain = !miniFoodChain
}
audio_listener_set_position(0,plrX,plrY,0);
audio_falloff_set_model(audio_falloff_inverse_distance_clamped);
if(room == roomTitle) {
	plrHunger = 100000;
	plrX = -10000;
	plrY = -10000;
	houseX1 = -10000;
	houseY1 = -10000;
	houseX2 = houseX1 + houseW;
	houseY2 = houseY1 + houseH;
	chartX = -10000;
	teleX = -10000;
	shopX = -10000;
	envView = true
	global.gameSpeed = 2;
	if(mouse_check_button_pressed(mb_left)) {
		room_goto(roomTut);
	}
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
} else if(clamp(round(plrX),shopX - 1,shopX + 2) == round(plrX) && clamp(round(plrY),shopY - 1,shopY + 2) == round(plrY)) {
	if(!viewClosed && !envView) {
		shopView = true;
		envView = true;
	}
} else {
	viewClosed = false;
}
if((graphView || envView) && keyboard_check_pressed(vk_escape)) {
	envView = false;
	graphView = false;
	shopView = false;
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
if(mouse_check_button(mb_left) && spearTime = -1 && !envView) {
	spearTime += 1;
	spearDir = point_direction(plrX + 0.5,plrY + 0.5, mouse_x/cellSize, mouse_y/cellSize);
	spearLength = 1;
}

plrHunger = min(plrHunger,plrHungerMax);
// when a move is taken, update board
if(!graphView && !shopView) {//keyboard_check_pressed(ord("J")) || keyboard_check_pressed(vk_space) || keyboard_check(ord("1")) || keyboard_check(ord("2")) || keyboard_check(ord("3"))) {
	// handle player's turn (movement, direction, attacking
	
	
	// adjust species counts for graphing
	if(gameTime%16 == 0) {
		for(f = recordedSteps - 2;f >= 0; f--) {
			grassCount[f + 1] = grassCount[f];
			profitCount[f + 1] = profitCount[f];
			for(s = 0;s < numbOfSpecies; s++) {
				speciesCount[s][f + 1] = speciesCount[s][f];
			}
		}
	
		
		profitCount[0] = plrProfit;
		profitMax = max(plrProfit,plrProfit);
	}
	for(s = 0;s < numbOfSpecies; s++) {
		speciesCount[s][0] = 0;
	}
	
	// run through all grass tiles and update spread and growth level
	if(gameTime%global.gameSpeed == 0) { 
		grassCount[0] = 0;
		simulate_grass_growth(); 
	}
	
	// run through each critter and simulate their turn
	simulate_creatures(gameTime%global.gameSpeed != 0);
	
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
	audio_play_sound(snd_starved,1,0);
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
		
		
	}
}
if(timeLeft < 0) {
	persistent = true;
	room_goto(roomEnd);
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
	camX = (plrX * cellSize) - camW/2 + 0.5;
	camY = (plrY * cellSize) - camH/2 + 0.5;
	camW = 64 * cellSize;
	camH = 36 * cellSize;
}
if(timeLeft < 10 && !audio_is_playing(snd_clock)) {
	audio_play_sound(snd_clock,1,0);
}
camX = clamp(camX, 0, room_width - camW);
camY = clamp(camY, 0, room_height - camH);

camera_set_view_pos(view_camera[0],camX,camY);
camera_set_view_size(view_camera[0],camW,camH);

if(speciesCount[1][5] == 0 && speciesCount[3][5] == 0 && gameTime > 60) {// coyotes & wolves extinct
	if(speciesCount[0][5] > 2000)
		grassSpreadChance *= 0.999;
		grassGrowthChance *= 0.9995;
	creaFeed[0] *= 1.0002;
	creaFeed[2] *= 0.9995;
	creaFeed[4] *= 0.9995;
}
