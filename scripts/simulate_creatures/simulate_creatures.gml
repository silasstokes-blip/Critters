function simulate_creatures(turnType){
	for(f = 0; f < creaCount; f++) {
		var myCrea = crea[f];
		var creaX = myCrea.myX;
		var creaY = myCrea.myY;
		var creaType = myCrea.myType;
			
		if(clamp(creaX,floor(spearX) - 2,floor(spearX) + 2) == creaX && clamp(creaY,floor(spearY) - 2,floor(spearY) + 2) == creaY) {
			myCrea.eaten = true;
			plrChoice = true;
			part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[myCrea.myType],150);
		}

		// if the creature is still alive
		if(!myCrea.eaten) {
			
			speciesCount[creaType][0] += 1;
			
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
				
					// set search distance and prey targets for each species
					var preyDistance = 4;
					var chaseTargets = [0];
					var foodTargets = [0, 4];
				
					if(creaType == 3) { // Wolf
						preyDistance = 15; 
						chaseTargets = [0, 1, 2];
						foodTargets = [0, 1, 2];
					} 
				
					if(creaType == 5) { // Ferret
						preyDistance = 5; 
						chaseTargets = [4];
						foodTargets = [4];
					} 
					
					if((creaType == 1 || creaType == 3) && (clamp(round(plrX),creaX - 1, creaX + 1) == round(plrX)) && clamp(round(plrY),creaY - 1, creaY + 1) == round(plrY)) {
						deathAnim = 120;
						part_particles_create(partSys,plrX,plrY,partTypePlr,200);
						plrX = -1000;
						plrY = -1000;
					}
					
						
				
				
					// run through all other creatures to find nearest prey target and eat colliding pray
					for(e = 0; e < creaCount; e++) {
						if(!crea[e].eaten) {
						
							// set new prey target
							if(abs(crea[e].myX - myCrea.myX) + abs(crea[e].myY - myCrea.myY) < preyDistance && array_contains(chaseTargets, crea[e].myType)) {
								preyDistance = abs(crea[e].myX - myCrea.myX) + abs(crea[e].myY - myCrea.myY);
								nearestPrey = e;
							}
					
							// eat colliding critter
							if(abs(crea[e].myX - myCrea.myX) <= 1 && abs(crea[e].myY - myCrea.myY) <= 1 && array_contains(foodTargets, crea[e].myType)) {
								crea[e].eaten = true;
								part_particles_create(partSys,crea[e].myX + 0.5,crea[e].myY + 0.5,partType[crea[e].myType],100);
								myCrea.myHunger += creaFeed[myCrea.myType] * (1 + ((myCrea.myHunger < 0) * 0.5)) * myCrea.feedMult;
								e = creaCount;
							}
						}
					}
				
					// point direction to target
					if(nearestPrey != -1) {
						if(abs(crea[nearestPrey].myX - creaX) < abs(crea[nearestPrey].myY - creaY)) {
							if(crea[nearestPrey].myY > creaY) { myCrea.myDir = 3;} 
							else {myCrea.myDir = 1;}
						} else {
							if(crea[nearestPrey].myX > creaX) { myCrea.myDir = 0;} 
							else {myCrea.myDir = 2;}
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
			
				// Randomly turn creature
				if(irandom_range(1,10) == 1) {
					myCrea.myDir = myMod(myCrea.myDir + choose(1,-1),4)
				}
			
				// If well-fed and sexually mature, have child
				if(myCrea.myHunger >= myCrea.childThreshold && myCrea.age > reproductiveAge) {
					myCrea.myHunger = -2;
					creaCount += 1;
					crea[creaCount - 1] = create_creature(creaType,creaX,creaY);
					while(crea[creaCount - 1].myDir = myCrea.myDir) {
						crea[creaCount - 1].myDir = irandom_range(0,3)
					}
				}
			
				// increment age
				myCrea.age += 1;
			
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
			
			// move one tile in proper direction
			if(myCrea.myDir == 0) {
				myCrea.myX += 0.5;
			}
			if(myCrea.myDir == 1) {
				myCrea.myY -= 0.5;
			}
			if(myCrea.myDir == 2) {
				myCrea.myX -= 0.5;
			}
			if(myCrea.myDir == 3) {
				myCrea.myY += 0.5;
			}
			
			// Lower hunger
			myCrea.myHunger -= 0.5;
			
			// if starving or attacked by player after moving, die
			if(clamp(creaX,floor(spearX) - 2,floor(spearX) + 2) == creaX && clamp(creaY,floor(spearY) - 2,floor(spearY) + 2) == creaY) {
				plrChoice = true;
				myCrea.eaten = true;
				part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[creaType],150);
			}
			if(myCrea.myHunger < myCrea.deathThreshold) {
				myCrea.eaten = true;
				part_particles_create(partSys,creaX + 0.5,creaY + 0.5,partType[creaType],100);
			}
		}
	}
}