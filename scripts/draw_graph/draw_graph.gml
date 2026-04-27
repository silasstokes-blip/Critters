function draw_graph(x1,y1,x2,y2,maxValue,valueArray,color,domain,detail,lineWidth){
	draw_set_colour(color)
	for(f = detail + 1; f < domain; f += detail) {
		draw_line_width(x1 + (((domain - f)/domain) * (x2 - x1)),y2 - ((valueArray[f]/maxValue) * (y2 - y1)),x1 + (((domain - (f - detail))/domain) * (x2 - x1)),y2 - ((valueArray[f - detail]/maxValue) * (y2 - y1)),lineWidth);
		//draw_line_width((0.1 + (((trueRecSteps - f)/trueRecSteps) * 0.8)) * room_width,(0.9 - ((grassCount[f]/grassMax) * 0.8)) * room_height,(0.1 + (((trueRecSteps - (f - 5))/trueRecSteps) * 0.8)) * room_width,(0.9 - ((grassCount[f - 5]/grassMax) * 0.8)) * room_height,0.1);
	}
	draw_set_colour(c_white);
}