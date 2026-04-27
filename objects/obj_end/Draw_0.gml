draw_set_font(Font3)
draw_text_ext(10,10,"You died!",30,room_width * 0.55);
draw_text_ext(10,60,"Survival Time: " + string(gameTime/60) + " s",30,room_width * 0.55);
draw_set_colour(c_yellow);
draw_text_ext(10,110,"Score: " + string(profitMax),30,room_width * 0.55);
draw_set_colour(c_white);
draw_text_ext(10,160,"How did your environment do? How did you do? Space to start again",30,room_width * 0.55);
draw_sprite_ext(spr_foodChain,0,500,-150,0.6,0.6,0,c_white,1);
var trueRecSteps = min(recordedSteps,floor(gameTime/16));
draw_graph(0.1 * room_width,0.4 * room_height,0.9 * room_width, 0.63 * room_height,grassMax,grassCount,c_lime,trueRecSteps,1,2);
colors = [c_white,c_orange,c_fuchsia,c_red,c_aqua,c_blue];
for(e = 0; e < numbOfSpecies; e++) {
	draw_graph(0.1 * room_width,0.4 * room_height,0.9 * room_width, 0.63 * room_height,creaMax[e],speciesCount[e],colors[e],trueRecSteps,1,2);
}

draw_graph(0.1 * room_width,0.67 * room_height,0.9 * room_width, 0.9 * room_height,profitMax,profitCount,c_yellow,trueRecSteps,1,2);
draw_rectangle(0.09 * room_width,0.39 * room_height,0.91 * room_width, 0.64 * room_height,true)
draw_rectangle(0.09 * room_width,0.66 * room_height,0.91 * room_width, 0.91 * room_height,true)
draw_sprite_ext(spr_mouse,0,mouse_x,mouse_y,2,2,0,c_white,1);