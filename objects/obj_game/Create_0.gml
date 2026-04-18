randomise();
cellSize = 1;
gridWidth = room_width/cellSize;
gridHeight = room_height/cellSize
for(f = 0;f < gridWidth; f++) {
	for(e = 0;e < gridHeight; e++) {
		grid[f][e] = 4;
	}
}
houseX1 = 10;
houseX2 = 18;
houseY1 = 10;
houseY2 = 18;
grassSpreadChance = 0.001;
grassGrowthChance = 0.15;
numbOfSpecies = 6
graphView = false;
creaFeed[0] = 1.8;
creaFeed[1] = 18;
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
creaChild[0] = 160 * 1.5;
creaChild[1] = 200 * 1.2;
creaChild[2] = 300;
creaChild[3] = 350 * 1.5;
creaChild[4] = 150;
creaChild[5] = 100 * 1.2;
creaStarve[0] = -400;//15;
creaStarve[1] = -200;
creaStarve[2] = -20;
creaStarve[3] = -250;
creaStarve[4] = -10;//15;
creaStarve[5] = -300;
reproductiveAge = 5;
baseCount[0] = 0.5 * 100;
baseCount[1] = 0.5 * 7;
baseCount[2] = 0.5 * 14;
baseCount[3] = 0.5 * 2;
baseCount[4] = 0.5 * 60;
baseCount[5] = 0.5 * 9;
camW = 32 * 2;
camH = 18 * 2;
spearX = -100;
spearY = -100;
spearLength = 0;
spearDir = 0;
spearTime = -1;
plrDir = 0;
plrChoice = false;
plrHunger = 50
plrHungerMax = 50;
plrFeed = 15;
plrProfit = 0;
plrLives = 1;
plrMaxLives = 1;
camX = 0;
camY = 0;
camW = room_width;
camH = room_height;
chartX = houseX1 + 1;
chartY = houseY1 + 1;
teleX = houseX1 + 5;
teleY = houseY1 + 1;
respawnX = floor(houseX1 + (houseX2 - houseX1)/2);
respawnY = floor(houseY1 + (houseY2 - houseY1) * 0.66);
plrX = respawnX;
plrY = respawnY;
viewClosed = false;
deathAnim = -1;

gameTime = 0;
creaCount = 0;
stepCounter = 0;
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
profitMax = 0;
for(f = 0;f < numbOfSpecies; f++) {
	creaMax[f] = 0;
	creaStability[f] = 0;
}
	
grassCount = array_create(recordedSteps, 0);
profitCount = array_create(recordedSteps, 0);
for(s = 0; s < numbOfSpecies; s++) {
	speciesCount[s] = array_create(recordedSteps, 0);
}
grassStability = 0;
creaSize[0] = 1;
creaSize[1] = 1;
creaSize[2] = 4;

envView = false;
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

partSys = part_system_create();
part_system_automatic_draw(partSys,false);

for(f = 0; f < numbOfSpecies; f++) {
	partType[f] = part_type_create();
	part_type_size(partType[f],0.005,0.015,0,0);
	part_type_colour1(partType[f],c_white)
	part_type_shape(partType[f],pt_shape_sphere);
	part_type_direction(partType[f],0,360,0,0);
	part_type_speed(partType[f],0.08,0.3,-0.01,0);
	part_type_life(partType[f],5,25);
}
part_type_colour1(partType[1],c_orange)
part_type_speed(partType[1],0.1,0.5,-0.01,0);
part_type_size(partType[1],0.008,0.020,0,0);
part_type_colour1(partType[2],c_fuchsia)
part_type_speed(partType[2],0.12,0.6,-0.01,0);
part_type_size(partType[2],0.01,0.025,0,0);
part_type_colour1(partType[3],c_red)
part_type_speed(partType[3],0.12,0.6,-0.01,0);
part_type_size(partType[3],0.01,0.025,0,0);
part_type_colour1(partType[4],c_aqua)
part_type_speed(partType[4],0.05,0.2,-0.01,0);
part_type_size(partType[4],0.003,0.008,0,0);
part_type_colour1(partType[5],c_blue)

partTypePlr = part_type_create();
part_type_size(partTypePlr,0.01,0.03,0,0);
part_type_colour1(partTypePlr,c_yellow)
part_type_shape(partTypePlr,pt_shape_sphere);
part_type_direction(partTypePlr,0,360,0,0);
part_type_speed(partTypePlr,0.1,0.5,-0.01,0);
part_type_life(partTypePlr,10,60);
//perlin_fill_grid(grid,room_width,room_height,10,10);

//grid = array_create_ext(gridWidth,array_create_ext(gridHeight, irandom_range(0,1)));