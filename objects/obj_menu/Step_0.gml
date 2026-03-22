with(obj_popup) return;
var h_gap = 0;
chosen_table._id = -1;
draw_set_font(font_options);
for(var STRUCT_INDEX = 0; STRUCT_INDEX < array_length(global.menu_order); STRUCT_INDEX++)
{
	var cur_menu = struct_get(global.menu, global.menu_order[STRUCT_INDEX]);
	if (cur_menu.show == true)
	{
		var cur_hitbox = {
			x0: 4 + h_gap + (STRUCT_INDEX > 0 ? 4 * STRUCT_INDEX : 0),
			y0: 16 - string_height(cur_menu.name),
			w: string_width(cur_menu.name),
			h: string_height(cur_menu.name)
		};
		var mouse_contains = point_in_rectangle(mouse_x, mouse_y, cur_hitbox.x0, cur_hitbox.y0, cur_hitbox.x0 + cur_hitbox.w, cur_hitbox.y0 + cur_hitbox.h);
		if (mouse_contains)
		{
			chosen_table._id = STRUCT_INDEX
			chosen_table._x = cur_hitbox.x0;
			break;
		}
		h_gap += string_width(cur_menu.name);
	}
}

if (chosen_table._id != -1)
{
	if (mouse_check_button_pressed(mb_left))
	{
		alarm[0] = 2;
	}
}