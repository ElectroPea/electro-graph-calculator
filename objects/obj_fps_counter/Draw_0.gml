draw_reset(); draw_set_color(HexcodeToColor(global.colors.UPPERMENU.fpscolor));
draw_set_font(font_debug); draw_set_halign(fa_right);
draw_text(x + 15,y - 4,string_concat("FPS: ", fps));
draw_set_halign(fa_left);