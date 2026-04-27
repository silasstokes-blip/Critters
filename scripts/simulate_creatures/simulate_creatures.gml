function simulate_creatures(turnType){
	for(f = 0; f < creaCount; f++) {
		var myCrea = crea[f];
		var creaX = myCrea.myX;
		var creaY = myCrea.myY;
		var creaType = myCrea.myType;
			
		if(clamp(creaX,floor(spearX) - 2,floor(spearX) + 2) == creaX && clamp(creaY,floor(spearY) - 2,floor(spearY) + 2) == creaY) {
			myCrea.eaten = true;
			plrHunger += ceil(power(creaSize[creaType] * 4,2)) * 2;
			plrProfit += ceil(power(creaSize[creaType] * 4,2));
			audio_play_sound_at(choose(snd_stab,snd_stab2,snd_stab3,snd_stab4),creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
			audio_play_sound_at(sounds[creaType],creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
			part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[myCrea.myType],150);
		}

		// if the creature is still alive
		if(!myCrea.eaten) {
			
			speciesCount[creaType][0] += 1;
			
			if(creaType == 1 || creaType == 3) {
				part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType2[creaType],5);
			}
			
			// Rabbits and Elk
			if(turnType == 0) {
				if(creaType == 0 || creaType == 2) {
					// eat grass
					if(grid[floor(creaX)][floor(creaY)] > 0) {
						myCrea.myHunger += creaFeed[creaType] * myCrea.feedMult;
						grid[floor(creaX)][floor(creaY)] -= 1;
					}
				}
				
				
				
				// Predators (Coyotes, Wolves, Ferrets)
				
				if(creaType == 1 || creaType == 3 || creaType == 5) {
				
					// find prey target
					var nearestPrey = -1;
					var antiprey = false;
				
					// set search distance and prey targets for each species
					var preyDistance = 5 + ((speciesCount[0][1] > baseCount[0] * 2) * 1000) - ((speciesCount[0][1] < baseCount[0] * 0.6) * 3);
					var chaseTargets = [0];
					var foodTargets = [0, 4];
				
					if(creaType == 3) { // Wolf
						preyDistance = 15 + ((speciesCount[2][1] > baseCount[2] * 2) * 1000) - ((speciesCount[2][1] < baseCount[2] * 0.6) * 10); 
						chaseTargets = [2];
						foodTargets = [0, 1, 2];
						if(speciesCount[1][1] <= 2) {
							foodTargets = [0, 2];
						}
						
					} 
				
					if(creaType == 5) { // Ferret
						preyDistance = 10 + ((speciesCount[4][1] > baseCount[4] * 2) * 1000) - ((speciesCount[4][1] < baseCount[4] * 0.6) * 7); 
						chaseTargets = [4];
						foodTargets = [4];
						antiprey = false;
					} 
					
					if((creaType == 1 || creaType == 3) && (clamp(round(plrX),creaX - 1, creaX + 1) == round(plrX)) && clamp(round(plrY),creaY - 1, creaY + 1) == round(plrY)) {
						deathAnim = 120;
						myCrea.blink = 1;
						part_particles_create(partSys,plrX,plrY,partTypePlr,200);
						plrX = -1000;
						plrY = -1000;
					}
					
						
				
				
					// run through all other creatures to find nearest prey target and eat colliding pray
					var searchLoops = 0;
					do {
						for(e = 0; e < creaCount; e++) {
							if(!crea[e].eaten) {
						
								// set new prey target
								if(abs(crea[e].myX - myCrea.myX) + abs(crea[e].myY - myCrea.myY) < preyDistance && array_contains(chaseTargets, crea[e].myType)) {
									preyDistance = abs(crea[e].myX - myCrea.myX) + abs(crea[e].myY - myCrea.myY);
									nearestPrey = e;
									if((speciesCount[crea[e].myType][1] < baseCount[crea[e].myType] * 0.25)) {antiprey = true;}
									else {antiprey = false;}
								}
					
								// eat colliding critter
								if(abs(crea[e].myX - myCrea.myX) <= 1 && abs(crea[e].myY - myCrea.myY) <= 1 && array_contains(foodTargets, crea[e].myType)) {
									crea[e].eaten = true;
									part_particles_create(partSys,crea[e].myX + 0.5,crea[e].myY + 0.5,partType[crea[e].myType],100);
									audio_play_sound_at(choose(snd_stab,snd_stab2,snd_stab3,snd_stab4),crea[e].myX + 0.5,crea[e].myY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
									audio_play_sound_at(sounds[crea[e].myType],creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
									
									myCrea.myHunger += creaFeed[myCrea.myType] * (1 + ((myCrea.myHunger < 0) * 0.5)) * myCrea.feedMult * creaSize[crea[e].myType];
									e = creaCount;
								}
							}
						}
						searchLoops += 1;
						chaseTargets = [0,2];
					} until(creaType != 3 || searchLoops >= 2 || nearestPrey != -1);
				
					// point direction to target
					if(nearestPrey != -1) {
						if(!antiprey) {
							if(abs(crea[nearestPrey].myX - creaX) < abs(crea[nearestPrey].myY - creaY)) {
								if(crea[nearestPrey].myY > creaY) { myCrea.myDir = 3;} 
								else {myCrea.myDir = 1;}
							} else {
								if(crea[nearestPrey].myX > creaX) { myCrea.myDir = 0;} 
								else {myCrea.myDir = 2;}
							}
						} else {
							if(abs(crea[nearestPrey].myX - creaX) < abs(crea[nearestPrey].myY - creaY)) {
								if(crea[nearestPrey].myY > creaY) { myCrea.myDir = 1;} 
								else {myCrea.myDir = 3;}
							} else {
								if(crea[nearestPrey].myX > creaX) { myCrea.myDir = 2;} 
								else {myCrea.myDir = 0;}
							}
						}
					
					}
				
				}
			
				// Mouse
			
				if(creaType == 4) {
					// eat grass
					if(irandom_range(1,3) == 1 && grid[floor(creaX)][floor(creaY)] > 0) {
						myCrea.myHunger += creaFeed[creaType] * myCrea.feedMult * 3;
						grid[floor(creaX)][floor(creaY)] -= 1;
					}
				}
				
				if(feedTrapsPlaced[creaType] > 0) {
					for(e = 0; e < feedTrapCount; e++) {
						if(feedTrapList[e].myTarget == creaType && abs(feedTrapList[e].myX - creaX) <= 1 && abs(feedTrapList[e].myY - creaY) <= 1) {
							if(feedTrapList[e].myType == 1) {//trap
								myCrea.myHunger = -100000;
								plrProfit += ceil(power(creaSize[creaType] * 4,2));
								audio_play_sound_at(choose(snd_stab,snd_stab2,snd_stab3,snd_stab4),creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
								audio_play_sound_at(sounds[creaType],creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
							}
							if(feedTrapList[e].myType == 0 && myCrea.age >= reproductiveAge) {//feeder
								myCrea.myHunger = 100000;
							}
						}
					}
				}
			
				// Randomly turn creature
				if(irandom_range(1,10) == 1) {
					myCrea.myDir = myMod(myCrea.myDir + choose(1,-1),4)
				}
			
				// If well-fed and sexually mature, have child
				if(myCrea.myHunger >= myCrea.childThreshold && myCrea.age > reproductiveAge && creaCount < 1000) {
					myCrea.myHunger = -2;
					myCrea.age = 0;
					creaCount += 1;
					crea[creaCount - 1] = create_creature(creaType,creaX,creaY);
					while(crea[creaCount - 1].myDir = myCrea.myDir) {
						crea[creaCount - 1].myDir = irandom_range(0,3)
					}
				}
			
				// increment age
				myCrea.age += 2/global.gameSpeed;
			
				// turn if colliding with wall
				var projX = creaX;
				var projY = creaY;
				if(myCrea.myDir == 0) {projX += 1;}
				if(myCrea.myDir == 1) {projY -= 1;}
				if(myCrea.myDir == 2) {projX -= 1;}
				if(myCrea.myDir == 3) {projY += 1;}
				while(clamp(projX,0,gridWidth - 1) != projX || clamp(projY,0,gridHeight - 1) != projY || (clamp(projX,houseX1,houseX2 - 1) == projX && clamp(projY,houseY1,houseY2 - 1) == projY)) {//((myCrea.myDir == 0 && myCrea.myX = gridWidth - 1) || (myCrea.myDir == 1 && myCrea.myY = 0) || (myCrea.myDir == 2 && myCrea.myX = 0) || (myCrea.myDir == 3 && myCrea.myY = gridHeight - 1) || ) {
					myCrea.myDir = myMod(myCrea.myDir + choose(1,-1),4);
					projX = myCrea.myX;
					projY = myCrea.myY;
					if(myCrea.myDir == 0) {projX += 1;}
					if(myCrea.myDir == 1) {projY -= 1;}
					if(myCrea.myDir == 2) {projX -= 1;}
					if(myCrea.myDir == 3) {projY += 1;}
				}
			}
			if(myCrea.blink > -1) {
				myCrea.blink -= 0.1;
				if(myCrea.blink < 0) {
					myCrea.blink = 1;
				}
				if(deathAnim <= 0) {
					myCrea.blink = -1;
				}
			}
			// move one tile in proper direction
			if(myCrea.myDir == 0) {
				myCrea.myX += 1/global.gameSpeed;
			}
			if(myCrea.myDir == 1) {
				myCrea.myY -= 1/global.gameSpeed;
			}
			if(myCrea.myDir == 2) {
				myCrea.myX -= 1/global.gameSpeed;
			}
			if(myCrea.myDir == 3) {
				myCrea.myY += 1/global.gameSpeed;
			}
			
			// Lower hunger
			myCrea.myHunger -= 1/global.gameSpeed;
			
			// if starving or attacked by player after moving, die
			if(clamp(creaX,floor(spearX) - 2,floor(spearX) + 2) == creaX && clamp(creaY,floor(spearY) - 2,floor(spearY) + 2) == creaY) {
				plrHunger += ceil(power(creaSize[creaType] * 4,2)) * 2;
				plrProfit += ceil(power(creaSize[creaType] * 4,2));
				audio_play_sound_at(choose(snd_stab,snd_stab2,snd_stab3,snd_stab4),creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
				audio_play_sound_at(sounds[creaType],creaX + 0.5,creaY + 0.5,0,5,12,1,0,1,sqrt(creaSize[creaType]));
				myCrea.eaten = true;
				part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[creaType],150);
			}
			if(myCrea.myHunger < myCrea.deathThreshold && ((creaType != 3 || speciesCount[creaType][0] > 1 || (speciesCount[0][1] == 0 && speciesCount[2][1] == 0)) && (creaType != 1 || speciesCount[creaType][0] > 2) && (creaType != 5 || speciesCount[creaType][0] > 2 || speciesCount[4][1] == 0))) {
				myCrea.eaten = true;
				part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[creaType],100);
			}
		}
	}
}