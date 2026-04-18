draw_set_font(Font3)
draw_text_ext(10,10,"Welcome to the demo of Critters and You, an environmental survival game. Your goal is to suvive and turn a profit in this wild landscape and navigate your role in its food chain The environment is fully simulated and dynamic, and your efforts for survival and profit may have consequences. Get as high a profit score as possible",30,room_width-20);
draw_text_ext(10,150,"Avoid getting hunted by ",30,room_width-20);
draw_set_colour(c_orange);
draw_text_ext(10 + string_width("Avoid getting hunted by "),150,"coyotes",30,room_width-20);
draw_set_colour(c_white);
draw_text_ext(10 + string_width("Avoid getting hunted by coyotes "),150,"and",30,room_width-20);
draw_set_colour(c_red);
draw_text_ext(10 + string_width("Avoid getting hunted by coyotes and "),150,"wolves",30,room_width-20);
draw_set_colour(c_white);
draw_text_ext(10,200,"Larger animals sell for more",30,room_width-20);
draw_text_ext(10,250,"Don't let your hunger reach zero",30,room_width-20);
draw_text_ext(10,300,"Space to start",30,room_width-20);
draw_sprite(spr_foodChain,0,0,0);