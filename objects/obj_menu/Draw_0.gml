draw_set_color(HexcodeToColor(global.colors.UPPERMENU.outline)); draw_rectangle(0, 0, room_width, 16, false);
draw_set_color(HexcodeToColor(global.colors.UPPERMENU.bg)); draw_rectangle(0, 0, room_width, 14, false);

draw_set_font(font_options);
var h_gap = 0;
for(var STRUCT_INDEX = 0; STRUCT_INDEX < array_length(global.menu_order); STRUCT_INDEX++)
{
	var cur_menu = struct_get(global.menu, global.menu_order[STRUCT_INDEX]);
	draw_set_valign(fa_bottom); draw_set_halign(fa_left);
	
	if (cur_menu.show == true)
	{
		if (STRUCT_INDEX == chosen_table._id)
		{
			var cur_hitbox = {
				x0: 4 + h_gap + (STRUCT_INDEX > 0 ? 4 * STRUCT_INDEX : 0),
				y0: 16 - string_height(cur_menu.name),
				w: string_width(cur_menu.name),
				h: string_height(cur_menu.name)
			};
			draw_set_color(mouse_check_button(mb_left) ? 
			HexcodeToColor(global.colors.UPPERMENU.buttons.PRESSED.bg) : 
			HexcodeToColor(global.colors.UPPERMENU.buttons.HOVER.bg));
			draw_rectangle(cur_hitbox.x0, cur_hitbox.y0, cur_hitbox.x0 + cur_hitbox.w, cur_hitbox.y0 + cur_hitbox.h - 2, false);
		
			draw_set_color(mouse_check_button(mb_left) ? 
			HexcodeToColor(global.colors.UPPERMENU.buttons.PRESSED.textcolor) : 
			HexcodeToColor(global.colors.UPPERMENU.buttons.HOVER.textcolor));
		} else {
			draw_set_color(HexcodeToColor(global.colors.UPPERMENU.buttons.STATIC.textcolor));
		}
	
	
		draw_text(4 + h_gap + (STRUCT_INDEX > 0 ? 4 * STRUCT_INDEX : 0), 16, cur_menu.name);
		h_gap += string_width(cur_menu.name);	
	}
}
draw_set_valign(fa_top); draw_set_halign(fa_left);

//var found_cursor = (mouse_x - x < 8 && mouse_x - x > -8);
//draw_set_color(found_cursor ? #ff00b3 : #000000);
//draw_rectangle(x-2, y, room_width, room_height, false)
//draw_set_color(#cac6f7)