function simulate_grass_growth(){
	// for each time
	for(f = 0;f < gridWidth; f++) {
		for(e = 0;e < gridHeight; e++) {
			
			// let tall grass periodically spread into surrounding emply tiles
			
			if(grid[f][e] >= 3) {
				if(f > 0 && irandom_range(1,1/grassSpreadChance) == 1) {
					grid[f - 1][e] = max(1,grid[f - 1][e])
				}
				if(f < gridWidth - 1 && irandom_range(1,1/grassSpreadChance) == 1) {
					grid[f + 1][e] = max(1,grid[f + 1][e])
				}
				if(e > 0 && irandom_range(1,1/grassSpreadChance) == 1) {
					grid[f][e - 1] = max(1,grid[f][e - 1])
				}
				if(e < gridHeight - 1 && irandom_range(1,1/grassSpreadChance) == 1) {
					grid[f][e + 1] = max(1,grid[f][e + 1])
				}
			} 
			
			// let short grass mature over time
			
			if(grid[f][e] >= 1) {
				if(irandom_range(1,1/grassGrowthChance) == 1) {
					grid[f][e] = min(4,grid[f][e] + 1);
				}
			}
			
			// count grass for species populations
			grassCount[0] += grid[f][e];
			
		}
	}
}