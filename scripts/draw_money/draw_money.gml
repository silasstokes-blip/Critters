function draw_money(){
var size = 0.125 * cellSize;
if(envView) {size *= 2}
draw_set_colour(merge_colour(c_yellow,c_black,0.5))
draw_text_transformed(camX + (0.5 * camW) - (string_width("$" + string(plrProfit)) * 0.5 * size) - (0.2 * cellSize),camY + (0.02 * camH),"$" + string(plrProfit),size,size,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width("$" + string(plrProfit)) * 0.5 * size),camY + (0.02 * camH) - (0.2 * cellSize),"$" + string(plrProfit),size,size,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width("$" + string(plrProfit)) * 0.5 * size) + (0.2 * cellSize),camY + (0.02 * camH),"$" + string(plrProfit),size,size,0);
draw_text_transformed(camX + (0.5 * camW) - (string_width("$" + string(plrProfit)) * 0.5 * size),camY + (0.02 * camH) + (0.2 * cellSize),"$" + string(plrProfit),size,size,0);
draw_set_colour(c_yellow);
draw_text_transformed(camX + (0.5 * camW) - (string_width("$" + string(plrProfit)) * 0.5 * size),camY + (0.02 * camH),"$" + string(plrProfit),size,size,0);
}