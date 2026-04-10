randomise();
cellSize = 1;
gridWidth = room_width/cellSize;
gridHeight = room_height/cellSize
for(f = 0;f < gridWidth; f++) {
	for(e = 0;e < gridHeight; e++) {
		grid[f][e] = 4;
	}
}
grassSpreadChance = 0.001;
grassGrowthChance = 0.08;
numbOfSpecies = 6
creaFeed[0] = 1.4;
creaFeed[1] = 15;
creaFeed[2] = 2;
creaFeed[3] = 12;
creaFeed[4] = 1.95;
creaFeed[5] = 25;
baseCreaFeed[0] = creaFeed[0];
baseCreaFeed[1] = creaFeed[1];
baseCreaFeed[2] = creaFeed[2];
baseCreaFeed[3] = creaFeed[3];
baseCreaFeed[4] = creaFeed[4];
baseCreaFeed[5] = creaFeed[5];
creaChild[0] = 50 * 1.5;
creaChild[1] = 120 * 1.2;
creaChild[2] = 300;
creaChild[3] = 300 * 1.5;
creaChild[4] = 150;
creaChild[5] = 100 * 1.2;
creaStarve[0] = -200;//15;
creaStarve[1] = -300;
creaStarve[2] = -20;
creaStarve[3] = -300;
creaStarve[4] = -10;//15;
creaStarve[5] = -300;
reproductiveAge = 15;
baseCount[0] = 1 * 100;
baseCount[1] = 1 * 6;
baseCount[2] = 1 * 14;
baseCount[3] = 1 * 2;
baseCount[4] = 1 * 60;
baseCount[5] = 1 * 9;
camW = 32;
camH = 18;
plrX = room_width/2;
plrY = room_width/2;
spearX = -1;
spearY = -1;
plrDir = 0;
plrChoice = false;
plrHunger = 50
plrHungerMax = 50;
plrFeed = 15;
plrProfit = 0;


creaCount = 0;
repeat(baseCount[0]) {
	crea[creaCount] = create_creature(0,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].myHunger = irandom_range(0,creaChild[0]);
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	creaCount++;
}
repeat(baseCount[1]) {
	crea[creaCount] = create_creature(1,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	creaCount++;
}
repeat(baseCount[2]) {
	crea[creaCount] = create_creature(2,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	crea[creaCount].myHunger = irandom_range(0,creaChild[2]);
	creaCount++;
}
repeat(baseCount[3]) {
	crea[creaCount] = create_creature(3,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	creaCount++;
}
repeat(baseCount[4]) {
	crea[creaCount] = create_creature(4,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	crea[creaCount].myHunger = irandom_range(0,creaChild[4]);
	creaCount++;
}
repeat(baseCount[5]) {
	crea[creaCount] = create_creature(5,irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1));
	crea[creaCount].age = irandom_range(0,reproductiveAge);
	creaCount++;
}
recordedSteps = 3000;
grassMax = 0;
for(f = 0;f < numbOfSpecies; f++) {
	creaMax[f] = 0;
	creaStability[f] = 0;
}
	
for(f = 0; f < recordedSteps; f++) {
	grassCount[f] = 0;
	for(s = 0; s < numbOfSpecies; s++) {
		speciesCount[s][f] = 0;
	}
}
grassStability = 0;
creaSize[0] = 1;
creaSize[1] = 1;
creaSize[2] = 4;


testedScenarios = 100;
for(f = 0; f < testedScenarios; f++) {
	_grassSpread[f] = random_range(0,0.4);
	_grassGrowth[f] = random_range(0,0.4);
	_rabbitStarve[f] = irandom_range(-1,-50);
	_rabbitChild[f] = irandom_range(1,20);
	_rabbitFeed[f] = irandom_range(1,10);
	_wolfStarve[f] = irandom_range(-1,-50);
	_wolfChild[f] = irandom_range(1,20);
	_wolfFeed[f] = irandom_range(1,10);
}
//perlin_fill_grid(grid,room_width,room_height,10,10);

//grid = array_create_ext(gridWidth,array_create_ext(gridHeight, irandom_range(0,1)));