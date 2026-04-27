draw_set_font(Font3)
draw_text_ext(10,10,"Welcome to the demo of Critters and You, an environmental survival game. Your goal is to suvive and turn a profit in this wild landscape and navigate your role in its food chain The environment is fully simulated and dynamic, and your efforts for survival and profit may have consequences. Get as high a profit score as possible",30,room_width-20);

draw_text_ext(10,150,"Get the highest score you can!",30,room_width-20);

draw_text_ext(10,200,"WASD to move, hold and move mouse to stab, E to place feeders and traps",30,room_width-20);

draw_text_ext(10,250,"Avoid getting hunted by ",30,room_width-20);
draw_set_colour(c_orange);
draw_text_ext(10 + string_width("Avoid getting hunted by "),250,"coyotes",30,room_width-20);
draw_set_colour(c_white);
draw_text_ext(10 + string_width("Avoid getting hunted by coyotes "),250,"and",30,room_width-20);
draw_set_colour(c_red);
draw_text_ext(10 + string_width("Avoid getting hunted by coyotes and "),250,"wolves",30,room_width-20);

draw_set_colour(c_white);
draw_text_ext(10,300,"Larger animals sell for more",30,room_width-20);
draw_text_ext(10,350,"Don't let your hunger reach zero, you have eight minutes",30,room_width-20);
draw_text_ext(10,400,"Space to start",30,room_width-20);
draw_sprite(spr_foodChain,0,0,0);
//draw_sprite_ext(spr_mouse,0,mouse_x,mouse_y,2,2,0,c_white,1);
draw_sprite_ext(spr_mouse,0,device_mouse_x_to_gui(0),device_mouse_y_to_gui(0),2,2,0,c_white,1);