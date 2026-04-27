if(room == roomEnd) {
	instance_create_depth(x,y,depth,obj_end);
	obj_end.recordedSteps = recordedSteps;
	obj_end.gameTime = gameTime;
	obj_end.numbOfSpecies = numbOfSpecies;
	obj_end.grassMax = grassMax;
	obj_end.grassCount = grassCount;
	obj_end.profitMax = profitMax;
	obj_end.profitCount = profitCount;
	for(f = 0; f < numbOfSpecies; f++) {
		obj_end.creaMax[f] = creaMax[f];
		obj_end.speciesCount[f] = speciesCount[f];
	}
	instance_destroy();
}