function simulate_creatures(){
	for(f = 0; f < creaCount; f++) {
		var myCrea = crea[f];
		
		// player kills creature before it moves
		if(myCrea.myX == spearX && myCrea.myY == spearY) {
			myCrea.eaten = true;
			plrChoice = true;
		}
			
		// if the creature is still alive
		if(!myCrea.eaten) {
			
			speciesCount[myCrea.myType][0] += 1;
			
			// Rabbits and Elk
			
			if(myCrea.myType == 0 || myCrea.myType == 2) {
				// eat grass
				if(grid[myCrea.myX][myCrea.myY] > 0) {
					myCrea.myHunger += creaFeed[myCrea.myType] * myCrea.feedMult;
					grid[myCrea.myX][myCrea.myY] -= 1;
				}
			}
				
			// Predators (Coyotes, Wolves, Ferrets)
				
			if(myCrea.myType == 1 || myCrea.myType == 3 || myCrea.myType == 5) {
				
				// find prey target
				var nearestPrey = -1;
				
				// set search distance and prey targets for each species
				var preyDistance = 4;
				var chaseTargets = [0];
				var foodTargets = [0, 4];
				
				if(myCrea.myType == 3) { // Wolf
					preyDistance = 15; 
					chaseTargets = [0, 1, 2];
					foodTargets = [0, 1, 2];
				} 
				
				if(myCrea.myType == 5) { // Ferret
					preyDistance = 5; 
					chaseTargets = [4];
					foodTargets = [4];
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
							myCrea.myHunger += creaFeed[myCrea.myType] * (1 + ((myCrea.myHunger < 0) * 0.5)) * myCrea.feedMult;
							e = creaCount;
						}
					}
				}
				
				// point direction to target
				if(nearestPrey != -1) {
					if(abs(crea[nearestPrey].myX - myCrea.myX) < abs(crea[nearestPrey].myY - myCrea.myY)) {
						if(crea[nearestPrey].myY > myCrea.myY) { myCrea.myDir = 3;} 
						else {myCrea.myDir = 1;}
					} else {
						if(crea[nearestPrey].myX > myCrea.myX) { myCrea.myDir = 0;} 
						else {myCrea.myDir = 2;}
					}
					
				}
				
			}
			
			// Mouse
			
			if(myCrea.myType == 4) {
				// always eat
				myCrea.myHunger += creaFeed[4] * myCrea.feedMult;
			}
			
			// Randomly turn creature
			if(irandom_range(1,10) == 1) {
				myCrea.myDir = myMod(myCrea.myDir + choose(1,-1),4)
			}
			
			// If well-fed and sexually mature, have child
			if(myCrea.myHunger >= myCrea.childThreshold && myCrea.age > reproductiveAge) {
				myCrea.myHunger = -2;
				creaCount += 1;
				crea[creaCount - 1] = create_creature(myCrea.myType,myCrea.myX,myCrea.myY);
				while(crea[creaCount - 1].myDir = myCrea.myDir) {
					crea[creaCount - 1].myDir = irandom_range(0,3)
				}
			}
			
			// increment age
			myCrea.age += 1;
			
			// turn if colliding with wall
			while((myCrea.myDir == 0 && myCrea.myX = gridWidth - 1) || (myCrea.myDir == 1 && myCrea.myY = 0) || (myCrea.myDir == 2 && myCrea.myX = 0) || (myCrea.myDir == 3 && myCrea.myY = gridHeight - 1)) {
				myCrea.myDir = myMod(myCrea.myDir + choose(1,-1),4)
			}
			
			// move one tile in proper direction
			if(myCrea.myDir == 0) {
				myCrea.myX += 1;
			}
			if(myCrea.myDir == 1) {
				myCrea.myY -= 1;
			}
			if(myCrea.myDir == 2) {
				myCrea.myX -= 1;
			}
			if(myCrea.myDir == 3) {
				myCrea.myY += 1;
			}
			
			// Lower hunger
			myCrea.myHunger -= 1;
			
			// if starving or attacked by player after moving, die
			if(myCrea.myHunger < myCrea.deathThreshold || (myCrea.myX == spearX && myCrea.myY == spearY)) {
				if(myCrea.myX == spearX && myCrea.myY == spearY) {
					plrChoice = true;
				}
				myCrea.eaten = true
			}
		}
	}
}