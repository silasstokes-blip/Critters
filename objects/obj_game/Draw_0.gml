// ---------------------------DRAW GRASS AND CRITTERS ---------------------------------
for(f = 0;f < gridWidth; f++) {
	for(e = 0;e < gridHeight; e++) {
		draw_sprite_ext(spr_grassPixel,grid[f][e],f * cellSize,e * cellSize,cellSize,cellSize,0,c_white,1);
	}
}
colors = [c_white,make_colour_rgb(255,130,40),c_fuchsia,c_red,c_aqua,c_blue];
for(f = 0; f < creaCount; f++) {
	if(!crea[f].eaten) {
		draw_sprite_ext(spr_pixel2,0,(crea[f].myX + 0.5) * cellSize,(crea[f].myY + 0.5) * cellSize,creaSize[crea[f].myType] * cellSize,creaSize[crea[f].myType] * cellSize,0,colors[crea[f].myType],1);
		if(crea[f].blink != -1) {
			draw_sprite_ext(spr_pixel2,0,(crea[f].myX + 0.5) * cellSize,(crea[f].myY + 0.5) * cellSize,creaSize[crea[f].myType] * cellSize,creaSize[crea[f].myType] * cellSize,0,c_white,crea[f].blink);
		}
	}
}
// ---------------------------DRAW FEEDERS AND TRAPS ---------------------------------
trapSpin += (1 - abs(sin(stepTime/20))) * 30;
for(f = 0; f < feedTrapCount; f++) {
	if(feedTrapList[f].myType == 0) {
		draw_sprite_ext(spr_feeder,0,(feedTrapList[f].myX + 0.5) * cellSize,(feedTrapList[f].myY + 0.5) * cellSize,sqrt(abs(sin(stepTime/20))) * (1/16) * cellSize,sqrt(abs(sin(stepTime/20))) * (1/16) * cellSize,0,colors[feedTrapList[f].myTarget],1);
		draw_sprite_ext(spr_feeder,0,(feedTrapList[f].myX + 0.5) * cellSize,(feedTrapList[f].myY + 0.5) * cellSize,sqrt(abs(sin(stepTime/20))) * (1/16) * cellSize,sqrt(abs(sin(stepTime/20))) * (1/16) * cellSize,0,c_white,(1 - sqr(abs(sin(stepTime/20)))) * (sin(stepTime/10) > 0));
	} else {
		draw_sprite_ext(spr_trap,0,(feedTrapList[f].myX + 0.5) * cellSize,(feedTrapList[f].myY + 0.5) * cellSize,(1/16) * cellSize,(1/16) * cellSize,trapSpin,colors[feedTrapList[f].myTarget],1);
	}
}
// ---------------------------DRAW HOUSE ---------------------------------
var c_brown = merge_color(c_orange,c_black,0.5);
draw_rectangle_colour(houseX1 * cellSize,houseY1 * cellSize,houseX2 * cellSize,houseY2 * cellSize,c_brown, c_brown, c_brown, c_brown,false);
draw_sprite_ext(spr_graphs,(gameTime/20)%3,chartX * cellSize,chartY * cellSize,(2/32) * cellSize,(2/32) * cellSize,0,c_white,1);
draw_text_transformed((chartX + 1 - (string_width("GRAPHS") * 0.015)) * cellSize, (chartY - 0.5 - (string_height("GRAPHS") * 0.03) - abs(sin(gameTime/20))) * cellSize,"GRAPHS",0.03 * cellSize,0.03 * cellSize,0);
draw_sprite_ext(spr_scope,0,teleX * cellSize,teleY * cellSize,(2/32) * cellSize,(2/32) * cellSize,0,c_white,1);
draw_text_transformed((teleX + 1 - (string_width("VIEW") * 0.015)) * cellSize, (teleY - 0.5 - (string_height("VIEW") * 0.03) - abs(sin((gameTime + 30)/20))) * cellSize,"VIEW",0.03 * cellSize,0.03 * cellSize,0);
draw_sprite_ext(spr_shop,0,shopX * cellSize,shopY * cellSize,(2/32) * cellSize,(2/32) * cellSize,0,c_white,1);
draw_text_transformed((shopX + 1 - (string_width("SHOP") * 0.015)) * cellSize, (shopY - 0.5 - (string_height("SHOP") * 0.03) - abs(sin((gameTime + 12)/20))) * cellSize,"SHOP",0.03 * cellSize,0.03 * cellSize,0);

// ---------------------------DRAW PLAYER ---------------------------------
draw_sprite_ext(spr_pixel,0,plrX * cellSize,plrY * cellSize,cellSize,cellSize,0,c_yellow,1);
draw_sprite_ext(spr_spear,0,(plrX + 0.5) * cellSize,(plrY + 0.5) * cellSize,spearLength * 0.15 * cellSize,0.15 * cellSize,spearDir,c_white,1);

// ---------------------------DRAW PARTICLES ---------------------------------
part_system_drawit(partSys);

// ---------------------------DRAW UI ---------------------------------
if(room != roomTitle) {
	// place menu
	if(placeView) {
		draw_sprite_ext(spr_darkRect,0,(plrX + 0.5) * cellSize,(plrY - 3) * cellSize,(1/8) * cellSize,(1/8) * cellSize,0,c_white,0.5);
		draw_sprite_ext(spr_darkRect,0,(plrX + 0.5) * cellSize,(plrY + 4) * cellSize,(1/8) * cellSize,(1/8) * cellSize,0,c_white,0.5);
		var feederCount = 0
		var trapCount = 0
		for(f = 0; f < numbOfSpecies; f++) {
			feederCount += (feeders[f] > 0);
			trapCount += (traps[f] > 0);
		}
		var sep = 2;
		var drawnFeeder = 0;
		var drawnTrap = 0;
		mouseX = camX + ((device_mouse_x_to_gui(0)/1366) * 64);
		mouseY = camY + ((device_mouse_y_to_gui(0)/768) * 36);
		//draw_sprite_ext(spr_mouse,0,mouseX,mouseY,1/8,1/8,0,c_white,1);
		for(f = 0; f < numbOfSpecies; f++) {
			if(feeders[f] > 0) {
				//draw_sprite_ext(spr_feeder,0,plrX + 0.5 - (sep * (feederCount - 1))/2 + (sep * drawnFeeder),plrY - 3,(1/16) * 0.8,(1/16) * 0.8,0,colors[f],1);
				if(abs(mouseX - (plrX + 0.5 - (sep * (feederCount - 1))/2 + (sep * drawnFeeder))) <= 1 && abs(mouseY - (plrY - 3)) <= 1) {
					draw_sprite_ext(spr_feeder,0,(plrX + 0.5 - (sep * (feederCount - 1))/2 + (sep * drawnFeeder)) * cellSize,(plrY - 3) * cellSize,(1/16) * 1.1 * cellSize,(1/16) * 1.1 * cellSize,0,colors[f],1);
					if(mouse_check_button_pressed(mb_left)) {
						feedTrapList[feedTrapCount] = create_feeder_trap(0,plrX,plrY,f);
						feeders[f] -= 1;
						feedTrapCount++;
						feedTrapsPlaced[f]++;
					}
				} else {
					draw_sprite_ext(spr_feeder,0,(plrX + 0.5 - (sep * (feederCount - 1))/2 + (sep * drawnFeeder)) * cellSize,(plrY - 3) * cellSize,(1/16) * 0.8 * cellSize,(1/16) * 0.8 * cellSize,0,colors[f],1);
				}
				drawnFeeder += 1;
			}
			if(traps[f] > 0) {
				//draw_sprite_ext(spr_trap,0,plrX + 0.5 - (sep * (trapCount - 1))/2 + (sep * drawnTrap),plrY + 4,(1/16) * 0.8,(1/16) * 0.8,0,colors[f],1);
				if(abs(mouseX - (plrX + 0.5 - (sep * (trapCount - 1))/2 + (sep * drawnTrap))) <= 1 && abs(mouseY - (plrY + 4)) <= 1) {
					draw_sprite_ext(spr_trap,0,(plrX + 0.5 - (sep * (trapCount - 1))/2 + (sep * drawnTrap)) * cellSize,(plrY + 4) * cellSize,(1/16) * 1.1 * cellSize,(1/16) * 1.1 * cellSize,0,colors[f],1);
					if(mouse_check_button_pressed(mb_left)) {
						feedTrapList[feedTrapCount] = create_feeder_trap(1,plrX,plrY,f);
						traps[f] -= 1;
						feedTrapCount++;
						feedTrapsPlaced[f]++;
					}
				} else {
					draw_sprite_ext(spr_trap,0,(plrX + 0.5 - (sep * (trapCount - 1))/2 + (sep * drawnTrap)) * cellSize,(plrY + 4) * cellSize,(1/16) * 0.8 * cellSize,(1/16) * 0.8 * cellSize,0,colors[f],1);
				}
				drawnTrap += 1;
			}
		}
	}

	// hunger
	draw_set_font(Font3)
	draw_healthbar(camX + (0.02 * camW),camY + (0.02 * camH),camX + (0.35 * camW),camY + (0.07 * camH),(plrHunger/plrHungerMax) * 100,c_black,c_red,c_red,0,true,false);
	draw_set_colour(c_black);
	draw_text_transformed(camX + (0.02 * camW),camY + (0.015 * camH),"HUNGER",0.05 * cellSize,0.05 * cellSize,0);
	draw_set_colour(c_white);

	// lives

	for(f =  0; f < plrMaxLives; f++) {
		draw_sprite_ext(spr_life,f < plrLives,camX + ((0.02 + (0.05 * f)) * camW),camY + (0.08 * camH),0.003 * camW,0.003 * camW,0,c_white,1);
	}

	// profit number
	draw_money();

	// Time
	var timeStr = clock_time(timeLeft);
	draw_set_colour(merge_color(c_white,c_red,clamp(1 - (timeLeft - 55)/5,0,1)));
	draw_text_transformed(camX + camW - (string_width(timeStr) * 0.125 * cellSize) - (0.02 * camW),camY + (0.02 * camH),timeStr,0.125 * cellSize,0.125 * cellSize,0);

	// Death text

	if(deathAnim > 0) {
		draw_set_colour(c_red);
		var word = "EATEN!";
		if(plrHunger <= 0) {
			word = "STARVED!";
		}
		draw_text_transformed(camX + (0.5 * camW) - (string_width(word) * 0.5 * 0.125 * cellSize),camY + (0.5 * camH) - (string_height(word) * 0.5 * 0.125 * cellSize),word,0.125 * cellSize,0.125 * cellSize,0);
	} else if(plrHunger < plrHungerMax * 0.25) {
		draw_set_colour(c_red);
		draw_text_transformed(camX + (0.5 * camW) - (string_width("HUNGRY!") * 0.5 * 0.075 * cellSize),camY + (0.4 * camH) - (string_height("HUNGRY!") * 0.5 * 0.075 * cellSize),"HUNGRY!",0.075 * cellSize,0.075 * cellSize,0);
	}

	// --------------------------- DRAW GRAPHS ---------------------------------
	if(graphView) {
		draw_set_colour(c_black)
		draw_rectangle(0,0,room_width,room_height,false);
		var trueRecSteps = min(recordedSteps,floor(gameTime/16));
		draw_graph(0.1 * room_width,0.1 * room_height,0.9 * room_width, 0.9 * room_height,grassMax,grassCount,c_lime,trueRecSteps,1,0.3 * cellSize);
	
		for(e = 0; e < numbOfSpecies; e++) {
			draw_graph(0.1 * room_width,0.1 * room_height,0.9 * room_width, 0.9 * room_height,creaMax[e],speciesCount[e],colors[e],trueRecSteps,1,0.3 * cellSize);
		}
		draw_sprite_ext(spr_foodChain,1,camX,camY,camW/1366,camH/768,0,c_white,1);
	} else {
	
		draw_set_alpha(0.5)
		draw_set_colour(c_black)
		draw_rectangle(camX,camY + (0.8 * camH),camX + (0.3 * camW),camY + camH,false);
		draw_set_colour(c_white)
		draw_rectangle(camX,camY + (0.8 * camH),camX + (0.3 * camW),camY + camH,true);
		draw_set_alpha(1)
		var trueRecSteps = max(min(100,floor(gameTime/16)),3);
		draw_graph(camX + 0.3 * cellSize,camY + (0.8 * camH) + 0.3 * cellSize,camX + (0.3 * camW) - 0.6 * cellSize,camY + camH - 0.6 * cellSize,grassMax,grassCount,c_lime,trueRecSteps,1,0.15 * cellSize);
	
		for(e = 0; e < numbOfSpecies; e++) {
			draw_graph(camX + 0.3 * cellSize,camY + (0.8 * camH) + 0.3 * cellSize,camX + (0.3 * camW) - 0.6 * cellSize,camY + camH - 0.6 * cellSize,creaMax[e],speciesCount[e],colors[e],trueRecSteps,1,0.15 * cellSize);
		}
	
		if(miniFoodChain) {
			draw_set_alpha(0.5)
			draw_set_colour(c_black);
			draw_rectangle(camX,camY + (0.45 * camH),camX + (0.3 * camW),camY + (0.8 * camH),false);
			draw_set_colour(c_white);
			draw_rectangle(camX,camY + (0.45 * camH),camX + (0.3 * camW),camY + (0.8 * camH),true);
			draw_sprite_ext(spr_foodChain,0,camX - 18,camY + (camH * 0.23),0.03 * cellSize,0.028 * cellSize,0,c_white,1)
			draw_set_alpha(1)
			draw_sprite_ext(spr_keyPrompts,0,camX + cellSize,camY + (0.8 * camH) - cellSize,0.02 * cellSize,0.02 * cellSize,0,c_white,1);
			draw_text_transformed(camX + 2 * cellSize, camY + (0.8 * camH) - cellSize - (string_height("Toggle") * 0.015 * cellSize),"Toggle",0.03 * cellSize,0.03 * cellSize,0);
		} else {
			draw_sprite_ext(spr_keyPrompts,0,camX + cellSize,camY + (0.8 * camH) - cellSize,0.02 * cellSize,0.02 * cellSize,0,c_white,1);
			draw_text_transformed(camX + 2 * cellSize, camY + (0.8 * camH) - cellSize - (string_height("Food Chain") * 0.015 * cellSize),"Food Chain",0.03 * cellSize,0.03 * cellSize,0);
		}
	
	}
	///////////////////////// SHOP /////////////////////////////////////
	names = ["Rabbit", "Coyote", "Elk", "Wolf", "Mouse", "Ferret"];
	if(shopView) {
		draw_set_colour(c_black)
		draw_rectangle(0,0,room_width,room_height,false);
		for(f = 0; f < numbOfSpecies; f++) {
			draw_text_ext_transformed_color(camX + (camW * 0.2),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)) - (string_height("F") * 0.08 * cellSize),names[f],0,10000,0.16 * cellSize,0.16 * cellSize,0,colors[f],colors[f],colors[f],colors[f],1)
			draw_sprite_ext(spr_feeder,0,camX + (camW * 0.45),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)),sqrt(abs(sin(stepTime/20))) * 0.2 * cellSize,sqrt(abs(sin(stepTime/20))) * 0.2 * cellSize,0,colors[f],1);
			draw_sprite_ext(spr_feeder,0,camX + (camW * 0.45),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)),sqrt(abs(sin(stepTime/20))) * 0.2 * cellSize,sqrt(abs(sin(stepTime/20))) * 0.2 * cellSize,0,c_white,(1 - sqr(abs(sin(stepTime/20)))) * (sin(stepTime/10) > 0));
			draw_text_ext_transformed_color(camX + (camW * 0.5),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)) - (string_height("F") * 0.08 * cellSize),string(feeders[f]),0,10000,0.16 * cellSize,0.16 * cellSize,0,colors[f],colors[f],colors[f],colors[f],1)
			draw_sprite_ext(spr_trap,0,camX + (camW * 0.7),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)),0.2 * cellSize,0.2 * cellSize,trapSpin,colors[f],1);
			draw_text_ext_transformed_color(camX + (camW * 0.75),camY + (camH * 0.2) + ((camH * 0.6) * (f/numbOfSpecies)) - (string_height("F") * 0.08 * cellSize),string(traps[f]),0,10000,0.16 * cellSize,0.16 * cellSize,0,colors[f],colors[f],colors[f],colors[f],1)
		}
		draw_money();
		draw_text_transformed(camX + (0.5 * camW) - (string_width("Click to Buy") * 0.5 * 0.1 * cellSize),camY + camH - (0.15 * camH) - (string_height("Click to Buy") * 0.1 * cellSize),"Click to Buy",0.1 * cellSize,0.1 * cellSize,0);
		draw_text_transformed(camX + (0.5 * camW) - (string_width("$50 Per Item") * 0.5 * 0.1 * cellSize),camY + camH - (0.1 * camH) - (string_height("$50 Per Item") * 0.1 * cellSize),"$50 Per Item",0.1 * cellSize,0.1 * cellSize,0);
		draw_set_alpha(0.5);
		if(mouse_x > camW * 0.4 && mouse_x < camW * 0.55) {
			spot = floor((mouse_y - (camH * 0.2) - (string_height("F") * 0.1 * cellSize))/((camH * 0.6)/numbOfSpecies)) + 1;
			if(spot >= 0 && spot < numbOfSpecies) {
				draw_rectangle_colour(camX + (camW * 0.4),camY + (camH * 0.2) + ((camH * 0.6) * ((spot - 0.5)/numbOfSpecies)),camX + (camW * 0.55),camY + (camH * 0.2) + ((camH * 0.6) * ((spot + 0.5)/numbOfSpecies)),colors[spot],colors[spot],colors[spot],colors[spot],false);
				if(mouse_check_button_pressed(mb_left)) {
					if(plrProfit >= 50) {
						plrProfit -= 50;
						feeders[spot] += 1;
					} else {
						moneyPromptAlpha = 1;
						moneyPromptX = camX + (camW * 0.475);
						moneyPromptY = camY + (camH * 0.2) + ((camH * 0.6) * ((spot - 0.5)/numbOfSpecies));
					}
				}
			}
		}
		if(mouse_x > camW * 0.65 && mouse_x < camW * 0.8) {
			spot = floor((mouse_y - (camH * 0.2) - (string_height("F") * 0.1 * cellSize))/((camH * 0.6)/numbOfSpecies)) + 1;
			if(spot >= 0 && spot < numbOfSpecies) {
				draw_rectangle_colour(camX + (camW * 0.65),camY + (camH * 0.2) + ((camH * 0.6) * ((spot - 0.5)/numbOfSpecies)),camX + (camW * 0.8),camY + (camH * 0.2) + ((camH * 0.6) * ((spot + 0.5)/numbOfSpecies)),colors[spot],colors[spot],colors[spot],colors[spot],false);
				if(mouse_check_button_pressed(mb_left)) {
					if(plrProfit >= 50) {
						plrProfit -= 50;
						traps[spot] += 1;
					} else {
						moneyPromptAlpha = 1;
						moneyPromptX = camX + (camW * 0.725);
						moneyPromptY = camY + (camH * 0.2) + ((camH * 0.6) * ((spot - 0.5)/numbOfSpecies));
					}
				}
			}
		}
		draw_set_alpha(moneyPromptAlpha);
		draw_text_transformed(moneyPromptX - (string_width("NOT ENOUGH MONEY") * 0.03 * cellSize), moneyPromptY - (string_height("N") * 0.03 * cellSize),"NOT ENOUGH MONEY",0.06 * cellSize,0.06 * cellSize,0);
		draw_set_alpha(1);
	} 

	// Exit menu text

	if(envView || graphView) {
		draw_text_transformed(camX + (0.5 * camW) - (string_width("ESC to Close") * 0.5 * 0.1 * cellSize),camY + camH - (0.05 * camH) - (string_height("ESC to Close") * 0.1 * cellSize),"ESC to Close",0.1 * cellSize,0.1 * cellSize,0);
	}
}
///////////////////// TITLE ///////////////////////////////////
else {
	draw_sprite_ext(spr_title,0,0,0,room_width/1366,room_height/768,0,c_white,1);
}