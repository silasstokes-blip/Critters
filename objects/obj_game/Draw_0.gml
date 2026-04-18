// ---------------------------DRAW GRASS AND CRITTERS ---------------------------------
for(f = 0;f < gridWidth; f++) {
	for(e = 0;e < gridHeight; e++) {
		draw_sprite_ext(spr_grassPixel,grid[f][e],f,e,1,1,0,c_white,1);
	}
}
for(f = 0; f < creaCount; f++) {
	if(!crea[f].eaten) {
		if(crea[f].myType == 0) {
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,0.35,0.35,0,c_white,1);
		} else if(crea[f].myType == 1){
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,0.6,0.6,0,c_orange,1);
		} else if(crea[f].myType == 2) {
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,1,1,0,c_fuchsia,1);
		} else if(crea[f].myType == 3) {
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,0.85,0.85,0,c_red,1);
		} else if(crea[f].myType == 4) {
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,0.25,0.25,0,c_aqua,1);
		} else {
			draw_sprite_ext(spr_pixel2,0,crea[f].myX + 0.5,crea[f].myY + 0.5,0.4,0.4,0,c_blue,1);
		}
	}
}
// ---------------------------DRAW HOUSE ---------------------------------
var c_brown = merge_color(c_orange,c_black,0.5);
draw_rectangle_colour(houseX1,houseY1,houseX2,houseY2,c_brown, c_brown, c_brown, c_brown,false);
draw_sprite_ext(spr_graphs,0,chartX,chartY,2/32,2/32,0,c_white,1);
draw_sprite_ext(spr_scope,0,teleX,teleY,2/32,2/32,0,c_white,1);

// ---------------------------DRAW PLAYER ---------------------------------
draw_sprite_ext(spr_pixel,0,plrX,plrY,1,1,0,c_yellow,1);
draw_sprite_ext(spr_spear,0,plrX + 0.5,plrY + 0.5,spearLength * 0.15,0.15,spearDir,c_white,1);

// ---------------------------DRAW PARTICLES ---------------------------------
part_system_drawit(partSys);

// ---------------------------DRAW UI ---------------------------------

// hunger
draw_set_font(Font3)
draw_healthbar(camX + (0.02 * camW),camY + (0.02 * camH),camX + (0.35 * camW),camY + (0.07 * camH),(plrHunger/plrHungerMax) * 100,c_black,c_red,c_red,0,true,false);
draw_set_colour(c_black);
draw_text_transformed(camX + (0.02 * camW),camY + (0.015 * camH),"HUNGER",0.05,0.05,0);
draw_set_colour(c_white);

// lives

for(f =  0; f < plrMaxLives; f++) {
	draw_sprite_ext(spr_life,f < plrLives,camX + ((0.02 + (0.05 * f)) * camW),camY + (0.08 * camH),0.003 * camW,0.003 * camW,0,c_white,1);
}

// profit number
draw_set_colour(merge_colour(c_yellow,c_black,0.5))
draw_text_transformed(camX + (0.5 * camW) - (string_width(plrProfit) * 0.5 * 0.125) - 0.2,camY + (0.02 * camH),string(plrProfit),0.125,0.125,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width(plrProfit) * 0.5 * 0.125),camY + (0.02 * camH) - 0.2,string(plrProfit),0.125,0.125,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width(plrProfit) * 0.5 * 0.125) + 0.2,camY + (0.02 * camH),string(plrProfit),0.125,0.125,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width(plrProfit) * 0.5 * 0.125),camY + (0.02 * camH) + 0.2,string(plrProfit),0.125,0.125,0);
draw_set_colour(c_yellow);
draw_text_transformed(camX + (0.5 * camW) - (string_width(plrProfit) * 0.5 * 0.125),camY + (0.02 * camH),string(plrProfit),0.125,0.125,0);

// Death text

if(deathAnim > 0) {
	draw_set_colour(c_red);
	var word = "EATEN!";
	if(plrHunger <= 0) {
		word = "STARVED!";
	}
	draw_text_transformed(camX + (0.5 * camW) - (string_width(word) * 0.5 * 0.125),camY + (0.5 * camH) - (string_height(word) * 0.5 * 0.125),word,0.125,0.125,0);
}

// --------------------------- DRAW GRAPHS ---------------------------------
if(graphView) {
	draw_set_colour(c_black)
	draw_rectangle(0,0,room_width,room_height,false);
	draw_set_colour(c_lime)
	var trueRecSteps = min(recordedSteps,floor(gameTime/4));
	draw_graph(0.1 * room_width,0.1 * room_height,0.9 * room_width, 0.9 * room_height,grassMax,grassCount,c_lime,trueRecSteps,1);
	colors = [c_white,c_orange,c_fuchsia,c_red,c_aqua,c_blue];
	for(e = 0; e < numbOfSpecies; e++) {
		draw_graph(0.1 * room_width,0.1 * room_height,0.9 * room_width, 0.9 * room_height,creaMax[e],speciesCount[e],colors[e],trueRecSteps,1);
	}
	draw_sprite_ext(spr_foodChain,1,camX,camY,camW/1366,camH/768,0,c_white,1);
}

// Exit menu text

if(envView || graphView) {
	draw_text_transformed(camX + (0.5 * camW) - (string_width("ESC to Close") * 0.5 * 0.1),camY + camH - (0.05 * camH) - (string_height("ESC to Close") * 0.1),"ESC to Close",0.1,0.1,0);
}