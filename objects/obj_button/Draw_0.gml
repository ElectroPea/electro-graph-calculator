draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, 0,
HexcodeToColor(global.colors.BUTTON)
,1);
draw_set_font(font_debug); draw_set_color(#000000); draw_set_halign(fa_center); draw_set_valign(fa_center); 

var delta = sprite_get_bbox_top(sprite_indexs.stat) - sprite_get_bbox_top(sprite_index);
draw_set_color(HexcodeToColor(global.colors.BUTTONTEXT));
draw_text(
	x,
	y - delta/2,
	text
);
draw_set_halign(fa_left);