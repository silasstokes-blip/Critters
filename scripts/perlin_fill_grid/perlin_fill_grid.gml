function perlin_fill_grid(grid,gridW,gridH,relCelW,relCelH){
	
for(f = 0; f < ceil(gridW/relCelW) + 1; f++) {
	for(e = 0; e < ceil(gridH/relCelH) + 1; e++) {
		perl[f][e] = random_range(0,2 * pi);
	}
}
for(f = 0; f < gridW; f++) {
	for(e = 0; e < gridH; e++) {
		point1X = floor(f/relCelW)// top left
		point1Y = floor(e/relCelH)// top left
		var dot1 = ((f - (point1X * relCelW))/relCelW * cos(perl[point1X][point1Y])) + ((e - (point1Y * relCelH))/relCelH * sin(perl[point1X][point1Y]));
		point2X = ceil(f/relCelW)// top left
		point2Y = floor(e/relCelH)// top left
		var dot2 = ((f - (point2X * relCelW))/relCelW * cos(perl[point2X][point2Y])) + ((e - (point2Y * relCelH))/relCelH * sin(perl[point2X][point2Y]));
		point3X = floor(f/relCelW)// top left
		point3Y = ceil(e/relCelH)// top left
		var dot3 = ((f - (point3X * relCelW))/relCelW * cos(perl[point3X][point3Y])) + ((e - (point3Y * relCelH))/relCelH * sin(perl[point3X][point3Y]));
		point4X = ceil(f/relCelW)// top left
		point4Y = ceil(e/relCelH)// top left
		var dot4 = ((f - (point4X * relCelW))/relCelW * cos(perl[point4X][point4Y])) + ((e - (point4Y * relCelH))/relCelH * sin(perl[point4X][point4Y]));
		xpercent = (f - (point1X * relCelW))/relCelW;
		ypercent = (e - (point1Y * relCelH))/relCelH;
		topInterp = ((1 - xpercent) * dot1) + (xpercent * dot2)
		bottomInterp = ((1 - xpercent) * dot3) + (xpercent * dot4)
		grid[f][e] = ((1  - ypercent) * topInterp) + (ypercent * bottomInterp);
	}
}


}