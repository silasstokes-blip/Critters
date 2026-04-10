for(f = 0;f < gridWidth; f++) {
	for(e = 0;e < gridHeight; e++) {
		draw_sprite_ext(spr_grassPixel,grid[f][e],f,e,1,1,0,c_white,1);
		/*point1X = floor(f/10)// top left
		point1Y = floor(e/10)// top left
		point2X = ceil(f/10)// top left
		point2Y = floor(e/10)// top left
		point3X = floor(f/10)// top left
		point3Y = ceil(e/10)// top left
		point4X = ceil(f/10)// top left
		point4Y = ceil(e/10)// top left
		if(mouse_x = f && mouse_y = e) {
			draw_sprite_ext(spr_pixel,0,point1X * 10,point1Y * 10,1,1,0,c_red,1);
			draw_sprite_ext(spr_pixel,0,point2X * 10,point2Y * 10,1,1,0,c_red,1);
			draw_sprite_ext(spr_pixel,0,point3X * 10,point3Y * 10,1,1,0,c_red,1);
			draw_sprite_ext(spr_pixel,0,point4X * 10,point4Y * 10,1,1,0,c_red,1);
		}
		draw_set_font(Font1)
		draw_text_transformed(f,e,grid[f][e],0.01,0.01,0);*/
	}
}
for(f = 0; f < creaCount; f++) {
	if(!crea[f].eaten) {
		if(crea[f].myType == 0) {
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_white,1);
		} else if(crea[f].myType == 1){
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_orange,1);
		} else if(crea[f].myType == 2) {
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_fuchsia,1);
		} else if(crea[f].myType == 3) {
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_red,1);
		} else if(crea[f].myType == 4) {
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_aqua,1);
		} else {
			draw_sprite_ext(spr_pixel,0,crea[f].myX,crea[f].myY,1,1,0,c_blue,1);
		}
		//draw_text_transformed_colour(crea[f].myX,crea[f].myY,crea[f].myDir,0.05,0.05,0,c_black,c_black,c_black,c_black,1);
	}
	//draw_text_transformed(0,6,(1/(creaChild[0]/(creaFeed[0] - 1))) * (speciesCount[0][0]),0.2,0.2,0);
	//draw_text_transformed(0,10,speciesCount[3][0],0.5,0.5,0);
}

draw_sprite_ext(spr_pixel,0,plrX,plrY,1,1,0,c_yellow,1);
draw_text_transformed_colour(plrX - 4,plrY - 4,plrHunger,0.05,0.05,0,c_yellow,c_yellow,c_yellow,c_yellow,1);
draw_text_transformed_colour(plrX + 2,plrY - 4,plrProfit,0.05,0.05,0,c_yellow,c_yellow,c_yellow,c_yellow,1);
draw_sprite_ext(spr_pixel,0,spearX,spearY,1,1,0,c_ltgray,1);

if(!true) {
	grassAverage = 0;
	for(s = 0;s < numbOfSpecies; s++) {
		creaAverage[s] = 0;
	}
	for(f = 0; f < recordedSteps; f += 5) {
		grassAverage += grassCount[f];
		for(s = 0;s < numbOfSpecies; s++) {
			creaAverage[s] += speciesCount[s][f];
		}
	}
	for(s = 0;s < numbOfSpecies; s++) {
		creaAverage[s] /= (recordedSteps/5);
		creaStability[s] = 1;
	}
	grassAverage /= (recordedSteps/5);
	for(f = 0; f < recordedSteps; f += 5) {
		grassStability += sqrt(abs(grassCount[f] - grassAverage)/(grassMax));
		
		for(s = 0;s < numbOfSpecies; s++) {
			creaStability[s] += sqrt(abs(speciesCount[s][f] - creaAverage[s])/(creaMax[s]));
		}
	}
	grassStability /= (recordedSteps/5);
	for(s = 0;s < numbOfSpecies; s++) {
		creaStability[s] /= (recordedSteps/5);
	}
	
}
if(!true) {
	draw_set_colour(c_black)
	draw_rectangle(0,0,room_width,room_height,false);
	draw_set_colour(c_lime)
	draw_text_transformed(0,0,grassStability,0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((grassCount[f]/grassMax) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((grassCount[f - 5]/grassMax) * 0.8)) * room_height,0.1);
	}
	draw_set_colour(c_white)
	draw_text_transformed(0,2,creaStability[0],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[0][f]/creaMax[0]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[0][f - 5]/creaMax[0]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[0]/creaMax[0]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[0]/creaMax[0]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_orange)
	draw_text_transformed(0,4,creaStability[1],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f - 5]/creaMax[1]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[1]/creaMax[1]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[1]/creaMax[1]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_fuchsia)
	draw_text_transformed(0,6,creaStability[2],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[2][f]/creaMax[2]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[2][f - 5]/creaMax[2]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[2]/creaMax[2]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[2]/creaMax[2]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_red)
	draw_text_transformed(0,8,creaStability[3],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[3][f]/creaMax[3]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[3][f - 5]/creaMax[3]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[3]/creaMax[3]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[3]/creaMax[3]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_aqua)
	draw_text_transformed(0,8,creaStability[4],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[4][f]/creaMax[4]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[4][f - 5]/creaMax[4]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[4]/creaMax[4]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[4]/creaMax[4]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_blue)
	draw_text_transformed(0,8,creaStability[5],0.1,0.1,0);
	for(f = 5; f < recordedSteps; f += 5) {
		//draw_sprite_ext(spr_pixel,0,(0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[1][f]/creaMax[1]) * 0.8)) * room_height,0.1,0.1,0,c_red,1)
		draw_line_width((0.1 + (((recordedSteps - f)/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[5][f]/creaMax[5]) * 0.8)) * room_height,(0.1 + (((recordedSteps - (f - 5))/recordedSteps) * 0.8)) * room_width,(0.9 - ((speciesCount[5][f - 5]/creaMax[5]) * 0.8)) * room_height,0.1);
	}
	draw_line_width(0.1 * room_width,(0.9 - ((baseCount[5]/creaMax[5]) * 0.8)) * room_height,0.9 * room_width,(0.9 - ((baseCount[5]/creaMax[5]) * 0.8)) * room_height,0.1);
	draw_set_colour(c_white)
	
}
/*for(f = 0;f < gridWidth/10; f++) {
	for(e = 0;e < gridHeight/10; e++) {
		draw_line_width(f * 10,e * 10,f * 10 + lengthdir_x(3,perl[f][e]),e * 10 + lengthdir_y(3,perl[f][e]),0.1);
	}
}
if(!keyboard_check(ord("E"))) {