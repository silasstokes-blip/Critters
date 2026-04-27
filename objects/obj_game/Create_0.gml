randomise();
cellSize = 1;
gridWidth = room_width/cellSize;
gridHeight = room_height/cellSize
for(f = 0;f < gridWidth + 2; f++) {
	for(e = 0;e < gridHeight + 2; e++) {
		grid[f][e] = 4;
	}
}
houseW = 10;
houseH = 10;
sounds = [snd_rabbit,snd_coyote,snd_elk,snd_wolf,snd_mouse,snd_ferret];
houseX1 = floor((room_width - houseW)/2);
houseX2 = floor((room_width + houseW)/2);
houseY1 = floor((room_height - houseH)/2);
houseY2 = floor((room_height + houseH)/2);
grassSpreadChance = 0.001;
grassGrowthChance = 0.15;
numbOfSpecies = 6;
feedTrapCount = 0;
feedTrapList = array_create(32, noone);
miniGraph = true;
miniFoodChain = false;
for(f = 0; f < numbOfSpecies; f++) {
	feedTrapsPlaced[f] = 0;
}
graphView = false;
creaFeed = [1.8, 70, 2, 25, 1.95, 80];
baseCreaFeed = [creaFeed[0], creaFeed[1], creaFeed[2], creaFeed[3], creaFeed[4], creaFeed[5]];
creaChild = [160 * 1.5, 240 * 1.2, 400, 350 * 1.5, 150, 90 * 1.2];
creaStarve = [-400, -200,-20, -250, -10, -300];
reproductiveAge = 5;
baseCount = [50, 4, 7, 1, 40, 4];
creaSize = [0.35, 0.6, 1, 0.85, 0.25, 0.4];
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
hungerRate = 0.075;
plrFeed = 15;
plrProfit = 0;
plrLives = 2;
plrMaxLives = 2;
camX = 0;
camY = 0;
camW = room_width;
camH = room_height;
chartX = houseX1 + 2;
chartY = houseY1 + 2;
teleX = houseX1 + 6;
teleY = houseY1 + 2;
shopX = houseX1 + 6;
shopY = houseY1 + 6;
respawnX = floor(houseX1 + 3);
respawnY = floor(houseY1 + 7);
plrX = respawnX;
plrY = respawnY;
viewClosed = false;
deathAnim = -1;
shopView = false;
trapSpin = 0;

gameTime = -1;
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
/*repeat(20) {
	var type = irandom_range(0, numbOfSpecies - 1);
	feedTrapList[feedTrapCount] = create_feeder_trap(irandom_range(0,1),irandom_range(0,gridWidth - 1),irandom_range(0,gridHeight - 1),type);
	feedTrapCount++;
	feedTrapsPlaced[type]++;
}*/
timeLeft = 6 * 60
recordedSteps = 3000;
grassMax = 0;
profitMax = 0;
for(f = 0;f < numbOfSpecies; f++) {
	creaMax[f] = 0;
	creaStability[f] = 0;
	feeders[f] = 0;
	traps[f] = 0;
}
	
grassCount = array_create(recordedSteps, 0);
profitCount = array_create(recordedSteps, 0);
for(s = 0; s < numbOfSpecies; s++) {
	speciesCount[s] = array_create(recordedSteps, 0);
}
grassStability = 0;

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

partType2[1] = part_type_create();
part_type_size(partType2[1],0.002,0.010,0,0);
part_type_colour1(partType2[1],c_orange)
part_type_shape(partType2[1],pt_shape_square);
part_type_direction(partType2[1],0,360,0,0);
part_type_speed(partType2[1],0.08,0.3,-0.05,0);
part_type_life(partType2[1],20,60);
part_type_alpha1(partType2[1],0.3);
partType2[3] = part_type_create();
part_type_size(partType2[3],0.002,0.010,0,0);
part_type_colour1(partType2[3],c_red)
part_type_shape(partType2[3],pt_shape_square);
part_type_direction(partType2[3],0,360,0,0);
part_type_speed(partType2[3],0.08,0.3,-0.05,0);
part_type_life(partType2[3],20,60);
part_type_alpha1(partType2[3],0.3);

partTypePlr = part_type_create();
part_type_size(partTypePlr,0.01,0.03,0,0);
part_type_colour1(partTypePlr,c_yellow)
part_type_shape(partTypePlr,pt_shape_sphere);
part_type_direction(partTypePlr,0,360,0,0);
part_type_speed(partTypePlr,0.1,0.5,-0.01,0);
part_type_life(partTypePlr,10,60);

moneyPromptX = 0;
moneyPromptY = 0;
moneyPromptAlpha = 0;
placeView = false;
stepTime = 0;
//perlin_fill_grid(grid,room_width,room_height,10,10);

//grid = array_create_ext(gridWidth,array_create_ext(gridHeight, irandom_range(0,1)));