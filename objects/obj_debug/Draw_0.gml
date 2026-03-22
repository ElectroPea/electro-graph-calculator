draw_set_halign(fa_left);
draw_set_alpha(1);
draw_set_font(font_debug);
draw_set_color(c_black);

var a = return_a();

for(var i = 0; i < array_length(a); i++)
{
	draw_text(x, y+i*16, a[i])
}